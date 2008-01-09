From: imyousuf@gmail.com
Subject: [PATCH] Simplified the invocation of command action in submodule
Date: Wed,  9 Jan 2008 09:59:00 +0600
Message-ID: <1199851140-31853-1-git-send-email-imyousuf@gmail.com>
Cc: gitster@pobox.com, Imran M Yousuf <imran@smartitengineering.com>,
	Imran M Yousuf <imyousuf@smartitengineering.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 09 04:59:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCS6R-0003x5-BP
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 04:59:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847AbYAID7Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 22:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752126AbYAID7Q
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 22:59:16 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:23515 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751607AbYAID7P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 22:59:15 -0500
Received: by fg-out-1718.google.com with SMTP id e21so96323fga.17
        for <git@vger.kernel.org>; Tue, 08 Jan 2008 19:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=8gXowv45W/8E2vyM9cGm+oS+UBodp5JZ2qHJK3/nsMM=;
        b=uar4rsoDnulGuxFjQBbLM50+FlenI/8VpFRlvr1YfoxyV6kZ1MZY0z/UmFuK5UUYQqssMQluW6MqgEQCeOYCsiflSjWnqkKRk0n3sWXQQ2d1L7UyuoMzCfjF4uqIa3aaoszpqQ/fUudUv//3FuXv5m0q68tL0M0VODbQ0xehXL0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=P7UhV50SzZxX5piDQpAbMbTGQImuV5iIx5wRU1Do7KKi8Hxm8hC0Kwx/QVRx/gP2cBxw6xDTwkL/7BgYe0DjT7ASX7KNYbm05arCEizILs/EP1X0RHqIvg+paBQftCvUdH0rfjkk/5REAiKq2nw79cUqweavSkknyba7uqpQXCU=
Received: by 10.86.73.17 with SMTP id v17mr190793fga.74.1199851153404;
        Tue, 08 Jan 2008 19:59:13 -0800 (PST)
Received: from localhost ( [62.101.198.35])
        by mx.google.com with ESMTPS id l19sm471316fgb.3.2008.01.08.19.59.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 Jan 2008 19:59:12 -0800 (PST)
X-Mailer: git-send-email 1.5.3.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69952>

From: Imran M Yousuf <imran@smartitengineering.com>

- Simplified the invocation of action.
- Changed switch case based action invoke rather more direct command
invocation. Previously first switch case was used to go through $@ and
determine the action, i.e. add, init, update etc, and second switch case
just to invoke the action. It is modified to determine the action name in
the first case structure instead and later just invoke it.

Signed-off-by: Imran M Yousuf <imyousuf@smartitengineering.com>
---
 git-submodule.sh |   32 ++++++++++++--------------------
 1 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index ad9fe62..8a29382 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -16,6 +16,7 @@ update=
 status=
 quiet=
 cached=
+command=
 
 #
 # print stuff on stdout unless -q was specified
@@ -293,20 +294,23 @@ modules_list()
 	done
 }
 
+# command specifies the whole function name since 
+# one of theirs prefix is module not modules
 while test $# != 0
 do
 	case "$1" in
 	add)
 		add=1
+		command="module_$1"
 		;;
 	init)
-		init=1
+		command="modules_$1"
 		;;
 	update)
-		update=1
+		command="modules_$1"
 		;;
 	status)
-		status=1
+		command="modules_list"
 		;;
 	-q|--quiet)
 		quiet=1
@@ -320,7 +324,7 @@ do
 		branch="$2"; shift
 		;;
 	--cached)
-		cached=1
+		command="modules_list"
 		;;
 	--)
 		break
@@ -345,20 +349,8 @@ case "$add,$branch" in
 	;;
 esac
 
-case "$add,$init,$update,$status,$cached" in
-1,,,,)
-	module_add "$@"
-	;;
-,1,,,)
-	modules_init "$@"
-	;;
-,,1,,)
-	modules_update "$@"
-	;;
-,,,*,*)
-	modules_list "$@"
-	;;
-*)
+if [ -z $command ]; then 
 	usage
-	;;
-esac
+else
+	"$command" "$@"
+fi
-- 
1.5.3.7
