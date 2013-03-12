From: Phil Hord <hordp@cisco.com>
Subject: [PATCH] tag: --force is quiet about new tags
Date: Tue, 12 Mar 2013 19:13:41 -0400
Message-ID: <1363130021-28624-1-git-send-email-hordp@cisco.com>
Cc: phil.hord@gmail.com, Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Phil Hord <hordp@cisco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 13 00:24:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFYY4-00060q-J6
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 00:24:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755740Ab3CLXXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Mar 2013 19:23:34 -0400
Received: from rcdn-iport-6.cisco.com ([173.37.86.77]:26061 "EHLO
	rcdn-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755540Ab3CLXXd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 19:23:33 -0400
X-Greylist: delayed 571 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Mar 2013 19:23:33 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1817; q=dns/txt; s=iport;
  t=1363130613; x=1364340213;
  h=from:to:cc:subject:date:message-id;
  bh=nnB9kQm/FGWbjwxrjSKuL3nzZwBAPwISKnID+dB20Vs=;
  b=XwFx+VMUHfZlUvMeNFvBw3HSOqgSL82ML3vGopRlav5S8CwixMm5V3HN
   xDiEVCT0sMnKv1Mkwanwnr5bLx6/FKO/211iCa4REcNszpKTd2M+OB0Cq
   pTIEOJvOjzxpYth7gHOQPy2ryFDgJEu/Og1QyN7TrAdoUDUaYrvy0PkSo
   s=;
X-IronPort-AV: E=Sophos;i="4.84,833,1355097600"; 
   d="scan'208";a="186762899"
Received: from rcdn-core2-4.cisco.com ([173.37.113.191])
  by rcdn-iport-6.cisco.com with ESMTP; 12 Mar 2013 23:14:00 +0000
Received: from ipsn-lnx-hordp.cisco.com (dhcp-64-100-104-138.cisco.com [64.100.104.138])
	by rcdn-core2-4.cisco.com (8.14.5/8.14.5) with ESMTP id r2CNE0aR022549;
	Tue, 12 Mar 2013 23:14:00 GMT
X-Mailer: git-send-email 1.8.2.rc3.394.g2617418.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218010>

git tag --force is used to replace an existing tag with
a new reference.  Git helpfully tells the user the old
ref when this happens.  But if the tag name is new and does
not exist, git tells the user the old ref anyway (000000).

Teach git to ignore --force if the tag is new.  Add a test
for this and also to ensure --force can replace tags at all.

Signed-off-by: Phil Hord <hordp@cisco.com>
---
 builtin/tag.c  |  2 +-
 t/t7004-tag.sh | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index f826688..af3af3f 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -582,7 +582,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		die(_("%s: cannot lock the ref"), ref.buf);
 	if (write_ref_sha1(lock, object, NULL) < 0)
 		die(_("%s: cannot update the ref"), ref.buf);
-	if (force && hashcmp(prev, object))
+	if (force && !is_null_sha1(prev) && hashcmp(prev, object))
 		printf(_("Updated tag '%s' (was %s)\n"), tag, find_unique_abbrev(prev, DEFAULT_ABBREV));
 
 	strbuf_release(&buf);
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index f5a79b1..c8d6e9f 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -104,6 +104,18 @@ test_expect_success 'creating a tag using HEAD directly should succeed' '
 	tag_exists myhead
 '
 
+test_expect_success '--force can create a tag with the name of one existing' '
+	tag_exists mytag &&
+	git tag --force mytag &&
+	tag_exists mytag'
+
+test_expect_success '--force is moot with a non-existing tag name' '
+	git tag newtag >expect &&
+	git tag --force forcetag >actual &&
+	test_cmp expect actual
+'
+git tag -d newtag forcetag
+
 # deleting tags:
 
 test_expect_success 'trying to delete an unknown tag should fail' '
-- 
1.8.2.rc3.394.g2617418.dirty
