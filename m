From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 8/9] transport-helper: add support to delete branches
Date: Thu, 29 Aug 2013 10:23:27 -0500
Message-ID: <1377789808-2213-9-git-send-email-felipe.contreras@gmail.com>
References: <1377789808-2213-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 29 17:29:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF4A3-0000oo-RN
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 17:29:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753756Ab3H2P3X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 11:29:23 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:52536 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752673Ab3H2P3X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 11:29:23 -0400
Received: by mail-oa0-f50.google.com with SMTP id i4so764013oah.23
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 08:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+v48rauq3NTD8f8caz1jUB7zCOp1nmHKvxPAueKeyH8=;
        b=QzJqHY6CSCkjikm4oaNX77zCgQpudVhnAgi/OI2R6wbeOoty4joeN7iFOKwl2YgLe0
         Qt4+Lk2GAdYWnI5YtPXjm9jHxmHCw42ysDJjk0WKJpGCHjh/ml2fAs5tDlxrCE6fwUgQ
         yzOw5WOIgOwGwg0sc/BYoCORoA5rSjSeILkVzBla18l3/gTrHfmL4ajcgEC8KCq4VlWE
         ltNb6fDds4JBsRO4pvHd3O1HakfKosM5VDBzSn9m8EvNwSrZMMfMPKOJ1BC36JZJapgj
         sEvBjNQ3F+XGUCMcA8aWEBaBCiwX/Z6yjB0N5l6HuPMnQr0p20he4aGpOLddjgMnq8XN
         fGGw==
X-Received: by 10.60.124.195 with SMTP id mk3mr2064314oeb.54.1377790162737;
        Thu, 29 Aug 2013 08:29:22 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id a18sm31902655obf.7.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 08:29:21 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377789808-2213-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233275>

For remote-helpers that use 'export' to push.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t5801-remote-helpers.sh |  8 ++++++++
 transport-helper.c        | 11 ++++++-----
 2 files changed, 14 insertions(+), 5 deletions(-)

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
index c7135ef..5490796 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -844,18 +844,19 @@ static int push_refs_with_export(struct transport *transport,
 		}
 		free(private);
 
-		if (ref->deletion)
-			die("remote-helpers do not support ref deletion");
-
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
