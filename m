From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 14/14] fetch-pack: eliminate spurious error messages
Date: Sun,  9 Sep 2012 08:19:49 +0200
Message-ID: <1347171589-13327-15-git-send-email-mhagger@alum.mit.edu>
References: <1347171589-13327-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 09 08:21:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAatr-00032a-0N
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 08:21:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753105Ab2IIGV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 02:21:27 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:45087 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752529Ab2IIGU4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Sep 2012 02:20:56 -0400
X-AuditID: 1207440f-b7fde6d00000095c-bb-504c3547ddf3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id B9.8A.02396.7453C405; Sun,  9 Sep 2012 02:20:55 -0400 (EDT)
Received: from michael.fritz.box (p57A25CBD.dip.t-dialin.net [87.162.92.189])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q896KIlr029164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 9 Sep 2012 02:20:54 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1347171589-13327-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsUixO6iqOtu6hNgsH6rjEXXlW4mi4beK8wW
	t1fMZ7b40dLDbNE5VdaB1ePv+w9MHsuXrmP0eNa7h9Hj4iVlj8+b5AJYo7htkhJLyoIz0/P0
	7RK4M9ofTmIq2CFcsXf/S8YGxov8XYycHBICJhINa/+xQthiEhfurWfrYuTiEBK4zCixfdZB
	VgjnDJNE36kNbCBVbAK6Eot6mplAbBEBNYmJbYdYQIqYBboYJZav+wVWJCzgLjG/Zws7iM0i
	oCpx4vdNFhCbV8BVoufIdxaIdYoSP76vYQaxOYHir2buZgSxhQRcJDbtvMY6gZF3ASPDKka5
	xJzSXN3cxMyc4tRk3eLkxLy81CJdE73czBK91JTSTYyQoOLfwdi1XuYQowAHoxIP78qb3gFC
	rIllxZW5hxglOZiURHk1THwChPiS8lMqMxKLM+KLSnNSiw8xSnAwK4nwXmUHyvGmJFZWpRbl
	w6SkOViUxHnVl6j7CQmkJ5akZqemFqQWwWRlODiUJHg/GAM1ChalpqdWpGXmlCCkmTg4QQQX
	yAYeoA3XQQp5iwsSc4sz0yGKTjEqSonzSoGcJQCSyCjNgxsAi/9XjOJA/wjzsoBU8QBTB1z3
	K6DBTECDRZ55gAwuSURISTUw9q7hOvnu37m8ia/87XxN3VM4pjIa7M7k7J7Zb3LAVFy0aqHd
	86jDp69H7bNpk76e9UVhxsr7cjXihl/XVzrlx4nkhsz1/WT4RdBdRdcy5vhyE0adVxwazGe2
	CWfWdrk3G1yuDHC8sePjMfFr2/ZWme+KqOCRW3uOOyjv98SOcw6xtj2/9VcosRRn 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205059>

It used to be that if "--all", "--depth", and also explicit references
were sought, then the explicit references were not handled correctly
in filter_refs() because the "--all --depth" code took precedence over
the explicit reference handling, and the explicit references were
never noted as having been found.  So check for explicitly sought
references before proceeding to the "--all --depth" logic.

This fixes two test cases in t5500.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch-pack.c  | 10 +++++-----
 t/t5500-fetch-pack.sh |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 42078e5..e644398 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -549,9 +549,6 @@ static void filter_refs(struct ref **refs, struct string_list *sought)
 		if (!memcmp(ref->name, "refs/", 5) &&
 		    check_refname_format(ref->name + 5, 0))
 			; /* trash */
-		else if (args.fetch_all &&
-			 (!args.depth || prefixcmp(ref->name, "refs/tags/")))
-			keep = 1;
 		else {
 			while (sought_pos < sought->nr) {
 				int cmp = strcmp(ref->name, sought->items[sought_pos].string);
@@ -567,6 +564,10 @@ static void filter_refs(struct ref **refs, struct string_list *sought)
 			}
 		}
 
+		if (! keep && args.fetch_all &&
+		    (!args.depth || prefixcmp(ref->name, "refs/tags/")))
+			keep = 1;
+
 		if (keep) {
 			*newtail = ref;
 			ref->next = NULL;
@@ -576,8 +577,7 @@ static void filter_refs(struct ref **refs, struct string_list *sought)
 		}
 	}
 
-	if (!args.fetch_all)
-		filter_string_list(sought, 0, non_matching_ref, NULL);
+	filter_string_list(sought, 0, non_matching_ref, NULL);
 	*refs = newlist;
 }
 
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 894d945..6322e8a 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -427,14 +427,14 @@ test_expect_success 'test missing ref before existing' '
 	test_cmp expect-error error-me
 '
 
-test_expect_failure 'test --all, --depth, and explicit head' '
+test_expect_success 'test --all, --depth, and explicit head' '
 	(
 		cd client &&
 		git fetch-pack --no-progress --all --depth=1 .. refs/heads/A
 	) >out-adh 2>error-adh
 '
 
-test_expect_failure 'test --all, --depth, and explicit tag' '
+test_expect_success 'test --all, --depth, and explicit tag' '
 	git tag OLDTAG refs/heads/B~5 &&
 	(
 		cd client &&
-- 
1.7.11.3
