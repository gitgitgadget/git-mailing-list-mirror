From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 6/9] transport-helper: add support for old:new refspec
Date: Fri, 24 May 2013 21:47:37 -0500
Message-ID: <1369450060-19011-7-git-send-email-felipe.contreras@gmail.com>
References: <1369450060-19011-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:50:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4Z0-0005RF-AP
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:50:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755978Ab3EYCu1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:50:27 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:46645 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755275Ab3EYCuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:50:25 -0400
Received: by mail-oa0-f54.google.com with SMTP id o17so7031892oag.13
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ILVeRAOnBJ9RL8WivoVGfw1Mhjka4nM4TZSTc2ALLPw=;
        b=acT7JHpEy73gdNebftl5xuMAi3HTczMhsT+sYV06JvgO8EUgbPZbHtQrikM5xWo/d7
         P2DVrTtsltcE2rFNiM3/cEbyb8j2sIpqOD9steCl1/Uk88IOLjrnQmgc/V8EpgGebbUj
         1u9bppJJuC/yuRKXUBRrvVLivlJ/G14Nxy3rqBCXLnF5tiqGD22ttthpdGejqr31RMx5
         VcqCukzGRE3piBEorIaIWCHUcaI1kuV1FRamtIo5R/kQYdNRxLMBMnxM3hE4/dbAuOby
         +fNZNURjVcU1/OUJNaF2sPkk2dSOMFZX931rH0B4tkH4eY9V1gBuJ24h9iOrwyO3VeaJ
         HwaQ==
X-Received: by 10.182.233.227 with SMTP id tz3mr13688611obc.23.1369450225087;
        Fri, 24 May 2013 19:50:25 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id eq4sm20147592obb.5.2013.05.24.19.50.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:50:24 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369450060-19011-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225482>

By using fast-export's new --refspec option.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t5801-remote-helpers.sh |  2 +-
 transport-helper.c        | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 4899af3..6a7db8b 100755
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
index e461764..cc2150f 100644
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
@@ -844,13 +844,23 @@ static int push_refs_with_export(struct transport *transport,
 		}
 		free(private);
 
-		if (ref->peer_ref)
+		if (ref->peer_ref) {
+			if (strcmp(ref->name, ref->peer_ref->name)) {
+				struct strbuf buf = STRBUF_INIT;
+				strbuf_addf(&buf, "%s:%s", ref->peer_ref->name, ref->name);
+				string_list_append(&revlist_args, "--refspec");
+				string_list_append(&revlist_args, buf.buf);
+				strbuf_release(&buf);
+			}
 			string_list_append(&revlist_args, ref->peer_ref->name);
+		}
 	}
 
 	if (get_exporter(transport, &exporter, &revlist_args))
 		die("Couldn't run fast-export");
 
+	string_list_clear(&revlist_args, 1);
+
 	if (finish_command(&exporter))
 		die("Error while running fast-export");
 	push_update_refs_status(data, remote_refs);
-- 
1.8.3.rc3.312.g47657de
