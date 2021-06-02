Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052B0C47093
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 15:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0DFA61246
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 15:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbhFBPWc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 11:22:32 -0400
Received: from mail.efficios.com ([167.114.26.124]:36804 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbhFBPWU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 11:22:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 6B491303338;
        Wed,  2 Jun 2021 11:20:36 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id oA9Znan3JO-5; Wed,  2 Jun 2021 11:20:36 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id EA75D3034A8;
        Wed,  2 Jun 2021 11:20:35 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com EA75D3034A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1622647235;
        bh=Uwm6mYAnQeCAyeFqmmDWETNfM8TkaJyhdProBbIWoVY=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=IYb5iAHF95VdbAlykkiJH1VcMtofjpo/R7H3jJFwLUTTzLd9OhxPhBIGBlGs8EUqs
         pQfrQbHRO5KJjCOql7wJv9YiO36Fx0zE1hDUjTfvaHkxVkTalro2J7FtDwSHcNS/hP
         bV7GNKUX0+FB4exGP8MHYR+EFqyEkiWUwp8jOo9mTpWTQ/OyXLUN2zpiswRIoBnSKj
         Hhe2RCiuqbPWH5hWAGrXwSXtcAXDLQQznnI3BtbQKEUSp+AS+iixZ+hJwRG/SPOgi9
         E81ociALpdpcTu1slRN/mZJarsrb+n4CBeggaWR/6dg5pY9s72fLXOhRqb60FkgFbp
         8pi8Y9CI+BItA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dHpPiLGh3TOw; Wed,  2 Jun 2021 11:20:35 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id DA1A6303337;
        Wed,  2 Jun 2021 11:20:35 -0400 (EDT)
Date:   Wed, 2 Jun 2021 11:20:35 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     git@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Message-ID: <30399052.5964.1622647235870.JavaMail.zimbra@efficios.com>
Subject: git feature request: git blame --ignore-cleanup/--ignore-trivial
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - FF88 (Linux)/8.8.15_GA_4026)
Thread-Index: CgspAIu30m0Vwa253dc6f6g5DlZX3A==
Thread-Topic: git feature request: git blame --ignore-cleanup/--ignore-trivial
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Following a discussion with Peter Zijlstra about whether code cleanup
and functional changes done to the Linux kernel scheduler belong to separate
patches or should be folded together, the argument for folding cleanup
and function changes came to be mainly motivated by the current behavior
of git blame: code cleanup patches end up burying the important changes so
it becomes cumbersome to find them using git blame.

Considering the added value brought by splitting cleanups from functional changes
from a maintainer perspective (easier reverts) and from a reviewer perspective
(easier to focus on the functional changes), I think it would be good to improve
the git tooling to allow easily filtering out the noise from git blame.

Perhaps a new git blame "--ignore-trivial" and/or "--ignore-cleanup" could solve
this by filtering out "trivial" and "cleanup" patches from the history it considers.

Tagging patches as trivial and cleanup should be done in the patch commit message
(possibly in the title), and enforcing proper tagging of commits is already the
responsibility of the maintainer merging those cleanup/trivial commits into the
Linux kernel anyway.

Under the hood, I suspect it could use something similar to git log --grep=<pattern>
--invert-grep.

This should allow git blame users to easily filter out the noise and focus on the relevant
functional changes.

Any maybe the patterns associated to "cleanup" and "trivial" commits should be something
that can be configured through a git config file.

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
