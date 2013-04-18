From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 6/6] transport-helper: update remote helper namespace
Date: Wed, 17 Apr 2013 19:05:24 -0500
Message-ID: <1366243524-18202-7-git-send-email-felipe.contreras@gmail.com>
References: <1366243524-18202-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Max Horn <max@quendi.de>, Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 18 02:07:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UScNT-0007MI-O6
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 02:07:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935549Ab3DRAG5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 20:06:57 -0400
Received: from mail-qc0-f180.google.com ([209.85.216.180]:50764 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935433Ab3DRAG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 20:06:56 -0400
Received: by mail-qc0-f180.google.com with SMTP id b40so988251qcq.39
        for <git@vger.kernel.org>; Wed, 17 Apr 2013 17:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=7KN0aTmNqJnltj4Zy8GDI6kjdBFreqly5Ru60EHLwPI=;
        b=wfHzGN/hRsTbwjOyk+QkW4sH7xXwof4/xY95A1qbJ6eQuEktFEvkw/LL4PMdfUNYFI
         qHeaPgsWVsX3gdgf6AYbScMtZ8RorkQXavI5uCiC60aDexI/vGsrgYy7Jl9tgUJR2rsn
         2je4T5DjUo5KekUio3/we9xg6gdR36bBO2Fl+DmXEy4RQBg3MPs+ZO+Bb2bhiLs8Q7gk
         7hHvYAoXVIb5z/veeqDtRSvIgJSs8F1CjQc2T70/ycWg8RBETbRr/dC56BX+/y038TiR
         qkBmPPHSjR1JGj8nNkvDTAoh78iAW4VPyuJwC9Kb7f+CWon+iI+fSPgsQiKlV7j9QbNI
         7ofQ==
X-Received: by 10.49.59.81 with SMTP id x17mr9634329qeq.21.1366243614720;
        Wed, 17 Apr 2013 17:06:54 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id r3sm10281919qef.5.2013.04.17.17.06.52
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Apr 2013 17:06:53 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.679.g509521a
In-Reply-To: <1366243524-18202-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221593>

When pushing, the remote namespace is updated correctly
(e.g. refs/origin/master), but not the remote helper's
(e.g. refs/testgit/origin/master), which currently is only updated while
fetching.

Since the remote namespace is used to tell fast-export which commits to
avoid (because they were already imported/exported), it makes sense to
have them in sync so they don't get generated twice. If the remote
helper was implemented properly, they would be ignored, if not, they
probably would end up repeated (probably).

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t5801-remote-helpers.sh | 12 ++++++++++++
 transport-helper.c        | 20 ++++++++++++++++----
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 1bb7529..097691c 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -153,4 +153,16 @@ test_expect_success 'push ref with existing object' '
 	compare_refs local dup server dup
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
index 9d31f2d..414d6c8 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -11,6 +11,7 @@
 #include "thread-utils.h"
 #include "sigchain.h"
 #include "argv-array.h"
+#include "refs.h"
 
 static int debug;
 
@@ -620,7 +621,7 @@ static int fetch(struct transport *transport,
 	return -1;
 }
 
-static void push_update_ref_status(struct strbuf *buf,
+static int push_update_ref_status(struct strbuf *buf,
 				   struct ref **ref,
 				   struct ref *remote_refs)
 {
@@ -686,7 +687,7 @@ static void push_update_ref_status(struct strbuf *buf,
 		*ref = find_ref_by_name(remote_refs, refname);
 	if (!*ref) {
 		warning("helper reported unexpected status of %s", refname);
-		return;
+		return 1;
 	}
 
 	if ((*ref)->status != REF_STATUS_NONE) {
@@ -695,11 +696,12 @@ static void push_update_ref_status(struct strbuf *buf,
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
@@ -708,11 +710,21 @@ static void push_update_refs_status(struct helper_data *data,
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
1.8.2.1.679.g509521a
