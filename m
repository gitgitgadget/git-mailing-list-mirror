From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git diff --exit-code does not honour textconv setting
Date: Wed, 6 Apr 2016 08:44:21 +0200
Message-ID: <5704B045.8000005@drmicha.warpmail.net>
References: <56EE9B09.6040700@gmail.com>
 <5703CA0D.2090808@drmicha.warpmail.net>
 <xmqqvb3vzlw5.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Georg Pichler <georg.pichler@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 08:44:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anhCZ-0006Fp-5m
	for gcvg-git-2@plane.gmane.org; Wed, 06 Apr 2016 08:44:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752754AbcDFGoZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 02:44:25 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:58756 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750731AbcDFGoY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Apr 2016 02:44:24 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 264A620F78
	for <git@vger.kernel.org>; Wed,  6 Apr 2016 02:44:23 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute5.internal (MEProxy); Wed, 06 Apr 2016 02:44:23 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=3NaezHBgZNzceiuuIBP25fhl/pA=; b=TNEl9i
	wQqJVt5VbNcdaBepESushKYnDXCl5qEic1bnPOXGJhCz4j4RpBJ2JguzlrzhBZMc
	9DJsjiRTX8T4hXcetUABLaipCvM16ZZwwC0Krgs24Mai1c8YF6bCYq2O007zix2k
	gw32M/+K4xylmnAe4sYRSynj8bCvBdEAbpqlc=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=3NaezHBgZNzceiu
	uIBP25fhl/pA=; b=VK7aglaGk91zz48Ose7pMYkrOLQHg2cBLX41QV8sSvlr5yA
	LX3Rmqock6QmV6R+V5ILm+ukAfX4l4R7Xe/f7BPxP+rtwBhO07YAiq4PYkZJQKqq
	6rU9BL2QObPXfpvlUjrArnXvsD6la2n7Lt9NmSU6f70B+m1isG6h1iBVjONc=
X-Sasl-enc: L+7bFWRkvfkotImVjAmBDtxjzeDGKJ7x2xA8S1KyocRl 1459925062
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id 62F076801DC;
	Wed,  6 Apr 2016 02:44:22 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.1
In-Reply-To: <xmqqvb3vzlw5.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290827>

