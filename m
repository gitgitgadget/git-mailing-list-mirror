From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] am --abort: merge ORIG_HEAD tree into index
Date: Mon, 17 Aug 2015 12:33:40 -0700
Message-ID: <xmqqsi7hd817.fsf@gitster.dls.corp.google.com>
References: <CA+55aFwDkQAS8ULiLt9N5NVOYJ242Nd2MOWeiRX8HrVHXf2zog@mail.gmail.com>
	<CA+55aFwwD=K-i9d40N5FtnTLT-ApZOzmgnXhnuA=C0zw2eBt3Q@mail.gmail.com>
	<03631611149f05dbcd862b4c1e8e9d6b@www.dscho.org>
	<20150817094819.GA10375@yoshi.chippynet.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 21:33:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRQAG-00087r-AS
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 21:33:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbbHQTdn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 15:33:43 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33093 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791AbbHQTdm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 15:33:42 -0400
Received: by pabyb7 with SMTP id yb7so114763807pab.0
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 12:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=HfpEyarC75jmIyWY9ypI1N/DASTjF7IVNaI0FTv6rUI=;
        b=IUOS15adMmaULzvefnnQJPj16FrFpCKSC2d+8Dee3ZmI72jhgoS9cyQ1cTvO+WZoht
         JxUmjtCtfl/jQF6fdMLbWESstorvSqWrFxEOBRqfsxzXrtrHJr1pJB97UnvCKxp3hPMn
         9YquhLk/OmBOTMojE3rYl8oidoF9K2p0A8Eb5AAh1lL8Z0p86kFqocFVo6PfL7DhhljD
         DgBLCyQRv5ORnne/NF6ztCttPUJGf1YNART3/uRPvlUeP3yVwymPgia/HaNSjjShyWtE
         f/ZwxtGCnv2K19Z/tHe0ClpKU9G78li3QG7mGJ+zsX4pZOCiZgaw0TyOaIdj9i+MOmBX
         t8yQ==
X-Received: by 10.68.249.101 with SMTP id yt5mr5714526pbc.6.1439840022096;
        Mon, 17 Aug 2015 12:33:42 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:d4db:7e94:b576:3da])
        by smtp.gmail.com with ESMTPSA id f5sm11681256pas.23.2015.08.17.12.33.41
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Aug 2015 12:33:41 -0700 (PDT)
In-Reply-To: <20150817094819.GA10375@yoshi.chippynet.com> (Paul Tan's message
	of "Mon, 17 Aug 2015 17:48:19 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276080>

Paul Tan <pyokagan@gmail.com> writes:

The codepath in the original looks like this:

        head_tree=$(git rev-parse --verify -q HEAD || echo $empty_tree) &&
==>     git read-tree --reset -u $head_tree $head_tree &&
        index_tree=$(git write-tree) &&
        orig_head=$(git rev-parse --verify -q ORIG_HEAD || echo $empty_tree) &&
==>     git read-tree -m -u $index_tree $orig_head
        if git rev-parse --verify -q ORIG_HEAD >/dev/null 2>&1
        then
                git reset ORIG_HEAD
        else
                git read-tree $empty_tree
                curr_branch=$(git symbolic-ref HEAD 2>/dev/null) &&
                git update-ref -d $curr_branch
        fi

Your am_abort() implements the above fairly faithfully up to the
point where it computes orig_head.  Your clean_index() function that
is called from there roughly corresponds to the "read-tree --reset -u"
to reset the index to the HEAD's tree and then "read-tree -m -u" to
go to ORIG_HEAD from $index_tree.

> diff --git a/builtin/am.c b/builtin/am.c
> index 1399c8d..6aaa85d 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -1940,15 +1940,48 @@ static int fast_forward_to(struct tree *head, struct tree *remote, int reset)
>  }
>  
>  /**
> + * Merges a tree into the index. The index's stat info will take precedence
> + * over the merged tree's. Returns 0 on success, -1 on failure.
> + */
> +static int merge_tree(struct tree *tree)
> +{
> +...
> +}

This looks more like "git reset ORIG_HEAD" in the original above ;-)

> +
> +/**
>   * Clean the index without touching entries that are not modified between
>   * `head` and `remote`.
>   */
>  static int clean_index(const unsigned char *head, const unsigned char *remote)
>  {
> -	struct lock_file *lock_file;
>  	struct tree *head_tree, *remote_tree, *index_tree;
>  	unsigned char index[GIT_SHA1_RAWSZ];
> -	struct pathspec pathspec;
>  
>  	head_tree = parse_tree_indirect(head);
>  	if (!head_tree)
> @@ -1973,18 +2006,8 @@ static int clean_index(const unsigned char *head, const unsigned char *remote)
>  	if (fast_forward_to(index_tree, remote_tree, 0))
>  		return -1;
>  
> -	memset(&pathspec, 0, sizeof(pathspec));
> -
> -	lock_file = xcalloc(1, sizeof(struct lock_file));
> -	hold_locked_index(lock_file, 1);
> -
> -	if (read_tree(remote_tree, 0, &pathspec)) {
> -		rollback_lock_file(lock_file);
> +	if (merge_tree(remote_tree))
>  		return -1;
> -	}
> -
> -	if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
> -		die(_("unable to write new index file"));

And by getting rid of the call to "one-tree from scratch" form or
read_tree(), we can lose quite a lot of code from here.  Good ;-)

Note that "am skip" codepath also calls clean_index(), so this patch
would affect it.

Have you checked how this change affects that codepath?  To put it
differently, does "am skip" have the same issue without this fix?
If so, I wonder if we can have a test for that, too?

Thanks.

> diff --git a/t/t4151-am-abort.sh b/t/t4151-am-abort.sh
> index 05bdc3e..9c3bbd1 100755
> --- a/t/t4151-am-abort.sh
> +++ b/t/t4151-am-abort.sh
> @@ -168,4 +168,16 @@ test_expect_success 'am --abort on unborn branch will keep local commits intact'
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'am --abort leaves index stat info alone' '
> +	git checkout -f --orphan stat-info &&
> +	git reset &&
> +	test_commit should-be-untouched &&
> +	test-chmtime =0 should-be-untouched.t &&
> +	git update-index --refresh &&
> +	git diff-files --exit-code --quiet &&
> +	test_must_fail git am 0001-*.patch &&
> +	git am --abort &&
> +	git diff-files --exit-code --quiet
> +'
> +
>  test_done
