Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B38C61F454
	for <e@80x24.org>; Fri,  8 Nov 2019 02:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbfKHCc6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 21:32:58 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59003 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbfKHCc5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 21:32:57 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5821496763;
        Thu,  7 Nov 2019 21:32:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=80JGSo3es5TFqvrjuPhoEEErER4=; b=EKjCc0
        eXQ5E4gBT1yE2o9n6EfEsKkieWdUl2jMNQNnnoJhq3p37ntXSBs12kJlV6XHYeEp
        +dT2RzSqpCGiGBK4vE7j9Snb4yrl67dvyDzizQwTP8r9ULEA4D/b/OK957JEK5OO
        p6UpGGI/gaccDjX79GSLmJFly2cOlPyCIMd+o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=P6WbmfW9sPLJyNDmR1QKl4PZ3PMjHWkm
        byudRn639e+B7O62inRn0SLiyYWsQAn6YLvfMOe5pRAqnXT8zowEnye0/U+5kbrv
        iEF52vNtQtHdapu7lBC7/CFlP/eTpOjzpi9xCvx3a39iGhN7b3ID2okqJ3cRbGsN
        bxBD3dFXojM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 50BA196762;
        Thu,  7 Nov 2019 21:32:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7B2B39675B;
        Thu,  7 Nov 2019 21:32:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Grzegorz Rajchman <rayman17@gmail.com>, git@vger.kernel.org
Subject: Re: [BUG] git stash pop --quiet deletes files in git 2.24.0
References: <CAMcnqp22tEFva4vYHYLzY83JqDHGzDbDGoUod21Dhtnvv=h_Pg@mail.gmail.com>
        <20191107184912.GA3115@cat>
Date:   Fri, 08 Nov 2019 11:32:50 +0900
In-Reply-To: <20191107184912.GA3115@cat> (Thomas Gummerer's message of "Thu, 7
        Nov 2019 18:49:12 +0000")
Message-ID: <xmqq7e4bp06l.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 10393140-01D0-11EA-A344-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> On 11/07, Grzegorz Rajchman wrote:
>> Hi, this is the first time I report an issue in git so I hope I'm
>> doing it right.
>
> Thanks for the report.  You are indeed doing this right, and the
> included reproduction is very helpful.
>
> I broke this in 34933d0eff ("stash: make sure to write refreshed
> cache", 2019-09-11), which wasn't caught by the tests, nor by me as I
> don't use the --quiet flag normally.
>
> Below is a fix for this, but I want to understand the problem a bit
> better and write some tests before sending a patch.

OK, thanks for quickly looking into this.

The commit added two places where refresh_and_write_cache() gets
called.

The first one at the very beginning of do_apply_stash() used to be
refresh_cache() that immediately follows read_cache_preload().  We
are writing back exactly what we read from the filesystem [*], so
this should be a no-op from the correctness POV, with benefit of
having a refreshed cache on disk.

	Side note.  This argument assumes that no caller has called
	read_cache() before calling us and did its own in-core index
	operation.  In such a case, the in-core index is already out
	of sync with the on-disk one due to our own operation, and
	read_cache() will not overwrite already initilized in-core
	index, so we will write out what the original code did not
	want to, which would be a bug.

The second one happens after we do all the 3-way merges to replay
the change between the base commit and the working tree state
recorded in the stash, and then adjust the index to the desired
state:

 - If we are propagating the change to the index recorded in the
   stash to the current index, reset_tree() reads the index_tree
   that has been computed earlier in the function to update the
   in-core index and the on-disk index.

 - Otherwise, we compute paths added between the base commit and the
   working tree state recorded in the stash (i.e. those that were
   created but not yet commited when the stash was made), go back to
   the in-core index state we had upon entry to this function
   (i.e. c_tree), and then add these new paths from the working tree
   directly to the on-disk index without updating the in-core
   index.  Notice that this leaves the in-core index stale wrt the
   on-disk index---but the stale in-core index gets discarded.

Then the code goes on to do:

 - under --quiet, refresh_cache() used to be called to silently
   refresh the in-core index.  34933d0eff made it to also write the
   in-core index to on-disk index.  OOPS.  The in-core index has
   been discarded at this point.

 - otherwise, "git status" is spawned and directly acted on the
   on-disk index (this also has a side effect of writing a refreshed
   on-disk index).

So, I do not think removing that discard_cache() alone solves the
breakage exposed by 34933d0eff.  Discarding and re-reading the
on-disk index there would restore correctness, but then you would
want to make sure that we are not wasting the overall cost for the
I/O and refreshing.

I think the safer immediate short-term fix is to revert the change
to the quiet codepath and let it only refresh the in-core index.

> index ab30d1e920..2dd9c9bbcd 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -473,22 +473,20 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
>  
>                 if (reset_tree(&c_tree, 0, 1)) {
>                         strbuf_release(&out);
>                         return -1;
>                 }
>  
>                 ret = update_index(&out);
>                 strbuf_release(&out);
>                 if (ret)
>                         return -1;
> -
> -               discard_cache();
>         }
>  
>         if (quiet) {
>                 if (refresh_and_write_cache(REFRESH_QUIET, 0, 0))
>                         warning("could not refresh index");
>         } else {
>                 struct child_process cp = CHILD_PROCESS_INIT;
