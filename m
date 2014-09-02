From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 07/22] commit.c: use ref transactions for updates
Date: Tue, 2 Sep 2014 14:02:19 -0700
Message-ID: <20140902210219.GH18279@google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
 <CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
 <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
 <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
 <20140820231723.GF20185@google.com>
 <20140826000354.GW20185@google.com>
 <xmqqlhqbge3a.fsf@gitster.dls.corp.google.com>
 <20140826221448.GY20185@google.com>
 <20140827002804.GA20185@google.com>
 <20140902205841.GA18279@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 23:02:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOvDf-00020F-LT
	for gcvg-git-2@plane.gmane.org; Tue, 02 Sep 2014 23:02:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754897AbaIBVCY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2014 17:02:24 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:50651 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455AbaIBVCX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2014 17:02:23 -0400
Received: by mail-pd0-f173.google.com with SMTP id p10so9491012pdj.32
        for <git@vger.kernel.org>; Tue, 02 Sep 2014 14:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=YX3A/xO8q/fEa1E8m3vOPvbIrfLLkTMH2SToKUOTplc=;
        b=ndqIErJp4qS19vTbFP6SEa8TC2EMozquF59/58kRKcSpaznjN7WlmsDcu4ZfUf1onn
         bggxmibFmhvalrME34EUpFkYxFGUUeft+46uiuNU1rQ8uxa24X4hh/UjFlIViDGJAIAK
         lUP38lOW7jPwa9aBZD8cD79BSYXne+hKn68BWgn+wOjWTwdMF1zsL/jPwo6iDxyVS9H5
         pu6gQc9fuHksLLKL/E1Ydqlr5+HawgLDfrOx70Ly/EQyHpho2DD14Vud1S2WNiy6tVcA
         lHf3Yyc04fBKRzYjtofesuedSfnhuEDaN/sDR36jbdD1Xnv964SXwYghlXGZTc3qkwLu
         UCUw==
X-Received: by 10.70.127.207 with SMTP id ni15mr23114157pdb.129.1409691742718;
        Tue, 02 Sep 2014 14:02:22 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id qn7sm4932088pbc.14.2014.09.02.14.02.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Sep 2014 14:02:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140902205841.GA18279@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256353>

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Wed, 16 Apr 2014 15:34:19 -0700

Change commit.c to use ref transactions for all ref updates.
Make sure we pass a NULL pointer to ref_transaction_update if have_old
is false.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/commit.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 5e2221c..9bf1003 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1627,11 +1627,12 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	const char *index_file, *reflog_msg;
 	char *nl;
 	unsigned char sha1[20];
-	struct ref_lock *ref_lock;
 	struct commit_list *parents = NULL, **pptr = &parents;
 	struct stat statbuf;
 	struct commit *current_head = NULL;
 	struct commit_extra_header *extra = NULL;
+	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(builtin_commit_usage, builtin_commit_options);
@@ -1753,16 +1754,6 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	strbuf_release(&author_ident);
 	free_commit_extra_headers(extra);
 
-	ref_lock = lock_any_ref_for_update("HEAD",
-					   !current_head
-					   ? NULL
-					   : current_head->object.sha1,
-					   0, NULL);
-	if (!ref_lock) {
-		rollback_index_files();
-		die(_("cannot lock HEAD ref"));
-	}
-
 	nl = strchr(sb.buf, '\n');
 	if (nl)
 		strbuf_setlen(&sb, nl + 1 - sb.buf);
@@ -1771,10 +1762,17 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	strbuf_insert(&sb, 0, reflog_msg, strlen(reflog_msg));
 	strbuf_insert(&sb, strlen(reflog_msg), ": ", 2);
 
-	if (write_ref_sha1(ref_lock, sha1, sb.buf) < 0) {
+	transaction = ref_transaction_begin(&err);
+	if (!transaction ||
+	    ref_transaction_update(transaction, "HEAD", sha1,
+				   current_head
+				   ? current_head->object.sha1 : NULL,
+				   0, !!current_head, &err) ||
+	    ref_transaction_commit(transaction, sb.buf, &err)) {
 		rollback_index_files();
-		die(_("cannot update HEAD ref"));
+		die("%s", err.buf);
 	}
+	ref_transaction_free(transaction);
 
 	unlink(git_path("CHERRY_PICK_HEAD"));
 	unlink(git_path("REVERT_HEAD"));
@@ -1803,5 +1801,6 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	if (!quiet)
 		print_summary(prefix, sha1, !current_head);
 
+	strbuf_release(&err);
 	return 0;
 }
-- 
2.1.0.rc2.206.gedb03e5
