From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 09/10] transport-helper: add support to delete branches
Date: Sat, 12 Oct 2013 02:05:28 -0500
Message-ID: <1381561533-20381-6-git-send-email-felipe.contreras@gmail.com>
References: <1381561533-20381-1-git-send-email-felipe.contreras@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:12:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtMv-0004bU-Ok
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:12:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753834Ab3JLHLt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:11:49 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:47155 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214Ab3JLHLr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:11:47 -0400
Received: by mail-oa0-f46.google.com with SMTP id k14so3133729oag.19
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2I0g71gPReDPxrZRmQR2kkA4IVNYioIjgozycVY8U40=;
        b=B7HvF3phU0/jgX0X3o3wwTLTCUg/FeRvhfWLUMPxOyWfWNVkQzJjZXsSXVsDOJLxe+
         Do2fr0A8ZPunWHk9SjewOp2kDOH6ycRM+DEcDMr42ZN1NjihcU+3N1KGJ3xK8iNgvPGL
         zrOHGLSne/pAMvydaEdbHalIemP4tjEI8tfDzbkUJQfYg0CVI7hdAJOO4R+Wb5cw/sMR
         0hdChbtMD5lhgWliJiTDM2J1OulTzY+zTKo5R8gfxYKWQeIJCk6MR1c5+AMnfFu6UYvc
         6ohX3O+O+qaNlYImYUGFkxsxtXtI+bBH/Qcc8Q8/seKX7lxCFU8ZuK+G52djsr9Ip0r+
         WT+A==
X-Received: by 10.60.80.8 with SMTP id n8mr17663141oex.33.1381561906994;
        Sat, 12 Oct 2013 00:11:46 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id wd7sm28633686obc.3.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:11:46 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561533-20381-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235979>

For remote-helpers that use 'export' to push.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t5801-remote-helpers.sh | 8 ++++++++
 transport-helper.c        | 8 ++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 8e2dd9f..a66a4e3 100755
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
index cffeb9a..ddb3309 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -849,12 +849,16 @@ static int push_refs_with_export(struct transport *transport,
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
