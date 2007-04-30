From: Dana How <danahow@gmail.com>
Subject: [PATCH 8/8] git-repack --max-pack-size: add option parsing to enable
 feature
Date: Mon, 30 Apr 2007 16:25:16 -0700
Message-ID: <46367ADC.2090704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, danahow@gmail.com
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 01 01:25:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HifFL-0003qG-4q
	for gcvg-git@gmane.org; Tue, 01 May 2007 01:25:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946887AbXD3XZ1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Apr 2007 19:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946889AbXD3XZ1
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Apr 2007 19:25:27 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:44302 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946888AbXD3XZT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2007 19:25:19 -0400
Received: by py-out-1112.google.com with SMTP id h31so2348624pyc
        for <git@vger.kernel.org>; Mon, 30 Apr 2007 16:25:18 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=rDrP8vd++8MFbUemtziril3Y5xNQSrfEcusClOBdSfgGFdu2oNcM6fCf8iQ6Hicp+1WaYSjl4AXOwfriTQN787XS4aCTT3sLTw/9KN/6lUmiptM3bnm4xwQQhUeZCBGRyLidknLDV+/PfFW54xisdMkS/DnrW3qc4lBP1H7QRZk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=Di61ekVi58uQMcXnNrN1HCsEkCwKozFkFxvFQXVuVlVSpoCNlwhHB5ueGK4BuurE0tcUtp70+qglXlWNo/W3KdbuqTo1lyY6X4eLos0iuokKa5/y7EpV0761kCzZrDfN8+6hTgkz1y7E5pYR8vP2e8tK5J3gyLAoMF0lK8HyOz4=
Received: by 10.65.243.18 with SMTP id v18mr12804549qbr.1177975518438;
        Mon, 30 Apr 2007 16:25:18 -0700 (PDT)
Received: from ?192.168.1.30? ( [64.186.171.227])
        by mx.google.com with ESMTP id r15sm7851420nza.2007.04.30.16.25.17;
        Mon, 30 Apr 2007 16:25:18 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051006)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45899>


Add --max-pack-size parsing and usage messages.
Upgrade git-repack.sh to handle multiple packfile names.

Signed-off-by: Dana L. How <danahow@gmail.com>
---
 builtin-pack-objects.c |   10 +++++++++-
 git-repack.sh          |   12 +++++++-----
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 328b3cb..ed958d6 100644
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
@@ -1766,6 +1766,14 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			incremental = 1;
 			continue;
 		}
+		if (!prefixcmp(arg, "--max-pack-size=")) {
+			char *end;
+			pack_size_limit = strtoul(arg+16, &end, 0) * 1024 * 1024;
+			if (!arg[16] || *end)
+				usage(pack_usage);
+			no_reuse_delta = 1;
+			continue;
+		}
 		if (!prefixcmp(arg, "--window=")) {
 			char *end;
 			window = strtoul(arg+9, &end, 0);
diff --git a/git-repack.sh b/git-repack.sh
index ddfa8b4..ebce1b3 100755
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
1.5.2.rc0.766.gba60-dirty
