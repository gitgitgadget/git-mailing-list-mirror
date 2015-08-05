From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 2/3] clone: do not use port number as dir name
Date: Wed,  5 Aug 2015 12:06:18 +0200
Message-ID: <1438769179-5943-3-git-send-email-ps@pks.im>
References: <1437997708-10732-1-git-send-email-ps@pks.im>
 <1438769179-5943-1-git-send-email-ps@pks.im>
Cc: sunshine@sunshineco.com, ps@pks.im, peff@peff.net,
	pclouds@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 05 12:06:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMvan-0003m5-Te
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 12:06:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066AbbHEKG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2015 06:06:29 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:52935 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751850AbbHEKG1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Aug 2015 06:06:27 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 282CE20B2D
	for <git@vger.kernel.org>; Wed,  5 Aug 2015 06:06:27 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Wed, 05 Aug 2015 06:06:27 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=9PEg
	M5fDLbI9Tks/5K7T2LVa1cY=; b=uIe5pQMIITUbDUvyfcVmcukwq4ERCrQOuvEo
	OHbNx2n9o1AJG5XnOJ94UzZ66fSFmrxwKpYqC+TjQ+tP14jDrE5H5f8EWLpgBD90
	/UbqWrP1BCmZilwwQh+MUwsd0ncxqz1068wLJK12CKIfE1qJE6bZLrgttOTzn57E
	MId+KNw=
X-Sasl-enc: 4wNJ5cdVHLPUhDwT8tBJNkHpfF140V0bJoHF8W2dx45/ 1438769186
Received: from localhost (x5ce10e86.dyn.telefonica.de [92.225.14.134])
	by mail.messagingengine.com (Postfix) with ESMTPA id B372AC0001C;
	Wed,  5 Aug 2015 06:06:26 -0400 (EDT)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1438769179-5943-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275366>

If the URI contains a port number and the URI's path component is
empty we fail to guess a sensible directory name. E.g. cloning a
repository 'ssh://example.com:2222/' we guess a directory name
'2222' where we would want the hostname only, e.g. 'example.com'.

Fix this by stripping trailing port numbers.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c          | 17 +++++++++++++++++
 t/t5603-clone-dirname.sh |  7 ++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 3ddf8b9..7d93e13 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -181,6 +181,23 @@ static char *guess_dir_name(const char *repo, int is_bundle, int is_bare)
 	}
 
 	/*
+	 * Strip trailing port number if we've got only a
+	 * hostname (that is, there is no dir separator but a
+	 * colon). This check is required such that we do not
+	 * strip URI's like '/foo/bar:2222.git', which should
+	 * result in a dir '2222' being guessed due to backwards
+	 * compatibility.
+	 */
+	if (memchr(start, '/', end - start) == NULL
+	    && memchr(start, ':', end - start) != NULL) {
+		ptr = end;
+		while (start < ptr && isdigit(ptr[-1]) && ptr[-1] != ':')
+			ptr--;
+		if (start < ptr && ptr[-1] == ':')
+			end = ptr - 1;
+	}
+
+	/*
 	 * Find last component. To remain backwards compatible we
 	 * also regard colons as path separators, such that
 	 * cloning a repository 'foo:bar.git' would result in a
diff --git a/t/t5603-clone-dirname.sh b/t/t5603-clone-dirname.sh
index 3a454f9..27dbd6c 100755
--- a/t/t5603-clone-dirname.sh
+++ b/t/t5603-clone-dirname.sh
@@ -63,8 +63,13 @@ test_clone_dir ssh://host/foo/.git/ foo
 
 # omitting the path should default to the hostname
 test_clone_dir ssh://host/ host
-test_clone_dir ssh://host:1234/ host fail
+test_clone_dir ssh://host:1234/ host
 test_clone_dir ssh://user@host/ host
 test_clone_dir ssh://user:password@host/ host
+test_clone_dir ssh://user:password@host:1234/ host
+
+# trailing port-like numbers should not be stripped for paths
+test_clone_dir ssh://user:password@host/test:1234 1234
+test_clone_dir ssh://user:password@host/test:1234.git 1234
 
 test_done
-- 
2.5.0
