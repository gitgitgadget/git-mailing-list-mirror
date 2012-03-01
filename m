From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 4/4] bundle: keep around names passed to add_pending_object()
Date: Thu, 1 Mar 2012 22:40:51 +0100
Message-ID: <6fba13f255f76481dc9098b5e8fbb33bd10735cb.1330637923.git.trast@student.ethz.ch>
References: <cover.1330637923.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 01 22:41:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3DkG-0007Si-4a
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 22:41:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965124Ab2CAVk6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 16:40:58 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:45305 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965066Ab2CAVk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 16:40:57 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 1 Mar
 2012 22:40:50 +0100
Received: from thomas.inf.ethz.ch (129.132.210.31) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 1 Mar
 2012 22:40:54 +0100
X-Mailer: git-send-email 1.7.9.2.467.g7fee4
In-Reply-To: <cover.1330637923.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.210.31]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191974>

The 'name' field passed to add_pending_object() is used to later
deduplicate in object_array_remove_duplicates().

git-bundle had a bug in this area since 18449ab (git-bundle: avoid
packing objects which are in the prerequisites, 2007-03-08): it passed
the name of each boundary object in a static buffer.  In other words,
all that object_array_remove_duplicates() saw was the name of the
*last* added boundary object.

The recent switch to a strbuf in bc2fed4 (bundle: use a strbuf to scan
the log for boundary commits, 2012-02-22) made this slightly worse: we
now free the buffer at the end, so it is not even guaranteed that it
still points into addressable memory by the time object_array_remove_
duplicates looks at it.  On the plus side however, it was now
detectable by valgrind.

The fix is easy: pass a copy of the string to add_pending_object.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 bundle.c         |    2 +-
 t/t5510-fetch.sh |   16 ++++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/bundle.c b/bundle.c
index 7a760db..d9cfd90 100644
--- a/bundle.c
+++ b/bundle.c
@@ -273,7 +273,7 @@ int create_bundle(struct bundle_header *header, const char *path,
 			if (!get_sha1_hex(buf.buf + 1, sha1)) {
 				struct object *object = parse_object(sha1);
 				object->flags |= UNINTERESTING;
-				add_pending_object(&revs, object, buf.buf);
+				add_pending_object(&revs, object, xstrdup(buf.buf));
 			}
 		} else if (!get_sha1_hex(buf.buf, sha1)) {
 			struct object *object = parse_object(sha1);
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index dd035bf..8b914f9 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -440,4 +440,20 @@ test_expect_success "should be able to fetch with duplicate refspecs" '
 	git fetch three
 '
 
+
+test_expect_success 'all boundary commits are excluded' '
+	test_commit base &&
+	test_commit oneside &&
+	git checkout HEAD^ &&
+	test_commit otherside &&
+	git checkout master &&
+	test_tick &&
+	git merge otherside &&
+	ad=$(git log --no-walk --format=%ad HEAD) &&
+	git bundle create twoside-boundary.bdl master --since="$ad" &&
+	convert_bundle_to_pack <twoside-boundary.bdl >twoside-boundary.pack &&
+	pack=$(git index-pack --fix-thin --stdin <twoside-boundary.pack) &&
+	test_bundle_object_count .git/objects/pack/pack-${pack##pack	}.pack 3
+'
+
 test_done
-- 
1.7.9.2.467.g7fee4
