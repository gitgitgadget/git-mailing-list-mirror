Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A5E31FAE5
	for <e@80x24.org>; Wed,  7 Jun 2017 10:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751576AbdFGKeT (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 06:34:19 -0400
Received: from ikke.info ([178.21.113.177]:34114 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751460AbdFGKeS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 06:34:18 -0400
Received: by vps892.directvps.nl (Postfix, from userid 182)
        id 919624400B6; Wed,  7 Jun 2017 12:34:16 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.8.0.50])
        by vps892.directvps.nl (Postfix) with ESMTP id 79A8D4400AB;
        Wed,  7 Jun 2017 12:34:14 +0200 (CEST)
From:   Kevin Daudt <me@ikke.info>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>
Subject: [PATCH] Fourth batch for 2.14
Date:   Wed,  7 Jun 2017 12:33:41 +0200
Message-Id: <20170607103341.22596-1-me@ikke.info>
X-Mailer: git-send-email 2.13.0.rc2.2.g9b669787fc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Kevin Daudt <me@ikke.info>
---
 Documentation/RelNotes/2.14.0.txt | 55 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/Documentation/RelNotes/2.14.0.txt b/Documentation/RelNotes/2.14.0.txt
index ee6c6075a..d0f7ef559 100644
--- a/Documentation/RelNotes/2.14.0.txt
+++ b/Documentation/RelNotes/2.14.0.txt
@@ -44,6 +44,22 @@ UI, Workflows & Features
  * "git repack" learned to accept the --threads=<n> option and pass it
    to pack-objects.
 
+ * "git send-email" learned to run sendemail-validate hook to inspect
+   and reject a message before sending it out.
+   (merge 6489660b4b jt/send-email-validate-hook later to maint).
+
+ * There is no good reason why "git fetch $there $sha1" should fail
+   when the $sha1 names an object at the tip of an advertised ref,
+   even when the other side hasn't enabled allowTipSHA1InWant.
+
+ * The recently introduced "[includeIf "gitdir:$dir"] path=..."
+   mechansim has further been taught to take symlinks into account.
+   The directory "$dir" specified in "gitdir:$dir" may be a symlink to
+   a real location, not something that $(getcwd) may return.  In such
+   a case, a realpath of "$dir" is compared with the real path of the
+   current repository to determine if the contents from the named path
+   should be included.
+
 
 Performance, Internal Implementation, Development Support etc.
 
@@ -75,6 +91,24 @@ Performance, Internal Implementation, Development Support etc.
 
  * Conversion from uchar[20] to struct object_id continues.
 
+ * Simplify parse_pathspec() codepath and stop it from looking at the
+   default in-core index.
+   (merge 08de9151a8 bw/pathspec-sans-the-index later to maint).
+
+ * Add perf-test for wildmatch.
+   (merge 62ca75a6b9 ab/perf-wildmatch later to maint).
+
+ * Code from "conversion using external process" codepath has been
+   extracted to a separate sub-process.[ch] module.
+   (merge 4f2a2e9f0e bp/sub-process-convert-filter later to maint).
+
+ * When "git checkout", "git merge", etc. manipulates the in-core
+   index, various pieces of information in the index extensions are
+   discarded from the original state, as it is usually not the case
+   that they are kept up-to-date and in-sync with the operation on the
+   main index.  The untracked cache extension is copied across these
+   operations now, which would speed up "git status" (as long as the
+   cache is properly invalidated).
 
 
 Also contains various documentation updates and code clean-ups.
@@ -209,6 +243,26 @@ notes for details).
    should silently be ignored instead)
    (merge a3ba6bf10a jk/ignore-broken-tags-when-ignoring-missing-links later to maint).
 
+ * "git describe --contains" penalized light-weight tags so much that
+   they were almost never considered.  Instead, give them about the
+   same chance to be considered as an annotated tag that is the same
+   age as the underlying commit would.
+   (merge ef1e74065c jc/name-rev-lw-tag later to maint).
+
+ * The "run-command" API implementation has been made more robust
+   against dead-locking in a threaded environment.
+   (merge e3f43ce765 bw/forking-and-threading later to maint).
+
+ * A recent update to t5545-push-options.sh started skipping all the
+   tests in the script when a web server testing is disabled or
+   unavailable, not just the ones that require a web server.  Non HTTP
+   tests have been salvaged to always run in this script.
+   (merge 2e397e4ddf jc/skip-test-in-the-middle later to maint).
+
+ * "git send-email" now uses Net::SMTP::SSL, which is obsolete, only
+   when needed.  Recent versions of Net::SMTP can do TLS natively.
+   (merge 0ead000c3a dk/send-email-avoid-net-smtp-ssl-when-able later to maint).
+
  * Other minor doc, test and build updates and code cleanups.
    (merge 515360f9e9 jn/credential-doc-on-clear later to maint).
    (merge 0e6d899fee ab/aix-needs-compat-regex later to maint).
@@ -217,3 +271,4 @@ notes for details).
    (merge c8f7c8b704 tb/dedup-crlf-tests later to maint).
    (merge 449456ad47 sg/core-filemode-doc-typofix later to maint).
    (merge ba4dce784e km/log-showsignature-doc later to maint).
+   (merge c5a9157393 jh/memihash-opt later to maint).
-- 
2.13.0.rc2.2.g9b669787fc

