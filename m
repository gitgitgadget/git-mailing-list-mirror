From: Jonathon Mah <me@jonathonmah.com>
Subject: [PATCHv5] sha1_file: fix iterating loose alternate objects
Date: Mon, 2 Feb 2015 12:05:54 -0800
Message-ID: <E05CAD49-755C-4F26-A527-597B1AD412D8@jonathonmah.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 21:06:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YINFw-0006JB-OD
	for gcvg-git-2@plane.gmane.org; Mon, 02 Feb 2015 21:06:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754639AbbBBUF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2015 15:05:56 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:53472 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754474AbbBBUF4 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 2 Feb 2015 15:05:56 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 8E59220D9D
	for <git@vger.kernel.org>; Mon,  2 Feb 2015 15:05:54 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute5.internal (MEProxy); Mon, 02 Feb 2015 15:05:54 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=jonathonmah.com;
	 h=x-sasl-enc:from:content-type:content-transfer-encoding
	:subject:date:message-id:cc:to:mime-version; s=mesmtp; bh=dK6Zfp
	tD6WdWU3MsmnO6ZGtNgno=; b=Y+8M2pydFzdcygxHFi+96y59OLaK3jL759qzzh
	vazBK8IxLeUhcJSz5Bl33gAlHX02O36xciTp1t4By4cnxOR0AcFyLlVe3J4i9Mlk
	VAhq/39FqmAYH0+nfwZAksptiV/QoT2hKVagN+r7tE1AYjLBoaG18cBrgUhYZXrH
	XQdks=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:content-type
	:content-transfer-encoding:subject:date:message-id:cc:to
	:mime-version; s=smtpout; bh=dK6ZfptD6WdWU3MsmnO6ZGtNgno=; b=GJM
	zK0opiMpK405D7zeDD1EzJIZ61Ecq+jUaO2McBWOW27xjYcWlXQ5UwTtX+iq0xUZ
	te7d2Lf48sW/44korYnd5ztiX7ocsWBOqQYRCmTEmDfPoPz5P8PzTbb3JcfrQ5lr
	Ha4IUaQuYJW/81MOkF6RVAVgM4AZGS/GDIgOsZY0=
X-Sasl-enc: EyteqK0TgjSkhQkFPfQnXtk5DFpTOz764FSlWfl+Q9Kg 1422907554
Received: from [172.16.3.162] (unknown [206.169.144.70])
	by mail.messagingengine.com (Postfix) with ESMTPA id A3E96C0028C;
	Mon,  2 Feb 2015 15:05:53 -0500 (EST)
X-Mailer: Apple Mail (2.2070.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263283>

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

Simplified test per Junio (verified that it fails before and passes now). Punting on Jeff's "more elaborate example".

 sha1_file.c      | 10 +++++++---
 t/t5304-prune.sh |  8 ++++++++
 2 files changed, 15 insertions(+), 3 deletions(-)

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
index e32e46d..0794d33 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -253,4 +253,12 @@ test_expect_success 'prune .git/shallow' '
 	test_path_is_missing .git/shallow
 '
 
+test_expect_success 'prune: handle alternate object database' '
+	test_create_repo A &&
+	git -C A commit --allow-empty -m "initial commit" &&
+	git clone --shared A B &&
+	git -C B commit --allow-empty -m "next commit" &&
+	git -C B prune
+'
+
 test_done
-- 
2.3.0.rc2.2.g184f7a0
