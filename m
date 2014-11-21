From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 1/6] prune_remote(): exit early if there are no stale references
Date: Fri, 21 Nov 2014 15:09:05 +0100
Message-ID: <1416578950-23210-2-git-send-email-mhagger@alum.mit.edu>
References: <1416423000-4323-1-git-send-email-sbeller@google.com>
 <1416578950-23210-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 21 15:09:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xroto-0000Fq-FW
	for gcvg-git-2@plane.gmane.org; Fri, 21 Nov 2014 15:09:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755757AbaKUOJU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2014 09:09:20 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:48731 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751175AbaKUOJT (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Nov 2014 09:09:19 -0500
X-AuditID: 1207440f-f792a6d000001284-f0-546f478ef7d4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id DE.6B.04740.E874F645; Fri, 21 Nov 2014 09:09:18 -0500 (EST)
Received: from michael.fritz.box (p5DDB272E.dip0.t-ipconnect.de [93.219.39.46])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sALE9EqP000733
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 21 Nov 2014 09:09:17 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1416578950-23210-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsUixO6iqNvnnh9i8HahgkXXlW4mi4beK8wW
	b28uYbS4vWI+s8W/CTUWmze3sziwefx9/4HJY+esu+weCzaVely8pOzxeZNcAGsUt01SYklZ
	cGZ6nr5dAnfGi4PNLAW9/BUPN+1kaWCcxdPFyMEhIWAise9tRhcjJ5ApJnHh3nq2LkYuDiGB
	y4wSD5qOsUM4x5kkvl3cyAxSxSagK7Gop5kJxBYR8JI4tW4GM0gRs8B8RonZ62YygiSEBQIk
	3s/9ywZiswioSty/vQnM5hVwkbjSOpUNYrOcxNZ13iBhTgFXiacr+thBbCGBGokrfdvZJjDy
	LmBkWMUol5hTmqubm5iZU5yarFucnJiXl1qka6KXm1mil5pSuokRElj8Oxi71sscYhTgYFTi
	4V2xOC9EiDWxrLgy9xCjJAeTkiivoVt+iBBfUn5KZUZicUZ8UWlOavEhRgkOZiUR3nJhoBxv
	SmJlVWpRPkxKmoNFSZxXfYm6n5BAemJJanZqakFqEUxWhoNDSYLXH2SoYFFqempFWmZOCUKa
	iYMTZDiXlEhxal5KalFiaUlGPCgy4ouBsQGS4gHaWwHSzltckJgLFIVoPcWoKCXO6wuSEABJ
	ZJTmwY2FpYtXjOJAXwrzVoFU8QBTDVz3K6DBTECD/y7NBRlckoiQkmpgTDy35e/zgPDFs+Kv
	HTT23ayiy1ZRuTk13e3ZgtPfjh75nbnuiSLTGuOv++STFtaqMf5zWNR4JLPM/VF8z6MzB+zK
	/yRu2fNz34TLt9rtqtsLFr44dElxiULJCV2LU7M8ssX/HFbfZ7OR59HpOsPI5hjW 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Aside from making the logic clearer, this avoids a call to
warn_dangling_symrefs(), which always does a for_each_rawref()
iteration.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
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
