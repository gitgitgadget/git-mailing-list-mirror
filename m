Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 372AA1F859
	for <e@80x24.org>; Fri, 12 Aug 2016 18:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577AbcHLSaR (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 14:30:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57963 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750989AbcHLSaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 14:30:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6FE5634E42;
	Fri, 12 Aug 2016 14:30:15 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WCk+zev2Vf5XJmCaigelGWAbYAE=; b=VxdZFl
	SK+W//KMPviXWcTsHDg8jHDB/CgF+kx2iBZo59SfbUD0fpfa+KaGLXeNHboeNFij
	5wICqXGF3bfLFCdPErnvDsDghCqNZg+1qX5pisptjX8B2hbigMH0G4pSk9wnqOhD
	rrzwBKqFBsoAQLckWQZE+UX+ByUai4B2TEkYA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=twRvPZbHzb6pn02kJbvNi9zlOQx2R7Fb
	Drq6/zlY6vWZqcjbuQ8bO5c4HFvT/3ITs/r4Ho4Zq5rqizXyzrjZ0MPwRLjubTS4
	o6yRcOuKRhNzlN0fxnzPInbAZsbItChdlJ43D/g8GpuoL3IlMBFIJcVD04ZR0FpS
	7r12Jz3vmZI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6865634E41;
	Fri, 12 Aug 2016 14:30:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 45CE834E3F;
	Fri, 12 Aug 2016 14:30:14 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Ivan Oleynikov <io@metrotek.spb.ru>,
	"David A. Greene" <greened@obbligato.org>
Cc:	git@vger.kernel.org, dvh@metrotek.spb.ru, apenwarr@gmail.com
Subject: Re: [PATCH] git-subtree: compare file names by absolute paths
References: <20160812154942.GA27294@metrotek.spb.ru>
Date:	Fri, 12 Aug 2016 11:30:11 -0700
In-Reply-To: <20160812154942.GA27294@metrotek.spb.ru> (Ivan Oleynikov's
	message of "Fri, 12 Aug 2016 18:49:42 +0300")
Message-ID: <xmqqwpjlx2ks.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CF81F344-60BA-11E6-85B4-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Ivan Oleynikov <io@metrotek.spb.ru> writes:

> Cc: git@vger.kernel.org,  dvh@metrotek.spb.ru,  apenwarr@gmail.com

I think Avery no longer actively works on this script; Dave Greene
has been helping it move forward by reviewing, so let's ask him to
lend his eyes.

> This commit removes false positive assertion fails of `git subtree split` when
> the --prefix argument is not in a particular form produced by `git ls-tree`.
>
> For example, typical usage of the command could be:
>
>   git subtree split -b split --prefix=some/relative/path
>
> But
>
>   git subtree split -b split --prefix=./some/relative/path
>
> Would fail with multiple assertion errors. This commit makes the latter command
> work without errors.
>
> Signed-off-by: Ivan Oleynikov <io@metrotek.spb.ru>
> ---
>
> Notes:
>     The bug fixed by this commit can be reproduced like this:
>     
>     $ git init
>     Initialized empty Git repository in /tmp/test/.git/
>     $ mkdir a b
>     $ touch a/file b/file
>     $ git add a
>     $ git commit -m a
>     [master (root-commit) b42584a] a
>      1 file changed, 0 insertions($), 0 deletions(-)
>      create mode 100644 a/file
>     $ git add b
>     $ git commit -m b
>     [master 5114301] b
>      1 file changed, 0 insertions($), 0 deletions(-)
>      create mode 100644 b/file
>     $ git subtree split -b split_a --prefix=a
>     Created branch 'split_a'
>     e9f5d81efacb33ab6cf67fe9ff376b33a483a92f
>     $ git subtree split -b split_b --prefix=./b
>     assertion failed:  [ b = ./b ]
>     No new revisions were found
>     
>     When the commit is applied `git subtree split` works as expected:
>     
>     $ git init
>     Initialized empty Git repository in /tmp/test/.git/
>     $ mkdir a b
>     $ touch a/file b/file
>     $ git add a
>     $ git commit -m a
>     [master (root-commit) bc80f36] a
>      1 file changed, 0 insertions($), 0 deletions(-)
>      create mode 100644 a/file
>     $ git add b
>     $ git commit -m b
>     [master e59c446] b
>      1 file changed, 0 insertions($), 0 deletions(-)
>      create mode 100644 b/file
>     $ git subtree split -b split_a --prefix=a
>     Created branch 'split_a'
>     d542e9cd2de5956dd7ca77b169dba1c8418fa03a
>     $ git subtree split -b split_b --prefix=./b
>     Created branch 'split_b'
>     3ae7854c0c395413c807b2bc4e75b651adc63f8c
>
>  contrib/subtree/git-subtree.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> index b567eae..d9351b9 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -411,7 +411,7 @@ subtree_for_commit()
>  	dir="$2"
>  	git ls-tree "$commit" -- "$dir" |
>  	while read mode type tree name; do
> -		assert [ "$name" = "$dir" ]
> +		assert [ "$(readlink -f $name)" = "$(readlink -f $dir)" ]
>  		assert [ "$type" = "tree" -o "$type" = "commit" ]
>  		[ "$type" = "commit" ] && continue  # ignore submodules
>  		echo $tree
> -- 
> 2.1.4
