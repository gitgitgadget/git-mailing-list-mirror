From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v11 17/41] tag.c: use ref transactions when doing updates
Date: Tue, 27 May 2014 13:25:36 -0700
Message-ID: <1401222360-21175-18-git-send-email-sahlberg@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 22:28:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpNyg-0004zy-Re
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 22:28:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753584AbaE0U1g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 16:27:36 -0400
Received: from mail-vc0-f202.google.com ([209.85.220.202]:50545 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752929AbaE0U0F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 16:26:05 -0400
Received: by mail-vc0-f202.google.com with SMTP id hq11so845145vcb.1
        for <git@vger.kernel.org>; Tue, 27 May 2014 13:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2lrrWX37AIoaAqeI86xjz61k0hUNjn99k+NE1vJouOM=;
        b=UABg+ydIeJOEaSc7GjGJAX3B1SQkIuFT+phiZjUWWi40HQ60y0xJMQ5Bqvp1QLQ233
         XYJExkDVTdPDhvj4ztfFOXmoDcoFSsDhTM70KsCHiLC7YV1wnOjTqZthc28LoeYjtE3n
         jQ0dJw14ZASkjuMbuSb6+DcHbA0yHxiN1Oz55q3TkQTQZYedNFRlwn7SpdpuWgnSzRSB
         C3TaIA2wpcYmmWyedGctK6VxXJkMPgSwE+gxIckp4s1n+xGYsTxm8QahFNWZspYcTrQZ
         bRFZFpjB+A2Mzyb4HmQfwpmyFe78NLSDCHKDUzKnyF6FgXSIFrKS62eLFYvsMWjrhT1n
         AmiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2lrrWX37AIoaAqeI86xjz61k0hUNjn99k+NE1vJouOM=;
        b=fapED8zg3QB7N8hB+Z0108bzZoYi5RuedfejKKBpp+3s/jkjCemusRtJW44avatJh6
         OzXLDJvDQUT9zZ4j7iGFDr3piCa5tDrcRljID1i0EivSV6EM+fohqdl/vkVoVH95ouah
         /MbOdjUJ27J4oOF7wEDtm3zY3DsfjX2/0g0Jn0NbGxmzcF+gNWnM/sBL4wUEzJgyYdzh
         dFRprOTIcsAbMssiXd9b2z9FnfSZpi3ebK1EFtbtc0HA7+aNOOI7su9vuLp2oGPLkyGu
         gRm9+joCE8Xt1fKEizRSqAM9EiKEvPGY2OLpsP2vwOS3IZscHKH3Ykct+ZngTgcT5ber
         nq0Q==
X-Gm-Message-State: ALoCoQlcppBtiKR1Yv44/sVbLj0lbGVH6KOcu9EBBNDgUQqTbHGaRWIWMHzTtaKFMVyxORH5/O0V
X-Received: by 10.236.85.131 with SMTP id u3mr12305086yhe.40.1401222364493;
        Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id k43si1575168yhq.3.2014.05.27.13.26.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 59CF42F4AC1;
	Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 35A38E0C28; Tue, 27 May 2014 13:26:03 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.474.g0203784
In-Reply-To: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250228>

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
2.0.0.rc3.474.g0203784
