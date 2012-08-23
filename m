From: mhagger@alum.mit.edu
Subject: [PATCH 15/17] cmd_fetch_pack(): simplify computation of return value
Date: Thu, 23 Aug 2012 10:10:40 +0200
Message-ID: <1345709442-16046-16-git-send-email-mhagger@alum.mit.edu>
References: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 10:11:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4SW9-0007n8-Bz
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 10:11:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933684Ab2HWILr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 04:11:47 -0400
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:63435 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933615Ab2HWILk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Aug 2012 04:11:40 -0400
X-AuditID: 1207440e-b7f036d0000008b5-0a-5035e5bc3b41
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 68.3D.02229.CB5E5305; Thu, 23 Aug 2012 04:11:40 -0400 (EDT)
Received: from michael.fritz.box (p57A2588E.dip.t-dialin.net [87.162.88.142])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7N8AkVF030408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 23 Aug 2012 04:11:39 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsUixO6iqLvnqWmAwevlfBZdV7qZLBp6rzBb
	3F4xn9niR0sPswOLx9/3H5g8nvXuYfS4eEnZ4/MmuQCWKG6bpMSSsuDM9Dx9uwTujM0fZzAV
	vOWquPchqoHxIEcXIyeHhICJxLGda9ghbDGJC/fWs3UxcnEICVxmlNj2/AYLhHOWSWLu7ess
	IFVsAlISLxt7wDpEBNQkJrYdAoszC6RIdDzvZgSxhQV8JTa8+wYWZxFQleh7u5gVxOYVcJX4
	OucS1DZFiR/f1zCD2JxA8QXfN4H1Cgm4SHxsvMk8gZF3ASPDKka5xJzSXN3cxMyc4tRk3eLk
	xLy81CJdY73czBK91JTSTYyQ8OHbwdi+XuYQowAHoxIP7wtz0wAh1sSy4srcQ4ySHExKorz/
	HgGF+JLyUyozEosz4otKc1KLDzFKcDArifCGzwPK8aYkVlalFuXDpKQ5WJTEedWWqPsJCaQn
	lqRmp6YWpBbBZGU4OJQkeNOeADUKFqWmp1akZeaUIKSZODhBhnNJiRSn5qWkFiWWlmTEgyIj
	vhgYGyApHqC9T0HaeYsLEnOBohCtpxh1Of6fPHmXUYglLz8vVUqc9yRIkQBIUUZpHtwKWLJ4
	xSgO9LEw7zmQKh5gooGb9ApoCRPQErWrxiBLShIRUlINjJUqWovvtS/VmCe1O5qNs1vHnflF
	1q2dm7VePnxYFfqoqvOOYKe7rYJFWeaHU7Y6Ky6VWQesPzJH7fmONYZHyzfrLbm7auUP/ss7
	9tlV9Z55ta0wTI+peqdVzanC7L0LmwIUtoT+ezpzDeOxCyWcgV57Z207tvTIc65H 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204117>

From: Michael Haggerty <mhagger@alum.mit.edu>

Set the final value at initialization rather than initializing it then
sometimes changing it.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch-pack.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 5b1e603..6c1a48e 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -1027,17 +1027,16 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	if (finish_connect(conn))
 		return 1;
 
-	ret = !ref;
-	if (nr_heads) {
-		/* If the heads to pull were given, we should have
-		 * consumed all of them by matching the remote.
-		 * Otherwise, 'git fetch remote no-such-ref' would
-		 * silently succeed without issuing an error.
-		 */
-		for (i = 0; i < nr_heads; i++)
-			error("no such remote ref %s", heads[i]);
-		ret = 1;
-	}
+	ret = !ref || nr_heads;
+
+	/*
+	 * If the heads to pull were given, we should have consumed
+	 * all of them by matching the remote.  Otherwise, 'git fetch
+	 * remote no-such-ref' would silently succeed without issuing
+	 * an error.
+	 */
+	for (i = 0; i < nr_heads; i++)
+		error("no such remote ref %s", heads[i]);
 	while (ref) {
 		printf("%s %s\n",
 		       sha1_to_hex(ref->old_sha1), ref->name);
-- 
1.7.11.3
