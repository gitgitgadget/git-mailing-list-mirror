From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 07/10] transport-helper: add support for old:new refspec
Date: Thu, 31 Oct 2013 03:36:35 -0600
Message-ID: <1383212197-14259-9-git-send-email-felipe.contreras@gmail.com>
References: <1383212197-14259-1-git-send-email-felipe.contreras@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 31 10:43:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbonB-0003uF-7G
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 10:43:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753784Ab3JaJnk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 05:43:40 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:46884 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753733Ab3JaJnh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 05:43:37 -0400
Received: by mail-ob0-f179.google.com with SMTP id uy5so2767527obc.10
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 02:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kcaTOqy16RMzOqdyhu9tsLDSkdKsEpm6vHxEHjd1++A=;
        b=q5StczZIbVHfkkpbs+UH5RDNKIuwOwDEjQ7llcjC2GgQ4vTkeV0iq4m/LwlJdSL9zX
         IxuxbOh/0lQ4j9EXMWy0J4mCV+ltJCiY7kLRReRbncp+nBLy0sEdK7CRzwavIkji8Jdy
         h9W4Ym4/QQM8QJ7U4LdowuTdcnE233JXoZ2Mi5tjqHP02rkXusJ3EDmKI4Pel04t8jtK
         NfgzIICFC8WAxUR/wScfVTGg6sQTsUlqzC0y8u8QJTRIKb/oUGEsHpcstkDX9DMf8Xgm
         hBFNlare7wUHw6Fmth+LK+HkIuOH8UEqtIP02BjVJL3WNj9KyrkrpeSeXkiqCx3XJJ+k
         SB8g==
X-Received: by 10.60.52.1 with SMTP id p1mr1851162oeo.41.1383212617321;
        Thu, 31 Oct 2013 02:43:37 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id d8sm5448757oeu.6.2013.10.31.02.43.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2013 02:43:36 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.2+fc1
In-Reply-To: <1383212197-14259-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237109>

By using fast-export's new --refspec option.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t5801-remote-helpers.sh |  2 +-
 transport-helper.c        | 13 ++++++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index c33cc25..454337e 100755
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
index 5aba15c..84ff578 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -849,7 +849,7 @@ static int push_refs_with_export(struct transport *transport,
 	struct ref *ref;
 	struct child_process *helper, exporter;
 	struct helper_data *data = transport->data;
-	struct string_list revlist_args = STRING_LIST_INIT_NODUP;
+	struct string_list revlist_args = STRING_LIST_INIT_DUP;
 	struct strbuf buf = STRBUF_INIT;
 
 	if (!data->refspecs)
@@ -887,8 +887,13 @@ static int push_refs_with_export(struct transport *transport,
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
@@ -896,6 +901,8 @@ static int push_refs_with_export(struct transport *transport,
 	if (get_exporter(transport, &exporter, &revlist_args))
 		die("Couldn't run fast-export");
 
+	string_list_clear(&revlist_args, 1);
+
 	if (finish_command(&exporter))
 		die("Error while running fast-export");
 	push_update_refs_status(data, remote_refs, flags);
-- 
1.8.4.2+fc1
