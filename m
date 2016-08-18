Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 233D91FD99
	for <e@80x24.org>; Thu, 18 Aug 2016 00:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753960AbcHRAvt (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 20:51:49 -0400
Received: from mga09.intel.com ([134.134.136.24]:3579 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753936AbcHRAvg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 20:51:36 -0400
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP; 17 Aug 2016 17:51:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,536,1464678000"; 
   d="scan'208";a="157475894"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.116])
  by fmsmga004.fm.intel.com with ESMTP; 17 Aug 2016 17:51:33 -0700
From:	Jacob Keller <jacob.e.keller@intel.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <stefanbeller@gmail.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v7 4/7] submodule: allow do_submodule_path to work if given gitdir directly
Date:	Wed, 17 Aug 2016 17:51:28 -0700
Message-Id: <20160818005131.31600-5-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.10.0.rc0.217.g609f9e8.dirty
In-Reply-To: <20160818005131.31600-1-jacob.e.keller@intel.com>
References: <20160818005131.31600-1-jacob.e.keller@intel.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

Currently, do_submodule_path relies on read_gitfile, which will die() if
it can't read from the specified gitfile. Unfortunately, this means that
do_submodule_path will not work when given the path to a submodule which
is checked out directly, such as a newly added submodule which you
cloned and then "git submodule add". Instead, replace the call with
resolve_gitdir. This first checks to see if we've been given a gitdir
already.

Because resolve_gitdir may return the same buffer it was passed, we have
to check for this case as well, since strbuf_reset() will not work as
expected here, and indeed is not necessary.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 path.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/path.c b/path.c
index 17551c483476..d1af029152a2 100644
--- a/path.c
+++ b/path.c
@@ -477,8 +477,8 @@ static void do_submodule_path(struct strbuf *buf, const char *path,
 	strbuf_complete(buf, '/');
 	strbuf_addstr(buf, ".git");
 
-	git_dir = read_gitfile(buf->buf);
-	if (git_dir) {
+	git_dir = resolve_gitdir(buf->buf);
+	if (git_dir && git_dir != buf->buf) {
 		strbuf_reset(buf);
 		strbuf_addstr(buf, git_dir);
 	}
-- 
2.10.0.rc0.217.g609f9e8.dirty

