From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 p2 1/9] transport-helper: update remote helper namespace
Date: Sat, 24 Nov 2012 04:25:12 +0100
Message-ID: <1353727520-26039-2-git-send-email-felipe.contreras@gmail.com>
References: <1353727520-26039-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 24 04:25:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tc6NP-0006my-KW
	for gcvg-git-2@plane.gmane.org; Sat, 24 Nov 2012 04:25:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932582Ab2KXDZi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 22:25:38 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39227 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755857Ab2KXDZh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 22:25:37 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so4063663bkw.19
        for <git@vger.kernel.org>; Fri, 23 Nov 2012 19:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=EMLJuwdtiD4yi9xgIJfvyDZ4ZgzdBM3W8xw3G5tcPrM=;
        b=lC0Q3h7wFyTpftrI4BQyfj/2xftSEADM5uuBaRIdfeOhEF7sd07g+g0nrfPK/5fETA
         ZOwcg+ndD1pZmTkZxcCV7RkPIAW9Aco6PSa4ybNvjA5MV+f5OQDESFGZl64koSB9+5kN
         UBKyyC343iRIK/OwhclKPEhuFYkXRM6mSa5Zjaa5CZZG4NPsOh1ZR+EcnpXNECwF0rvP
         C5tNqcxHhAQoyVqb3rL0djIHVtboapoZfgyox69iTTm7W+LMVUDFXnPz5eNmMKArWrVd
         CmFFUshAtezyPsjHuIaiTn/rZ6hqlLci68NPXfZyE+ANoEXfFYWnKwIyBtJHUaqnTLma
         8KFA==
Received: by 10.204.10.74 with SMTP id o10mr1765257bko.9.1353727536761;
        Fri, 23 Nov 2012 19:25:36 -0800 (PST)
Received: from localhost (ip-109-43-0-90.web.vodafone.de. [109.43.0.90])
        by mx.google.com with ESMTPS id f24sm5466486bkv.7.2012.11.23.19.25.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Nov 2012 19:25:35 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353727520-26039-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210300>

When pushing, the remote namespace is updated correctly
(e.g. refs/origin/master), but not the remote helper's
(e.g. refs/testgit/origin/master).

This alone should not cause any regressions, but combined with other
patches to handle negative refs correctly (upcoming patch), it might.
However, that's a good thing;  otherwise those issues would go
unnoticed.

For the moment though, this patch alone shouldn't cause any issues, in
fact the rest of the code seems to rely on this happening.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 transport-helper.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index cfe0988..32ad877 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -10,6 +10,7 @@
 #include "string-list.h"
 #include "thread-utils.h"
 #include "sigchain.h"
+#include "refs.h"
 
 static int debug;
 
@@ -600,7 +601,7 @@ static int fetch(struct transport *transport,
 	return -1;
 }
 
-static void push_update_ref_status(struct strbuf *buf,
+static int push_update_ref_status(struct strbuf *buf,
 				   struct ref **ref,
 				   struct ref *remote_refs)
 {
@@ -651,7 +652,7 @@ static void push_update_ref_status(struct strbuf *buf,
 		*ref = find_ref_by_name(remote_refs, refname);
 	if (!*ref) {
 		warning("helper reported unexpected status of %s", refname);
-		return;
+		return 1;
 	}
 
 	if ((*ref)->status != REF_STATUS_NONE) {
@@ -660,11 +661,12 @@ static void push_update_ref_status(struct strbuf *buf,
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
@@ -673,11 +675,23 @@ static void push_update_refs_status(struct helper_data *data,
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
 	}
 	strbuf_release(&buf);
 }
-- 
1.8.0
