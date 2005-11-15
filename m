From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 2/2] archimport: sync_to_ps() messages for tracking tla methods
Date: Tue, 15 Nov 2005 00:06:52 -0800
Message-ID: <20051115080652.GB30506@Muzzle>
References: <20051112092336.GA16218@Muzzle> <46a038f90511120354n4584aedfhb1f2928ac41478ab@mail.gmail.com> <20051112202150.GA2037@Muzzle> <46a038f90511141438q1d85d429vedcf2a3b54d761e1@mail.gmail.com> <20051115080352.GG7484@mail.yhbt.net> <20051115080546.GA30506@Muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 15 09:09:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbvqC-0005iT-W1
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 09:06:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbVKOIGy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 03:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbVKOIGy
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 03:06:54 -0500
Received: from hand.yhbt.net ([66.150.188.102]:30114 "EHLO mail.yhbt.net")
	by vger.kernel.org with ESMTP id S1751375AbVKOIGx (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Nov 2005 03:06:53 -0500
Received: from mayonaise.dyndns.org (user-118bgak.cable.mindspring.com [66.133.193.84])
	by mail.yhbt.net (Postfix) with SMTP id 90B882DC033;
	Tue, 15 Nov 2005 00:06:52 -0800 (PST)
Received: by mayonaise.dyndns.org (sSMTP sendmail emulation); Tue, 15 Nov 2005 00:06:52 -0800
To: Martin Langhoff <martin@catalyst.net.nz>
Content-Disposition: inline
In-Reply-To: <20051115080546.GA30506@Muzzle>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11884>

This patch adds debug messages (enabled with the usual -v switch) for
tracking how often each tla command is called.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 git-archimport.perl |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

applies-to: 8a7cc429d0fd935805851ac5ac10941d0bd86e94
b4de7920e0116afb35016435131a404658818ced
diff --git a/git-archimport.perl b/git-archimport.perl
index b624ba6..1f721f6 100755
--- a/git-archimport.perl
+++ b/git-archimport.perl
@@ -429,18 +429,23 @@ sub sync_to_ps {
     my $ps = shift;
     my $tree_dir = $tmptree.'/'.tree_dirname($ps->{id});
 
+    $opt_v && print "sync_to_ps($ps->{id}) method: ";
+
     if (-d $tree_dir) {
         if ($ps->{type} eq 't') {
             # looks like a tag-only or (worse,) a mixed tags/changeset branch,
             # can't rely on replay to work correctly on these
             rmtree($tree_dir);
+	    $opt_v && print "get (tag)\n";
             safe_pipe_capture($TLA,'get','--no-pristine',$ps->{id},$tree_dir);
         } else {
                 my $tree_id = arch_tree_id($tree_dir);
                 if ($ps->{parent_id} eq $tree_id) {
                     # the common case (hopefully)
+		    $opt_v && print "replay\n";
                     safe_pipe_capture($TLA,'replay','-d',$tree_dir,$ps->{id});
                 } else {
+		    $opt_v && print "apply-delta\n";
                     # this can happen if branches cherry-pick
                     safe_pipe_capture($TLA,'apply-delta','-d',$tree_dir,
                                                         $tree_id, $ps->{id});
@@ -448,6 +453,7 @@ sub sync_to_ps {
         }
     } else {
         # new branch work
+        $opt_v && print "get (new tree)\n";
         safe_pipe_capture($TLA,'get','--no-pristine',$ps->{id},$tree_dir);
     }
    
---
0.99.9.GIT
