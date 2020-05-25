Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F1BC433E0
	for <git@archiver.kernel.org>; Mon, 25 May 2020 19:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32B352073B
	for <git@archiver.kernel.org>; Mon, 25 May 2020 19:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="YVRMivrQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390415AbgEYT7x (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 15:59:53 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38686 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390316AbgEYT7p (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 May 2020 15:59:45 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1E374609CF;
        Mon, 25 May 2020 19:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1590436784;
        bh=fK4p8fIWd9Go9/zHEmibNYwlQh8e8IryNd34Ad991b8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=YVRMivrQN9A5Q8VUvIm6xar2DncDaMlR/AKl8S5X7N/j9b6k+ZfmEsZzIYMU/Du7R
         NCeeFDDm3LAo0n7ej/+X3S4dVlpVnQda4lRYdQdkl78YhkrecPoCw374KNwKEMFzDs
         OzjmFKxOjB6yA07Kjtq1G9YW17OsnlVigdJ9AK6uNvVBQwAsqfKkOjTT8jVtVnWJKj
         cmi7UDzj4ekZk0KAEiIC3VRcfup+slUKEFeOnEE/lq+4Y/M9jnNbBmhJEnA06qv/cf
         77vI/tg63nozM5fnQixqpp9f+M2QMPVeWzasRuAoGpaTCGq0HvHe4qMC43Il5B8wsv
         cjcy69jvsuNPAPxdjI98cqoVVwXKiYOln4qPrtIPMLPg68FNKp4l/aeyo5/TFisoI4
         T3SeLMDwKa6B5YPdMI4svq4oqjUzMm6TDrAMWS4t08AcYFLIs6d9hbBhvraEBMx4QM
         oFaHyGpQ+YnetvmQc5YC3OVWBhA/cBebZBXwsWbUNaz1WKVbhVz
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 03/44] connect: have ref processing code take struct packet_reader
Date:   Mon, 25 May 2020 19:58:49 +0000
Message-Id: <20200525195930.309665-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652
In-Reply-To: <20200525195930.309665-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
 <20200525195930.309665-1-sandals@crustytoothpaste.net>
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

Rename the len variable to "linelen" to make it clearer what the
variable does in light of the variable change.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 connect.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/connect.c b/connect.c
index 23013c6344..ccc5274189 100644
--- a/connect.c
+++ b/connect.c
@@ -204,17 +204,19 @@ static void annotate_refs_with_symref_info(struct ref *ref)
 	string_list_clear(&symref, 0);
 }
 
-static void process_capabilities(const char *line, int *len)
+static void process_capabilities(struct packet_reader *reader, int *linelen)
 {
+	const char *line = reader->line;
 	int nul_location = strlen(line);
-	if (nul_location == *len)
+	if (nul_location == *linelen)
 		return;
 	server_capabilities_v1 = xstrdup(line + nul_location + 1);
-	*len = nul_location;
+	*linelen = nul_location;
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
