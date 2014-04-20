From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/8] transport-helper: add support for old:new refspec
Date: Sun, 20 Apr 2014 13:59:25 -0500
Message-ID: <1398020370-11406-4-git-send-email-felipe.contreras@gmail.com>
References: <1398020370-11406-1-git-send-email-felipe.contreras@gmail.com>
Cc: Richard Hansen <rhansen@bbn.com>, Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 20 21:10:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wbx8O-0005mr-UZ
	for gcvg-git-2@plane.gmane.org; Sun, 20 Apr 2014 21:10:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755498AbaDTTK0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2014 15:10:26 -0400
Received: from mail-yh0-f46.google.com ([209.85.213.46]:63220 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755412AbaDTTKB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2014 15:10:01 -0400
Received: by mail-yh0-f46.google.com with SMTP id b6so2913181yha.5
        for <git@vger.kernel.org>; Sun, 20 Apr 2014 12:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b2NZxuDXHrZ2QUEibVqnqogp4oOvJRrthlGBs8Alos8=;
        b=Q6fyThzyoERStttCwvmYsOW2E5OzXZVjagJvCwVTp48emZCjCqjm2cgnfe/s8yByIo
         7S32iU2A6RIKf4Gqojsz2aoE4lMuM/fnz6y+CasUlqeltSpIIFnT1VDs+Mkn+FRkCGUX
         ig1Wl42mZsU57UMdWrKqR2rsgb8V9Bcc4mo6vmVPNS7x3C3kKGIcwAakuNSsaLab1eoi
         SSWo1eT2FxrNWbrk2xm7H0t2qPS3aPxfyAIuwdmhB3zT89nZQLQndl86MnsXgMIwD9N2
         Fb902prCpnOBDgI0C5Arf0kC1GEEweY3wrla83igVi2n7LJrrnIES3BpVFdbfw+wW7Lo
         gfcw==
X-Received: by 10.236.7.47 with SMTP id 35mr47238497yho.23.1398021000900;
        Sun, 20 Apr 2014 12:10:00 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id e70sm65417032yhk.9.2014.04.20.12.09.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Apr 2014 12:09:59 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc3.9.gc73078e
In-Reply-To: <1398020370-11406-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246562>

By using fast-export's new --refspec option.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5801-remote-helpers.sh |  2 +-
 transport-helper.c        | 13 ++++++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 25fd2e7..52b3c99 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -87,7 +87,7 @@ test_expect_success 'push new branch by name' '
 	compare_refs local HEAD server refs/heads/new-name
 '
 
-test_expect_failure 'push new branch with old:new refspec' '
+test_expect_success 'push new branch with old:new refspec' '
 	(cd local &&
 	 git push origin new-name:new-refspec
 	) &&
diff --git a/transport-helper.c b/transport-helper.c
index 86e1679..3f45c47 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -856,7 +856,7 @@ static int push_refs_with_export(struct transport *transport,
 	struct ref *ref;
 	struct child_process *helper, exporter;
 	struct helper_data *data = transport->data;
-	struct string_list revlist_args = STRING_LIST_INIT_NODUP;
+	struct string_list revlist_args = STRING_LIST_INIT_DUP;
 	struct strbuf buf = STRBUF_INIT;
 
 	if (!data->refspecs)
@@ -894,8 +894,13 @@ static int push_refs_with_export(struct transport *transport,
 		free(private);
 
 		if (ref->peer_ref) {
-			if (strcmp(ref->peer_ref->name, ref->name))
-				die("remote-helpers do not support old:new syntax");
+			if (strcmp(ref->name, ref->peer_ref->name)) {
+				struct strbuf buf = STRBUF_INIT;
+				strbuf_addf(&buf, "%s:%s", ref->peer_ref->name, ref->name);
+				string_list_append(&revlist_args, "--refspec");
+				string_list_append(&revlist_args, buf.buf);
+				strbuf_release(&buf);
+			}
 			string_list_append(&revlist_args, ref->peer_ref->name);
 		}
 	}
@@ -903,6 +908,8 @@ static int push_refs_with_export(struct transport *transport,
 	if (get_exporter(transport, &exporter, &revlist_args))
 		die("Couldn't run fast-export");
 
+	string_list_clear(&revlist_args, 1);
+
 	if (finish_command(&exporter))
 		die("Error while running fast-export");
 	push_update_refs_status(data, remote_refs, flags);
-- 
1.9.1+fc3.9.gc73078e
