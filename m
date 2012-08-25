From: mhagger@alum.mit.edu
Subject: [PATCH v2 10/17] Remove ineffective optimization
Date: Sat, 25 Aug 2012 08:44:20 +0200
Message-ID: <1345877067-11841-11-git-send-email-mhagger@alum.mit.edu>
References: <1345877067-11841-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 25 08:45:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5A7g-0002eg-9W
	for gcvg-git-2@plane.gmane.org; Sat, 25 Aug 2012 08:45:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752894Ab2HYGpZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Aug 2012 02:45:25 -0400
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:44501 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752666Ab2HYGpW (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Aug 2012 02:45:22 -0400
X-AuditID: 1207440e-b7f036d0000008b5-d8-50387480b8b2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id CA.CF.02229.08478305; Sat, 25 Aug 2012 02:45:20 -0400 (EDT)
Received: from michael.fritz.box (p57A257CD.dip.t-dialin.net [87.162.87.205])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7P6igSl011615
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 25 Aug 2012 02:45:19 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1345877067-11841-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsUixO6iqNtQYhFgsLdJzaLrSjeTRUPvFWaL
	2yvmM1v8aOlhtuicKuvA6vH3/Qcmj+VL1zF6POvdw+hx8ZKyx+dNcgGsUdw2SYklZcGZ6Xn6
	dgncGTPn72QqOMBd8e5kA2MD42zOLkZODgkBE4nblxcyQ9hiEhfurWfrYuTiEBK4zChx4+1L
	NpCEkMBZJomZH8BsNgEpiZeNPewgtoiAmsTEtkMsIA3MAl2MEsvX/QIrEhawlLj7ZiojiM0i
	oCpx7OcZsAZeAVeJa1uWskJsU5T48X0N2GZOoPiEXxfZIZa5SDQdu8IygZF3ASPDKka5xJzS
	XN3cxMyc4tRk3eLkxLy81CJdY73czBK91JTSTYyQkOLbwdi+XuYQowAHoxIP740z5gFCrIll
	xZW5hxglOZiURHnFCi0ChPiS8lMqMxKLM+KLSnNSiw8xSnAwK4nwfmcAyvGmJFZWpRblw6Sk
	OViUxHnVlqj7CQmkJ5akZqemFqQWwWRlODiUJHi/FwM1ChalpqdWpGXmlCCkmTg4QYZzSYkU
	p+alpBYllpZkxINiI74YGB0gKR6gvXdB2nmLCxJzgaIQracYdTn+nzx5l1GIJS8/L1VKnPcU
	SJEASFFGaR7cClgCecUoDvSxMO/MIqAqHmDygZv0CmgJE9CScldzkCUliQgpqQZGpiPK5+9s
	jG3I2h1/T7aQt+zGy8gLZif/F0muPPNygtYGuwezJbcrSUw/0z//V07K2afOCRay+ry9n0o/
	WramTb7Y/SDp4nuuEwET2kq1rzUcLtPT2ac0yTTj+4+XHS/mcc/mNCxf/p2Z9dE6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204254>

From: Michael Haggerty <mhagger@alum.mit.edu>

I cannot find a scenario in which this function is called any
significant number of times, so simplify the code by always allocating
an array for return_refs rather than trying to use a stack-allocated
array for small lists.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch-pack.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index c47090d..ca1ddd9 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -527,17 +527,10 @@ static void filter_refs(struct ref **refs, int *nr_heads, char **heads)
 	struct ref *newlist = NULL;
 	struct ref **newtail = &newlist;
 	struct ref *ref, *next;
-	struct ref *fastarray[32];
 	int head_pos;
 
-	if (*nr_heads && !args.fetch_all) {
-		if (ARRAY_SIZE(fastarray) < *nr_heads)
-			return_refs = xcalloc(*nr_heads, sizeof(struct ref *));
-		else {
-			return_refs = fastarray;
-			memset(return_refs, 0, sizeof(struct ref *) * *nr_heads);
-		}
-	}
+	if (*nr_heads && !args.fetch_all)
+		return_refs = xcalloc(*nr_heads, sizeof(struct ref *));
 	else
 		return_refs = NULL;
 
@@ -584,8 +577,7 @@ static void filter_refs(struct ref **refs, int *nr_heads, char **heads)
 				newtail = &ref->next;
 			}
 		}
-		if (return_refs != fastarray)
-			free(return_refs);
+		free(return_refs);
 	}
 	*refs = newlist;
 }
-- 
1.7.11.3
