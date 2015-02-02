From: Jonathon Mah <me@jonathonmah.com>
Subject: [PATCHv4] sha1_file: fix iterating loose alternate objects
Date: Mon, 2 Feb 2015 10:48:12 -0800
Message-ID: <4727F1DC-2FC3-49BE-8C6D-0C4D7D8B107C@jonathonmah.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 19:48:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIM2q-0002mx-O3
	for gcvg-git-2@plane.gmane.org; Mon, 02 Feb 2015 19:48:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932650AbbBBSsQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2015 13:48:16 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:56791 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754506AbbBBSsO convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 2 Feb 2015 13:48:14 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id D502F20A7B
	for <git@vger.kernel.org>; Mon,  2 Feb 2015 13:48:13 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 02 Feb 2015 13:48:13 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=jonathonmah.com;
	 h=x-sasl-enc:from:content-type:content-transfer-encoding
	:subject:date:message-id:cc:to:mime-version; s=mesmtp; bh=2D9a6L
	GcDTpV5rDvDx3FfAllE1A=; b=Un6m1SEBRCcmmAVPrhJ8soQlnEeENHwhz9KIfR
	4+OZXBRqPRjdCIxWTIfuXyvPquxc/qL9hoTPIBo0KQ639MuSn3OsPyeeclu4xOEc
	Uz/EQI70uSxr/0s9PcpR737iDQSMDHAvMhXPBS+v2wuAw4hFk76hQD0HSRX905o7
	UTN9g=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:content-type
	:content-transfer-encoding:subject:date:message-id:cc:to
	:mime-version; s=smtpout; bh=2D9a6LGcDTpV5rDvDx3FfAllE1A=; b=OXX
	E/ljbC4TFkH4Hf8oBtCNQ+MSgDhpa08jlfkL2lF7LMJnYKOt/U6cYNWdccrY7FPP
	tgi3FTqykDkumHuVDCAGyT20ABkeUxLpBSlD8N0IBi1cIqR+Uu6h/NwGishES5Y1
	zfDWdOnG3IyAb3uNAIbCgbPxSB+KWte3CJDRLEP0=
X-Sasl-enc: rAvQWLuIv25RGqCGW3RHWG1OsPIOBWX4obYjEe/9NyI9 1422902893
Received: from [172.16.3.162] (unknown [206.169.144.70])
	by mail.messagingengine.com (Postfix) with ESMTPA id 04C84C00297;
	Mon,  2 Feb 2015 13:48:12 -0500 (EST)
X-Mailer: Apple Mail (2.2070.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263275>

The string in 'base' contains a path suffix to a specific object; when
its value is used, the suffix must either be filled (as in
stat_sha1_file, open_sha1_file, check_and_freshen_nonlocal) or cleared
(as in prepare_packed_git) to avoid junk at the end.  loose_from_alt_odb
(introduced in 660c889e46d185dc98ba78963528826728b0a55d) did neither and
treated 'base' as a complete path to the "base" object directory,
instead of a pointer to the "base" of the full path string.

The trailing path after 'base' is still initialized to NUL, hiding the
bug in some common cases.  Additionally the descendent
for_each_file_in_obj_subdir function swallows ENOENT, so an error only
shows if the alternate's path was last filled with a valid object
(where statting /path/to/existing/00/0bjectfile/00 fails).

Signed-off-by: Jonathon Mah <me@JonathonMah.com>
---
Squashed test and fix.

 sha1_file.c      | 10 +++++++---
 t/t5304-prune.sh | 14 ++++++++++++++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 30995e6..fcb1c4b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3396,9 +3396,13 @@ static int loose_from_alt_odb(struct alternate_object_database *alt,
 			      void *vdata)
 {
 	struct loose_alt_odb_data *data = vdata;
-	return for_each_loose_file_in_objdir(alt->base,
-					     data->cb, NULL, NULL,
-					     data->data);
+	int r;
+	alt->name[-1] = 0;
+	r = for_each_loose_file_in_objdir(alt->base,
+					  data->cb, NULL, NULL,
+					  data->data);
+	alt->name[-1] = '/';
+	return r;
 }
 
 int for_each_loose_object(each_loose_object_fn cb, void *data)
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index e32e46d..c65cf9b 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -253,4 +253,18 @@ test_expect_success 'prune .git/shallow' '
 	test_path_is_missing .git/shallow
 '
 
+test_expect_success 'prune: handle alternate object database' '
+	test_create_repo A &&
+		(cd A &&
+		echo "Hello World" >file1 &&
+		git add file1 &&
+		git commit -m "Initial commit" file1) &&
+	git clone -s A B &&
+		(cd B &&
+		echo "foo bar" >file2 &&
+		git add file2 &&
+		git commit -m "next commit" file2 &&
+		git prune)
+'
+
 test_done
-- 
2.3.0.rc2.2.g184f7a0
