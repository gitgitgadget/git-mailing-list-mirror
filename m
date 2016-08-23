Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B15641FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 17:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753656AbcHWRBM (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 13:01:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52036 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751676AbcHWRBL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 13:01:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 799ED35C92;
        Tue, 23 Aug 2016 13:01:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=o72vkEXpWR34as7UrRmUZE7TT+s=; b=R7m1wE
        I0riVmtmXDy8Fv/Gtq5CCObY+5g+NikTvveCwRD9xVFG87yexdKEGjsCrTJM0lKb
        Irb7Id08euB0qQmiDrMzhlh/cbcD3aSycDl+40N2PXsNfYZQycFC1hQE08vzYqyt
        zgj6bOucT/jbkRyxHiGUoQ6basYh2li5FqkZg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jSVCQ4FreW01NDT/0qK4bEXviBBLX7Il
        4rxliNZZg+ifUtp3T6h0Vge1bQiQ8ob+USbLMmE4WlYAI74ZVnbE5hZvxWNGUGM1
        c9aQ6hNlF0mUEfeforrnoBnAwSVBDLe3KVZyErnYrtRmoHYJEIGUUHMf4iWVG9bm
        VuYGLyyEGIg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6FCBA35C91;
        Tue, 23 Aug 2016 13:01:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D989D35C8F;
        Tue, 23 Aug 2016 13:01:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v2 7/7] blame: actually use the diff opts parsed from the command line
References: <cover.1471864378.git.mhagger@alum.mit.edu>
        <8192012a6bf725e0460522f9e67bab83b613127a.1471864378.git.mhagger@alum.mit.edu>
Date:   Tue, 23 Aug 2016 10:01:07 -0700
In-Reply-To: <8192012a6bf725e0460522f9e67bab83b613127a.1471864378.git.mhagger@alum.mit.edu>
        (Michael Haggerty's message of "Mon, 22 Aug 2016 13:22:46 +0200")
Message-ID: <xmqqtwebwhbg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3095455A-6953-11E6-AF4B-E86612518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Somebody who knows more about how diff operations are configured
> should please review this. I'm not certain that the change as
> implemented won't have other unwanted side-effects, though of course
> I checked that the test suite runs correctly.

Generally, I think this is a bad idea.  

We run "diff-tree" internally for multiple purposes:

 - When the same path we are drilling down appears, we use diff-tree
   to compare that path alone, to obtain textual diff, so that we
   can say "what did not appear in the textual diff output are
   attributable to the parent commit, we can exonerate this child".

   Even if the command line to "git blame" had "-Sfoo", you do not
   want to pass it down to this invocation.  If the child did not
   change the number of occurrences of string "foo" in the path
   being drilled down, it will pass down the blame for all lines to
   the parent.  And copying -R from the command line to this
   invocation does not make any sense.  Copying -C -C from the
   command line will defeat the whole purpose of having find_origin
   vs find_rename distinction, I would think, for this step.

 - When the path we have been drilling down for no longer appears in
   the parent, we use diff-tree with rename detection to find where
   the file _could_ have come from.

   It is a good idea to allow the similarity threshold to be tweaked
   from the command line.  Copying -R from the command line to this
   invocation may make sense, but I think you would break this step
   if you copied -C/-C -C

 - When -C/-C -C/-C -C -C is given from the command line, after
   running the "pass the blame to our primary suspect", we run
   tree-level diff-tree with find-copy option, only to enumerate
   paths that appear in the parent.  We pick pieces from these paths
   by doing blob-level diffs in diff_hunks() ourselves.  Copying -C
   from the command line would be useful if you are only doing a
   single '-C' (because it would allow you to tweak the similarity
   threshold), but otherwise it would probably break the command.

The design principle taken in "git blame" is to leave the decision
on what diff options do or do not make sense for these particular
invocations of the internal "diff-tree", and have "blame" give the
selected options to the internal "diff-tree" invocations.  "-w"
happens to use xdl_opts that will eventually be passed down to diff
machinery but you should consider it an accidental optimization
(i.e. "blame" designer considered that it makes sense to give
whitespace-ignoring comparison at the leaf-level "diff between
blobs", and found that the most efficient way to do so is to just
take "-w" from the command line and set the ignore-whitespace bit
used to drive the internal "diff-tree" invocation).  If we _were_
adding -R<num> to allow the users to affect similarity threshold,
we would parse it in "git blame" command line option processing,
and would give that _ONLY_ to the second invocation above, i.e. the
one done in find_rename() but not in others like in find_origin.





