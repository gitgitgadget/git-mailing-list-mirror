Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EADC19F2B
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 07:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234475AbiHBHyX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 03:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbiHBHyW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 03:54:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39ABF25E5
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 00:54:21 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2726N9ov011984;
        Tue, 2 Aug 2022 07:54:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2022-7-12;
 bh=1+XjjvQDG/O6jNHUiraMFbH+JNlzIxW7AUC7y+myaQQ=;
 b=hVezdDOqZIyHc1BSmcNh5EU5h+j5krtDdjvSFjCV+VsXwcOCpnUrkj31LqHFjR+uKydU
 Wp2xsfV/wqG/frhopbXpvMkxSgWX2FA/TzmQtEPPbHOqPltNEDoBNpbpnjSXCt9OFgtK
 J/oeu6LUPX+ceUQ6q50yacY00c4xJ6qyvqxP7zuG/2izhA5hMeDfeOX6NS3Ah9UEEOJT
 PFd19G/YAkXYyCvVim/nmPtNVA/5I7JyZnX7S8Kg08bjKEVblbARNsz5KL/SRoYRkEyp
 uHs0O7gturhrFE8pc/49XkG7QMTdQS9ZF7axN3+kF3dUd4vd1BmIFjlNIUFZ7KtE8GIw yw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmv8s603t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Aug 2022 07:54:11 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2726wTsP003269;
        Tue, 2 Aug 2022 07:54:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu3223ak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Aug 2022 07:54:10 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2727rxPL034445;
        Tue, 2 Aug 2022 07:54:10 GMT
Received: from t460.home (dhcp-10-175-37-86.vpn.oracle.com [10.175.37.86])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3hmu32239e-2;
        Tue, 02 Aug 2022 07:54:09 +0000
From:   Vegard Nossum <vegard.nossum@oracle.com>
To:     git@vger.kernel.org
Cc:     Vegard Nossum <vegard.nossum@oracle.com>,
        Johan Herland <johan@herland.net>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Christian Hesse <mail@eworm.de>
Subject: [RFC PATCH 2/2] notes: create interface to iterate over notes for a given oid
Date:   Tue,  2 Aug 2022 09:54:01 +0200
Message-Id: <20220802075401.2393-2-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.35.1.46.g38062e73e0
In-Reply-To: <20220802075401.2393-1-vegard.nossum@oracle.com>
References: <20220802075401.2393-1-vegard.nossum@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-02_04,2022-08-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208020037
X-Proofpoint-GUID: -dfVhkEPU31gYoqwib9Di0kwSxqJmt-L
X-Proofpoint-ORIG-GUID: -dfVhkEPU31gYoqwib9Di0kwSxqJmt-L
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

format_display_notes() outputs notes in a specific format which is
suitable for displaying in a terminal with "git log"/"git show". Other
users may want a different format.

This patch adds a new function -- for_each_oid_note() -- which, given the
oid for a commit, iterates over notes refs and calls the given callback
function for each note ref that contains a corresponding note.

The old functionality can easily be implemented using the new interface,
so I'm doing that at the same time.

Cc: Johan Herland <johan@herland.net>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Christian Hesse <mail@eworm.de>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 notes.c | 108 ++++++++++++++++++++++++++++++++++----------------------
 notes.h |   5 +++
 2 files changed, 70 insertions(+), 43 deletions(-)

diff --git a/notes.c b/notes.c
index 90ec625192..4c7e883758 100644
--- a/notes.c
+++ b/notes.c
@@ -1242,56 +1242,68 @@ void free_notes(struct notes_tree *t)
 	memset(t, 0, sizeof(struct notes_tree));
 }
 
