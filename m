From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 05/20] tag.c: use ref transactions when doing updates
Date: Tue, 15 Jul 2014 16:34:03 -0700
Message-ID: <1405467258-24102-6-git-send-email-sahlberg@google.com>
References: <1405467258-24102-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 01:34:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7CFM-0003Pj-LL
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 01:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934334AbaGOXeb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 19:34:31 -0400
Received: from mail-oa0-f74.google.com ([209.85.219.74]:61939 "EHLO
	mail-oa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934241AbaGOXeX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 19:34:23 -0400
Received: by mail-oa0-f74.google.com with SMTP id eb12so34164oac.5
        for <git@vger.kernel.org>; Tue, 15 Jul 2014 16:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=27SnOc42jOfGJ3qHqIx/9MPskPkqWMhwR7+MeQAOEic=;
        b=KOyRXT8N2rJz7n1xg0pB6ko57VD6cP8ORMby3M2lrOPn7+mYf3A+Z5/u2nbXjCDTIs
         kgyNIejZie7+qHT/IBPBcHTzPPx4HVceFq4K2t6cqlZWaZXHs1wUHeM1a3+9su79adHE
         4AhqV6jsDxTfD95KWVnsA08eXocseuzzuMBA/20Lk80eYGq+jvhvs2/uZRCHDaUqIbbi
         SgTD6VGy4IBGm1mb3cp8dH1uWfR239sAirX9ey6ebSpJB0rs74+8leGA1aMND/3EoIAZ
         wNK3wEe76TpQJpxBLS4+GuuIT0z6134ygcCBwXiKEW2YbI5+zPkEUqMqf83yiKa8HB+i
         iPUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=27SnOc42jOfGJ3qHqIx/9MPskPkqWMhwR7+MeQAOEic=;
        b=DODefZ00KA6qdh0kHTl+hTnvf7aC0XuOqVX9E1jb7pZ3s5jntM8XMaprysy0Gk6uv3
         /jrkCoJrdY0Pno2Ra+vDgtXjju8ysJ6Zaf0WlggfiZeHM8sy5tfjNqrghpJzNXkTHXkp
         q2L/gDJOQAY8W+8UGSA50V5p9ttKu0lrGn21rlpSffvIPqRHb2szba4PHFWGf3G5k4xG
         B1bWa10MzCl1Tjvxoy9A2xkKnWT6MPyxUvXmu9ty7qvgHTz9bABDI+OKejzSzacHE7lO
         lBGv0OuTNxtvRIeHz7NDqnXolLLxaT/CtQcpNfM+AmAzJZG2Xfx7QvXzdo47U3/A6Ods
         7EpQ==
X-Gm-Message-State: ALoCoQk/qmYo6Lqalbxlnv5jRr7Ocq2v3exHegATtlKry0V1m8ldLoJNDtDavugwHWqcK5lQY+W7
X-Received: by 10.182.45.161 with SMTP id o1mr12753333obm.2.1405467263304;
        Tue, 15 Jul 2014 16:34:23 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c50si1058680yhl.7.2014.07.15.16.34.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Jul 2014 16:34:23 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 29F1A31C2D7;
	Tue, 15 Jul 2014 16:34:23 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id F09DFE0CE0; Tue, 15 Jul 2014 16:34:22 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.481.gb244468
In-Reply-To: <1405467258-24102-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253630>

Change tag.c to use ref transactions for all ref updates.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/tag.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index c6e8a71..1aa88a2 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -548,7 +548,6 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	struct strbuf ref = STRBUF_INIT;
 	unsigned char object[20], prev[20];
 	const char *object_ref, *tag;
-	struct ref_lock *lock;
 	struct create_tag_options opt;
 	char *cleanup_arg = NULL;
 	int annotate = 0, force = 0, lines = -1;
@@ -556,6 +555,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	const char *msgfile = NULL, *keyid = NULL;
 	struct msg_arg msg = { 0, STRBUF_INIT };
 	struct commit_list *with_commit = NULL;
+	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
 	struct option options[] = {
 		OPT_CMDMODE('l', "list", &cmdmode, N_("list tag names"), 'l'),
 		{ OPTION_INTEGER, 'n', NULL, &lines, N_("n"),
@@ -701,11 +702,13 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	if (annotate)
 		create_tag(object, tag, &buf, &opt, prev, object);
 
-	lock = lock_any_ref_for_update(ref.buf, prev, 0, NULL);
-	if (!lock)
-		die(_("%s: cannot lock the ref"), ref.buf);
-	if (write_ref_sha1(lock, object, NULL) < 0)
-		die(_("%s: cannot update the ref"), ref.buf);
+	transaction = ref_transaction_begin(&err);
+	if (!transaction ||
+	    ref_transaction_update(transaction, ref.buf, object, prev,
+				   0, 1, &err) ||
+	    ref_transaction_commit(transaction, NULL, &err))
+		die("%s", err.buf);
+	ref_transaction_free(transaction);
 	if (force && !is_null_sha1(prev) && hashcmp(prev, object))
 		printf(_("Updated tag '%s' (was %s)\n"), tag, find_unique_abbrev(prev, DEFAULT_ABBREV));
 
-- 
2.0.1.442.g7fe6834.dirty
