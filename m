From: mhagger@alum.mit.edu
Subject: [PATCH 06/17] Let fetch_pack() inform caller about number of unique heads
Date: Thu, 23 Aug 2012 10:10:31 +0200
Message-ID: <1345709442-16046-7-git-send-email-mhagger@alum.mit.edu>
References: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 10:18:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4Scf-00005j-U7
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 10:18:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933671Ab2HWIS2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 04:18:28 -0400
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:45089 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933655Ab2HWISU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Aug 2012 04:18:20 -0400
X-AuditID: 12074412-b7f216d0000008e3-32-5035e5a484ce
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id EE.B8.02275.4A5E5305; Thu, 23 Aug 2012 04:11:16 -0400 (EDT)
Received: from michael.fritz.box (p57A2588E.dip.t-dialin.net [87.162.88.142])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7N8AkV6030408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 23 Aug 2012 04:11:15 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsUixO6iqLvkqWmAwfvHNhZdV7qZLBp6rzBb
	3F4xn9niR0sPswOLx9/3H5g8nvXuYfS4eEnZ4/MmuQCWKG6bpMSSsuDM9Dx9uwTujI1Nq1kL
	7shVLDt1nLGBcYVEFyMnh4SAicS8pTuYIWwxiQv31rN1MXJxCAlcZpS4fvg9E4Rzlkni7I5Z
	bCBVbAJSEi8be9hBbBEBNYmJbYdYQGxmgRSJjufdjF2MHBzCAkES/58EgIRZBFQlDjd9Aivh
	FXCRWHR1CTvEMkWJH9/XgC3mFHCVWPB9EyOILQRU87HxJvMERt4FjAyrGOUSc0pzdXMTM3OK
	U5N1i5MT8/JSi3TN9HIzS/RSU0o3MULCR2gH4/qTcocYBTgYlXh4X5ibBgixJpYVV+YeYpTk
	YFIS5f33CCjEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhDd8HlCONyWxsiq1KB8mJc3BoiTO+3Ox
	up+QQHpiSWp2ampBahFMVoaDQ0mCVxIYJ0KCRanpqRVpmTklCGkmDk4QwQWygQdogyJIIW9x
	QWJucWY6RNEpRkUpcV4TkIQASCKjNA9uACzSXzGKA/0jzOsOUsUDTBJw3a+ABjMBDVa7agwy
	uCQRISXVwGj3ZunHk2wzPuzbxp79lX//KXuGCS4xs9YevMKfWua8N+m13cPdMs85GM9zHDga
	cb77sFzJZJ0Nskd/mT91OjR/xkyROxP/zv73k8vrO8+BPZybFxhuvV38IqFVQ2DKk665Ry6p
	PimYtsvI8e7RSXs1j51/32Q2O35Ro7a2Y2Lqw1sZ3bOE/a3PK7EUZyQaajEXFScC 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204122>

From: Michael Haggerty <mhagger@alum.mit.edu>

fetch_pack() remotes duplicates from the list (nr_heads, heads),
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
index a6406e7..3c93ec4 100644
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
