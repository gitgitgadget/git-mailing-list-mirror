From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 11/14] cmd_fetch_pack(): return early if finish_connect() fails
Date: Sun,  9 Sep 2012 08:19:46 +0200
Message-ID: <1347171589-13327-12-git-send-email-mhagger@alum.mit.edu>
References: <1347171589-13327-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 09 08:21:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAatq-00032a-0d
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 08:21:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753036Ab2IIGVY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 02:21:24 -0400
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:44287 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752509Ab2IIGUt (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Sep 2012 02:20:49 -0400
X-AuditID: 12074414-b7f846d0000008b8-b2-504c35403eb1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id DF.84.02232.0453C405; Sun,  9 Sep 2012 02:20:48 -0400 (EDT)
Received: from michael.fritz.box (p57A25CBD.dip.t-dialin.net [87.162.92.189])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q896KIlo029164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 9 Sep 2012 02:20:47 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1347171589-13327-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsUixO6iqOtg6hNgsLrXzKLrSjeTRUPvFWaL
	2yvmM1v8aOlhtuicKuvA6vH3/Qcmj+VL1zF6POvdw+hx8ZKyx+dNcgGsUdw2SYklZcGZ6Xn6
	dgncGRO/72cpWMpWsen0G+YGxibWLkZODgkBE4n/Rx+zQ9hiEhfurWfrYuTiEBK4zCjxtuMj
	M0hCSOAMk8S/NWogNpuArsSinmYmEFtEQE1iYtshFpAGZoEuRonl636xgSSEBYIkXv7cB2az
	CKhKTNj7BWwDr4CrxOaPp9ggtilK/Pi+BmwBJ1D81czdjBDLXCQ27bzGOoGRdwEjwypGucSc
	0lzd3MTMnOLUZN3i5MS8vNQiXQu93MwSvdSU0k2MkJAS2cF45KTcIUYBDkYlHl6mO94BQqyJ
	ZcWVuYcYJTmYlER5NUx8AoT4kvJTKjMSizPii0pzUosPMUpwMCuJ8F5lB8rxpiRWVqUW5cOk
	pDlYlMR5vy1W9xMSSE8sSc1OTS1ILYLJynBwKEnwLgYZKliUmp5akZaZU4KQZuLgBBFcIBt4
	gDacBCnkLS5IzC3OTIcoOsWoKCXOWwaSEABJZJTmwQ2ARf8rRnGgf4R5a0GqeICJA677FdBg
	JqDBIs88QAaXJCKkpBoY7YJDGuUFlC9fLSmRcZ+dwCJqc7/IWe3Q3eL/UnoRwbZxeqct/Oat
	LLcJ6eXvslNWZHbQsEs8ILh7C0vT6e13cj/WyfMIyNx8+Enn1GMGp3759z9tuCJPZ85JzjuX
	bXXaJMTz8NIyx+2iBzsNZW+4/dNrSlSWt7P5kHb64PlllqGxXsy9SUosxRmJhlrM 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205058>

This simplifies the logic without changing the behavior.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch-pack.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 056ccb8..fb2a423 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -1018,10 +1018,10 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	close(fd[0]);
 	close(fd[1]);
 	if (finish_connect(conn))
-		ref = NULL;
-	ret = !ref;
+		return 1;
 
-	if (!ret && sought.nr) {
+	ret = !ref;
+	if (ref && sought.nr) {
 		/* If the heads to pull were given, we should have
 		 * consumed all of them by matching the remote.
 		 * Otherwise, 'git fetch remote no-such-ref' would
-- 
1.7.11.3
