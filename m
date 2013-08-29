From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 5/9] transport-helper: add support for old:new refspec
Date: Thu, 29 Aug 2013 10:23:24 -0500
Message-ID: <1377789808-2213-6-git-send-email-felipe.contreras@gmail.com>
References: <1377789808-2213-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 29 17:29:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF49g-0000Su-Lp
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 17:29:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755149Ab3H2P2y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 11:28:54 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:33848 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755096Ab3H2P2x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 11:28:53 -0400
Received: by mail-ob0-f179.google.com with SMTP id fb19so624712obc.24
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 08:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NFkfvgHkJwOPSCary4K0n4pqnLoMXuUud1HkJliLJAQ=;
        b=uvqyX5t5PdxUEo7IRbl3cL0db7tUwrElEOjgvlPT3e0mbbKST1LNk4Px0ztRo2YuEB
         LlEOynbtaIv+KT10vIpUR4W9R9EwFvRSaZwExmf0bKLDWiLwrCPv9bg8t8D4qgNsZEL7
         blea+eh4gs6Vd7TPS0vHnaRR+D4bJ/9qj+17kQiQ8uEY6AAWo0hD91ZpR8aHAtqaBOyU
         nlTAoQ/GAB2nG2jd6tCnQVaIQTG24wCpCttm1oSyRt+2jl111K3e3+rngqLbP91Ljbah
         K5C0Sdi0lNi8O4lPu8YMepZB2J+FlgPQhqTrMb7cl8OuOQA3bgQuJQZ4bFklTzacOtuo
         j2ZA==
X-Received: by 10.60.46.193 with SMTP id x1mr2918262oem.36.1377790132285;
        Thu, 29 Aug 2013 08:28:52 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id ru3sm31899919obc.2.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 08:28:51 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377789808-2213-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233272>

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
index 95dd72e..c7135ef 100644
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
@@ -848,8 +848,13 @@ static int push_refs_with_export(struct transport *transport,
 			die("remote-helpers do not support ref deletion");
 
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
@@ -857,6 +862,8 @@ static int push_refs_with_export(struct transport *transport,
 	if (get_exporter(transport, &exporter, &revlist_args))
 		die("Couldn't run fast-export");
 
+	string_list_clear(&revlist_args, 1);
+
 	if (finish_command(&exporter))
 		die("Error while running fast-export");
 	push_update_refs_status(data, remote_refs);
-- 
1.8.4-fc
