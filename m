From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 1/2] archimport: allow for old style branch and public tag names
Date: Tue, 15 Nov 2005 00:05:46 -0800
Message-ID: <20051115080546.GA30506@Muzzle>
References: <20051112092336.GA16218@Muzzle> <46a038f90511120354n4584aedfhb1f2928ac41478ab@mail.gmail.com> <20051112202150.GA2037@Muzzle> <46a038f90511141438q1d85d429vedcf2a3b54d761e1@mail.gmail.com> <20051115080352.GG7484@mail.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 15 09:07:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ebvp8-0005KG-Ss
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 09:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbVKOIFs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 03:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbVKOIFs
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 03:05:48 -0500
Received: from hand.yhbt.net ([66.150.188.102]:29346 "EHLO mail.yhbt.net")
	by vger.kernel.org with ESMTP id S1751369AbVKOIFs (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Nov 2005 03:05:48 -0500
Received: from mayonaise.dyndns.org (user-118bgak.cable.mindspring.com [66.133.193.84])
	by mail.yhbt.net (Postfix) with SMTP id BEA662DC033;
	Tue, 15 Nov 2005 00:05:46 -0800 (PST)
Received: by mayonaise.dyndns.org (sSMTP sendmail emulation); Tue, 15 Nov 2005 00:05:46 -0800
To: Martin Langhoff <martin@catalyst.net.nz>
Content-Disposition: inline
In-Reply-To: <20051115080352.GG7484@mail.yhbt.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11883>

This patch adds the -o switch, which lets old trees tracked by
git-archmirror continue working with their old branch and tag names
to make life easier for people tracking your tree.

Private tags that are only used internally by git-archimport continue to be
new-style, and automatically converted upon first run.

Signed-off-by:: Eric Wong <normalperson@yhbt.net>

---

 git-archimport.perl |   22 +++++++++++++++++-----
 1 files changed, 17 insertions(+), 5 deletions(-)

applies-to: 44d831812786f4dfbf54a67b51e5f48c7d5afd66
4b341dd903883db0a89fe2f04e93dab053beb045
diff --git a/git-archimport.perl b/git-archimport.perl
index 1f721f6..304d462 100755
--- a/git-archimport.perl
+++ b/git-archimport.perl
@@ -67,12 +67,12 @@ my $git_dir = $ENV{"GIT_DIR"} || ".git";
 $ENV{"GIT_DIR"} = $git_dir;
 my $ptag_dir = "$git_dir/archimport/tags";
 
-our($opt_h,$opt_v,$opt_T,$opt_t,$opt_D,$opt_a);
+our($opt_h,$opt_v,$opt_T,$opt_t,$opt_D,$opt_a,$opt_o);
 
 sub usage() {
     print STDERR <<END;
 Usage: ${\basename $0}     # fetch/update GIT from Arch
-       [ -h ] [ -v ] [ -T ] [ -a ] [ -D depth  ] [ -t tempdir ]
+       [ -o ] [ -h ] [ -v ] [ -T ] [ -a ] [ -D depth  ] [ -t tempdir ]
        repository/arch-branch [ repository/arch-branch] ...
 END
     exit(1);
@@ -267,7 +267,15 @@ sub tree_dirname {
     return $name;
 }
 
-*git_branchname = *tree_dirname;
+# old versions of git-archimport just use the <category--branch> part:
+sub old_style_branchname {
+    my $id = shift;
+    my $ret = safe_pipe_capture($TLA,'parse-package-name','-p',$id);
+    chomp $ret;
+    return $ret;
+}
+
+*git_branchname = $opt_o ? *old_style_branchname : *tree_dirname;
 
 # process patchsets in ancestry order
 foreach my $ps (@psets) {
@@ -527,8 +535,12 @@ sub parselog {
 sub tag {
     my ($tag, $commit) = @_;
  
-    # don't use subdirs for tags yet, it could screw up other porcelains
-    $tag =~ s|/|,|;
+    if ($opt_o) {
+        $tag =~ s|/|--|g;
+    } else {
+        # don't use subdirs for tags yet, it could screw up other porcelains
+        $tag =~ s|/|,|g;
+    }
     
     if ($commit) {
         open(C,">","$git_dir/refs/tags/$tag")
---
0.99.9.GIT
