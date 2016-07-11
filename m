Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AF7F1F744
	for <e@80x24.org>; Mon, 11 Jul 2016 20:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbcGKUvg (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 16:51:36 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:33714 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751149AbcGKUvg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 16:51:36 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A6631F744
	for <git@vger.kernel.org>; Mon, 11 Jul 2016 20:51:35 +0000 (UTC)
From:	Eric Wong <e@80x24.org>
To:	git@vger.kernel.org
Subject: [RFC 0/3] dumb HTTP transport speedups
Date:	Mon, 11 Jul 2016 20:51:28 +0000
Message-Id: <20160711205131.1291-1-e@80x24.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

TL;DR: dumb HTTP clone from a certain badly-packed repo goes from
~2 hours to ~30 min memory usage drops from 2G to 360M


I hadn't packed the public repo at https://public-inbox.org/git
for a few weeks.  As an admin of a small server limited memory
and CPU resources but fairly good bandwidth, I prefer clients
use dumb HTTP for initial clones.

Unfortunately, I noticed my dinky netbook runs out-of-memory
when using GIT_SMART_HTTP=0 to clone this giant repo; and a
machine with more memory still takes over two hours depending
on network conditions (and uses around 2GB RSS!).

Anyways, https://public-inbox.org/git is better packed, now;
but I've kept https://80x24.org/git-i-forgot-to-pack available
with over 7K loose objects to illustrate the problem:

	(this is dumb HTTP-only)
	git clone --mirror https://80x24.org/git-i-forgot-to-pack

The primary problem is fixed by PATCH 3/3 in this series, and I
can now clone the above in around 30 minutes and "only" seems to
use around 360M memory.

I'll leave git-i-forgot-to-pack up for a few months/year
so others can test and hammer away at it.

The following changes since commit 5c589a73de4394ad125a4effac227b3aec856fa1:

  Third batch of topics for 2.10 (2016-07-06 13:42:58 -0700)

are available in the git repository at:

  git://bogomips.org/git-svn.git dumb-speedups

for you to fetch changes up to b9d5aca4b8e6c9f7fb5ee4e0ce33bb42c4ea2992:

  http-walker: reduce O(n) ops with doubly-linked list (2016-07-11 20:25:51 +0000)

----------------------------------------------------------------
Eric Wong (3):
      http-walker: remove unused parameter from fetch_object
      http: avoid disconnecting on 404s for loose objects
      http-walker: reduce O(n) ops with doubly-linked list

 http-walker.c |  55 ++++++++++----------
 http.c        |  16 +++++-
 list.h        | 164 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 204 insertions(+), 31 deletions(-)
 create mode 100644 list.h
