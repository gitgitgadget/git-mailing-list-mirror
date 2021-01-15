Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A90C433DB
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 16:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E13EB238EF
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 16:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbhAOQTq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 11:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbhAOQTq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 11:19:46 -0500
X-Greylist: delayed 142 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 15 Jan 2021 08:19:05 PST
Received: from joooj.vinc17.net (joooj.vinc17.net [IPv6:2001:4b99:1:3:216:3eff:fe20:ac98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EC6C0613C1
        for <git@vger.kernel.org>; Fri, 15 Jan 2021 08:19:05 -0800 (PST)
Received: from smtp-zira.vinc17.net (128.119.75.86.rev.sfr.net [86.75.119.128])
        by joooj.vinc17.net (Postfix) with ESMTPSA id 142624B7;
        Fri, 15 Jan 2021 17:16:00 +0100 (CET)
Received: by zira.vinc17.org (Postfix, from userid 1000)
        id B8DE5C201E2; Fri, 15 Jan 2021 17:15:59 +0100 (CET)
Date:   Fri, 15 Jan 2021 17:15:59 +0100
From:   Vincent Lefevre <vincent@vinc17.net>
To:     git@vger.kernel.org
Subject: git fails with a broken pipe when one quits the pager
Message-ID: <YAG/vzctP4JwSp5x@zira.vinc17.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer-Info: https://www.vinc17.net/mutt/
User-Agent: Mutt/2.0.4+79 (53181e6b) vl-132933 (2021-01-14)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I had reported the following bug at
  https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=914896

It still occurs with Git 2.30.0.

Some git commands with a lot of output fail with a broken pipe when
one quits the pager (without going to the end of the output).

For instance, in zsh:

cventin% setopt PRINT_EXIT_VALUE
cventin% git log
zsh: broken pipe  git log
cventin% echo $?
141
cventin% 

This is annoying. And of course, I don't want to hide error messages
by default, because this would hide *real* errors.

The broken pipe is internally expected, thus should not be reported
by git.

Just to be clear: this broken pipe should be discarded only when git
uses its builtin pager feature, not with a general pipe, where the
error may be important.

For instance,

$ { git log ; echo "Exit status: $?" >&2 ; } | true

should still output

Exit status: 141

like currently.

-- 
Vincent Lefèvre <vincent@vinc17.net> - Web: <https://www.vinc17.net/>
100% accessible validated (X)HTML - Blog: <https://www.vinc17.net/blog/>
Work: CR INRIA - computer arithmetic / AriC project (LIP, ENS-Lyon)
