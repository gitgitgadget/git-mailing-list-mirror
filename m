From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 13/14] cmd_fetch_pack(): simplify computation of return value
Date: Sun,  9 Sep 2012 08:19:48 +0200
Message-ID: <1347171589-13327-14-git-send-email-mhagger@alum.mit.edu>
References: <1347171589-13327-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 09 08:21:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAatg-0002rp-Le
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 08:21:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753078Ab2IIGVZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 02:21:25 -0400
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:43233 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752516Ab2IIGUx (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Sep 2012 02:20:53 -0400
X-AuditID: 12074412-b7f216d0000008e3-e5-504c354582e7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 42.9B.02275.5453C405; Sun,  9 Sep 2012 02:20:53 -0400 (EDT)
Received: from michael.fritz.box (p57A25CBD.dip.t-dialin.net [87.162.92.189])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q896KIlq029164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 9 Sep 2012 02:20:51 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1347171589-13327-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsUixO6iqOtq6hNg0NXOa9F1pZvJoqH3CrPF
	7RXzmS1+tPQwW3ROlXVg9fj7/gOTx/Kl6xg9nvXuYfS4eEnZ4/MmuQDWKG6bpMSSsuDM9Dx9
	uwTujMd7HjEW3OGqmP8jsYFxO0cXIyeHhICJxO+WGSwQtpjEhXvr2boYuTiEBC4zSlyb+IMF
	wjnDJHF160F2kCo2AV2JRT3NTCC2iICaxMS2Q2BFzAJdjBLL1/1iA0kICwRITL3fzwxiswio
	Smx7+p8VxOYVcJU4/n47I8Q6RYkf39eA1XACxV/N3A0WFxJwkdi08xrrBEbeBYwMqxjlEnNK
	c3VzEzNzilOTdYuTE/PyUot0zfRyM0v0UlNKNzFCQkpoB+P6k3KHGAU4GJV4eFnueAcIsSaW
	FVfmHmKU5GBSEuXVMPEJEOJLyk+pzEgszogvKs1JLT7EKMHBrCTCe5UdKMebklhZlVqUD5OS
	5mBREuf9uVjdT0ggPbEkNTs1tSC1CCYrw8GhJMFrDDJUsCg1PbUiLTOnBCHNxMEJMpxLSqQ4
	NS8ltSixtCQjHhQb8cXA6ABJ8QDtDQZp5y0uSMwFikK0nmLU5Zh9c8V9RiGWvPy8VClx3jKQ
	IgGQoozSPLgVsATyilEc6GNhXmeQKh5g8oGb9ApoCRPQEpFnHiBLShIRUlINjGmdBYn3H1lt
	ypiS7LA/K4U5bMqHI9P6Njw9ldR2zyEkWPbBabW1H1e/TXWcJSPep7FL3WPRysvcW58lVOyv
	fX16dwGjpXKN4r1Pjmlsra8y/LWrv5/YU3i99qFcIq+6C6vrzOkXXLQ6j0s0z7qr 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205056>

Set the final value at initialization rather than initializing it then
sometimes changing it.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch-pack.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 3d388b5..42078e5 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -1020,17 +1020,16 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	if (finish_connect(conn))
 		return 1;
 
-	ret = !ref;
-	if (sought.nr) {
-		/* If the heads to pull were given, we should have
-		 * consumed all of them by matching the remote.
-		 * Otherwise, 'git fetch remote no-such-ref' would
-		 * silently succeed without issuing an error.
-		 */
-		for (i = 0; i < sought.nr; i++)
-			error("no such remote ref %s", sought.items[i].string);
-		ret = 1;
-	}
+	ret = !ref || sought.nr;
+
+	/*
+	 * If the heads to pull were given, we should have consumed
+	 * all of them by matching the remote.  Otherwise, 'git fetch
+	 * remote no-such-ref' would silently succeed without issuing
+	 * an error.
+	 */
+	for (i = 0; i < sought.nr; i++)
+		error("no such remote ref %s", sought.items[i].string);
 	while (ref) {
 		printf("%s %s\n",
 		       sha1_to_hex(ref->old_sha1), ref->name);
-- 
1.7.11.3
