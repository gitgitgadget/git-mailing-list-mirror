From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 06/10] transport-helper: add support for old:new refspec
Date: Sun, 27 Oct 2013 01:05:14 -0600
Message-ID: <1382857521-7005-4-git-send-email-felipe.contreras@gmail.com>
References: <1382857521-7005-1-git-send-email-felipe.contreras@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 27 08:12:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VaKWO-0006pL-Oc
	for gcvg-git-2@plane.gmane.org; Sun, 27 Oct 2013 08:12:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018Ab3J0HML (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Oct 2013 03:12:11 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:46195 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952Ab3J0HMI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Oct 2013 03:12:08 -0400
Received: by mail-oa0-f47.google.com with SMTP id i1so2441669oag.20
        for <git@vger.kernel.org>; Sun, 27 Oct 2013 00:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uL1T4krAcH3jt8O+NF3MVHJJjOd9TNxCa4hMTSh673Y=;
        b=TbTd1miKkZD6mz1ED9OA6AvbJPnSN9226RxFw6jf0hXZFh/371P21vJ+UEpVNu2z+t
         DDGBRYE5G95s1VdJjBXJ4lAZHRDtsqv8N8EwuNQC+Ra+WuV/XkDMiLltlrRlttPqUVu7
         bN4nedyhd8Xd5V+TvT/LvuaVrspXAaeIGhGc8kwow8VWbfHRJ/BlsCEY9OxYU+Vhc7LA
         Q5thN11jV/dst2XUyN5WeuQnA5x2c42QUjsTdJwvFdkhc3HULhdm6XqNqdkge0feqZoo
         HEaEJDX1QkaQydprF3/YIOJv0CtG/zJsp8dVX4v/fDWbLtOD5sfiGTiWlAyri6UmvICd
         dEBQ==
X-Received: by 10.60.173.205 with SMTP id bm13mr9657547oec.25.1382857928408;
        Sun, 27 Oct 2013 00:12:08 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id rr6sm22443114oeb.0.2013.10.27.00.12.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Oct 2013 00:12:07 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1382857521-7005-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236783>

By using fast-export's new --refspec option.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t5801-remote-helpers.sh |  2 +-
 transport-helper.c        | 13 ++++++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 613f69a..407c18d 100755
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
index f8eb143..5454822 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -848,7 +848,7 @@ static int push_refs_with_export(struct transport *transport,
 	struct ref *ref;
 	struct child_process *helper, exporter;
 	struct helper_data *data = transport->data;
-	struct string_list revlist_args = STRING_LIST_INIT_NODUP;
+	struct string_list revlist_args = STRING_LIST_INIT_DUP;
 	struct strbuf buf = STRBUF_INIT;
 
 	if (!data->refspecs)
@@ -886,8 +886,13 @@ static int push_refs_with_export(struct transport *transport,
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
@@ -895,6 +900,8 @@ static int push_refs_with_export(struct transport *transport,
 	if (get_exporter(transport, &exporter, &revlist_args))
 		die("Couldn't run fast-export");
 
+	string_list_clear(&revlist_args, 1);
+
 	if (finish_command(&exporter))
 		die("Error while running fast-export");
 	push_update_refs_status(data, remote_refs);
-- 
1.8.4-fc
