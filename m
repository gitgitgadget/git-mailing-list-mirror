Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31877C432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 09:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09E9F610A4
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 09:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240660AbhHZJGd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 05:06:33 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:40725 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240657AbhHZJG3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 05:06:29 -0400
Received: by mail-lj1-f181.google.com with SMTP id i28so3826893ljm.7
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 02:05:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=HNWJa9dY+JSwdQ6Xk1za51eSuRV1gwvpKw6lARfhBx0=;
        b=BdV4PT39SrbIhEGfIhxr2vfCeKVs2Zy9wpsKSSq++q53O6kV/Q5yTBJaVHre931Kxh
         J11iTIRDJaQtEpHF2JDUnyxMzLnMwzQk8itDUl8X2Vr9hssAfHIF3TTCUDxKfuwGxU+p
         sODRa4BzFt4h8TYV9Agml6IPcM8ID30DGQKxYre65oJ0vrK0mlpk++17hxrk3ZzExFoh
         uF7/SDh7i7Ju85dfWzz7QioJQLsMiaoDFtEck40dQjYZfQZgdQXzg8OFgelMoXnF6ONI
         Jc+hemBs2f1liJpp/tU3pbCqU4ExTc24tgst4eFIc5+q3pgLOgld7ca20/FrZr7Dy80l
         rEVQ==
X-Gm-Message-State: AOAM533LRhW5dbQb8P+ex8RWnpk6CuaOd9F0PsjfZEBfsMriOxluICwz
        tgPo4RwTEKgl7UfHhq/kqHe0KbvBQUuiobK4AvQylYP0bDLxxw==
X-Google-Smtp-Source: ABdhPJzPE2ffcB/oAIwXLqFkNk1TtNodcfiHZyn2tLDtuWr5VzuxBGFttW/+NYmrl41A7NT2FQDzlacPN804t8XhWpI=
X-Received: by 2002:a05:651c:1582:: with SMTP id h2mr2145103ljq.372.1629968741101;
 Thu, 26 Aug 2021 02:05:41 -0700 (PDT)
MIME-Version: 1.0
From:   Stefan Hoffmeister <Stefan.Hoffmeister@econos.de>
Date:   Thu, 26 Aug 2021 11:05:30 +0200
Message-ID: <CALhB_QN1k6=j8KQZcP6W3doiQ3BWZYFAKw9fRhVLz2ZRz9gm4g@mail.gmail.com>
Subject: Re: BUG: git diff --name-only ignores --ignore-*
To:     stefan.hoffmeister@gmail.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A quick peek suggests options to tackle this:

a) by including XDF_IGNORE_BLANK_LINES as an option that also forces a
content check
b) adjusting the implementation in diff_flush to better take into
account the specified --ignore-* flags

Now, looking closely at diff_flush it would seem as if all of the
command-line options
  --raw
  --name-only
  --name-status
might benefit from taking into account --ignore-*

So, in the end this is a matter intent and requirements - what should
happen whenever a user provided --ignore*?

From my point of view, git diff --raw, --name-only, name-status all
should honour --ignore-whitespace*, and all should also honour
--ignore-blank-lines

Below please find a patch which shows the code areas affected;
implementation quality is not acceptable as-is (logic distributed
across the function), because I'd love to get some feedback on --raw
and --name-status and the general approach.

*********************

diff --git a/diff.c b/diff.c
index a8113f1707..7b19cfa5f0 100644
--- a/diff.c
+++ b/diff.c
@@ -4645,11 +4645,13 @@ void diff_setup_done(struct diff_options *options)
/*
* Most of the time we can say "there are changes"
* only by checking if there are changed paths, but
- * --ignore-whitespace* options force us to look
- * inside contents.
+ * options
+ * --ignore-whitespace*
+ * --ignore-blank-lines
+ * force us to look inside contents.
*/
- if ((options->xdl_opts & XDF_WHITESPACE_FLAGS) ||
+ if ((options->xdl_opts & (XDF_WHITESPACE_FLAGS | XDF_IGNORE_BLANK_LINES)) ||
options->ignore_regex_nr)
options->flags.diff_from_contents = 1;
else
@@ -6408,10 +6410,10 @@ void diff_flush(struct diff_options *options)
if (!q->nr)
goto free_queue;
- if (output_format & (DIFF_FORMAT_RAW |
- DIFF_FORMAT_NAME |
+ if ((output_format & (DIFF_FORMAT_RAW |
DIFF_FORMAT_NAME_STATUS |
- DIFF_FORMAT_CHECKDIFF)) {
+ DIFF_FORMAT_CHECKDIFF)) ||
+ (output_format & DIFF_FORMAT_NAME && !options->flags.diff_from_contents)) {
for (i = 0; i < q->nr; i++) {
struct diff_filepair *p = q->queue[i];
if (check_pair_status(p))
@@ -6449,9 +6451,10 @@ void diff_flush(struct diff_options *options)
separator++;
}
- if (output_format & DIFF_FORMAT_NO_OUTPUT &&
+ if ((output_format & DIFF_FORMAT_NO_OUTPUT &&
options->flags.exit_with_status &&
- options->flags.diff_from_contents) {
+ options->flags.diff_from_contents)) ||
+ (output_format & DIFF_FORMAT_NAME && options->flags.diff_from_contents) {
/*
* run diff_flush_patch for the exit status. setting
* options->file to /dev/null should be safe, because we
