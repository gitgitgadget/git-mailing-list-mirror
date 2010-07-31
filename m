From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] Mark new entries skip-worktree appropriately
Date: Fri, 30 Jul 2010 21:32:20 -0500
Message-ID: <20100731023219.GB906@burratino>
References: <1280135310-2347-1-git-send-email-pclouds@gmail.com>
 <1280135310-2347-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 31 04:33:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Of1tO-0006TP-2o
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 04:33:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754611Ab0GaCdh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Jul 2010 22:33:37 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:64494 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754536Ab0GaCdg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 22:33:36 -0400
Received: by yxg6 with SMTP id 6so853184yxg.19
        for <git@vger.kernel.org>; Fri, 30 Jul 2010 19:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=geCPOqKRe3yGZxsL97cYLBYtjSbew6YA1nTmhob419I=;
        b=LxitvJQINPs4WWOUi4I++yaUXj+g6dbDDjf5RefDr/bf6xTGLu2nATxepy8zH2hKma
         010KlhZOm6BnFXwjwY8zBcoT2KKT7+LsRkVIX7Crkcy7mhhPsqxGW31V1GSQsb6+NNE/
         mQYTQ4+pzkfDLV0eaFp6tz49AwgAPFUwWNlIU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Dbwcm0FmHtuwRVQrbBw8DjiIkvcSC76bQqWa6iuq7pxOYTCXeyY7B/UDuJ9T1Q/FEl
         P1UA+QZENISRWaMZSAuNaFbortFNViGtW+MEGng8pMfvjTk1lCurVMQ2wpkRZYLvdJIS
         3dGQMF7X4SxASZvV354EAPKuKBree9glPY69E=
Received: by 10.151.77.8 with SMTP id e8mr4179211ybl.224.1280543615569;
        Fri, 30 Jul 2010 19:33:35 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id x3sm1538493ybl.22.2010.07.30.19.33.34
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 Jul 2010 19:33:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1280135310-2347-3-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152291>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> Sparse checkout updates worktree based on the old and new
> skip-worktree status when $GIT_DIR/info/sparse-checkout changes:
>=20
> old =3D ce_skip_worktree(ce);           // current skip-worktree
> new =3D will_have_skip_work_tree(ce);   // from $GIT..sparse-checkout
> if (old && !new) add_file_back(ce);   // shrink checkout area
> if (!old && new) remove_file_out(ce); [1] // enlarge checkout area
>=20
> New entries after merging will always have skip-worktree unset
> (i.e. old =3D 0). If those files are filtered out by
> $GIT_DIR/info/sparse-checkout (i.e. new !=3D 0), then case [1] will
> happen. But there is nothing to remove because they're new.

When using unpack_trees to add a new file, there is no in-file
index entry to grab the previous skip worktree bit from.  If it
is outside the checkout area, we should pretend it was skipped before,
too; otherwise a checkout can cause a file on disk whose name
coincides with a newly added outside-worktree file to be deleted.

Do I understand correctly?

> +++ b/unpack-trees.c
> @@ -1091,6 +1091,8 @@ static int merged_entry(struct cache_entry *mer=
ge, struct cache_entry *old,
>  	if (!old) {
>  		if (verify_absent(merge, "overwritten", o))
>  			return -1;
> +		if (!o->skip_sparse_checkout && will_have_skip_worktree(merge, o))
> +			update |=3D CE_SKIP_WORKTREE;
>  		invalidate_ce_path(merge, o);
>  	} else if (!(old->ce_flags & CE_CONFLICTED)) {
>  		/*

Looks sane.

Thanks for the fixes,
Jonathan
