Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35505C4338F
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 23:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B9D361251
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 23:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhHUXxP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Aug 2021 19:53:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:55224 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229519AbhHUXxO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Aug 2021 19:53:14 -0400
Received: (qmail 866 invoked by uid 109); 21 Aug 2021 23:52:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 21 Aug 2021 23:52:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17085 invoked by uid 111); 21 Aug 2021 23:52:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 21 Aug 2021 19:52:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 21 Aug 2021 19:52:33 -0400
From:   Jeff King <peff@peff.net>
To:     TECOB270_Ganesh Pawar <pawarg256@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re:
Message-ID: <YSGRwUs8oj/r2MQf@coredump.intra.peff.net>
References: <CAAOR--EV5iixus=wY4ukO2VpE6Ktr=XtKB58FDCyUZ0OvqLuAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAOR--EV5iixus=wY4ukO2VpE6Ktr=XtKB58FDCyUZ0OvqLuAQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 21, 2021 at 08:10:59PM +0530, TECOB270_Ganesh Pawar wrote:

> To reproduce:
> 1. Set the contents of .git/hooks/prepare-commit-msg to this:
> ```
> #!/bin/sh
> 
> COMMIT_MSG_FILE=$1
> 
> echo "Initial Commit." > "$COMMIT_MSG_FILE"
> echo "" >> "$COMMIT_MSG_FILE"
> echo "# Some random comment." >> "$COMMIT_MSG_FILE"
> ```
> Notice the comment being added to the file.
> 
> 2. Append a commit with the --no-edit flag.
> `git commit --amend --no-edit`
> 
> The comment ("Some random comment" in this case) is included in the
> final commit message, but it shouldn't right?
> 
> If I don't pass the flag and just save the commit without changing
> anything, the comment isn't included. Shouldn't this be the case with
> the --no-edit flag too?

No, the behavior you're seeing is expected. Try this:

  git commit --cleanup=strip --amend --no-edit

The default for "--cleanup" is "strip" when the editor is run, and
"whitespace" otherwise. I.e., if Git did not insert comments, then it
doesn't remove them either.

If you have a hook which is inserting comments which may need to be
stripped, you may want to set the commit.cleanup config to tell Git to
always remove them (but beware that invocations like "git commit -F"
will also start stripping comments).

See "--cleanup" in "git help commit" for the possible values.

-Peff
