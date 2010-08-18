From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] commit: update the index after running the
 pre-commit hook
Date: Wed, 18 Aug 2010 17:51:30 -0500
Message-ID: <20100818225130.GC2346@burratino>
References: <6e4c323b0905031620m48769dbdp52684d6b470ebea3@mail.gmail.com>
 <1282139649-21097-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Hinrik =?utf-8?Q?=C3=96rn_Sigur=C3=B0sson?= 
	<hinrik.sig@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 19 00:53:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlrVU-0005HE-DN
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 00:53:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751622Ab0HRWxK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Aug 2010 18:53:10 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:45555 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876Ab0HRWxJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Aug 2010 18:53:09 -0400
Received: by ywh1 with SMTP id 1so446758ywh.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 15:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=kleanNaLJj2DyTEEHLnofofZh6qZoskF03+MMe+JfHE=;
        b=irJS8YMVUA+Gv2jDphd3d5+NW/psequ8TM+xkp6AKhu+jwlOyW3ob5kiF8j87pAXPs
         FHzeBMleP2G4hMl6xFn84rfyzwyiP+mKI4b9ZoBGGlgEobHJaeX9gIcSVRjYeAmWmO3T
         B6EMfJac364AFrBCMwiMD0Lqr64pvObsLsbUU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=rZRAEnNZ32M/TgbDrkbit93HohOpNt5gS1y2vgGIql1uMWOb8A8uOIjoK9Sts+2q6H
         Nz28SIHyZJRxJSpmVMZ10Nj5P4w7qrJQOs69xr6x1/6ESSu9MCZNvfAVcAnHFrUJrtd6
         fjiKl8BUcNfK98YJg+2tithv3hVRn8sWHGtmQ=
Received: by 10.150.52.11 with SMTP id z11mr1189643ybz.149.1282171988916;
        Wed, 18 Aug 2010 15:53:08 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id q3sm1793330ybe.14.2010.08.18.15.53.07
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 18 Aug 2010 15:53:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1282139649-21097-1-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153890>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> +++ b/builtin/commit.c
> @@ -565,6 +579,16 @@ static int prepare_to_commit(const char *index_f=
ile, const char *prefix,
>  	if (!no_verify && run_hook(index_file, "pre-commit", NULL))
>  		return 0;
> =20
> +	/* Update the index after we run the pre-commit hook, but before
> +	 * we construct the message we're sending to the editor. The
> +	 * pre-commit hook may e.g. create a new file and add it to the
> +	 * index.
> +	 *
> +	 * Having that file show up as modified but not staged is confusing=
=2E
> +	 */
> +	if (!update_index(index_file))
> +		return 0;
> +
>  	if (message.len) {
>  		strbuf_addbuf(&sb, &message);
>  		hook_arg1 =3D "message";
> @@ -728,15 +752,8 @@ static int prepare_to_commit(const char *index_f=
ile, const char *prefix,
>  	 * and write it out as a tree.  We must do this before we invoke
>  	 * the editor and after we invoke run_status above.
>  	 */
> -	discard_cache();
> -	read_cache_from(index_file);
> -	if (!active_cache_tree)
> -		active_cache_tree =3D cache_tree();
> -	if (cache_tree_update(active_cache_tree,
> -			      active_cache, active_nr, 0, 0) < 0) {
> -		error("Error building trees");
> +	if (!update_index(index_file))
>  		return 0;
> -	}
> =20
>  	if (run_hook(index_file, "prepare-commit-msg",

Before, "commit" updated the index once, and after, twice.  How does
this affect the running time on, say, the linux-2.6 tree?  Could one
of the update_index() calls be suppressed when there is no hook to
run?
