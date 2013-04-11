From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/2] transport-helper: update remote helper namespace
Date: Wed, 10 Apr 2013 19:07:12 -0500
Message-ID: <1365638832-9000-3-git-send-email-felipe.contreras@gmail.com>
References: <1365638832-9000-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 11 02:08:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ54A-0001Ae-Kw
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 02:08:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937467Ab3DKAIZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 20:08:25 -0400
Received: from mail-qa0-f43.google.com ([209.85.216.43]:40222 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937707Ab3DKAIW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 20:08:22 -0400
Received: by mail-qa0-f43.google.com with SMTP id i13so3940qae.9
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 17:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=cm3eUTf88UL2Wwc5GvH9/f8Wzs/bdS+8g4sy6Ahz1no=;
        b=OjCrpv50y1crSOUgA2sMMo+++Gpnx9RSZZs5kG5OsWABlKPCw3hFfvdzqiT3Jvi/6O
         XrsYQPtt4hkIt09iyVWpdLlh0aLMVkqja9d6NRzGheb6ZY3H16NUpGopB7CS8ZEH0DNx
         TlCogSahUwD+0o5S/GDIVM1xbdBNr6DbQt8cDFv/+Z2B0oeWkzOkSUB2DVJUho5XTLTU
         saMxMcxIY+ozQvdX4DASXg2ROfqoz2ZCdPANaOh5GMYFMsw11xiZOL0g6D6AfK1aYgX1
         ntWQYS+d3X1A0MgK4GRBvjnVAYFu14Im8fl6YDm1fUPt/DIY6AnrWxe34fEupdjZXU7X
         plxg==
X-Received: by 10.49.6.2 with SMTP id w2mr5496487qew.0.1365638902048;
        Wed, 10 Apr 2013 17:08:22 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id k8sm3361624qej.2.2013.04.10.17.08.20
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Apr 2013 17:08:21 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365638832-9000-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220797>

When pushing, the remote namespace is updated correctly
(e.g. refs/origin/master), but not the remote helper's
(e.g. refs/testgit/origin/master).

Let's update it correctly.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t5801-remote-helpers.sh | 12 ++++++++++++
 transport-helper.c        | 23 +++++++++++++++++++----
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 214aa40..07f2862 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -180,4 +180,16 @@ test_expect_success 'push messages' '
 	)
 '
 
+test_expect_success 'push update refs' '
+	(cd local &&
+	git checkout -b update master &&
+	echo update >>file &&
+	git commit -a -m update &&
+	git push origin update
+	git rev-parse --verify testgit/origin/heads/update >expect &&
+	git rev-parse --verify remotes/origin/update >actual
+	test_cmp expect actual
+	)
+'
+
 test_done
diff --git a/transport-helper.c b/transport-helper.c
index 2257025..7dff0c2 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -11,6 +11,7 @@
 #include "thread-utils.h"
 #include "sigchain.h"
 #include "argv-array.h"
+#include "refs.h"
 
 static int debug;
 
@@ -618,7 +619,7 @@ static int fetch(struct transport *transport,
 	return -1;
 }
 
-static void push_update_ref_status(struct strbuf *buf,
+static int push_update_ref_status(struct strbuf *buf,
 				   struct ref **ref,
 				   struct ref *remote_refs)
 {
@@ -684,7 +685,7 @@ static void push_update_ref_status(struct strbuf *buf,
 		*ref = find_ref_by_name(remote_refs, refname);
 	if (!*ref) {
 		warning("helper reported unexpected status of %s", refname);
-		return;
+		return 1;
 	}
 
 	if ((*ref)->status != REF_STATUS_NONE) {
@@ -693,11 +694,12 @@ static void push_update_ref_status(struct strbuf *buf,
 		 * status reported by the remote helper if the latter is 'no match'.
 		 */
 		if (status == REF_STATUS_NONE)
-			return;
+			return 1;
 	}
 
 	(*ref)->status = status;
 	(*ref)->remote_status = msg;
+	return 0;
 }
 
 static void push_update_refs_status(struct helper_data *data,
@@ -706,11 +708,24 @@ static void push_update_refs_status(struct helper_data *data,
 	struct strbuf buf = STRBUF_INIT;
 	struct ref *ref = remote_refs;
 	for (;;) {
+		char *private;
+
 		recvline(data, &buf);
 		if (!buf.len)
 			break;
 
-		push_update_ref_status(&buf, &ref, remote_refs);
+		if (push_update_ref_status(&buf, &ref, remote_refs))
+			continue;
+
+		if (!data->refspecs)
+			continue;
+
+		/* propagate back the update to the remote namespace */
+		private = apply_refspecs(data->refspecs, data->refspec_nr, ref->name);
+		if (!private)
+			continue;
+		update_ref("update by helper", private, ref->new_sha1, NULL, 0, 0);
+		free(private);
 	}
 	strbuf_release(&buf);
 }
-- 
1.8.2.1
