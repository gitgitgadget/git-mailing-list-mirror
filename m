From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] Make repack less likely to corrupt repository
Date: Thu, 19 Feb 2009 23:21:17 +0100
Message-ID: <200902192321.17802.robin.rosenberg.lists@dewire.com>
References: <1234140299-29785-1-git-send-email-robin.rosenberg@dewire.com> <200902151942.15055.robin.rosenberg.lists@dewire.com> <7vvdrbjwbt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, spearce@spearce.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 23:22:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaHIG-0006nC-KJ
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 23:22:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754339AbZBSWV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 17:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753967AbZBSWV1
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 17:21:27 -0500
Received: from mail.dewire.com ([83.140.172.130]:7616 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753958AbZBSWV0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Feb 2009 17:21:26 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id C0730147E9CF;
	Thu, 19 Feb 2009 23:21:20 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SMbG4OaFjO7j; Thu, 19 Feb 2009 23:21:19 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id E2BC8147E9CD;
	Thu, 19 Feb 2009 23:21:18 +0100 (CET)
User-Agent: KMail/1.11.0 (Linux/2.6.27-12-generic; KDE/4.2.0; i686; ; )
In-Reply-To: <7vvdrbjwbt.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110761>

Here is a new version on my ammendments to Junios patch.

-- robin

>From 67347a63ce5ba324a750eb2c1ed7b9b0260d966a Mon Sep 17 00:00:00 2001
From: Robin Rosenberg <robin.rosenberg@dewire.com>
Date: Thu, 19 Feb 2009 23:18:59 +0100
Subject: [PATCH] Recover from some known repack failure situations

For the know problems that we can recover from we exit
with code 2 instead of 1.

Also removed the old packs when repack succeeds

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 Documentation/git-repack.txt |    6 ++++++
 git-repack.sh                |   18 +++++++++++++++++-
 2 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index aaa8852..e5ecd66 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -24,6 +24,12 @@ associated index file.
 Packs are used to reduce the load on mirror systems, backup
 engines, disk storage, etc.
 
+On Windows repacking may fail because packs that should be replaced
+are locked by other programs. In this case the program will recover
+from the situation with an exit code of 2. The user does not have
+to take any action to recover. For repacking to succeed the user
+mustc stop the offending program or wait for it to close the packs.
+
 OPTIONS
 -------
 
diff --git a/git-repack.sh b/git-repack.sh
index 0f13043..519c83a 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -136,8 +136,15 @@ then
 		do
 			echo >&2 "WARNING:   old-$file -> $file"
 		done
+		exit 1
 	fi
-	exit 1
+	echo >&2 "INFO: We recovered from the repack error, but your repo"
+	echo >&2 "INFO: is probably suboptimally packed. You may try to repack"
+	echo >&2 "INFO: later. A common reason for repacking failure is that"
+	echo >&2 "INFO: a Windows program was locking one of the old pack files."
+	echo >&2 "INFO: To repack successfully you may have to close that program"
+	echo >&2 "INFO: before repacking."
+	exit 2
 fi
 
 # Now the ones with the same name are out of the way...
@@ -152,6 +159,15 @@ do
 	exit
 done
 
+# Remove the "old-" files
+for name in $names
+do
+	rm -f "$PACKDIR/old-pack-$name.idx"
+	rm -f "$PACKDIR/old-pack-$name.pack"
+done
+
+# End of pack replacement.
+
 if test "$remove_redundant" = t
 then
 	# We know $existing are all redundant.
-- 
1.6.1.285.g35d8b
