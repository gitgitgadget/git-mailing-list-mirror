Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745F5C2D0FB
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51C5D20675
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="wYjcKk7g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732017AbgEMAzO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 20:55:14 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38198 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731991AbgEMAzK (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 May 2020 20:55:10 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D9DDF609CF;
        Wed, 13 May 2020 00:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589331279;
        bh=4rEdmRrkp7YTyoWHj6LeQnNui2xThC7IUvb10raiKlY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=wYjcKk7gk+FQ3iJshZNTRgdJT5eNONMlgB9kgevRSBSIOY//cxS7JQ8FIr8B5tc5c
         xBOmh0RFYxdaX8FdavR9g9Mua9LZM2RRpWwPlpbZY+kSnQ1+b+N9O7GuLfvLC+p/fO
         2lEYIaxGHbsHsflcubMp/Jd0bDalj+hgSqxkwORlryYigCYweRpnL+L2poyJ4QCU/K
         kUl0ZgncqKPeXDBNKkqWCAu6EqD2qaECDq78Udhuyw7FrXEUXUtrMod4r6uF04QLMr
         TfV5JAJwB2NCH6CwCPSF84YHBLkrDyT0UY1DmLN+c7Wi90SbAvrZvF3GYSLwKWZz2H
         Sy5/SqC/P9LrLh7NM8BPOAsG5E2BKEDWRFSDDviDW8glxpAxmdUndVyNTpFbmwUkd9
         oSuSw0uRaTLuFfdtaO6oeEyXxtulIojmDQIrCEYA5VHoHdoR/lgbF3yzTgMyJwaOp2
         +0rmGDm8CFRCV1AFn2aosJbCCVM6fbuHc8tL+RwwelzmbJcbbFu
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 03/44] connect: have ref processing code take struct packet_reader
Date:   Wed, 13 May 2020 00:53:43 +0000
Message-Id: <20200513005424.81369-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be
In-Reply-To: <20200513005424.81369-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a future patch, we'll want to access multiple members from struct
packet_reader when parsing references.  Therefore, have the ref parsing
code take pointers to struct reader instead of having to pass multiple
arguments to each function.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 connect.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/connect.c b/connect.c
index 23013c6344..641388a766 100644
--- a/connect.c
+++ b/connect.c
@@ -204,8 +204,9 @@ static void annotate_refs_with_symref_info(struct ref *ref)
 	string_list_clear(&symref, 0);
 }
 
-static void process_capabilities(const char *line, int *len)
+static void process_capabilities(struct packet_reader *reader, int *len)
 {
+	const char *line = reader->line;
 	int nul_location = strlen(line);
 	if (nul_location == *len)
 		return;
@@ -213,8 +214,9 @@ static void process_capabilities(const char *line, int *len)
 	*len = nul_location;
 }
 
-static int process_dummy_ref(const char *line)
+static int process_dummy_ref(const struct packet_reader *reader)
 {
+	const char *line = reader->line;
 	struct object_id oid;
 	const char *name;
 
@@ -234,9 +236,11 @@ static void check_no_capabilities(const char *line, int len)
 			line + strlen(line));
 }
 
-static int process_ref(const char *line, int len, struct ref ***list,
-		       unsigned int flags, struct oid_array *extra_have)
+static int process_ref(const struct packet_reader *reader, int len,
+		       struct ref ***list, unsigned int flags,
+		       struct oid_array *extra_have)
 {
+	const char *line = reader->line;
 	struct object_id old_oid;
 	const char *name;
 
@@ -260,9 +264,10 @@ static int process_ref(const char *line, int len, struct ref ***list,
 	return 1;
 }
 
-static int process_shallow(const char *line, int len,
+static int process_shallow(const struct packet_reader *reader, int len,
 			   struct oid_array *shallow_points)
 {
+	const char *line = reader->line;
 	const char *arg;
 	struct object_id old_oid;
 
@@ -315,20 +320,20 @@ struct ref **get_remote_heads(struct packet_reader *reader,
 
 		switch (state) {
 		case EXPECTING_FIRST_REF:
-			process_capabilities(reader->line, &len);
-			if (process_dummy_ref(reader->line)) {
+			process_capabilities(reader, &len);
+			if (process_dummy_ref(reader)) {
 				state = EXPECTING_SHALLOW;
 				break;
 			}
 			state = EXPECTING_REF;
 			/* fallthrough */
 		case EXPECTING_REF:
-			if (process_ref(reader->line, len, &list, flags, extra_have))
+			if (process_ref(reader, len, &list, flags, extra_have))
 				break;
 			state = EXPECTING_SHALLOW;
 			/* fallthrough */
 		case EXPECTING_SHALLOW:
-			if (process_shallow(reader->line, len, shallow_points))
+			if (process_shallow(reader, len, shallow_points))
 				break;
 			die(_("protocol error: unexpected '%s'"), reader->line);
 		case EXPECTING_DONE:
