From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 17/33] repack_without_ref(): silence errors for dangling packed refs
Date: Mon, 22 Apr 2013 21:52:25 +0200
Message-ID: <1366660361-21831-18-git-send-email-mhagger@alum.mit.edu>
References: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 22 21:54:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUMoS-0005Bt-JV
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 21:54:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755149Ab3DVTxy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 15:53:54 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:53461 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755116Ab3DVTxw (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Apr 2013 15:53:52 -0400
X-AuditID: 1207440f-b7f0e6d000000957-b2-517595509901
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id FA.0D.02391.05595715; Mon, 22 Apr 2013 15:53:52 -0400 (EDT)
Received: from michael.fritz.box (p57A2598E.dip0.t-ipconnect.de [87.162.89.142])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3MJrEOU008578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 22 Apr 2013 15:53:51 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsUixO6iqBswtTTQYOlsbouuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M5onjSbpWChXMXv93INjK/F
	uxg5OCQETCR2HBHoYuQEMsUkLtxbz9bFyMUhJHCZUeLexD1MEM4FJokFE76zglSxCehKLOpp
	ZgKxRQTUJCa2HWIBsZkFHCQ2f25kBLGFBcIlXu+6xQZiswioSvRda2UGsXkFXCXObJnLBLFN
	QeL49m1g9ZxA8dMdJ8DmCAm4SKw4OJVlAiPvAkaGVYxyiTmlubq5iZk5xanJusXJiXl5qUW6
	Jnq5mSV6qSmlmxghgcK/g7FrvcwhRgEORiUe3gzP0kAh1sSy4srcQ4ySHExKorwcU4BCfEn5
	KZUZicUZ8UWlOanFhxglOJiVRHhF84FyvCmJlVWpRfkwKWkOFiVxXvUl6n5CAumJJanZqakF
	qUUwWRkODiUJ3gyQoYJFqempFWmZOSUIaSYOThDBBbKBB2hDJEghb3FBYm5xZjpE0SlGRSlx
	XrdJQAkBkERGaR7cAFhMv2IUB/pHmNcDpJ0HmA7gul8BDWYCGpyZUAIyuCQRISXVwCi0qurX
	MTNfy7Wir325b3PXLDu9IJnpvIvC++vvel7GynWcvbNIb4Kv8+HPIk7va0v6uFY4a8Rd4skz
	6nCN9PVeLGadesP3RcYtjyOXTQSP8e5k0J83qcZJsTy1x3b78o7rzWzFP45/8TmR45/ollTq
	dMr5vYsxX4rNx0O20Vkc51rz9D7xK7EUZyQaajEXFScCAPcw9PbEAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222064>

Stop emitting an error message when deleting a packed reference if we
find another dangling packed reference that is overridden by a loose
reference.  See the previous commit for a longer explanation of the
issue.

We have to be careful to make sure that the invalid packed reference
really *is* overridden by a loose reference; otherwise what we have
found is repository corruption, which we *should* report.

Please note that this approach is vulnerable to a race condition
similar to the race conditions already known to affect packed
references [1]:

* Process 1 tries to peel packed reference X as part of deleting
  another packed reference.  It discovers that X does not refer to a
  valid object (because the object that it referred to has been
  garbage collected).

* Process 2 tries to delete reference X.  It starts by deleting the
  loose reference X.

* Process 1 checks whether there is a loose reference X.  There is not
  (it has just been deleted by process 2), so process 1 reports a
  spurious error "X does not point to a valid object!"

The worst case seems relatively harmless, and the fix is identical to
the fix that will be needed for the other race conditions (namely
holding a lock on the packed-refs file during *all* reference
deletions), so we leave the cleaning up of all of them as a future
project.

[1] http://thread.gmane.org/gmane.comp.version-control.git/211956

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c               | 37 +++++++++++++++++++++++++++++++++++--
 t/t3210-pack-refs.sh |  2 +-
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index ed54ed4..2957f6d 100644
--- a/refs.c
+++ b/refs.c
@@ -1901,8 +1901,41 @@ static int repack_without_ref_fn(struct ref_entry *entry, void *cb_data)
 
 	if (!strcmp(data->refname, entry->name))
 		return 0;
-	if (!ref_resolves_to_object(entry))
-		return 0; /* Skip broken refs */
+	if (entry->flag & REF_ISBROKEN) {
+		/* This shouldn't happen to packed refs. */
+		error("%s is broken!", entry->name);
+		return 0;
+	}
+	if (!has_sha1_file(entry->u.value.sha1)) {
+		unsigned char sha1[20];
+		int flags;
+
+		if (read_ref_full(entry->name, sha1, 0, &flags))
+			/* We should at least have found the packed ref. */
+			die("Internal error");
+		if ((flags & REF_ISSYMREF) || !(flags & REF_ISPACKED))
+			/*
+			 * This packed reference is overridden by a
+			 * loose reference, so it is OK that its value
+			 * is no longer valid; for example, it might
+			 * refer to an object that has been garbage
+			 * collected.  For this purpose we don't even
+			 * care whether the loose reference itself is
+			 * invalid, broken, symbolic, etc.  Silently
+			 * omit the packed reference from the output.
+			 */
+			return 0;
+		/*
+		 * There is no overriding loose reference, so the fact
+		 * that this reference doesn't refer to a valid object
+		 * indicates some kind of repository corruption.
+		 * Report the problem, then omit the reference from
+		 * the output.
+		 */
+		error("%s does not point to a valid object!", entry->name);
+		return 0;
+	}
+
 	len = snprintf(line, sizeof(line), "%s %s\n",
 		       sha1_to_hex(entry->u.value.sha1), entry->name);
 	/* this should not happen but just being defensive */
diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index c032d88..559f602 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -142,7 +142,7 @@ test_expect_success 'delete ref with dangling packed version' '
 	test_cmp /dev/null result
 '
 
-test_expect_failure 'delete ref while another dangling packed ref' '
+test_expect_success 'delete ref while another dangling packed ref' '
 	git branch lamb &&
 	git commit --allow-empty -m "future garbage" &&
 	git pack-refs --all &&
-- 
1.8.2.1
