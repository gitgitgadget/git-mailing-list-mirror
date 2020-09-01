Return-Path: <SRS0=kr1+=CK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74741C433E2
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 07:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52E12204EC
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 07:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgIAHn4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Sep 2020 03:43:56 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:38662 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgIAHn4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Sep 2020 03:43:56 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id C6FCE1F66E;
        Tue,  1 Sep 2020 07:43:55 +0000 (UTC)
Date:   Tue, 1 Sep 2020 07:43:55 +0000
From:   Eric Wong <e@80x24.org>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH] core.abbrev <off|false|no> disables abbreviations
Message-ID: <20200901074355.GA4498@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These allows users to write hash-agnostic scripts and configs to
disable abbreviations.  Using "-c core.abbrev=40" will be
insufficient with SHA-256, and "-c core.abbrev=64" won't work
with SHA-1 repos today.

Signed-off-by: Eric Wong <e@80x24.org>
---
  I kinda wanted to allow a value of "max", but I figured the existing
  boolean falsiness words might make more sense with `--no-abbrev' in
  for some commands...  Naming is hard :x

 config.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/config.c b/config.c
index 2bdff4457b..f2e09c72ca 100644
--- a/config.c
+++ b/config.c
@@ -1217,6 +1217,10 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
 			return config_error_nonbool(var);
 		if (!strcasecmp(value, "auto"))
 			default_abbrev = -1;
+		else if (!strcasecmp(value, "false") ||
+			 !strcasecmp(value, "no") ||
+			 !strcasecmp(value, "off"))
+			default_abbrev = the_hash_algo->hexsz;
 		else {
 			int abbrev = git_config_int(var, value);
 			if (abbrev < minimum_abbrev || abbrev > the_hash_algo->hexsz)
