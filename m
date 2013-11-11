From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 10/10] transport-helper: add support to delete branches
Date: Mon, 11 Nov 2013 16:54:57 -0600
Message-ID: <1384210507-26561-1-git-send-email-felipe.contreras@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 12 00:02:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vg0Ue-0005wh-36
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 00:02:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753224Ab3KKXCA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 18:02:00 -0500
Received: from mail-ob0-f175.google.com ([209.85.214.175]:61653 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753035Ab3KKXB6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 18:01:58 -0500
Received: by mail-ob0-f175.google.com with SMTP id va2so5152639obc.34
        for <git@vger.kernel.org>; Mon, 11 Nov 2013 15:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=T+rum7UD+0Kk60+QYQjD1BaKcxN/WlbPJff10Y81NR0=;
        b=HjlJzeKPGtIQ6c1KXcvRijiVI7UQZrb7VZYUx987DLMOujaF7Bj/nLY8lF8YMfd9TH
         r9jOXEzZNFnl+/jCa0IonFhlg61rSi9A+1Dw6JBt+wiDxDNhBzHHCFyfWp+8arDHcWGI
         eGBFBBwKA6MHpaD/V6xjMDYMGm5aXKHG4BAr30oOWxNW8LyiZcYjXfcznE+9UHUOBq/m
         CcjiOIlzhk9rlNjZmL4xjW3Pjy2jRL/J0oELXScPfR6idWh+zmoL1u0rL9aMeFo30RKp
         2Ccus0PZTUENxw/6ddSfayUUBZzDCoSb/jRCUW6qo4E1Lv9nAWRjGjxFxUErMzXxPQM0
         LXcQ==
X-Received: by 10.182.237.75 with SMTP id va11mr27934835obc.5.1384210918188;
        Mon, 11 Nov 2013 15:01:58 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id rl1sm29420856oeb.7.2013.11.11.15.01.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2013 15:01:57 -0800 (PST)
X-Mailer: git-send-email 1.8.4.2+fc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237663>

For remote-helpers that use 'export' to push.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t5801-remote-helpers.sh |  8 ++++++++
 transport-helper.c        | 11 ++++++-----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 454337e..c667965 100755
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
 test_expect_success 'forced push' '
 	(cd local &&
 	git checkout -b force-test &&
diff --git a/transport-helper.c b/transport-helper.c
index 7411125..2257588 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -876,9 +876,6 @@ static int push_refs_with_export(struct transport *transport,
 		char *private;
 		unsigned char sha1[20];
 
-		if (ref->deletion)
-			die("remote-helpers do not support ref deletion");
-
 		private = apply_refspecs(data->refspecs, data->refspec_nr, ref->name);
 		if (private && !get_sha1(private, sha1)) {
 			strbuf_addf(&buf, "^%s", private);
@@ -890,12 +887,16 @@ static int push_refs_with_export(struct transport *transport,
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
1.8.4.2+fc1
