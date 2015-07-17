From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] unpack-trees: don't update files with CE_WT_REMOVE set
Date: Fri, 17 Jul 2015 14:34:25 -0700
Message-ID: <xmqqbnfa1na6.fsf@gitster.dls.corp.google.com>
References: <xmqqk2ty1reo.fsf@gitster.dls.corp.google.com>
	<1437167967-5933-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Anatole Shaw <git-devel@omni.poc.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jul 17 23:34:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGDH8-0007WC-DM
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jul 2015 23:34:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754550AbbGQVea (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 17:34:30 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:35986 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753593AbbGQVe3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 17:34:29 -0400
Received: by pdjr16 with SMTP id r16so68497738pdj.3
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 14:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=1lRFFl7Z+MqCn4VDpPeynx2KmnbycQ61byew7pePMms=;
        b=YpNpfonS3G0FBgHoxKpyVS101q+T6jnpXERcZg3z2EMf6AboKn2WhjUBr7XRpB5DC1
         3bKuGmmsqUaTsymnyZNEu2SoKdp8v+L+yFfPWYAo5E3Vnszn/eaH4zKro5b+DZ8vhLhi
         3mqKWpIQ3XQr5GrHcaH+tHspKr4drM74iw3MZQ5owINnhrhDKdM3CgSxyhL54y+yZXpK
         jL7uilrCBQRmb627xq3iWVQQKrnXEXi9thWE6cNO/z+pLn0eKXmuAf9UsIUSUqucDxrP
         N98VpqQwBPDQ+Vc9jx6DpiOLcEnL35yLo/isYqqpdl56c0rIAFCnklhjo1AunJNZ1A7v
         /iSw==
X-Received: by 10.66.155.36 with SMTP id vt4mr33996260pab.32.1437168867006;
        Fri, 17 Jul 2015 14:34:27 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:902a:e9ec:1aae:aea2])
        by smtp.gmail.com with ESMTPSA id j5sm6915287pdi.7.2015.07.17.14.34.25
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 17 Jul 2015 14:34:26 -0700 (PDT)
In-Reply-To: <1437167967-5933-1-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Fri, 17 Jul 2015 17:19:27 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274106>

David Turner <dturner@twopensource.com> writes:

> Don't update files in the worktree from cache entries which are
> flagged with CE_WT_REMOVE.
>
> When a user does a sparse checkout, git removes files that are marked
> with CE_WT_REMOVE (because they are out-of-scope for the sparse
> checkout). If those files are also marked CE_UPDATE (for instance,
> because they differ in the branch that is being checked out and the
> outgoing branch), git would previously recreate them.  This patch
> prevents them from being recreated.
>
> These erroneously-created files would also interfere with merges,
> causing pre-merge revisions of out-of-scope files to appear in the
> worktree.
>
> Signed-off-by: Anatole Shaw <git-devel@omni.poc.net>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---

That's much more readable and understandable ;-)

Duy Cc'ed for final sanity check and possiible extra comments.

Thanks.

>  t/t1090-sparse-checkout-scope.sh | 52 ++++++++++++++++++++++++++++++++++++++++
>  unpack-trees.c                   |  2 +-
>  2 files changed, 53 insertions(+), 1 deletion(-)
>  create mode 100755 t/t1090-sparse-checkout-scope.sh
>
> diff --git a/t/t1090-sparse-checkout-scope.sh b/t/t1090-sparse-checkout-scope.sh
> new file mode 100755
> index 0000000..1f61eb3
> --- /dev/null
> +++ b/t/t1090-sparse-checkout-scope.sh
> @@ -0,0 +1,52 @@
> +#!/bin/sh
> +
> +test_description='sparse checkout scope tests'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +	echo "initial" >a &&
> +	echo "initial" >b &&
> +	echo "initial" >c &&
> +	git add a b c &&
> +	git commit -m "initial commit"
> +'
> +
> +test_expect_success 'create feature branch' '
> +	git checkout -b feature &&
> +	echo "modified" >b &&
> +	echo "modified" >c &&
> +	git add b c &&
> +	git commit -m "modification"
> +'
> +
> +test_expect_success 'perform sparse checkout of master' '
> +	git config --local --bool core.sparsecheckout true &&
> +	echo "!/*" >.git/info/sparse-checkout &&
> +	echo "/a" >>.git/info/sparse-checkout &&
> +	echo "/c" >>.git/info/sparse-checkout &&
> +	git checkout master &&
> +	test_path_is_file a &&
> +	test_path_is_missing b &&
> +	test_path_is_file c
> +'
> +
> +test_expect_success 'merge feature branch into sparse checkout of master' '
> +	git merge feature &&
> +	test_path_is_file a &&
> +	test_path_is_missing b &&
> +	test_path_is_file c &&
> +	test "$(cat c)" = "modified"
> +'
> +
> +test_expect_success 'return to full checkout of master' '
> +	git checkout feature &&
> +	echo "/*" >.git/info/sparse-checkout &&
> +	git checkout master &&
> +	test_path_is_file a &&
> +	test_path_is_file b &&
> +	test_path_is_file c &&
> +	test "$(cat b)" = "modified"
> +'
> +
> +test_done
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 2927660..11a5300 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -223,7 +223,7 @@ static int check_updates(struct unpack_trees_options *o)
>  	for (i = 0; i < index->cache_nr; i++) {
>  		struct cache_entry *ce = index->cache[i];
>  
> -		if (ce->ce_flags & CE_UPDATE) {
> +		if (ce->ce_flags & CE_UPDATE && !(ce->ce_flags & CE_WT_REMOVE)) {
>  			display_progress(progress, ++cnt);
>  			ce->ce_flags &= ~CE_UPDATE;
>  			if (o->update && !o->dry_run) {
