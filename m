From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 6/6] transport-helper: update remote helper namespace
Date: Wed, 17 Apr 2013 23:14:33 -0500
Message-ID: <1366258473-12841-7-git-send-email-felipe.contreras@gmail.com>
References: <1366258473-12841-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Max Horn <max@quendi.de>, Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 18 06:16:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USgGb-0002Oo-9w
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 06:16:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753839Ab3DREQG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 00:16:06 -0400
Received: from mail-ye0-f174.google.com ([209.85.213.174]:56809 "EHLO
	mail-ye0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753694Ab3DREQD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 00:16:03 -0400
Received: by mail-ye0-f174.google.com with SMTP id l2so385421yen.33
        for <git@vger.kernel.org>; Wed, 17 Apr 2013 21:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=lIY+LxW6khn1K0mXnfBWZXCH6ATHzQbpKFqE3qIs1Tg=;
        b=En8XbmL5V3WaMhi9NvlFITi+XxGlgtpFOOXXt1XR29rwxnWch2WDC4KdorlUgU1PvW
         HYhOAo5BYEb8M+e7R/hLERP6ca7bKQrbIgUBUgwLXZ6xP/5CArqGhzwtwXncAwJj0vyV
         LqL63wGiSdOpumoABOD8zZaVHEF6qMfGd1U22Z2mC0nE/Al2vvui5LcNAZBplea6vuMh
         wOJFJpMIh3wPztV2EV72vxRgJ1nw77bQ7Bqe7s+afrsW5YRK3onaPgTI+AoGJ74ORMTS
         xmZ3LO7eHdhN3wSE9rCmf8Q438q/I2vSV5+I8Enx1IY02ww648N2GcpsUYj4WSJt3SYx
         i7og==
X-Received: by 10.236.170.66 with SMTP id o42mr6425393yhl.3.1366258562896;
        Wed, 17 Apr 2013 21:16:02 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id c67sm14540629yhh.16.2013.04.17.21.16.01
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Apr 2013 21:16:02 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.679.g509521a
In-Reply-To: <1366258473-12841-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221608>

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
 transport-helper.c        | 23 +++++++++++++++++++----
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 1bb7529..5466969 100755
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
+	git rev-parse --verify remotes/origin/update >expect &&
+	git rev-parse --verify testgit/origin/heads/update >actual &&
+	test_cmp expect actual
+	)
+'
+
 test_done
diff --git a/transport-helper.c b/transport-helper.c
index 9d31f2d..da16393 100644
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
@@ -708,11 +710,24 @@ static void push_update_refs_status(struct helper_data *data,
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
1.8.2.1.679.g509521a
