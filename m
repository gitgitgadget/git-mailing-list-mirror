From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 06/18] report_refname_conflict(): inline function
Date: Fri,  1 May 2015 14:25:46 +0200
Message-ID: <1430483158-14349-7-git-send-email-mhagger@alum.mit.edu>
References: <1430483158-14349-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 01 14:26:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoA1b-0000zA-MS
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 14:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753767AbbEAM01 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 08:26:27 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:55396 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753553AbbEAM0T (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 May 2015 08:26:19 -0400
X-AuditID: 12074413-f79f26d0000030e7-0b-554370e9a7eb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id E8.EC.12519.9E073455; Fri,  1 May 2015 08:26:17 -0400 (EDT)
Received: from michael.fritz.box (p4FC97D7E.dip0.t-ipconnect.de [79.201.125.126])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t41CQ3Zj004310
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 1 May 2015 08:26:16 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1430483158-14349-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsUixO6iqPuywDnUYEOnukXXlW4mi4beK8wW
	t1fMZ7b40dLDbLF5czuLA6vH3/cfmDwWbCr1eNa7h9Hj4iVlj8+b5AJYo7htkhJLyoIz0/P0
	7RK4M/rPLmMqmMFd8eb3d5YGxnccXYycHBICJhJbZ3eyQdhiEhfurQezhQQuM0osX+QJYZ9g
	krg8nR3EZhPQlVjU08wEYosIqElMbDvE0sXIxcEs0MEocWH5NrAiYQFHieu7J4PZLAKqEst/
	72UGsXkFXCRO3n3MCrFMTuL88Z9AcQ4OTgFXiS9TEyF2uUjc//6VbQIj7wJGhlWMcok5pbm6
	uYmZOcWpybrFyYl5ealFuuZ6uZkleqkppZsYIeEkvINx10m5Q4wCHIxKPLwcJ51ChVgTy4or
	cw8xSnIwKYny2iY4hwrxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4b2nDpTjTUmsrEotyodJSXOw
	KInzqi1R9xMSSE8sSc1OTS1ILYLJynBwKEnwJuYDNQoWpaanVqRl5pQgpJk4OEGGc0mJFKfm
	paQWJZaWZMSD4iK+GBgZICkeoL3LQNp5iwsSc4GiEK2nGBWlxHl7QBICIImM0jy4sbAk8YpR
	HOhLYV5WYMoQ4gEmGLjuV0CDmYAGn7/lADK4JBEhJdXAOHuJtIfc6zY1ZR23sKP2OzI/xB6/
	0LG4523GrZcfXzz8prf+y13hL+aPsuvZvZ+djSrsyXoreP/e7/Kmu+ILbs76OunM/9+PWoOZ
	P3IduX4t+IhC1Vmt7Ne8h8SUfX901bYqCLTeihDYsmbvjzIG5Y647XnfZ303/ff2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268120>

It wasn't pulling its weight. And we are about to need code similar to
this where no ref_entry is available and with more diverse error
messages. Rather than try to generalize the function, just inline it.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/refs.c b/refs.c
index e9c9146..f1da87b 100644
--- a/refs.c
+++ b/refs.c
@@ -862,12 +862,6 @@ static int nonmatching_ref_fn(struct ref_entry *entry, void *vdata)
 	return 1;
 }
 
-static void report_refname_conflict(struct ref_entry *entry,
-				    const char *refname)
-{
-	error("'%s' exists; cannot create '%s'", entry->name, refname);
-}
-
 /*
  * Return true iff a reference named refname could be created without
  * conflicting with the name of an existing reference in dir.  If
@@ -915,7 +909,7 @@ static int is_refname_available(const char *refname,
 				 */
 				return 1;
 			}
-			report_refname_conflict(entry, refname);
+			error("'%s' exists; cannot create '%s'", entry->name, refname);
 			return 0;
 		}
 
@@ -956,7 +950,7 @@ static int is_refname_available(const char *refname,
 		if (!do_for_each_entry_in_dir(dir, 0, nonmatching_ref_fn, &data))
 			return 1;
 
-		report_refname_conflict(data.found, refname);
+		error("'%s' exists; cannot create '%s'", data.found->name, refname);
 		return 0;
 	}
 
-- 
2.1.4
