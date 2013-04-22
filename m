From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 21/33] repack_without_ref(): write peeled refs in the rewritten file
Date: Mon, 22 Apr 2013 21:52:29 +0200
Message-ID: <1366660361-21831-22-git-send-email-mhagger@alum.mit.edu>
References: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 22 21:54:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUMoT-0005Bt-Is
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 21:54:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755170Ab3DVTyA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 15:54:00 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:43666 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755155Ab3DVTx6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Apr 2013 15:53:58 -0400
X-AuditID: 12074413-b7f226d000000902-4d-51759555b99d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id B2.3E.02306.55595715; Mon, 22 Apr 2013 15:53:57 -0400 (EDT)
Received: from michael.fritz.box (p57A2598E.dip0.t-ipconnect.de [87.162.89.142])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3MJrEOY008578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 22 Apr 2013 15:53:56 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsUixO6iqBs6tTTQ4Pk9NYuuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M5YO6ePueCwSsXtA4/ZGxjX
	ynYxcnJICJhIvJ55ig3CFpO4cG89kM3FISRwmVHi/Nr7LBDOBSaJu7NvsYBUsQnoSizqaWYC
	sUUE1CQmth0CizMLOEhs/tzICGILC4RLHO+czQ5iswioSixr2c8KYvMKuErc/DOXEWKbgsTx
	7dvAbE6g+OmOE2BzhARcJFYcnMoygZF3ASPDKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdc73c
	zBK91JTSTYyQYBHewbjrpNwhRgEORiUeXgH30kAh1sSy4srcQ4ySHExKorwcU4BCfEn5KZUZ
	icUZ8UWlOanFhxglOJiVRHhF84FyvCmJlVWpRfkwKWkOFiVxXrUl6n5CAumJJanZqakFqUUw
	WRkODiUJ3lcgQwWLUtNTK9Iyc0oQ0kwcnCCCC2QDD9CGSJBC3uKCxNzizHSIolOMilLivNWT
	gBICIImM0jy4AbC4fsUoDvSPMO9BkHYeYEqA634FNJgJaHBmQgnI4JJEhJRUA6PT7uO2jFM+
	rJ3Lqut8nNv4t+v3B5O764PMSwNnzVig8CU3LujcmsVeX9J3vNPsr1dveyykJXFfR3JKXuZn
	D0fWtfOCF7CkF3VMmbMic35cvOct+7ccNzwD5Q6dE9A5/PZYvg6/55cg3qVGxw2n1V2Vz2fS
	dG3Ycog/QqDu7R/L3dMKctfubVZiKc5INNRiLipOBAAKfhd4xgIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222063>

When a reference that existed in the packed-refs file is deleted, the
packed-refs file must be rewritten.  Previously, the file was
rewritten without any peeled refs, even if the file contained peeled
refs when it was read.  This was not a bug, because the packed-refs
file header didn't claim that the file contained peeled values.  But
it had a performance cost, because the repository would lose the
benefit of having precomputed peeled references until pack-refs was
run again.

Teach repack_without_ref() to write peeled refs to the packed-refs
file (regardless of whether they were present in the old version of
the file).

This means that if the old version of the packed-refs file was not
fully peeled, then repack_without_ref() will have to peel references.
To avoid the expense of reading lots of loose references, we take two
shortcuts relative to pack-refs:

* If the peeled value of a reference is already known (i.e., because
  it was read from the old version of the packed-refs file), then
  output that peeled value again without any checks.  This is the
  usual code path and should avoid any noticeable overhead.  (This is
  different than pack-refs, which always re-peels references.)

* We don't verify that the packed ref is still current.  It could be
  that a packed references is overridden by a loose reference, in
  which case the packed ref is no longer needed and might even refer
  to an object that has been garbage collected.  But we don't check;
  instead, we just try to peel all references.  If peeling is
  successful, the peeled value is written out (even though it might
  not be needed any more); if not, then the reference is silently
  omitted from the output.

The extra overhead of peeling references in repack_without_ref()
should only be incurred the first time the packed-refs file is written
by a version of Git that knows about the "fully-peeled" attribute.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c              | 23 +++++++++++++++++++++++
 t/t3211-peel-ref.sh |  2 +-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 51915a8..ff4c5f1 100644
--- a/refs.c
+++ b/refs.c
@@ -876,6 +876,13 @@ void invalidate_ref_cache(const char *submodule)
 #define PEELED_LINE_LENGTH 42
 
 /*
+ * The packed-refs header line that we write out.  Perhaps other
+ * traits will be added later.  The trailing space is required.
+ */
+static const char PACKED_REFS_HEADER[] =
+	"# pack-refs with: peeled fully-peeled \n";
+
+/*
  * Parse one line from a packed-refs file.  Write the SHA1 to sha1.
  * Return a pointer to the refname within the line (null-terminated),
  * or NULL if there was a problem.
@@ -1390,6 +1397,12 @@ static enum peel_status peel_object(const unsigned char *name, unsigned char *sh
 
 /*
  * Peel the entry (if possible) and return its new peel_status.
+ *
+ * It is OK to call this function with a packed reference entry that
+ * might be stale and might even refer to an object that has since
+ * been garbage-collected.  In such a case, if the entry has
+ * REF_KNOWS_PEELED then leave the status unchanged and return
+ * PEEL_PEELED or PEEL_NON_TAG; otherwise, return PEEL_INVALID.
  */
 static enum peel_status peel_entry(struct ref_entry *entry)
 {
@@ -1992,6 +2005,15 @@ static int repack_ref_fn(struct ref_entry *entry, void *cb_data)
 	if (len > sizeof(line))
 		die("too long a refname '%s'", entry->name);
 	write_or_die(*fd, line, len);
+	if (!peel_entry(entry)) {
+		/* This reference could be peeled; write the peeled value: */
+		if (snprintf(line, sizeof(line), "^%s\n",
+			     sha1_to_hex(entry->u.value.peeled)) !=
+		    PEELED_LINE_LENGTH)
+			die("internal error");
+		write_or_die(*fd, line, PEELED_LINE_LENGTH);
+	}
+
 	return 0;
 }
 
@@ -2022,6 +2044,7 @@ static int repack_without_ref(const char *refname)
 		rollback_lock_file(&packlock);
 		return 0;
 	}
+	write_or_die(fd, PACKED_REFS_HEADER, strlen(PACKED_REFS_HEADER));
 	do_for_each_entry_in_dir(packed, 0, repack_ref_fn, &fd);
 	return commit_lock_file(&packlock);
 }
diff --git a/t/t3211-peel-ref.sh b/t/t3211-peel-ref.sh
index cca1acb..3b7caca 100755
--- a/t/t3211-peel-ref.sh
+++ b/t/t3211-peel-ref.sh
@@ -61,7 +61,7 @@ test_expect_success 'refs are peeled outside of refs/tags (old packed)' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'peeled refs survive deletion of packed ref' '
+test_expect_success 'peeled refs survive deletion of packed ref' '
 	git pack-refs --all &&
 	cp .git/packed-refs fully-peeled &&
 	git branch yadda &&
-- 
1.8.2.1
