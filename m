Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302F0C433EF
	for <git@archiver.kernel.org>; Mon,  9 May 2022 23:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbiEIXWb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 19:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbiEIXWa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 19:22:30 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5B051333
        for <git@vger.kernel.org>; Mon,  9 May 2022 16:18:34 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D64CE1365BF;
        Mon,  9 May 2022 19:18:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=554+IYPmMv4Y/M2WPBIEOXfsJdJXwBy44nA9Yw
        XS1YM=; b=np0wWARMbgI662rzk/Ggme8Lzt6KKBOaom3rFH/o9DkQGYCBDxGw28
        AP0i89r/JNB8vZ3umNQFl+umI0KFawCYAR95Ox73FNFmYi1MQx2gou3N3Ple6XAI
        u3JIc37KTu00rcsgT+R75sI+R+vozhz1wmr6xBUR9ElDFNyyvJ7UM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CDAC01365BE;
        Mon,  9 May 2022 19:18:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2D3DE1365BD;
        Mon,  9 May 2022 19:18:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Timo Funke <timoses@msn.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Weird behaviour of git diff-index in container
References: <VI1PR0402MB28779C7A41783472B2EF6823BFC69@VI1PR0402MB2877.eurprd04.prod.outlook.com>
Date:   Mon, 09 May 2022 16:18:32 -0700
In-Reply-To: <VI1PR0402MB28779C7A41783472B2EF6823BFC69@VI1PR0402MB2877.eurprd04.prod.outlook.com>
        (Timo Funke's message of "Mon, 9 May 2022 22:42:14 +0000")
Message-ID: <xmqqy1za9tx3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 584A0C2C-CFEE-11EC-A15E-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Timo Funke <timoses@msn.com> writes:

>> container# git diff-index --quiet HEAD -- ; echo $?
> 1
>> container# git status
> On branch master
> nothing to commit, working tree clean
>> container# git diff-index --quiet HEAD -- ; echo $?
> 0

This is unfortunately very much expected and doubly unfortunately
not very well documented.  Patches to update documentation is very
much welcomed, but such a patch cannot be written in void, so let's
explain what is going on.

To detect paths that have not been modified quickly, Git uses the
mechanism called "cached stat data" in the index.  Among the cached
stat data is the timestamp of the last modification of each file.
By noting that the fact that the last time it checked, the contents
in the file on the filesystem hasn't been modified, together with
the file timestamp observed at the time of such a check, the next
time somebody asks "please compute 'git diff'", Git can notice that
the timestamp of the working tree file hasn't changed and say "no,
there is no change" without looking at the contents.

Now, when the file on the filesystem is "touched" in a way that its
timestamp gets updated without changing the contents (hence, if
there weren't the above optimization, diff would have said "no
change"), Git will think there is a change in the file.

There are two levels of Git subcommands.  Porcelain commands, like
"git diff", are end-user facing and are optimized more for usability
than performance.  "git diff --quiet HEAD --" in the above scenario
WILL notice that there is no change in the contents after all and
exit with 0 (unless diff.autoRefreshIndex configuration is set to
false).  The way they do so is by refreshing the "cached stat data"
automatically before using, and that operation is called "refreshing
the index" (hence the configuration variable name to disable it).

On the other hand, plumbing commands, like "git diff-files" and "git
diff-index", are designed to be used in scripts, number of times,
and do not want to pay the cost of refreshing the index always
before working.  The correct way to use them in a repository whose
current state you do not know about is to first "refresh the index"
by running the command to do so,  e.g. "git update-index --refresh"
before doing anything else.

If you were to run "git diff-files" and "git diff-index HEAD" in a
row in order to compute what "git status" would give you, for
example, you do not need to and want to pay the cost of refreshing
the index twice.  You run "git update-index --refresh" once, and
then run "git diff-files".  Doing so would not change the contents
of the working tree files, so you do not have to refresh the index
again after that, before running "git diff-index HEAD".  That is why
these plumbing commands do not refresh the index themselves.  They
expect you to be refreshing the index before you call them.

"git status" is one of the commands (as a Porcelain) that refreshes
the index automatically, so it is very much understandable that the
same "diff-index --quiet" behaves differently after running it once
and until you touch/smudge the working tree files.

