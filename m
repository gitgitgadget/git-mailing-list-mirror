From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 04/10] unpack-trees: fix sparse checkout's "unable to
 match directories" fault
Date: Mon, 15 Nov 2010 13:10:41 -0600
Message-ID: <20101115191041.GE16385@burratino>
References: <1289817410-32470-1-git-send-email-pclouds@gmail.com>
 <1289817410-32470-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 15 20:11:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PI4St-0004Yh-Rr
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 20:11:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933148Ab0KOTLU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Nov 2010 14:11:20 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:45513 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933009Ab0KOTLT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Nov 2010 14:11:19 -0500
Received: by ewy8 with SMTP id 8so915746ewy.19
        for <git@vger.kernel.org>; Mon, 15 Nov 2010 11:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=BuYobvK65xQEKShKEX71fepfNv1K/B4KMXMdwfQC+gY=;
        b=hLmOSloj4KUiHANkkbFS9mhEyYMrSwIXTW05wOpg59fmyK+tMjNyOAW3dsJMyzqO+m
         DOlddvqCsptxChD2ismblMGuEc23JdfGYWi+Bj1oiN0XlykCg0WvliP/0LPTwLO44Kzr
         jAhp7n7qnHZJ/2eaovYHY5XEoJ3mEtJCoObFo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=TKYLWUbd6rffLKvFLw8CFfGPA/Bh2aBHYEkGLlNsMXVcp3/RXgem8l2yBRyS/WWMnd
         4lm0DM9YBgCAevvPYU/4kMRTt9kwXR7Hi6jJtsr2q0MLtGzKIF+5wI7xxrP6vL7seIvR
         v1QntAmNt7AV0rV//wQgCmNeTjWuJedcGyZ2Q=
Received: by 10.216.171.19 with SMTP id q19mr7110995wel.53.1289848277699;
        Mon, 15 Nov 2010 11:11:17 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id p4sm156612wej.28.2010.11.15.11.11.15
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 15 Nov 2010 11:11:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1289817410-32470-5-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161504>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> excluded_from_list() is designed to be work with a directory
> structure, where there are files and directories. Index however is a
                                                   ^
                                                   The
> list of files, no directories, not really fit in excluded_from_list()
                 ^with no separate entries for directories, so it does
> design.
[...]
> clear_ce_flags() is now used to match the index against sparse
> patterns. It does generate directories for excluded_from_list()

Sounds exciting.  I can't believe I missed that, but I guess what
was needed is a simple example caller.  Let's see how this patch
works in that vein.

> --- a/Documentation/git-read-tree.txt
> +++ b/Documentation/git-read-tree.txt
> @@ -416,13 +416,6 @@ turn `core.sparseCheckout` on in order to have s=
parse checkout
>  support.
> =20
> =20
> -BUGS
> -----
> -In order to match a directory with $GIT_DIR/info/sparse-checkout,
> -trailing slash must be used. The form without trailing slash, while
> -works with .gitignore, does not work with sparse checkout.

Nice.

[...]
> diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree=
-sparse-checkout.sh
> index 9a07de1..50f7dfe 100755
> --- a/t/t1011-read-tree-sparse-checkout.sh
> +++ b/t/t1011-read-tree-sparse-checkout.sh
> @@ -91,12 +91,20 @@ test_expect_success 'match directories with trail=
ing slash' '
>  	test -f sub/added
>  '
> =20
> -test_expect_failure 'match directories without trailing slash' '
> +test_expect_success 'match directories without trailing slash' '

Also nice.

> -	echo init.t >.git/info/sparse-checkout &&
>  	echo sub >>.git/info/sparse-checkout &&
>  	git read-tree -m -u HEAD &&
>  	git ls-files -t >result &&
> -	test_cmp expected.swt result &&
> +	test_cmp expected.swt-noinit result &&
> +	test ! -f init.t &&
> +	test -f sub/added

Maybe the new

	test_path_is_missing

and

	test_path_is_file

would be a good fit here, for better behavior when the path is a direct=
ory in
the former case and better debugging output for failures in the latter.

> +'
> +
> +test_expect_success 'match directory pattern' '
> +	echo "s?b" >>.git/info/sparse-checkout &&
> +	git read-tree -m -u HEAD &&
> +	git ls-files -t >result &&
> +	test_cmp expected.swt-noinit result &&
>  	test ! -f init.t &&
>  	test -f sub/added
>  '

A pattern change that changes the list of matched paths would be more
impressive.  (Though I understand, this version already works for
demonstrating progress.)

[...]
> --- a/dir.c
> +++ b/dir.c
> @@ -359,12 +359,6 @@ int excluded_from_list(const char *pathname,
>  			int to_exclude =3D x->to_exclude;
> =20
>  			if (x->flags & EXC_FLAG_MUSTBEDIR) {
> -				if (!dtype) {
> -					if (!prefixcmp(pathname, exclude))
> -						return to_exclude;
> -					else
> -						continue;
> -				}

Removing the no longer used !dtype codepath.

This hunk could be a separate patch (simplifying the diff and
decoupling this series from patch 1).

> --- a/unpack-trees.c
> +++ b/unpack-trees.c
[...]
> @@ -926,14 +917,19 @@ static void set_new_skip_worktree_1(struct unpa=
ck_trees_options *o)
>  {
>  	int i;
> =20
> +	/* Mark everything out (except staged entries) */
>  	for (i =3D 0;i < o->src_index->cache_nr;i++) {
>  		struct cache_entry *ce =3D o->src_index->cache[i];
>  		ce->ce_flags &=3D ~CE_ADDED;
> +		if (!ce_stage(ce))

Not a fan of this new definition of "staged".  The following might be
clearer:

	/*
	 * The WILL_BE_SKIP_WORKTREE bit is initialized in two stages:
	 *
	 * 1. Pretend the checkout is so narrow it contains no files.
	 *    Only unresolved entries participating in a merge would
	 *    get written to the worktree.
	 *
	 * 2. Add back entries according to .git/info/sparse-checkout
	 */

[...]
> @@ -943,19 +939,26 @@ static int set_new_skip_worktree_2(struct unpac=
k_trees_options *o)
> =20
>  	/*
>  	 * CE_ADDED marks new index entries. These have not been processed
> -	 * by set_new_skip_worktree_1() so we do it here.
> +	 * by set_new_skip_worktree_1() so we do it here. Mark every new
> +	 * entries out.
>  	 */

Nit: "every" wants a singular noun.  But even better would be to move
the description of effect to the call site.

The description of strategy can stay here so it doesn't go out of date
when the code changes:

	/*
	 * Just like set_new_skip_worktree_1.
	 * unpack-trees never writes conflicted entries to the worktree,
	 * so there is no need to worry about conflicted files.
	 *
	 * 1. Set WILL_BE_SKIP_WORKTREE for all new entries.
	 * 2. Clear it again for paths within the sparse checkout.
	 */

Is it possible to make the two code paths share code without
sacrificing speed?
