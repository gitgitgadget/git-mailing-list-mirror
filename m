From: mhagger@alum.mit.edu
Subject: [PATCH v2 06/17] Let fetch_pack() inform caller about number of unique heads
Date: Sat, 25 Aug 2012 08:44:16 +0200
Message-ID: <1345877067-11841-7-git-send-email-mhagger@alum.mit.edu>
References: <1345877067-11841-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 25 08:52:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5AEV-0001x1-8k
	for gcvg-git-2@plane.gmane.org; Sat, 25 Aug 2012 08:52:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753921Ab2HYGw3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Aug 2012 02:52:29 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:63429 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753586Ab2HYGw0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Aug 2012 02:52:26 -0400
X-AuditID: 12074413-b7f786d0000008bb-69-503874775e69
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id EF.6A.02235.77478305; Sat, 25 Aug 2012 02:45:11 -0400 (EDT)
Received: from michael.fritz.box (p57A257CD.dip.t-dialin.net [87.162.87.205])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7P6igSh011615
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 25 Aug 2012 02:45:10 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1345877067-11841-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsUixO6iqFteYhFgMGeWkUXXlW4mi4beK8wW
	t1fMZ7b40dLDbNE5VdaB1ePv+w9MHsuXrmP0eNa7h9Hj4iVlj8+b5AJYo7htkhJLyoIz0/P0
	7RK4M2YvvMJScEeu4suqyywNjCskuhg5OSQETCTW3z3HAmGLSVy4t56ti5GLQ0jgMqPEvjVf
	mSGcs0wSV64dYwOpYhOQknjZ2MMOYosIqElMbDvEAlLELNDFKLF83S+wImGBUImjd44xgtgs
	AqoS06YcZgKxeQVcJD4uvsMGsU5R4sf3NcwgNqeAq8SEXxfBhgoB1TQdu8IygZF3ASPDKka5
	xJzSXN3cxMyc4tRk3eLkxLy81CJdc73czBK91JTSTYyQoBLewbjrpNwhRgEORiUe3htnzAOE
	WBPLiitzDzFKcjApifKKFVoECPEl5adUZiQWZ8QXleakFh9ilOBgVhLh/c4AlONNSaysSi3K
	h0lJc7AoifOqLVH3ExJITyxJzU5NLUgtgsnKcHAoSfDWFgM1ChalpqdWpGXmlCCkmTg4QQQX
	yAYeoA3JIIW8xQWJucWZ6RBFpxgVpcR5DUASAiCJjNI8uAGw+H/FKA70jzDvzCKgKh5g6oDr
	fgU0mAlocLmrOcjgkkSElFQD45qV2QJ83CxzvCt3df3MLWnwemZx/K/gxppN7v2fe6Ze6d7A
	73Dv7VbmCxxWD8w/f//z9J+WGbedY+SedKYbgfzfa8QWHKzvY/4ScnA/X9fT1WqsIjV8E+uM
	gq7farFsdzmgfrPvsEhj35L//Fyi1QclHSauanjoxtO63Op7WhAT37ZbbdMslViK 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204265>

From: Michael Haggerty <mhagger@alum.mit.edu>

fetch_pack() removes duplicates from the list (nr_heads, heads),
thereby shrinking the list.  But previously, the caller was not
informed about the shrinkage.  This would cause a spurious error
message to be emitted by cmd_fetch_pack() if "git fetch-pack" is
called with duplicate refnames.

So change the signature of fetch_pack() to accept nr_heads by
reference, and if any duplicates were removed then modify it to
reflect the number of remaining references.

The last test of t5500 inexplicably *required* "git fetch-pack" to
fail when fetching a list of references that contains duplicates;
i.e., it insisted on the buggy behavior.  So change the test to expect
the correct behavior.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch-pack.c  | 12 ++++++------
 fetch-pack.h          |  2 +-
 t/t5500-fetch-pack.sh |  2 +-
 transport.c           |  2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index bda3c0c..cf65998 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -1021,7 +1021,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	get_remote_heads(fd[0], &ref, 0, NULL);
 
 	ref = fetch_pack(&args, fd, conn, ref, dest,
-		nr_heads, heads, pack_lockfile_ptr);
+		&nr_heads, heads, pack_lockfile_ptr);
 	if (pack_lockfile) {
 		printf("lock %s\n", pack_lockfile);
 		fflush(stdout);
@@ -1062,7 +1062,7 @@ struct ref *fetch_pack(struct fetch_pack_args *my_args,
 		       int fd[], struct child_process *conn,
 		       const struct ref *ref,
 		       const char *dest,
-		       int nr_heads,
+		       int *nr_heads,
 		       char **heads,
 		       char **pack_lockfile)
 {
@@ -1077,16 +1077,16 @@ struct ref *fetch_pack(struct fetch_pack_args *my_args,
 			st.st_mtime = 0;
 	}
 
-	if (heads && nr_heads) {
-		qsort(heads, nr_heads, sizeof(*heads), compare_heads);
-		nr_heads = remove_duplicates(nr_heads, heads);
+	if (heads && *nr_heads) {
+		qsort(heads, *nr_heads, sizeof(*heads), compare_heads);
+		*nr_heads = remove_duplicates(*nr_heads, heads);
 	}
 
 	if (!ref) {
 		packet_flush(fd[1]);
 		die("no matching remote head");
 	}
-	ref_cpy = do_fetch_pack(fd, ref, nr_heads, heads, pack_lockfile);
+	ref_cpy = do_fetch_pack(fd, ref, *nr_heads, heads, pack_lockfile);
 
 	if (args.depth > 0) {
 		struct cache_time mtime;
diff --git a/fetch-pack.h b/fetch-pack.h
index 1dbe90f..a9d505b 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -21,7 +21,7 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 		       int fd[], struct child_process *conn,
 		       const struct ref *ref,
 		       const char *dest,
-		       int nr_heads,
+		       int *nr_heads,
 		       char **heads,
 		       char **pack_lockfile);
 
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 3cc3346..0d4edcb 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -391,7 +391,7 @@ test_expect_success 'fetch mixed refs from cmdline and stdin' '
 test_expect_success 'test duplicate refs from stdin' '
 	(
 	cd client &&
-	test_must_fail git fetch-pack --stdin --no-progress .. <../input.dup
+	git fetch-pack --stdin --no-progress .. <../input.dup
 	) >output &&
 	cut -d " " -f 2 <output | sort >actual &&
 	test_cmp expect actual
diff --git a/transport.c b/transport.c
index 1811b50..f7bbf58 100644
--- a/transport.c
+++ b/transport.c
@@ -548,7 +548,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 
 	refs = fetch_pack(&args, data->fd, data->conn,
 			  refs_tmp ? refs_tmp : transport->remote_refs,
-			  dest, nr_heads, heads, &transport->pack_lockfile);
+			  dest, &nr_heads, heads, &transport->pack_lockfile);
 	close(data->fd[0]);
 	close(data->fd[1]);
 	if (finish_connect(data->conn))
-- 
1.7.11.3
