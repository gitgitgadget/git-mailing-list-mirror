From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 07/10] transport-helper: add support for old:new refspec
Date: Mon, 11 Nov 2013 16:55:05 -0600
Message-ID: <1384210507-26561-9-git-send-email-felipe.contreras@gmail.com>
References: <1384210507-26561-1-git-send-email-felipe.contreras@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 12 00:02:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vg0V8-0006dG-Eb
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 00:02:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753548Ab3KKXC3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 18:02:29 -0500
Received: from mail-ob0-f173.google.com ([209.85.214.173]:55163 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753509Ab3KKXCT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 18:02:19 -0500
Received: by mail-ob0-f173.google.com with SMTP id wm4so5128011obc.32
        for <git@vger.kernel.org>; Mon, 11 Nov 2013 15:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oTdDPz7Mo/nkOJO9Jm8iXQEuDlMD7CpSNMKO+pzk7sY=;
        b=Hj4eMhmxqk5KRZywXxyc90sh2ksju1YIsRmpyQK+YfdEAz32DDMZRXPISPXsCnaD7H
         wjU/HCJncLDsFudF/Ack7QuZ+RB2jOSZAhgnVsdbxbk1kNXXscUSXwfN+ViJmq0UVHxe
         ExWkVN9K1ynBmQhKbXDuaC1iG34y4m8FRws+marjdEmdTh9w3HlSvMFVJnvT/84gzAPe
         341iddsqHIGyKozM7G9VFRNKw7f60ldGWAjopuVBzeGXnUBG2O4xZHY0T+mqil/QWgW/
         72Ux2I6DuwMT0lLmD4XOntV12vZKil9fz67uiEZ8i5nW2ZnROHYCiv6/PW4fpWzRIe/S
         S/Eg==
X-Received: by 10.60.60.71 with SMTP id f7mr490oer.82.1384210939505;
        Mon, 11 Nov 2013 15:02:19 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id s14sm34187805oeo.1.2013.11.11.15.02.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2013 15:02:18 -0800 (PST)
X-Mailer: git-send-email 1.8.4.2+fc1
In-Reply-To: <1384210507-26561-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237671>

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
index 9a5814d..7411125 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -850,7 +850,7 @@ static int push_refs_with_export(struct transport *transport,
 	struct ref *ref;
 	struct child_process *helper, exporter;
 	struct helper_data *data = transport->data;
-	struct string_list revlist_args = STRING_LIST_INIT_NODUP;
+	struct string_list revlist_args = STRING_LIST_INIT_DUP;
 	struct strbuf buf = STRBUF_INIT;
 
 	if (!data->refspecs)
@@ -888,8 +888,13 @@ static int push_refs_with_export(struct transport *transport,
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
@@ -897,6 +902,8 @@ static int push_refs_with_export(struct transport *transport,
 	if (get_exporter(transport, &exporter, &revlist_args))
 		die("Couldn't run fast-export");
 
+	string_list_clear(&revlist_args, 1);
+
 	if (finish_command(&exporter))
 		die("Error while running fast-export");
 	push_update_refs_status(data, remote_refs, flags);
-- 
1.8.4.2+fc1
