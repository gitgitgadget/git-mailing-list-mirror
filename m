Return-Path: <SRS0=/qQH=ZU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DE5C432C0
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 00:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51912208E4
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 00:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfK1AmD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 19:42:03 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:52822 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727008AbfK1AmD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 19:42:03 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 724071F463;
        Thu, 28 Nov 2019 00:42:02 +0000 (UTC)
Date:   Thu, 28 Nov 2019 00:42:02 +0000
From:   Eric Wong <e@80x24.org>
To:     Colin Stolley <cstolley@runbox.com>
Cc:     git@vger.kernel.org
Subject: hashmap vs khash? Re: [PATCH] packfile.c: speed up loading lots of
 packfiles.
Message-ID: <20191128004202.GA25910@dcvr>
References: <20191127222453.GA3765@owl.colinstolley.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191127222453.GA3765@owl.colinstolley.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Colin Stolley <cstolley@runbox.com> wrote:
> When loading packfiles on start-up, we traverse the internal packfile
> list once per file to avoid reloading packfiles that have already
> been loaded. This check runs in quadratic time, so for poorly
> maintained repos with a large number of packfiles, it can be pretty
> slow.

Cool!  Thanks for looking into this, and I've been having
trouble in that department with big alternates files.

> Add a hashmap containing the packfile names as we load them so that
> the average runtime cost of checking for already-loaded packs becomes
> constant.

Btw, would you have time to do a comparison against khash?

AFAIK hashmap predates khash in git; and hashmap was optimized
for removal.   Removals don't seem to be a problem for pack
loading.

I'm interested in exploring the removing of hashmap entirely in
favor of khash to keep our codebase smaller and easier-to-learn.
khash shows up more in other projects, and ought to have better
cache-locality.

Thanks again.
