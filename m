From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v16 25/48] tag.c: use ref transactions when doing updates
Date: Thu, 12 Jun 2014 10:21:16 -0700
Message-ID: <1402593699-13983-26-git-send-email-sahlberg@google.com>
References: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 19:23:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv8ic-00087X-Dk
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 19:23:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933601AbaFLRXF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 13:23:05 -0400
Received: from mail-vc0-f201.google.com ([209.85.220.201]:50232 "EHLO
	mail-vc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756253AbaFLRVp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 13:21:45 -0400
Received: by mail-vc0-f201.google.com with SMTP id ij19so142814vcb.4
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wcBs1VB1N9QPuYAYVOw1HG02vy57APCUHs9L4uCDipc=;
        b=ltEQzVeCm6FzoQa0mk9bUmCAUbcP4a0DGwzwqioB70pLA3wo2J76ECyh+arQgr51ow
         K9bmC4/0lqlwmE+nlL8D/7TUw5k7uh7AR8xxtXFrTLiHJcTl17aWI/aOlJaQ+ETMpobA
         Htscb0rEZ4D6dPl5axd9FaQUbBI4YV1pdacrXT0PCkMisu7Rp6JIQMlNd9/Xy+//JV2d
         YWF9GbtVje9/lBBdyDisWgnrIM2AVTF5vvE+9jAxAC+fqJGV5Dh6NprNKm2TS0dFtEWf
         l2hvwmto15vQelG1GVHRtEN2jJefyFLLGw9Del206T2rF4QmXYjXsux5i/n4Kfp/ybor
         id4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wcBs1VB1N9QPuYAYVOw1HG02vy57APCUHs9L4uCDipc=;
        b=OFJzOwuXNRL4PYY3B1kMrbxt0YNuEksReUKyE4R25i3HCUuZm6jQtuAwixtkKHhv/x
         mm4CeZfbVhjp1r5MzBpRZbk2ytrcrDEOHbtYmdme0h5oaRHuLG34WMQDz3qL9N7AbXC1
         zMuKahYYKQiGlo/upwIaxehS7MMqqvyC//YHpgv8yWKK2/iLyu8tVaL4Z3yCdks41iiU
         v4CUFv7INXVUBWwpkiB5aW5Sjx3CyEAzkqaFgDwpheiPOcvZzPx+8qGrKZygxtGg61g2
         8WViRRlt2grZL+nLakVUjsPOtXtqqH9XNRYt7VZ8Vzo+HL2dQjOmdIPi/LC8xVxgu/LH
         6n4Q==
X-Gm-Message-State: ALoCoQmssH1vCu9tq2fsC1aDXOu4CnXwKsUDPFHYGPbRRysbj+5e/OKK2advPaWlaKiDLeyvArzH
X-Received: by 10.58.144.99 with SMTP id sl3mr751471veb.30.1402593703830;
        Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si112564yhk.4.2014.06.12.10.21.43
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id ABED931C65C;
	Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 88E78E0961; Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.599.g83ced0e
In-Reply-To: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251445>

Change tag.c to use ref transactions for all ref updates.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/tag.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index c6e8a71..c9bfc9a 100644
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
+				   0, !is_null_sha1(prev), &err) ||
+	    ref_transaction_commit(transaction, NULL, &err))
+		die("%s", err.buf);
+	ref_transaction_free(transaction);
 	if (force && !is_null_sha1(prev) && hashcmp(prev, object))
 		printf(_("Updated tag '%s' (was %s)\n"), tag, find_unique_abbrev(prev, DEFAULT_ABBREV));
 
-- 
2.0.0.599.g83ced0e
