From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] git-archimport: initial import needs empty directory
Date: Sat, 3 Feb 2007 22:38:59 +0000
Message-ID: <20070203223859.19409.qmail@31fbb50a56ed49.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 03 23:38:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDTWx-0004P8-Ho
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 23:38:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785AbXBCWio (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 17:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751800AbXBCWio
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 17:38:44 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:58254 "HELO a.mx.smarden.org"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with SMTP
	id S1751785AbXBCWin (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 17:38:43 -0500
Received: (qmail 19410 invoked by uid 1000); 3 Feb 2007 22:38:59 -0000
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38614>

Hi, please see http://bugs.debian.org/400508:

> git-archimport deletes the directory tree in the current working
> directory during the initial import. The documentation has a sentence
> saying that an empty directory is expected but this can be dangerous
> for people not familiar with the tool.

git-archimport should better refuse to start an initial import if the
current directory is not empty.

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 git-archimport.perl |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/git-archimport.perl b/git-archimport.perl
index 2e15781..66aaeae 100755
--- a/git-archimport.perl
+++ b/git-archimport.perl
@@ -95,6 +95,15 @@ $ENV{'TMPDIR'} = $opt_t if $opt_t; # $ENV{TMPDIR} will affect tempdir() calls:
 my $tmp = tempdir('git-archimport-XXXXXX', TMPDIR => 1, CLEANUP => 1);
 $opt_v && print "+ Using $tmp as temporary directory\n";
 
+unless (-d $git_dir) { # initial import needs empty directory
+    opendir DIR, '.' or die "Unable to open current directory: $!\n";
+    while (my $entry = readdir DIR) {
+        $entry =~ /^\.\.?$/ or
+            die "Initial import needs an empty current working directory.\n"
+    }
+    closedir DIR
+}
+
 my %reachable = ();             # Arch repositories we can access
 my %unreachable = ();           # Arch repositories we can't access :<
 my @psets  = ();                # the collection
-- 
1.4.4.4
