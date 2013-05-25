From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 9/9] transport-helper: add support to delete branches
Date: Fri, 24 May 2013 21:47:40 -0500
Message-ID: <1369450060-19011-10-git-send-email-felipe.contreras@gmail.com>
References: <1369450060-19011-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:50:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4Z9-0005Xs-Ly
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:50:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756010Ab3EYCuh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:50:37 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:53318 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309Ab3EYCue (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:50:34 -0400
Received: by mail-oa0-f54.google.com with SMTP id o17so7031972oag.13
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=UQ1VoU8/DaNc45rMfeGg1M9dM19hsOin4HN4uqtBa+I=;
        b=pZRwjdodGH1cVoswQaa1XcCtrtbjF4omp+HxB/6S4jlUQ5/74m3l8Cmx7eCSJmQkv4
         RKZple3TOboACb/zAC8UxNCuH5/XSgC/6UFlf0bUcyp/GTX5x+REhrKh0Nu4DaDp4gup
         KP8pUsDqP+vwZCYv8tET/n590oSTINlmfAZW2v/NpqZWvKAbw5PUyIy4krw/zSuqwn7M
         suVWK67bXwtN0cZlcqDmXzxLTw3q8RRfzW95JucVx/9vhrVbgUExlYsbYM5ZHQ4vr7WI
         Ib0VUI44UZvzei/GffnjL+jv2dI598+pFB3Ov8fA9VdLVTc9/0vT2cb00kJI5Xl8WYLv
         hkog==
X-Received: by 10.182.137.196 with SMTP id qk4mr13532938obb.53.1369450234523;
        Fri, 24 May 2013 19:50:34 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id x5sm20657630oep.1.2013.05.24.19.50.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:50:33 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369450060-19011-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225484>

For remote-helpers that use 'export' to push.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t5801-remote-helpers.sh |  8 ++++++++
 transport-helper.c        | 11 ++++++-----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 6a7db8b..a4643ce 100755
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
index cc2150f..3ac4ced 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -833,9 +833,6 @@ static int push_refs_with_export(struct transport *transport,
 		char *private;
 		unsigned char sha1[20];
 
-		if (ref->deletion)
-			die("remote-helpers do not support ref deletion");
-
 		private = apply_refspecs(data->refspecs, data->refspec_nr, ref->name);
 		if (private && !get_sha1(private, sha1)) {
 			strbuf_addf(&buf, "^%s", private);
@@ -847,12 +844,16 @@ static int push_refs_with_export(struct transport *transport,
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
1.8.3.rc3.312.g47657de
