From: "martin f. krafft" <madduck@debian.org>
Subject: [PATCH] Allow help/--help/-h to be run outside of a TopGit repo
Date: Thu, 20 Nov 2008 12:46:34 +0100
Message-ID: <1227181594-15123-1-git-send-email-madduck@debian.org>
Cc: "martin f. krafft" <madduck@debian.org>
To: git@vger.kernel.org, pasky@suse.cz
X-From: git-owner@vger.kernel.org Thu Nov 20 12:48:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3813-0003ie-VZ
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 12:48:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754250AbYKTLqx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 06:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754189AbYKTLqx
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 06:46:53 -0500
Received: from clegg.madduck.net ([193.242.105.96]:47786 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754052AbYKTLqx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 06:46:53 -0500
Received: from wall.oerlikon.madduck.net (wall.oerlikon.madduck.net [IPv6:2001:41e0:ff12::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id C8F481D40AF;
	Thu, 20 Nov 2008 12:46:36 +0100 (CET)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [IPv6:2001:41e0:ff12:0:211:2fff:fe6b:c869])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 298A29F34F;
	Thu, 20 Nov 2008 12:46:35 +0100 (CET)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id BDD2945F4; Thu, 20 Nov 2008 12:46:34 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2
X-Virus-Scanned: ClamAV 0.94.1/8653/Thu Nov 20 10:04:07 2008 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101407>

The user ought to be able to call `tg help` from anywhere in the filesystem,
not just Git repositories, so the help parsing has to happen before the calls
to git git binary.

Debian bug: #501982

Signed-off-by: martin f. krafft <madduck@debian.org>

---
 tg.sh |   28 +++++++++++++++++++++++++---
 1 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/tg.sh b/tg.sh
index 4dcc15e..258f8ce 100644
--- a/tg.sh
+++ b/tg.sh
@@ -235,12 +235,37 @@ do_help()
 	fi
 }
 
+# Check whether we are supposed to output the help message
+should_do_help()
+{
+	# we are being sourced for utility functions, never run help
+	[ -z "$tg__include" ] || return 1
+
+	local prev
+	while [ -n "$1" ]; do
+		case "$1" in
+		help|--help|-h)
+			shift
+			echo "${1:-$prev}"
+			return 0
+		esac
+		prev="$1"
+		shift
+	done
+
+	# run help when there was no previous topic, meaning that there where
+	# no arguments at all
+	test -z "$prev"
+}
 
 ## Startup
 
 [ -d "@cmddir@" ] ||
 	die "No command directory: '@cmddir@'"
 
+# check if we should run help and get the topic while we're at it
+help_topic="$(should_do_help "$@")" && { do_help "$help_topic"; exit 0; }
+
 ## Initial setup
 
 set -e
@@ -270,9 +295,6 @@ cmd="$1"
 shift
 
 case "$cmd" in
-help|--help|-h)
-	do_help "$1"
-	exit 0;;
 --hooks-path)
 	# Internal command
 	echo "@hooksdir@";;
-- 
tg: (f17218e..) fixes/independent-help (depends on: upstream)
