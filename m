From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 11/11] transport-helper: add support to delete branches
Date: Tue, 12 Nov 2013 14:57:10 -0600
Message-ID: <1384289830-5471-18-git-send-email-felipe.contreras@gmail.com>
References: <1384289830-5471-1-git-send-email-felipe.contreras@gmail.com>
Cc: Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 12 22:05:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgL9W-0000cy-1i
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 22:05:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315Ab3KLVFA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 16:05:00 -0500
Received: from mail-oa0-f42.google.com ([209.85.219.42]:44461 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932312Ab3KLVEx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 16:04:53 -0500
Received: by mail-oa0-f42.google.com with SMTP id h16so3732330oag.15
        for <git@vger.kernel.org>; Tue, 12 Nov 2013 13:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nHksl9CndQL1UwXs0AinCAZDSflY9oSMAvLn3xTq/m4=;
        b=m7oYM5iYm805PVus/WMCJd06ZvdqxyDKOG8UOjE7Tn6zEON827xcPpsz3ShKXd8RQt
         cHUKp8Jv8f6Q2gSjtHyzbvUhr2h4j/scCspO+q4xS6Y8tGxE5czD1mUWlt/UhdqCahmJ
         aNw0YSfnhICXAbG9LjB7thT3GRlI9TIf8PZQojPzoki8biGFd6kySTrbGY45Qr8m4Qev
         Sv104eyvCT08j+Y0BhQ9c5Vo8GhKne67gkZjV6s7g3z/rYWovY0cO30vIyaZzP1cr7Sx
         xdYZk+DwReIkbkwH/agi+R97RFW6bq4XwVPI8QK3Rst1OeoyPXjc+pje7foWRDjwVt+0
         85gA==
X-Received: by 10.60.179.113 with SMTP id df17mr22676397oec.16.1384290293075;
        Tue, 12 Nov 2013 13:04:53 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id m7sm35391484obo.7.2013.11.12.13.04.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2013 13:04:52 -0800 (PST)
X-Mailer: git-send-email 1.8.4.2+fc1
In-Reply-To: <1384289830-5471-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237747>

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
