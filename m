From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 2/6] prune_remote(): initialize both delete_refs lists in a single loop
Date: Fri, 21 Nov 2014 15:09:06 +0100
Message-ID: <1416578950-23210-3-git-send-email-mhagger@alum.mit.edu>
References: <1416423000-4323-1-git-send-email-sbeller@google.com>
 <1416578950-23210-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 21 15:09:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xrou6-0000PW-3s
	for gcvg-git-2@plane.gmane.org; Fri, 21 Nov 2014 15:09:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758403AbaKUOJg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2014 09:09:36 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:52946 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758383AbaKUOJf (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Nov 2014 09:09:35 -0500
X-AuditID: 1207440c-f79376d00000680a-6d-546f478ff750
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 84.74.26634.F874F645; Fri, 21 Nov 2014 09:09:19 -0500 (EST)
Received: from michael.fritz.box (p5DDB272E.dip0.t-ipconnect.de [93.219.39.46])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sALE9EqQ000733
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 21 Nov 2014 09:09:18 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1416578950-23210-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsUixO6iqNvvnh9i8GCVsUXXlW4mi4beK8wW
	b28uYbS4vWI+s8W/CTUWmze3sziwefx9/4HJY+esu+weCzaVely8pOzxeZNcAGsUt01SYklZ
	cGZ6nr5dAnfGsxbVglu8FRtmHWZuYJzG3cXIySEhYCLxbsMaJghbTOLCvfVsXYxcHEIClxkl
	Jl0/zQaSEBI4ziRx7L0tiM0moCuxqKcZrEFEwEvi1LoZzCANzALzGSVmr5vJCJIQFgiXWLrm
	PjOIzSKgKnGsuZOli5GDg1fARWLHegEQU0JATmLrOm+QCk4BV4mnK/rYIVbVSFzp2842gZF3
	ASPDKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdQ73czBK91JTSTYyQoOLZwfhtncwhRgEORiUe
	3hWL80KEWBPLiitzDzFKcjApifIauuWHCPEl5adUZiQWZ8QXleakFh9ilOBgVhLhLRcGyvGm
	JFZWpRblw6SkOViUxHlVl6j7CQmkJ5akZqemFqQWwWRlODiUJHhvuQI1ChalpqdWpGXmlCCk
	mTg4QYZzSYkUp+alpBYllpZkxIOiIr4YGBcgKR6gvbYgN/EWFyTmAkUhWk8xKkqJ8/KAJARA
	EhmleXBjYaniFaM40JfCvGtAqniAaQau+xXQYCagwX+X5oIMLklESEk1MMo/e/N6Zr1f5GIP
	/efpFS+5y5j3/fgvFyb1+9Z3g16DVP5ZSsYfdZ+veVFiELbkW5yyVV+p0ItaT13GxlP2/zdc
	2XFCj/d6kNj26XPYT8V9vDnjFQcTo+T/lkXZMt59MTfVfMxzJb5NPbVf5Tr/3ArB 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Also free them together at the end of the function.

In a moment, the array version will become redundant. Managing them
together makes later steps more obvious.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/remote.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index d2b684c..d5a5a16 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1337,8 +1337,13 @@ static int prune_remote(const char *remote, int dry_run)
 		  : _("(no URL)"));
 
 	delete_refs = xmalloc(states.stale.nr * sizeof(*delete_refs));
-	for (i = 0; i < states.stale.nr; i++)
-		delete_refs[i] = states.stale.items[i].util;
+	for (i = 0; i < states.stale.nr; i++) {
+		const char *refname = states.stale.items[i].util;
+
+		delete_refs[i] = refname;
+		string_list_insert(&delete_refs_list, refname);
+	}
+
 	if (!dry_run) {
 		struct strbuf err = STRBUF_INIT;
 		if (repack_without_refs(delete_refs, states.stale.nr,
@@ -1346,13 +1351,10 @@ static int prune_remote(const char *remote, int dry_run)
 			result |= error("%s", err.buf);
 		strbuf_release(&err);
 	}
-	free(delete_refs);
 
 	for (i = 0; i < states.stale.nr; i++) {
 		const char *refname = states.stale.items[i].util;
 
-		string_list_insert(&delete_refs_list, refname);
-
 		if (!dry_run)
 			result |= delete_ref(refname, NULL, 0);
 
@@ -1365,8 +1367,9 @@ static int prune_remote(const char *remote, int dry_run)
 	}
 
 	warn_dangling_symrefs(stdout, dangling_msg, &delete_refs_list);
-	string_list_clear(&delete_refs_list, 0);
 
+	free(delete_refs);
+	string_list_clear(&delete_refs_list, 0);
 	free_remote_ref_states(&states);
 	return result;
 }
-- 
2.1.3
