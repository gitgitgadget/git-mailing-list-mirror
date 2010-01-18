From: Andreas Gruenbacher <agruen@suse.de>
Subject: builtin-apply.c: fix the --- and +++ header filename consistency check
Date: Mon, 18 Jan 2010 22:37:38 +0100
Organization: SUSE Labs
Message-ID: <201001182237.38562.agruen@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 18 22:37:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWzIB-0005Tq-So
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 22:37:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756114Ab0ARVhn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2010 16:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756113Ab0ARVhn
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jan 2010 16:37:43 -0500
Received: from cantor.suse.de ([195.135.220.2]:47702 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751636Ab0ARVhm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2010 16:37:42 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 96DD094109
	for <git@vger.kernel.org>; Mon, 18 Jan 2010 22:37:41 +0100 (CET)
User-Agent: KMail/1.12.2 (Linux/2.6.31.8-0.1-desktop; KDE/4.3.1; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137406>

gitdiff_verify_name() only did a filename prefix check because of an
off-by-one error.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>
---
 builtin-apply.c            |    2 +-
 t/t4133-apply-filenames.sh |   38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 1 deletions(-)
 create mode 100755 t/t4133-apply-filenames.sh

diff --git a/builtin-apply.c b/builtin-apply.c
index 541493e..c8be66e 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -686,7 +686,7 @@ static char *gitdiff_verify_name(const char *line, int 
isnull, char *orig_name,
 		if (isnull)
 			die("git apply: bad git-diff - expected /dev/null, got %s on line %d", 
name, linenr);
 		another = find_name(line, NULL, p_value, TERM_TAB);
-		if (!another || memcmp(another, name, len))
+		if (!another || memcmp(another, name, len + 1))
 			die("git apply: bad git-diff - inconsistent %s filename on line %d", 
oldnew, linenr);
 		free(another);
 		return orig_name;
diff --git a/t/t4133-apply-filenames.sh b/t/t4133-apply-filenames.sh
new file mode 100755
index 0000000..3421807
--- /dev/null
+++ b/t/t4133-apply-filenames.sh
@@ -0,0 +1,38 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Andreas Gruenbacher
+#
+
+test_description='git apply filename consistency check'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	cat > bad1.patch <<EOF
+diff --git a/f b/f
+new file mode 100644
+index 0000000..d00491f
+--- /dev/null
++++ b/f-blah
+@@ -0,0 +1 @@
++1
+EOF
+	cat > bad2.patch <<EOF
+diff --git a/f b/f
+deleted file mode 100644
+index d00491f..0000000
+--- b/f-blah
++++ /dev/null
+@@ -1 +0,0 @@
+-1
+EOF
+'
+
+test_expect_success 'apply diff with inconsistent filenames in headers' '
+	test_must_fail git apply bad1.patch 2>err
+	grep "inconsistent new filename" err
+	test_must_fail git apply bad2.patch 2>err
+	grep "inconsistent old filename" err
+'
+
+test_done
-- 
1.6.6.243.gff6d2
