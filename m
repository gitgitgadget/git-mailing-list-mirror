From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] branch: show (rebasing) or (bisecting) instead of (no
 branch) when possible
Date: Tue, 29 Jan 2013 11:13:21 -0800
Message-ID: <20130129191321.GB18266@google.com>
References: <1359461574-24529-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 20:13:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0Gcu-000733-To
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 20:13:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753713Ab3A2TN1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jan 2013 14:13:27 -0500
Received: from mail-pb0-f50.google.com ([209.85.160.50]:64300 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752032Ab3A2TN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 14:13:26 -0500
Received: by mail-pb0-f50.google.com with SMTP id ro8so460401pbb.23
        for <git@vger.kernel.org>; Tue, 29 Jan 2013 11:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ATy0krDG4TvnPPoNnzYXiH05fO3wbs/EBJW3QrTlbco=;
        b=ABxyiF9rch07NeHfAoIodGQYYdaAQ6nWJAugG67uv+sPt3iGaRtW6OGRJK7JCNOTLT
         eoB5Wmib5KyfF2UKJRrRXSZ4VmA2DCqxc9lth2xceO5yg7z65Qc1m4PsmeXNrH91i/EI
         ErGblxKb55Ce9i/1mMvFX2PVdvlCqM6977l9+1CnSIbwEajRRTT3838bevSVPRMOK8Vp
         YVJIDDPBxertM8UORyHuQn6GwSysfWpz+2mdyMpzOOh2APIUW+7RPuYdXTi4nPvwhBvx
         HTPrJSO+S981BBxFPDjUjsrloc881R6rKBZArJJMM/jNm5K8osYESKh0CBTvP2772o1F
         htzA==
X-Received: by 10.66.84.3 with SMTP id u3mr5145121pay.51.1359486805758;
        Tue, 29 Jan 2013 11:13:25 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id nj1sm8947145pbc.13.2013.01.29.11.13.23
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 29 Jan 2013 11:13:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1359461574-24529-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214957>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  In the spirit of status' in-progress info. I think showing this is
>  more useful than "(no branch)". I tend to do "git br" more often tha=
n
>  "git st" and this catches my eyes.

Very nice idea.  This would also have been a nice way to avoid
confusion when my officemate used bisect for the first time.

Any particular reason the above explanation is after the triple-dash
instead of before it?

[...]
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -557,7 +557,15 @@ static void show_detached(struct ref_list *ref_l=
ist)
> =20
>  	if (head_commit && is_descendant_of(head_commit, ref_list->with_com=
mit)) {
>  		struct ref_item item;
> -		item.name =3D xstrdup(_("(no branch)"));
> +		struct stat st;
> +		if ((!stat(git_path("rebase-apply"), &st) &&
> +		     stat(git_path("rebase-apply/applying"), &st)) ||
> +		    !stat(git_path("rebase-merge"), &st))

Here's a straight translation of contrib/completion/prompt.sh for
comparison, skipping the cases that don't involve automatically
detaching HEAD:

	if (!stat(git_path("rebase-merge"), &st) && S_ISDIR(st.st_mode))
		item.name =3D xstrdup(_("(rebasing)"));
	else if (!access(git_path("rebase-apply/rebasing"), F_OK))
		item.name =3D xstrdup(_("(rebasing)"));
	else if (!access(git_path("BISECT_LOG"), F_OK))
		item.name =3D xstrdup(_("(bisecting)"));
	else
		item.name =3D xstrdup(_("(no branch)"));

That would mean:

 * using access() instead of stat() to avoid unnecessary work
 * relying on rebase--am to write .git/rebase-apply/rebasing when
   appropriate instead of guessing

Not important, though. :)

Jonathan
