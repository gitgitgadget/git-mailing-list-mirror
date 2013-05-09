From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/3] transport-helper: add support for old:new refspec
Date: Wed,  8 May 2013 20:31:35 -0500
Message-ID: <1368063095-22861-4-git-send-email-felipe.contreras@gmail.com>
References: <1368063095-22861-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 09 03:33:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaFjZ-0007D4-Ka
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 03:33:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754798Ab3EIBdN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 21:33:13 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:43284 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753353Ab3EIBdM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 21:33:12 -0400
Received: by mail-oa0-f41.google.com with SMTP id k1so2879197oag.14
        for <git@vger.kernel.org>; Wed, 08 May 2013 18:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=hC3ZeubpO1rODeSEJ4MDLK0dB/RCYmVBYZeSuuLfrtA=;
        b=y0wboCHsPjDD72h8pwMCzu5Cq960dzc78cNocWlkIIU85vs+EkhN9OIEZjCsoaoeRZ
         bzhlRFtSRsNEAyYr/MzNdO/2o4Sdn0XCh+cjcUt2z7LGl8RcsPtd8n8eIxUHG93PgDK1
         bLS17OhoKE5GxEUWR1ptuA2y/3Hj0GM2VYBoUvNv/PwFqt1rc+yIQv3CbRjbeqpivzqk
         aDxzdKP3K1fFjNnE6IsG9172ON/GjVYJp3TE7GVf0xPkc+KoTw4S0mt00wJ/uNMpllcj
         ckj2H7s6wFi3nZOPZFW//eEuHkUAbPLtPkmbXm7/2LDtuXgIZka3U0/NZe8V4LoFNpnA
         4boA==
X-Received: by 10.60.63.174 with SMTP id h14mr3035406oes.137.1368063191008;
        Wed, 08 May 2013 18:33:11 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id ns4sm1172896obc.2.2013.05.08.18.33.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 08 May 2013 18:33:10 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.553.gac13664
In-Reply-To: <1368063095-22861-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223709>

By using fast-export's new --refspec option.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t5801-remote-helpers.sh |  2 +-
 transport-helper.c        | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index dbb02e2..d15f794 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -92,7 +92,7 @@ test_expect_success 'push new branch by name' '
 	compare_refs local HEAD server refs/heads/new-name
 '
 
-test_expect_failure 'push new branch with old:new refspec' '
+test_expect_success 'push new branch with old:new refspec' '
 	(cd local &&
 	 git push origin new-name:new-refspec
 	) &&
diff --git a/transport-helper.c b/transport-helper.c
index 835815f..b1fdd39 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -787,7 +787,7 @@ static int push_refs_with_export(struct transport *transport,
 	struct ref *ref;
 	struct child_process *helper, exporter;
 	struct helper_data *data = transport->data;
-	struct string_list revlist_args = STRING_LIST_INIT_NODUP;
+	struct string_list revlist_args = STRING_LIST_INIT_DUP;
 	struct strbuf buf = STRBUF_INIT;
 
 	helper = get_helper(transport);
@@ -814,14 +814,24 @@ static int push_refs_with_export(struct transport *transport,
 			die("remote-helpers do not support ref deletion");
 		}
 
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
1.8.3.rc1.553.gac13664
