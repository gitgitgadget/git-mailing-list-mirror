From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 10/10] transport-helper: add support to delete branches
Date: Tue, 12 Nov 2013 14:57:09 -0600
Message-ID: <1384289830-5471-17-git-send-email-felipe.contreras@gmail.com>
References: <1384289830-5471-1-git-send-email-felipe.contreras@gmail.com>
Cc: Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 12 22:05:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgL9W-0000cy-JP
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 22:05:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316Ab3KLVFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 16:05:08 -0500
Received: from mail-oa0-f52.google.com ([209.85.219.52]:45632 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932309Ab3KLVEu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 16:04:50 -0500
Received: by mail-oa0-f52.google.com with SMTP id o6so3361421oag.39
        for <git@vger.kernel.org>; Tue, 12 Nov 2013 13:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nHksl9CndQL1UwXs0AinCAZDSflY9oSMAvLn3xTq/m4=;
        b=nT67G3RqPxPj3Ozw2VmDSDYNkTMS0UQasc0N+tkiqBNsHLwFdl73h5sp5Ee36qRqEn
         UgiIH+12E4D5ZG4VAVFxkRPj9rSLfAh97d6A1fOBJoaBKb+dQU7a0SZPuNkDlblUS5V3
         1MwALDgtwcAceQiAZ0O3SPj6/aWgO90THxVxjjFxIstOGgve0q9sHaoLvSGvvArhNR+z
         ZAJtjAINaXied/QVBP6jFu4qth24K9PBFqYTqVXrE4bdIe1fWjd0+e1H/wW8VfLmZVsV
         VhXMyDpCNwYMJNqfdGBAka5/3tyb368c9upyV2Ap/7uJruUMYfCR1k8CcCIUr2PXdfol
         V9eg==
X-Received: by 10.182.214.98 with SMTP id nz2mr26060781obc.37.1384290289922;
        Tue, 12 Nov 2013 13:04:49 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id nw5sm8063128obc.9.2013.11.12.13.04.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2013 13:04:49 -0800 (PST)
X-Mailer: git-send-email 1.8.4.2+fc1
In-Reply-To: <1384289830-5471-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237754>

For remote-helpers that use 'export' to push.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t5801-remote-helpers.sh |  8 ++++++++
 transport-helper.c        | 11 ++++++-----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 454337e..c667965 100755
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
 test_expect_success 'forced push' '
 	(cd local &&
 	git checkout -b force-test &&
diff --git a/transport-helper.c b/transport-helper.c
index 2da4259..7a95125 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -876,9 +876,6 @@ static int push_refs_with_export(struct transport *transport,
 		char *private;
 		unsigned char sha1[20];
 
-		if (ref->deletion)
-			die("remote-helpers do not support ref deletion");
-
 		private = apply_refspecs(data->refspecs, data->refspec_nr, ref->name);
 		if (private && !get_sha1(private, sha1)) {
 			strbuf_addf(&buf, "^%s", private);
@@ -890,12 +887,16 @@ static int push_refs_with_export(struct transport *transport,
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
1.8.4.2+fc1
