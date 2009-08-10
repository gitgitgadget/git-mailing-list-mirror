From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH v2 1/4] Prevent diff machinery from examining
 assume-unchanged entries on worktree
Date: Mon, 10 Aug 2009 18:20:19 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908101800480.8324@intel-tinevez-2-302>
References: <1249917562-5931-1-git-send-email-pclouds@gmail.com> <1249917562-5931-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-388088401-1249921219=:8324"
Cc: git@vger.kernel.org
To: =?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 18:20:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaXbp-0004gK-Kd
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 18:20:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755581AbZHJQUV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 12:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755417AbZHJQUU
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 12:20:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:40852 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753209AbZHJQUU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 12:20:20 -0400
Received: (qmail invoked by alias); 10 Aug 2009 16:20:19 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp062) with SMTP; 10 Aug 2009 18:20:19 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19dlM4Jvs1dkKhMgY6AnI9jUbbKLJbJfIeAuFxs1z
	NVSgFRrAOlVJ3O
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1249917562-5931-2-git-send-email-pclouds@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125477>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-388088401-1249921219=:8324
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 10 Aug 2009, Nguyễn Thái Ngọc Duy wrote:

> diff --git a/diff-lib.c b/diff-lib.c
> index b7813af..f5787f6 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -337,6 +337,8 @@ static void do_oneway_diff(struct unpack_trees_options *o,
>  	struct rev_info *revs = o->unpack_data;
>  	int match_missing, cached;
>  
> +	/* if the entry is not checked out, don't examine work tree */
> +	cached = o->index_only || (idx && (idx->ce_flags & CE_VALID));
>  	/*
>  	 * Backward compatibility wart - "diff-index -m" does
>  	 * not mean "do not ignore merges", but "match_missing".
> @@ -344,7 +346,6 @@ static void do_oneway_diff(struct unpack_trees_options *o,
>  	 * But with the revision flag parsing, that's found in
>  	 * "!revs->ignore_merges".
>  	 */
> -	cached = o->index_only;
>  	match_missing = !revs->ignore_merges;
>  
>  	if (cached && idx && ce_stage(idx)) {

Out of curiosity: why did that line have to move up?

Ciao,
Dscho

> diff --git a/t/t4039-diff-assume-unchanged.sh b/t/t4039-diff-assume-unchanged.sh
> new file mode 100755
> index 0000000..d0e46a7
> --- /dev/null
> +++ b/t/t4039-diff-assume-unchanged.sh
> @@ -0,0 +1,31 @@
> +#!/bin/sh
> +
> +test_description='diff with assume-unchanged entries'
> +
> +. ./test-lib.sh
> +
> +# external diff has been tested in t4020-diff-external.sh
> +
> +test_expect_success 'setup' '
> +	echo zero > zero &&
> +	git add zero &&
> +	git commit -m zero &&
> +	echo one > one &&
> +	echo two > two &&
> +	git add one two &&
> +	git commit -m onetwo &&
> +	git update-index --assume-unchanged one &&
> +	echo borked >> one &&
> +	test "$(git ls-files -v one)" = "h one"
> +'

Maybe use test_commit, to make it more readable?

> +
> +test_expect_success 'diff-index does not examine assume-unchanged entries' '
> +	git diff-index HEAD^ -- one | grep -q 5626abf0f72e58d7a153368ba57db4c673c0e171 
> +'
> +
> +# TODO ced_uptodate()

What is this about?

> +test_expect_success 'diff-files does not examine assume-unchanged entries' '
> +	/usr/bin/git diff-files -- one
> +'
> +
> +test_done

Thanks,
Dscho

--8323329-388088401-1249921219=:8324--