Junio C Hamano venit, vidit, dixit 06.04.2016 01:16:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>>> The "test" command is used as it does not generate any output on stdout.
>>
>> "test" is a bit of a red herring here since it will receive commands.
>> But your example works even with "true" which ignores its commands and
>> produces no output.
> 
> Either sounds strange, as they exit without reading their input at
> all, so the other side of the pipe may get an write error it has to
> handle ;-)
> 
>> The description doesn't make it clear whether exit-code refers to
>> the actual diff (foo vs. bar) or to the diff after textconv (empty
>> vs. empty). In any case, "-b" should not make a difference for
>> your example.
>>
>> diff_flush() in diff.c has this piece of code:
>>
> 
> It is understandable that "-b" makes difference.  The actual
> short-cut happens a bit before the code you quoted.
> 
> 	if (output_format & DIFF_FORMAT_NO_OUTPUT &&
> 	    DIFF_OPT_TST(options, EXIT_WITH_STATUS) &&
> 	    DIFF_OPT_TST(options, DIFF_FROM_CONTENTS)) {
> 		/*
> 		 * run diff_flush_patch for the exit status. setting
> 		 * options->file to /dev/null should be safe, because we
> 		 * aren't supposed to produce any output anyway.
> 		 */
> 		if (options->close_file)
> 			fclose(options->file);
> 		options->file = fopen("/dev/null", "w");
> 		if (!options->file)
> 			die_errno("Could not open /dev/null");
> 		options->close_file = 1;
> 		for (i = 0; i < q->nr; i++) {
> 			struct diff_filepair *p = q->queue[i];
> 			if (check_pair_status(p))
> 				diff_flush_patch(p, options);
> 			if (options->found_changes)
> 				break;
> 		}
> 	}
> 
> When running without producing output but we need the exit status,
> unless DIFF_FROM_CONTENTS is set (e.g. "-b" in use), we do not run
> the code that would inspect the blob contents that would have
> produced the actual patch.  When DIFF_FROM_CONTENTS is set, we need
> to dig into the blob contents and the body of the above if() gets
> run only to trigger o->found_changes (e.g. in builtin_diff() that
> sets ecbdata.found_changesp to point at o->found_changes before
> calling into the xdiff machinery), but the output is discarded to
> /dev/null.
> 
> The textconv filter is an unfortunate beast, in that while some
> paths use one while others don't, so it won't be as simple as "-b"
> that flips DIFF_FROM_CONTENTS to say "We need to inspect blobs for
> ALL FILEPAIRS to see if there is any difference" if we want to keep
> the optimization as much as possible.
> 
> Without DIFF_FROM_CONTENTS set, any filepair that point at two
> different blobs that might end up to be the same after applying
> textconv will flip the o->found_changes bit on, and with
> EXIT_WITH_STATUS bit on, we have another optimization to skip
> checking the remainder of the filepairs.  So if you want to support
> textconv with QUICK, you would also need to disable that
> optimization by teaching diff_change() to refrain from setting
> HAS_CHANGES bit, i.e.
> 
>     diff --git a/diff.h b/diff.h
>     index 125447b..f6c0c07 100644
>     --- a/diff.h
>     +++ b/diff.h
>     @@ -69,7 +69,7 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
>      #define DIFF_OPT_FIND_COPIES_HARDER  (1 <<  6)
>      #define DIFF_OPT_FOLLOW_RENAMES      (1 <<  7)
>      #define DIFF_OPT_RENAME_EMPTY        (1 <<  8)
>     -/* (1 <<  9) unused */
>     +#define DIFF_OPT_WITH_TEXTCONV       (1 <<  9)
>      #define DIFF_OPT_HAS_CHANGES         (1 << 10)
>      #define DIFF_OPT_QUICK               (1 << 11)
>      #define DIFF_OPT_NO_INDEX            (1 << 12)
> 
>     diff --git a/diff.c b/diff.c
>     index 4dfe660..0016ad2 100644
>     --- a/diff.c
>     +++ b/diff.c
>     @@ -5018,6 +5018,11 @@ void diff_change(struct diff_options *options,
>             two->dirty_submodule = new_dirty_submodule;
>             p = diff_queue(&diff_queued_diff, one, two);
> 
>     +       if (either path one or path two has textconv defined) {
>     +               DIFF_OPT_SET(options, DIFF_WITH_TEXTCONV);
>     +               return;
>     +       }
>     +
>             if (DIFF_OPT_TST(options, DIFF_FROM_CONTENTS))
>                     return;
> 
> And then in order to keep the optimization, add this to the above
> codepath:
> 
>     diff --git a/diff.c b/diff.c
>     index 4dfe660..7b318cc 100644
>     --- a/diff.c
>     +++ b/diff.c
>     @@ -4598,6 +4598,7 @@ void diff_flush(struct diff_options *options)
>             int i, output_format = options->output_format;
>             int separator = 0;
>             int dirstat_by_line = 0;
>     +       int textconv_hack;
> 
>             /*
>              * Order: raw, stat, summary, patch
>     @@ -4652,9 +4653,17 @@ void diff_flush(struct diff_options *options)
>                     separator++;
>             }
> 
>     +       /*
>     +        * If there is any path that needs textconv and we haven't
>     +        * found any change on paths that don't, we need to pass
>     +        * them through textconv and see the textual difference.
>     +        */
>     +       textconv_hack = (DIFF_OPT_TST(options, DIFF_WITH_TEXTCONV) &&
>     +                        !DIFF_OPT_TST(options, HAS_CHANGES));
>     +
>             if (output_format & DIFF_FORMAT_NO_OUTPUT &&
>                 DIFF_OPT_TST(options, EXIT_WITH_STATUS) &&
>     -           DIFF_OPT_TST(options, DIFF_FROM_CONTENTS)) {
>     +           (textconv_hack || DIFF_OPT_TST(options, DIFF_FROM_CONTENTS))) {
>                     /*
>                      * run diff_flush_patch for the exit status. setting
>                      * options->file to /dev/null should be safe, because we
> 
> so that if we find some other change (e.g. diff_addremove() noticed
> a path added or removed, or diff_change() noticed a changed blob
> that does not have textconv defined), we do not have to inspect all
> the paths to see if there is any change at all by going into the
> body of this if() block.
> 
> And then finally, clean things up in a way similar to how
> DIFF_FROM_CONTENTS codepath handles the HAS_CHANGES bit.
> 
>     diff --git a/diff.c b/diff.c
>     index 4dfe660..7b318cc 100644
>     --- a/diff.c
>     +++ b/diff.c
>     @@ -4709,7 +4718,7 @@ free_queue:
>              * diff_addremove/diff_change does not set the bit when
>              * DIFF_FROM_CONTENTS is in effect (e.g. with -w).
>              */
>     -       if (DIFF_OPT_TST(options, DIFF_FROM_CONTENTS)) {
>     +       if (textconv_hack || DIFF_OPT_TST(options, DIFF_FROM_CONTENTS)) {
>                     if (options->found_changes)
>                             DIFF_OPT_SET(options, HAS_CHANGES);
>                     else
> 
> By the way, I have a suspicion that the existing code immediately
> after the context of this hunk is wrong to clear HAS_CHANGES bit
> when options->found_changes is clear.  HAS_CHANGES bit should be
> clear upon entry to this function, when DIFF_FROM_CONTENTS is in
> use.
> 
> I also suspect that addremove() that refrains from setting
> HAS_CHANGES when DIFF_FROM_CONTENTS is in effect is wrong.  No
> matter what combination of -w or -b is used, an addition of a new
> file, or a removal of an existing file, is a change.
> 

We certainly share that suspicion.

Even with your clear explanations, I still can't wrap my brain
completely around that flow of different cases. But in any case:

--textconv is about presenting blobs (and, as a consequence diffs) to
the user.

--name-status and the like are about differences between the actual
objects (irrespective of any possibly coinciding textual representation)

Shouldn't "--exit-code" rather be in the "name-status ballpark" than in
the "textconv ballpark", i.e. signal that there are changes irrespective
of representation?

On the other hand, if "--exit-code" should be in the "textconv ballbark"
then, e.g., it should return 0 resp. 1 on a file with mere white space
changes when run with resp. without "-w", which means we can never use
optimizations with --exit-code, or more correctly: optimization (quick)
can identify "equal" (equal blobs produce equal textual representations)
but not "unequal". textconv filters are functions, but not necessarily
injective. So we could keep "quick" in the presumably more common case
of equal blobs.

Michael
