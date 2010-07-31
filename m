From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] unpack-trees.c: Do not check ce_stage in
 will_have_skip_worktree()
Date: Fri, 30 Jul 2010 21:11:44 -0500
Message-ID: <20100731021144.GA906@burratino>
References: <1280135310-2347-1-git-send-email-pclouds@gmail.com>
 <1280135310-2347-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 31 04:13:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Of1Ze-0000gb-4D
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 04:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044Ab0GaCM7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Jul 2010 22:12:59 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:50514 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321Ab0GaCM6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 22:12:58 -0400
Received: by gyg10 with SMTP id 10so851585gyg.19
        for <git@vger.kernel.org>; Fri, 30 Jul 2010 19:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=D0L7o9p/AJ+P/XZN1DUwfC0W/nZSSpD1gYo3IIQEht8=;
        b=c+RmZhpeYgkn8TaCvEBKUWV5rhz6FCHFaqutX2AO2AgJCuLwi3FJqCfACntPNk5yb1
         VWmXGj7yC5ttgiSMBoiIdGRAtNXYZZNr45trghaCEc/SU+sO5ehQFr11XBxhLs4JOp/k
         Pp0wSxxfDpLapgxzF+S+ESBuLNh0KT06Lvf8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=LXka3XcjGo0z8ZwwNNn3Q+W3Exak59a2dH9ljjbO+rhRGn5w3i/lWBbJoqKudP565p
         5SHpHNb7bIrH8ualN2l56LIYgwy/dPU9NDvFJE4JxeM7WQQznSNgr3gmloiZVxnwCnl4
         DRFXSVjVjbfYsfXJB8HyE/L10stIgLPQa0zWc=
Received: by 10.150.207.1 with SMTP id e1mr3948185ybg.307.1280542377372;
        Fri, 30 Jul 2010 19:12:57 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id q17sm2861401ybk.17.2010.07.30.19.12.55
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 Jul 2010 19:12:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1280135310-2347-2-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152287>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> The idea of sparse checkout is conflicted entries should always stay
> in worktree, regardless $GIT_DIR/info/sparse-checkout. Therefore,
> ce_stage(ce) usually means no CE_SKIP_WORKTREE. This is true when all
> entries have been merged into the index, and identical staged entries
> collapsed.
>=20
> However, will_have_skip_worktree() since f1f523e (unpack-trees():
> ignore worktree check outside checkout area) is also used earlier in
> verify_* functions, when entries have not been merged to index yet
> and ce_stage() may not be zero. Checking ce_stage() then can make
> unnecessary verification on entries outside checkout area and error o=
ut.

s/make/provoke/?

So: conflicts from unmerged index entries are supposed to be kept in
the work tree; but unpack_trees() is checking too early and seeing
conflicts where there are none.  Do I understand correctly?

> This fixes part of test case "read-tree adds to worktree, dirty case"=
=2E

A summary might help people who do not remember the test:

	So attempting to add a file outside the checkout area=20
	where there is a file already present (as in
	t1011.13 "read-tree adds to worktree, dirty case")
	will no longer error out with

	error: Untracked working tree file 'sub/added' would be overwritten by=
 merge.

	but instead will remove the file.  (The latter problem will be
	addressed in a later patch.)

> +++ a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -135,9 +135,6 @@ static int will_have_skip_worktree(const struct c=
ache_entry *ce, struct unpack_t
>  {
>  	const char *basename;
> =20
> -	if (ce_stage(ce))
> -		return 0;
> -
>  	basename =3D strrchr(ce->name, '/');
>  	basename =3D basename ? basename+1 : ce->name;
>  	return excluded_from_list(ce->name, ce_namelen(ce), basename, NULL,=
 o->el) <=3D 0;
> @@ -147,7 +144,7 @@ static int apply_sparse_checkout(struct cache_ent=
ry *ce, struct unpack_trees_opt
>  {
>  	int was_skip_worktree =3D ce_skip_worktree(ce);
> =20
> -	if (will_have_skip_worktree(ce, o))
> +	if (!ce_stage(ce) && will_have_skip_worktree(ce, o))
>  		ce->ce_flags |=3D CE_SKIP_WORKTREE;
>  	else
>  		ce->ce_flags &=3D ~CE_SKIP_WORKTREE;

Makes sense.

Thanks,
Jonathan
