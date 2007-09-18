From: Jeff King <peff@peff.net>
Subject: [PATCH] contrib/fast-import: add perl version of simple example
Date: Tue, 18 Sep 2007 03:26:27 -0400
Message-ID: <20070918072627.GB3506@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 09:26:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXXTf-0000qk-Gg
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 09:26:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754481AbXIRH0a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 03:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754543AbXIRH0a
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 03:26:30 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2865 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754257AbXIRH03 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 03:26:29 -0400
Received: (qmail 25471 invoked by uid 111); 18 Sep 2007 07:26:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 18 Sep 2007 03:26:28 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Sep 2007 03:26:27 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58534>

This is based on the git-import.sh script, but is a little
more robust and efficient. More importantly, it should
serve as a quick template for interfacing fast-import with
perl scripts.

Signed-off-by: Jeff King <peff@peff.net>
---
 contrib/fast-import/git-import.perl |   64 +++++++++++++++++++++++++++++++++++
 1 files changed, 64 insertions(+), 0 deletions(-)
 create mode 100755 contrib/fast-import/git-import.perl

diff --git a/contrib/fast-import/git-import.perl b/contrib/fast-import/git-import.perl
new file mode 100755
index 0000000..f9fef6d
--- /dev/null
+++ b/contrib/fast-import/git-import.perl
@@ -0,0 +1,64 @@
+#!/usr/bin/perl
+#
+# Performs an initial import of a directory. This is the equivalent
+# of doing 'git init; git add .; git commit'. It's a little slower,
+# but is meant to be a simple fast-import example.
+
+use strict;
+use File::Find;
+
+my $USAGE = 'Usage: git-import branch import-message';
+my $branch = shift or die "$USAGE\n";
+my $message = shift or die "$USAGE\n";
+
+chomp(my $username = `git config user.name`);
+chomp(my $email = `git config user.email`);
+die 'You need to set user name and email'
+  unless $username && $email;
+
+system('git init');
+open(my $fi, '|-', qw(git fast-import --date-format=now))
+  or die "unable to spawn fast-import: $!";
+
+print $fi <<EOF;
+commit refs/heads/$branch
+committer $username <$email> now
+data <<MSGEOF
+$message
+MSGEOF
+
+EOF
+
+find(
+  sub {
+    if($File::Find::name eq './.git') {
+      $File::Find::prune = 1;
+      return;
+    }
+    return unless -f $_;
+
+    my $fn = $File::Find::name;
+    $fn =~ s#^.\/##;
+
+    open(my $in, '<', $_)
+      or die "unable to open $fn: $!";
+    my @st = stat($in)
+      or die "unable to stat $fn: $!";
+    my $len = $st[7];
+
+    print $fi "M 644 inline $fn\n";
+    print $fi "data $len\n";
+    while($len > 0) {
+      my $r = read($in, my $buf, $len < 4096 ? $len : 4096);
+      defined($r) or die "read error from $fn: $!";
+      $r > 0 or die "premature EOF from $fn: $!";
+      print $fi $buf;
+      $len -= $r;
+    }
+    print $fi "\n";
+
+  }, '.'
+);
+
+close($fi);
+exit $?;
-- 
1.5.3.1.967.g6bb01
