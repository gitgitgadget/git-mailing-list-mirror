From: Dana How <danahow@gmail.com>
Subject: [PATCH 4/4] git-repack --max-pack-size: add option parsing to enable
 feature
Date: Tue, 08 May 2007 13:05:04 -0700
Message-ID: <4640D7F0.40702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, danahow@gmail.com
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 08 22:06:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlVwq-0006Wm-Oa
	for gcvg-git@gmane.org; Tue, 08 May 2007 22:06:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031943AbXEHUFQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 16:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031712AbXEHUFQ
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 16:05:16 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:11071 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031943AbXEHUFM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 16:05:12 -0400
Received: by py-out-1112.google.com with SMTP id a29so1582081pyi
        for <git@vger.kernel.org>; Tue, 08 May 2007 13:05:12 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=cvr02cbasi0QrZWzwHePm9ZG3bgg7m9OyDBXxkfZopHk5+nzon5eQQ83UdzmOPsJV0FyrrC7gGcJ3T7vtikHmZrBQggRFjx8+EMGcw5wyoE7MdX5HPa4qZYe68f18hxqkJ9qDPPnPRhpuyVTSTeBEcQ4C+UxKo5rST0Xz2msREw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=THukN80KDTwn/rzKYafaBugefUEicpUZMLbP6IzpF9othHaOQ7a9XFXU0YSpFAybDUjqmyts99+5taetMiHCEWMLht3ZaVQm+uMgK6CmrmTNF4NKTedN8Zf+rOQK2udZOeC+rQwImEW2V6Q98WuA3d3/sp00+bcpJWe10SoZVtA=
Received: by 10.35.62.1 with SMTP id p1mr13879907pyk.1178654712131;
        Tue, 08 May 2007 13:05:12 -0700 (PDT)
Received: from ?192.168.1.30? ( [64.186.171.227])
        by mx.google.com with ESMTP id a79sm17392776pye.2007.05.08.13.05.08;
        Tue, 08 May 2007 13:05:10 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051006)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46617>


Add --max-pack-size parsing and usage messages.
Upgrade git-repack.sh to handle multiple packfile names,
and build packfiles in GIT_OBJECT_DIRECTORY not GIT_DIR.
Update documentation.

Signed-off-by: Dana L. How <danahow@gmail.com>
---
 Documentation/git-pack-objects.txt |    5 +++++
 Documentation/git-repack.txt       |    5 +++++
 builtin-pack-objects.c             |    9 ++++++++-
 git-repack.sh                      |   14 ++++++++------
 4 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index d9e11c6..e762cc7 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -85,6 +85,11 @@ base-name::
 	times to get to the necessary object.
 	The default value for both --window and --depth is 10.
 
+--max-pack-size=<n>::
+	Maximum size of each output packfile, expressed in MiB.
+	If specified,  multiple packfiles may be created.
+	The default is unlimited.
+
 --incremental::
 	This flag causes an object already in a pack ignored
 	even if it appears in the standard input.
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index d39abc1..c6be673 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -65,6 +65,11 @@ OPTIONS
 	to be applied that many times to get to the necessary object.
 	The default value for both --window and --depth is 10.
 
+--max-pack-size=<n>::
+	Maximum size of each output packfile, expressed in MiB.
+	If specified,  multiple packfiles may be created.
+	The default is unlimited.
+
 
 Configuration
 -------------
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 2932b88..8824793 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -15,7 +15,7 @@
 #include "progress.h"
 
 static const char pack_usage[] = "\
-git-pack-objects [{ -q | --progress | --all-progress }] \n\
+git-pack-objects [{ -q | --progress | --all-progress }] [--max-pack-size=N] \n\
 	[--local] [--incremental] [--window=N] [--depth=N] \n\
 	[--no-reuse-delta] [--delta-base-offset] [--non-empty] \n\
 	[--revs [--unpacked | --all]*] [--reflog] [--stdout | base-name] \n\
@@ -1754,6 +1754,13 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			incremental = 1;
 			continue;
 		}
+		if (!prefixcmp(arg, "--max-pack-size=")) {
+			char *end;
+			pack_size_limit = strtoul(arg+16, &end, 0) * 1024 * 1024;
+			if (!arg[16] || *end)
+				usage(pack_usage);
+			continue;
+		}
 		if (!prefixcmp(arg, "--window=")) {
 			char *end;
 			window = strtoul(arg+9, &end, 0);
diff --git a/git-repack.sh b/git-repack.sh
index ddfa8b4..44c12a7 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2005 Linus Torvalds
 #
 
-USAGE='[-a] [-d] [-f] [-l] [-n] [-q] [--window=N] [--depth=N]'
+USAGE='[-a] [-d] [-f] [-l] [-n] [-q] [--max-pack-size=N] [--window=N] [--depth=N]'
 SUBDIRECTORY_OK='Yes'
 . git-sh-setup
 
@@ -18,6 +18,7 @@ do
 	-q)	quiet=-q ;;
 	-f)	no_reuse_delta=--no-reuse-delta ;;
 	-l)	local=--local ;;
+	--max-pack-size=*) extra="$extra $1" ;;
 	--window=*) extra="$extra $1" ;;
 	--depth=*) extra="$extra $1" ;;
 	*)	usage ;;
@@ -35,7 +36,7 @@ true)
 esac
 
 PACKDIR="$GIT_OBJECT_DIRECTORY/pack"
-PACKTMP="$GIT_DIR/.tmp-$$-pack"
+PACKTMP="$GIT_OBJECT_DIRECTORY/.tmp-$$-pack"
 rm -f "$PACKTMP"-*
 trap 'rm -f "$PACKTMP"-*' 0 1 2 3 15
 
@@ -62,11 +63,12 @@ case ",$all_into_one," in
 esac
 
 args="$args $local $quiet $no_reuse_delta$extra"
-name=$(git-pack-objects --non-empty --all --reflog $args </dev/null "$PACKTMP") ||
+names=$(git-pack-objects --non-empty --all --reflog $args </dev/null "$PACKTMP") ||
 	exit 1
-if [ -z "$name" ]; then
+if [ -z "$names" ]; then
 	echo Nothing new to pack.
-else
+fi
+for name in $names ; do
 	chmod a-w "$PACKTMP-$name.pack"
 	chmod a-w "$PACKTMP-$name.idx"
 	if test "$quiet" != '-q'; then
@@ -92,7 +94,7 @@ else
 		exit 1
 	}
 	rm -f "$PACKDIR/old-pack-$name.pack" "$PACKDIR/old-pack-$name.idx"
-fi
+done
 
 if test "$remove_redundant" = t
 then
-- 
1.5.2.rc0.787.g0014
