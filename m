From: Robert Zeh <robert.a.zeh@gmail.com>
Subject: [PATCH] git svn: add (failing) test for a git svn gc followed by a 
	git svn mkdirs
Date: Tue, 22 Dec 2009 22:08:15 -0600
Message-ID: <57d579150912222008j19b16b1aq88ebd0938c2553e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Dec 23 05:08:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNIWQ-0005dD-TC
	for gcvg-git-2@lo.gmane.org; Wed, 23 Dec 2009 05:08:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752771AbZLWEIU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2009 23:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752768AbZLWEIT
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Dec 2009 23:08:19 -0500
Received: from mail-yw0-f182.google.com ([209.85.211.182]:64784 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752771AbZLWEIQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2009 23:08:16 -0500
Received: by ywh12 with SMTP id 12so7474397ywh.21
        for <git@vger.kernel.org>; Tue, 22 Dec 2009 20:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type;
        bh=UpT4E3TuLCB3+0nAB277yBzrE7dHapd8b9PbO0IQLXM=;
        b=jU4IBv89Pbi0YtTmsIFRBobPr5wv14VVZigcFQ0NQHyspLfqSo+fs8xT/33dyy9/nk
         dCXdGU1J0lRShHdGbKEMUZX2Ebe19H1m7bOwwiHYrCa94IdObcmBV/Kv1BIjrdfYSTii
         jB7gdin4dfbG3H8fbeHmPn0e5NnH7658l+kEc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=XyQFZFigsBTZaVYUzCVS1KN6btAu3dbfjJ5bBKTax8alW4GTUYg1KDFIw5/U0j3ZqK
         fzP+sWfbDBzzOrH3M3/VPvkWYmzww+vEk0GGYBDVucv6xO4BWYzTAD7DIGBkwJ8AfIHO
         FR30FcdEAqTeJ1kkyRUpPRnX3xT8vuL3G0cVU=
Received: by 10.150.118.37 with SMTP id q37mr13766443ybc.322.1261541295738; 
	Tue, 22 Dec 2009 20:08:15 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135610>

git svn gc will compress the unhandled.log files that git svn mkdirs reads,
causing git svn mkdirs to skip directory creation.
---
 t/t9152-svn-empty-dirs-after-gc.sh |   41 ++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)
 create mode 100755 t/t9152-svn-empty-dirs-after-gc.sh

diff --git a/t/t9152-svn-empty-dirs-after-gc.sh
b/t/t9152-svn-empty-dirs-after-gc.sh
new file mode 100755
index 0000000..9ac6ea9
--- /dev/null
+++ b/t/t9152-svn-empty-dirs-after-gc.sh
@@ -0,0 +1,41 @@
+#!/bin/sh
+#
+# Copyright (c) 2009 Robert Zeh
+
+test_description='git svn creates empty directories, calls git gc,
makes sure they are still empty'
+. ./lib-git-svn.sh
+
+test_expect_success 'initialize repo' '
+	for i in a b c d d/e d/e/f "weird file name"
+	do
+		svn_cmd mkdir -m "mkdir $i" "$svnrepo"/"$i"
+	done
+'
+
+test_expect_success 'clone' 'git svn clone "$svnrepo" cloned'
+
+test_expect_success 'git svn gc runs' '
+	(
+		cd cloned &&
+		git svn gc
+	)
+'
+
+test_expect_success 'git svn mkdirs recreates empty directories after
git svn gc' '
+	(
+		cd cloned &&
+		rm -r * &&
+		git svn mkdirs &&
+		for i in a b c d d/e d/e/f "weird file name"
+		do
+			if ! test -d "$i"
+			then
+				echo >&2 "$i does not exist"
+				exit 1
+			fi
+		done
+	)
+'
+
+
+test_done
-- 
1.6.6.rc3.dirty