-/*
- * Fill the given strbuf with the notes associated with the given object.
- *
- * If the given notes_tree structure is not initialized, it will be auto-
- * initialized to the default value (see documentation for init_notes() above).
- * If the given notes_tree is NULL, the internal/default notes_tree will be
- * used instead.
- *
- * (raw != 0) gives the %N userformat; otherwise, the note message is given
- * for human consumption.
- */
-static void format_note(struct notes_tree *t, const struct object_id *object_oid,
-			struct strbuf *sb, const char *output_encoding, int raw)
+void for_each_oid_note(const struct object_id *object_oid,
+		       const char *output_encoding, int raw,
+		       each_oid_note_fn fn, void *cb_data)
 {
 	static const char utf8[] = "utf-8";
-	const struct object_id *oid;
-	char *msg, *msg_p;
-	unsigned long linelen, msglen;
-	enum object_type type;
 
-	if (!t)
-		t = &default_notes_tree;
-	if (!t->initialized)
-		init_notes(t, NULL, NULL, 0);
+	int i;
+	assert(display_notes_trees);
+	for (i = 0; display_notes_trees[i]; i++) {
+		struct notes_tree *t = display_notes_trees[i];
+		const struct object_id *oid;
+		char *msg;
+		unsigned long msglen;
+		enum object_type type;
+
+		if (!t)
+			t = &default_notes_tree;
+		if (!t->initialized)
+			init_notes(t, NULL, NULL, 0);
+
+		oid = get_note(t, object_oid);
+		if (!oid)
+			continue;
 
-	oid = get_note(t, object_oid);
-	if (!oid)
-		return;
+		if (!(msg = read_object_file(oid, &type, &msglen)) || type != OBJ_BLOB) {
+			free(msg);
+			continue;
+		}
+
+		if (output_encoding && *output_encoding &&
+		    !is_encoding_utf8(output_encoding)) {
+			char *reencoded = reencode_string(msg, output_encoding, utf8);
+			if (reencoded) {
+				free(msg);
+				msg = reencoded;
+				msglen = strlen(msg);
+			}
+		}
 
-	if (!(msg = read_object_file(oid, &type, &msglen)) || type != OBJ_BLOB) {
+		fn(t->ref, msg, msglen, cb_data);
 		free(msg);
-		return;
 	}
+}
 
-	if (output_encoding && *output_encoding &&
-	    !is_encoding_utf8(output_encoding)) {
-		char *reencoded = reencode_string(msg, output_encoding, utf8);
-		if (reencoded) {
-			free(msg);
-			msg = reencoded;
-			msglen = strlen(msg);
-		}
-	}
+struct format_display_notes_cb {
+	int raw;
+	struct strbuf *output;
+};
+
+static void format_note(const char *ref, const char *msg, unsigned long msglen, void *cb_data)
+{
+	struct format_display_notes_cb *cb = cb_data;
+	int raw = cb->raw;
+	struct strbuf *sb = cb->output;
+	const char *msg_p;
+	unsigned long linelen;
 
 	/* we will end the annotation by a newline anyway */
 	if (msglen && msg[msglen - 1] == '\n')
 		msglen--;
 
 	if (!raw) {
-		const char *ref = t->ref;
 		if (!ref || !strcmp(ref, GIT_NOTES_DEFAULT_REF)) {
 			strbuf_addstr(sb, "\nNotes:\n");
 		} else {
@@ -1309,18 +1321,28 @@ static void format_note(struct notes_tree *t, const struct object_id *object_oid
 		strbuf_add(sb, msg_p, linelen);
 		strbuf_addch(sb, '\n');
 	}
-
-	free(msg);
 }
 
+/*
+ * Fill the given strbuf with the notes associated with the given object.
+ *
+ * If the given notes_tree structure is not initialized, it will be auto-
+ * initialized to the default value (see documentation for init_notes() above).
+ * If the given notes_tree is NULL, the internal/default notes_tree will be
+ * used instead.
+ *
+ * (raw != 0) gives the %N userformat; otherwise, the note message is given
+ * for human consumption.
+ */
 void format_display_notes(const struct object_id *object_oid,
 			  struct strbuf *sb, const char *output_encoding, int raw)
 {
-	int i;
-	assert(display_notes_trees);
-	for (i = 0; display_notes_trees[i]; i++)
-		format_note(display_notes_trees[i], object_oid, sb,
-			    output_encoding, raw);
+	struct format_display_notes_cb cb = {
+		.raw = raw,
+		.output = sb,
+	};
+
+	for_each_oid_note(object_oid, output_encoding, raw, format_note, &cb);
 }
 
 int copy_note(struct notes_tree *t,
diff --git a/notes.h b/notes.h
index c7aae85ea6..833af94fae 100644
--- a/notes.h
+++ b/notes.h
@@ -309,6 +309,11 @@ void load_display_notes(struct display_notes_opt *opt);
 void format_display_notes(const struct object_id *object_oid,
 			  struct strbuf *sb, const char *output_encoding, int raw);
 
+typedef void (*each_oid_note_fn)(const char *ref, const char *msg, unsigned long msglen, void *cb_data);
+
+void for_each_oid_note(const struct object_id *object_oid,
+		       const char *output_encoding, int raw, each_oid_note_fn fn, void *cb_data);
+
 /*
  * Load the notes tree from each ref listed in 'refs'.  The output is
  * an array of notes_tree*, terminated by a NULL.
-- 
2.35.1.46.g38062e73e0

