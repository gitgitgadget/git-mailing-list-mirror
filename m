From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH] stash: simplify parsing fixes
Date: Tue, 28 Sep 2010 01:32:45 +1000
Message-ID: <1285601565-24709-1-git-send-email-jon.seymour@gmail.com>
References: <7vzkv3hkg1.fsf@alter.siamese.dyndns.org>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com, brian@gernhardtsoftware.com
X-From: git-owner@vger.kernel.org Mon Sep 27 17:29:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0FeN-0005zA-CK
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 17:29:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759657Ab0I0P3f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Sep 2010 11:29:35 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:60150 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759647Ab0I0P3d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Sep 2010 11:29:33 -0400
Received: by pvg2 with SMTP id 2so1298594pvg.19
        for <git@vger.kernel.org>; Mon, 27 Sep 2010 08:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=4dCNVb/iYCQtIBEWTupYPWEx6vcl5UDFNwQEkhW2q/s=;
        b=xf6/zsKXhPLrE3fy7EoymLKJehwiXiPOTemIWPnq5IJIA+WZ01HRVZGbvRKnBpmzpI
         P+YlE49/GwA1B9Ap/SNIP1A9XbPt9LlHfW0zS/kTz99Rq+9dMgT168LYg2hak2N5Rid3
         drXW9MmSqh7DqKxrZxRF0dNS0lwxe5sp1qbzg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=u7A84dALrGZopvfD4LkwG9oGzpOndHHLaoHNrDmgAsc1qWjLPKMPMGW2SHT7dBN1tG
         Qk1oEMJsVTzHfcoWj41sUV7QOkAgdDRhF3Ty5j+zqHIBWdyrOzphO1f/FhwGrXfSfxKK
         Bzf7+rBTvRRvkrggIpWCv60YeobyxXK650aXE=
Received: by 10.114.36.4 with SMTP id j4mr8699995waj.176.1285601372910;
        Mon, 27 Sep 2010 08:29:32 -0700 (PDT)
Received: from localhost.localdomain (124-169-19-228.dyn.iinet.net.au [124.169.19.228])
        by mx.google.com with ESMTPS id r3sm6310149ibk.7.2010.09.27.08.29.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 27 Sep 2010 08:29:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.2.g9027fa.dirty
In-Reply-To: <7vzkv3hkg1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157342>

This patch simplifies Brian's fix for the recent regression by:

* eliminating the extra loop
* eliminating use of git rev-parse for parsing flags
* making use of the for opt idiom for the retained loop
* eliminating the redundant -- case

The patch has been tested with the tests in current maint.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-stash.sh |   28 +++++++---------------------
 1 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 57f36ce..23a9ab5 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -264,36 +264,22 @@ parse_flags_and_rev()
 	b_tree=
 	i_tree=
 
-	# Work around rev-parse --flags eating -q
-	for opt
-	do
-		case "$opt" in
-		-q|--quiet)
-			GIT_QUIET=t
-			;;
-		esac
-	done
-
 	REV=$(git rev-parse --no-flags --symbolic "$@" 2>/dev/null)
-	FLAGS=$(git rev-parse --no-revs --flags "$@" 2>/dev/null)
-
-	set -- $FLAGS
 
 	FLAGS=
-	while test $# -ne 0
+	for opt
 	do
-		case "$1" in
+		case "$opt" in
+			-q|--quiet)
+				GIT_QUIET=-t
+			;;
 			--index)
 				INDEX_OPTION=--index
 			;;
-			--)
-				:
-			;;
-			*)
-				FLAGS="${FLAGS}${FLAGS:+ }$1"
+			-*)
+				FLAGS="${FLAGS}${FLAGS:+ }$opt"
 			;;
 		esac
-		shift
 	done
 
 	set -- $REV
-- 
1.7.3.2.g9027fa.dirty
