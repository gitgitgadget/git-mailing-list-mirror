From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 09/10] transport-helper: add support to delete branches
Date: Sun, 27 Oct 2013 01:05:16 -0600
Message-ID: <1382857521-7005-6-git-send-email-felipe.contreras@gmail.com>
References: <1382857521-7005-1-git-send-email-felipe.contreras@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 27 08:12:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VaKWP-0006pL-9P
	for gcvg-git-2@plane.gmane.org; Sun, 27 Oct 2013 08:12:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752111Ab3J0HMQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Oct 2013 03:12:16 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:42085 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207Ab3J0HMN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Oct 2013 03:12:13 -0400
Received: by mail-oa0-f42.google.com with SMTP id k14so2485087oag.1
        for <git@vger.kernel.org>; Sun, 27 Oct 2013 00:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iQv6ivOhEcp3T245y5TeEewNFxFil7uKXxL5gay2s9k=;
        b=0Kz/9995InbkHu81ivGqBA//Rj762PsW2PP5PHWhAwA3B3nLG2Ih/LtwJ7EU5MwobR
         uErZDq6imopisEVNpXIn3slkNK27/DIKl59dl2eIJs9F4bliXuiF4QdqDK5XEA1ieHbm
         9hE0VrkgI4UxPSakuBsCHIeUoUhZUwSRknbSk6FOHj6JKl0kDvrf5fL4fwU1dgF9nBOe
         jJZMIYNURGIw2YPzkMzTFnxgawppWJ+jlBvmVbl8Ga+yiW5+xamN9bg/EK/WUKfjpUqe
         1EOgEImZ9wDpIkS2SOPsvGvcDDfneiZsbOSdp4NbucbVFGKVNcLH2vUihpjc+2i/prVG
         DQxQ==
X-Received: by 10.182.125.65 with SMTP id mo1mr9837381obb.40.1382857932959;
        Sun, 27 Oct 2013 00:12:12 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id ee7sm22406936oeb.5.2013.10.27.00.12.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Oct 2013 00:12:12 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1382857521-7005-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236782>

For remote-helpers that use 'export' to push.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t5801-remote-helpers.sh |  8 ++++++++
 transport-helper.c        | 11 ++++++-----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 407c18d..be543c0 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -94,6 +94,14 @@ test_expect_success 'push new branch with old:new refspec' '
 	compare_refs local HEAD server refs/heads/new-refspec
 '
 
+test_expect_success 'push delete branch' '
+	(cd local &&
+	 git push origin :new-name
+	) &&
+	test_must_fail git --git-dir="server/.git" \
+	 rev-parse --verify refs/heads/new-name
+'
+
 test_expect_success 'cloning without refspec' '
 	GIT_REMOTE_TESTGIT_REFSPEC="" \
 	git clone "testgit::${PWD}/server" local2 2>error &&
diff --git a/transport-helper.c b/transport-helper.c
index 5454822..4f47bdd 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -874,9 +874,6 @@ static int push_refs_with_export(struct transport *transport,
 		char *private;
 		unsigned char sha1[20];
 
-		if (ref->deletion)
-			die("remote-helpers do not support ref deletion");
-
 		private = apply_refspecs(data->refspecs, data->refspec_nr, ref->name);
 		if (private && !get_sha1(private, sha1)) {
 			strbuf_addf(&buf, "^%s", private);
@@ -888,12 +885,16 @@ static int push_refs_with_export(struct transport *transport,
 		if (ref->peer_ref) {
 			if (strcmp(ref->name, ref->peer_ref->name)) {
 				struct strbuf buf = STRBUF_INIT;
-				strbuf_addf(&buf, "%s:%s", ref->peer_ref->name, ref->name);
+				if (!ref->deletion)
+					strbuf_addf(&buf, "%s:%s", ref->peer_ref->name, ref->name);
+				else
+					strbuf_addf(&buf, ":%s", ref->name);
 				string_list_append(&revlist_args, "--refspec");
 				string_list_append(&revlist_args, buf.buf);
 				strbuf_release(&buf);
 			}
-			string_list_append(&revlist_args, ref->peer_ref->name);
+			if (!ref->deletion)
+				string_list_append(&revlist_args, ref->peer_ref->name);
 		}
 	}
 
-- 
1.8.4-fc
