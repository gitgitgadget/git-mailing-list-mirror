From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 8/8] Add contrib/stg-sink: sink a patch to given location
	(mirrors float).
Date: Fri, 02 Mar 2007 00:04:15 +0100
Message-ID: <20070301230415.32459.45545.stgit@gandelf.nowhere.earth>
References: <20070301225651.32459.89156.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 00:05:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMuL6-0004VH-4V
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 00:05:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161223AbXCAXE2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 18:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161217AbXCAXE2
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 18:04:28 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:49982 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161223AbXCAXE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 18:04:26 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 2431C3949;
	Fri,  2 Mar 2007 00:04:24 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id C1D361F084;
	Fri,  2 Mar 2007 00:04:15 +0100 (CET)
In-Reply-To: <20070301225651.32459.89156.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41150>




Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 contrib/stg-sink |   44 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/contrib/stg-sink b/contrib/stg-sink
new file mode 100755
index 0000000..e63eb93
--- /dev/null
+++ b/contrib/stg-sink
@@ -0,0 +1,44 @@
+#!/usr/bin/perl
+use strict;
+use warnings;
+
+sub _run {
+  print(' >> ', @_, "\n");# and 0;
+  system(@_);
+}
+
+my $dopush=1;
+my $pop='pop -a';
+while (@ARGV and $ARGV[0] =~ m/^-/) {
+  if ($ARGV[0] eq '-n') {
+    $dopush=0;
+    shift @ARGV;
+  }
+  if ($ARGV[0] eq '-t') {
+    shift @ARGV;
+    $pop = 'goto '.shift @ARGV;
+  }
+}
+
+# default: sink current patch
+if (@ARGV == 0) {
+  $ARGV[0] = `stg top`;
+}
+
+my @oldapplied=`stg applied`;
+chomp (@oldapplied);
+
+_run('stg '.$pop) &&
+  die "cannot pop all patches";
+_run('stg push ' . join (' ', @ARGV)) &&
+  die "error pushing patches";
+
+if ($dopush) {
+  my @newapplied=`stg applied`;
+  chomp (@newapplied);
+  my @remaining=grep { my $check=$_;
+		       not grep { $check eq $_ } @newapplied;
+		     } @oldapplied;
+  _run('stg push ' . join (' ', @remaining)) &&
+    die "error pushing remaining patches";
+}
