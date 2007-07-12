From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] script to display a distribution of longest common hash
 prefixes
Date: Thu, 12 Jul 2007 03:40:18 -0400 (EDT)
Message-ID: <alpine.LFD.0.999.0707120337420.32552@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Jul 12 09:40:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8tHl-0001r2-7N
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 09:40:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757537AbXGLHkW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 03:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757370AbXGLHkU
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 03:40:20 -0400
Received: from relais.videotron.ca ([24.201.245.36]:53955 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756565AbXGLHkT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 03:40:19 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JL2008C62N6NR80@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 12 Jul 2007 03:40:18 -0400 (EDT)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52252>

This script was originally posted on the git mailing list by
Randal L. Schwartz <merlyn@stonehenge.com>.
    
Signed-off-by: Nicolas Pitre <nico@cam.org>
---

diff --git a/contrib/stats/git-common-hash b/contrib/stats/git-common-hash
new file mode 100755
index 0000000..e27fd08
--- /dev/null
+++ b/contrib/stats/git-common-hash
@@ -0,0 +1,26 @@
+#!/bin/sh
+
+# This script displays the distribution of longest common hash prefixes.
+# This can be used to determine the minimum prefix length to use
+# for object names to be unique.
+
+git rev-list --objects --all | sort | perl -lne '
+  substr($_, 40) = "";
+  # uncomment next line for a distribution of bits instead of hex chars
+  # $_ = unpack("B*",pack("H*",$_));
+  if (defined $p) {
+    ($p ^ $_) =~ /^(\0*)/;
+    $common = length $1;
+    if (defined $pcommon) {
+      $count[$pcommon > $common ? $pcommon : $common]++;
+    } else {
+      $count[$common]++; # first item
+    }
+  }
+  $p = $_;
+  $pcommon = $common;
+  END {
+    $count[$common]++; # last item
+    print "$_: $count[$_]" for 0..$#count;
+  }
+'
