From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 06/10] transport-helper: add support for old:new refspec
Date: Sat, 12 Oct 2013 02:05:26 -0500
Message-ID: <1381561533-20381-4-git-send-email-felipe.contreras@gmail.com>
References: <1381561533-20381-1-git-send-email-felipe.contreras@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:15:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtPj-0006cl-9i
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:15:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752558Ab3JLHLo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:11:44 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:37592 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214Ab3JLHLm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:11:42 -0400
Received: by mail-oa0-f52.google.com with SMTP id n2so3106531oag.39
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N3QcLvTQb9N7K2fOjr+krLHt0tWT4EgV2i7TR4mXxmU=;
        b=kwF3U12Ewwq8p5DO2y9yEMYXVvwpE0mkdjdUndpw0twXDZ+TEUewCqgEvPbTy7ha3S
         uyymJy8Z/nspJdZx4huRXStZ3WUhAOBSF7mTv2ZUIWbyOG0gaB/KprvATotKgFs+bcb5
         Qh7cR8DCvZfCKQ5ugxvVhrbTGh4qxl8Hwju2towb+Txo9TMgdMN1Jg0Wwl4HVEVnCsO2
         VQ9WjMlFsMFvOJs0+sXl4jGkZqL/wTHrtrFaViVSulsEEoZSIovDoM2PoSgfTwb4Mai5
         ELNNR8FybAbOK5dqWZF0Ck+DyuJIoh1a4hLK21ZMw79v2kSduNIIoNjfjRRx6sMn0W3+
         ptVQ==
X-Received: by 10.182.16.201 with SMTP id i9mr17809722obd.21.1381561901986;
        Sat, 12 Oct 2013 00:11:41 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id s9sm28635959obu.4.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:11:41 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561533-20381-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236037>

By using fast-export's new --refspec option.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t5801-remote-helpers.sh |  2 +-
 transport-helper.c        | 13 ++++++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 8c4c539..8e2dd9f 100755
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
index 46b3e57..cffeb9a 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -809,7 +809,7 @@ static int push_refs_with_export(struct transport *transport,
 	struct ref *ref;
 	struct child_process *helper, exporter;
 	struct helper_data *data = transport->data;
-	struct string_list revlist_args = STRING_LIST_INIT_NODUP;
+	struct string_list revlist_args = STRING_LIST_INIT_DUP;
 	struct strbuf buf = STRBUF_INIT;
 
 	if (!data->refspecs)
@@ -847,8 +847,13 @@ static int push_refs_with_export(struct transport *transport,
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
@@ -856,6 +861,8 @@ static int push_refs_with_export(struct transport *transport,
 	if (get_exporter(transport, &exporter, &revlist_args))
 		die("Couldn't run fast-export");
 
+	string_list_clear(&revlist_args, 1);
+
 	if (finish_command(&exporter))
 		die("Error while running fast-export");
 	push_update_refs_status(data, remote_refs);
-- 
1.8.4-fc
