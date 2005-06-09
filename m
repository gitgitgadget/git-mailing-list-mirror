From: Pavel Roskin <proski@gnu.org>
Subject: [COGITO PATCH] Improvements for cg and cg-help
Date: Thu, 09 Jun 2005 11:17:22 -0400
Message-ID: <1118330242.27441.15.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jun 09 17:23:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgOir-0002BC-RD
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 17:13:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbVFIPRg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Jun 2005 11:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbVFIPRg
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jun 2005 11:17:36 -0400
Received: from h-64-105-159-118.phlapafg.covad.net ([64.105.159.118]:40880
	"EHLO dv.roinet.com") by vger.kernel.org with ESMTP id S261897AbVFIPRZ
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 9 Jun 2005 11:17:25 -0400
Received: from dv.roinet.com (localhost.localdomain [127.0.0.1])
	by dv.roinet.com (8.13.4/8.13.4) with ESMTP id j59FHPqj029548
	for <git@vger.kernel.org>; Thu, 9 Jun 2005 11:17:25 -0400
Received: (from proski@localhost)
	by dv.roinet.com (8.13.4/8.13.4/Submit) id j59FHNJ0029545
	for git@vger.kernel.org; Thu, 9 Jun 2005 11:17:23 -0400
X-Authentication-Warning: dv.roinet.com: proski set sender to proski@gnu.org using -f
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.2 (2.2.2-8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello!

cg should not run cg-help with arguments unless they were specified
after an explicit "help" command
("cg help -option")

cg without arguments should run cg-help.
cg with any option before the command ("cg -foo cmd") should also run
cg-help.

cg-help should print help for cg-help if specific help is not available,
e.g.:

$ cg-help foo
Error: no help available for "foo"
Usage: cg-help [COMMAND]
...

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/cg b/cg
--- a/cg
+++ b/cg
@@ -1,7 +1,10 @@
 #!/bin/sh
 
 cmd="$1"; shift
-[ x"$cmd" = x"--help" ] && cmd="help"
+case x$cmd in
+	x-*) exec cg-help;;
+	x) exec cg-help;;
+esac
 
 exe="cg-$cmd"
 exec $exe "$@"
diff --git a/cg-help b/cg-help
--- a/cg-help
+++ b/cg-help
@@ -19,7 +19,9 @@ _git_repo_unneeded=1
 
 if [ "$1" ]; then
 	cmd=$(echo "$1" | sed 's/^cg-//')
-	print_help $cmd
+	(print_help $cmd) && exit
+	echo "Error: no help available for \"$1\""
+	print_help help
 fi
 
 


-- 
Regards,
Pavel Roskin

