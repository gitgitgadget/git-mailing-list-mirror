From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 1/7] prune_remote(): exit early if there are no stale references
Date: Tue, 25 Nov 2014 09:02:29 +0100
Message-ID: <1416902555-10748-2-git-send-email-mhagger@alum.mit.edu>
References: <1416902555-10748-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 09:02:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtB5N-0001l0-6Y
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 09:02:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752068AbaKYICw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 03:02:52 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:52000 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751800AbaKYICu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Nov 2014 03:02:50 -0500
X-AuditID: 12074413-f79f26d0000030e7-ea-547437a8c566
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id DE.CC.12519.8A734745; Tue, 25 Nov 2014 03:02:48 -0500 (EST)
Received: from michael.fritz.box (p5DDB361F.dip0.t-ipconnect.de [93.219.54.31])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sAP82i0k027888
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 25 Nov 2014 03:02:47 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1416902555-10748-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsUixO6iqLvCvCTE4NprXouuK91MFg29V5gt
	3t5cwmhxe8V8Zot/E2osNm9uZ3Fg8/j7/gOTx85Zd9k9Fmwq9bh4Sdnj8ya5ANYobpukxJKy
	4Mz0PH27BO6M36u2sRUc4K9oe/uIrYHxBE8XIyeHhICJxK+/B5kgbDGJC/fWs4HYQgKXGSU6
	+rIh7ONMEv3XwGw2AV2JRT3NYPUiAmoSE9sOsXQxcnEwCxxmlHi9cxk7SEJYIFji8bJnYINY
	BFQl9p0/zQhi8wq4SCy5/RGogQNomZzE1nXeIGFOAVeJmXsPMULscpFYu6+VfQIj7wJGhlWM
	cok5pbm6uYmZOcWpybrFyYl5ealFuuZ6uZkleqkppZsYIWElvINx10m5Q4wCHIxKPLwNx4pD
	hFgTy4orcw8xSnIwKYnyihiWhAjxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4Y2aB1TOm5JYWZVa
	lA+TkuZgURLnVVui7ickkJ5YkpqdmlqQWgSTleHgUJLglTcDGipYlJqeWpGWmVOCkGbi4AQZ
	ziUlUpyal5JalFhakhEPiov4YmBkgKR4gPYWgbTzFhck5gJFIVpPMSpKifOGgiQEQBIZpXlw
	Y2HJ4hWjONCXwrwTQKp4gIkGrvsV0GAmoMFxMwtBBpckIqSkGhgjZzxlWeZrU7/wlseDjwoS
	ejsuXSx97Cy9jWnX7BlVer6H7kestG/ROWHKpXrkuXiM9TQG2f5LV3ZMflY9d8tv/U3WZs1m
	JZeuTinunRR27d2XF6/Z/kTM3bNVXqPVSsDpb88jl/VplsHBSy+EXPl5JE6u+tGU 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260199>

Aside from making the logic clearer, this avoids a call to
warn_dangling_symrefs(), which always does a for_each_rawref()
iteration.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/remote.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 7f28f92..d2b684c 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1325,25 +1325,28 @@ static int prune_remote(const char *remote, int dry_run)
 	memset(&states, 0, sizeof(states));
 	get_remote_ref_states(remote, &states, GET_REF_STATES);
 
-	if (states.stale.nr) {
-		printf_ln(_("Pruning %s"), remote);
-		printf_ln(_("URL: %s"),
-		       states.remote->url_nr
-		       ? states.remote->url[0]
-		       : _("(no URL)"));
-
-		delete_refs = xmalloc(states.stale.nr * sizeof(*delete_refs));
-		for (i = 0; i < states.stale.nr; i++)
-			delete_refs[i] = states.stale.items[i].util;
-		if (!dry_run) {
-			struct strbuf err = STRBUF_INIT;
-			if (repack_without_refs(delete_refs, states.stale.nr,
-						&err))
-				result |= error("%s", err.buf);
-			strbuf_release(&err);
-		}
-		free(delete_refs);
+	if (!states.stale.nr) {
+		free_remote_ref_states(&states);
+		return 0;
+	}
+
+	printf_ln(_("Pruning %s"), remote);
+	printf_ln(_("URL: %s"),
+		  states.remote->url_nr
+		  ? states.remote->url[0]
+		  : _("(no URL)"));
+
+	delete_refs = xmalloc(states.stale.nr * sizeof(*delete_refs));
+	for (i = 0; i < states.stale.nr; i++)
+		delete_refs[i] = states.stale.items[i].util;
+	if (!dry_run) {
+		struct strbuf err = STRBUF_INIT;
+		if (repack_without_refs(delete_refs, states.stale.nr,
+					&err))
+			result |= error("%s", err.buf);
+		strbuf_release(&err);
 	}
+	free(delete_refs);
 
 	for (i = 0; i < states.stale.nr; i++) {
 		const char *refname = states.stale.items[i].util;
-- 
2.1.3
