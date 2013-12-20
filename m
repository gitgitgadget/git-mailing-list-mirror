From: Wang Nan <wangnan0@huawei.com>
Subject: [PATCH] git-quiltimport: add a --series option
Date: Fri, 20 Dec 2013 18:21:27 +0800
Message-ID: <1387534887-68321-1-git-send-email-wangnan0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Wang Nan <wangnan0@huawei.com>
To: <git@vger.kernel.org>
X-From: linux-kernel-owner@vger.kernel.org Fri Dec 20 11:22:34 2013
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1VtxE1-0003lT-UN
	for glk-linux-kernel-3@plane.gmane.org; Fri, 20 Dec 2013 11:22:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756113Ab3LTKWX (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 20 Dec 2013 05:22:23 -0500
Received: from szxga01-in.huawei.com ([119.145.14.64]:16031 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755888Ab3LTKWU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Dec 2013 05:22:20 -0500
Received: from 172.24.2.119 (EHLO szxeml205-edg.china.huawei.com) ([172.24.2.119])
	by szxrg01-dlp.huawei.com (MOS 4.3.7-GA FastPath queued)
	with ESMTP id BOV30577;
	Fri, 20 Dec 2013 18:22:18 +0800 (CST)
Received: from SZXEML403-HUB.china.huawei.com (10.82.67.35) by
 szxeml205-edg.china.huawei.com (172.24.2.58) with Microsoft SMTP Server (TLS)
 id 14.3.158.1; Fri, 20 Dec 2013 18:22:15 +0800
Received: from lggeml430-hub.china.huawei.com (10.72.61.130) by
 szxeml403-hub.china.huawei.com (10.82.67.35) with Microsoft SMTP Server (TLS)
 id 14.3.158.1; Fri, 20 Dec 2013 18:22:17 +0800
Received: from kernel-host.huawei (10.107.197.247) by
 lggeml430-hub.china.huawei.com (10.72.61.130) with Microsoft SMTP Server id
 14.3.158.1; Fri, 20 Dec 2013 18:22:11 +0800
X-Mailer: git-send-email 1.8.4
X-Originating-IP: [10.107.197.247]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239568>

This patch add a --series option to git-quiltimport to allow users to
select the name of series file. This option is an analog of quilt's
QUILT_SERIES environment variable.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 Documentation/git-quiltimport.txt |  5 +++++
 git-quiltimport.sh                | 21 ++++++++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-quiltimport.txt b/Documentation/git-quiltimport.txt
index a356196..39d8e4b 100644
--- a/Documentation/git-quiltimport.txt
+++ b/Documentation/git-quiltimport.txt
@@ -44,6 +44,11 @@ OPTIONS
 --patches <dir>::
 	The directory to find the quilt patches and the
 	quilt series file.
+
+--series <file>::
+	The name of the series file, defaulting to "series". Relative to
+	patches directory unless an absolute path is used.
+
 +
 The default for the patch directory is patches
 or the value of the $QUILT_PATCHES environment
diff --git a/git-quiltimport.sh b/git-quiltimport.sh
index 8e17525..11a97b4 100755
--- a/git-quiltimport.sh
+++ b/git-quiltimport.sh
@@ -6,6 +6,7 @@ git quiltimport [options]
 n,dry-run     dry run
 author=       author name and email address for patches without any
 patches=      path to the quilt series and patches
+series=       name of the series file
 "
 SUBDIRECTORY_ON=Yes
 . git-sh-setup
@@ -26,6 +27,10 @@ do
 		shift
 		QUILT_PATCHES="$1"
 		;;
+	--series)
+		shift
+		QUILT_SERIES="$1"
+		;;
 	--)
 		shift
 		break;;
@@ -52,6 +57,20 @@ if ! [ -d "$QUILT_PATCHES" ] ; then
 	exit 1
 fi
 
+: ${QUILT_SERIES:=series}
+case ${QUILT_SERIES} in
+	/*)
+		QUILT_SERIES_FILE=${QUILT_SERIES}
+	   ;;
+	*)
+		QUILT_SERIES_FILE=${QUILT_PATCHES}/${QUILT_SERIES}
+esac
+
+if ! [ -f "$QUILT_SERIES_FILE" ] ; then
+	echo "The \"$QUILT_SERIES_FILE\" file does not exist."
+	exit 1
+fi
+
 # Temporary directories
 tmp_dir="$GIT_DIR"/rebase-apply
 tmp_msg="$tmp_dir/msg"
@@ -134,5 +153,5 @@ do
 		commit=$( (echo "$SUBJECT"; echo; cat "$tmp_msg") | git commit-tree $tree -p $commit) &&
 		git update-ref -m "quiltimport: $patch_name" HEAD $commit || exit 4
 	fi
-done 3<"$QUILT_PATCHES/series"
+done 3<"$QUILT_SERIES_FILE"
 rm -rf $tmp_dir || exit 5
-- 
1.8.4
