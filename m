From: Mike Hommey <mh@glandium.org>
Subject: [PATCH] sha1_name: avoid unnecessary sha1 lookup in find_unique_abbrev
Date: Wed, 26 Nov 2014 19:12:47 +0900
Message-ID: <1416996767-12672-1-git-send-email-mh@glandium.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 26 11:13:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtZan-0003Lr-Sa
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 11:13:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbaKZKM4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2014 05:12:56 -0500
Received: from ks3293202.kimsufi.com ([5.135.186.141]:53495 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750811AbaKZKMz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2014 05:12:55 -0500
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1XtZaZ-0003J2-D9
	for git@vger.kernel.org; Wed, 26 Nov 2014 19:12:47 +0900
X-Mailer: git-send-email 2.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260278>

An example where this happens is when doing an ls-tree on a tree that
contains a commit link. In that case, find_unique_abbrev is called
to get a non-abbreviated hex sha1, but still, a lookup is done as
to whether the sha1 is in the repository (which ends up looking for
a loose object in .git/objects), while the result of that lookup is
not used when returning a non-abbreviated hex sha1.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 sha1_name.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

This hit me on a corner case, where I kind of abuse commit links and
have a tree with tens of thousands of them.

Without the patch:
  $ time git ls-tree -r HEAD | wc -l
  114987

  real	0m4.412s
  user	0m1.980s
  sys	0m2.480s

With the patch:
  $ time git ls-tree -r HEAD | wc -l
  114987

  real	0m0.205s
  user	0m0.196s
  sys	0m0.012s


diff --git a/sha1_name.c b/sha1_name.c
index 5b004f5..cb88170 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -372,10 +372,10 @@ const char *find_unique_abbrev(const unsigned char *sha1, int len)
 	int status, exists;
 	static char hex[41];
 
-	exists = has_sha1_file(sha1);
 	memcpy(hex, sha1_to_hex(sha1), 40);
 	if (len == 40 || !len)
 		return hex;
+	exists = has_sha1_file(sha1);
 	while (len < 40) {
 		unsigned char sha1_ret[20];
 		status = get_short_sha1(hex, len, sha1_ret, GET_SHA1_QUIETLY);
-- 
2.1.1
