From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] cvsimport: use show-ref to support packed refs
Date: Wed, 28 Nov 2007 13:56:11 -0500
Message-ID: <20071128185611.GB11320@coredump.intra.peff.net>
References: <20071128185504.GA11236@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Emanuele Giaquinta <e.giaquinta@glauco.it>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 19:56:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxS5U-0005Zi-Jw
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 19:56:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754656AbXK1S4O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 13:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751930AbXK1S4O
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 13:56:14 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3691 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754604AbXK1S4N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 13:56:13 -0500
Received: (qmail 13204 invoked by uid 111); 28 Nov 2007 18:56:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 28 Nov 2007 13:56:12 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Nov 2007 13:56:11 -0500
Content-Disposition: inline
In-Reply-To: <20071128185504.GA11236@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66408>

Previously, if refs were packed, git-cvsimport would assume
that particular refs did not exist. This could lead to, for
example, overwriting previous 'origin' commits that were
packed.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-cvsimport.perl   |   24 +++++++++---------------
 t/t9600-cvsimport.sh |    2 ++
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index efa6a0c..b852f2f 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -527,18 +527,12 @@ sub is_sha1 {
 	return $s =~ /^[a-f0-9]{40}$/;
 }
 
-sub get_headref ($$) {
-    my $name    = shift;
-    my $git_dir = shift;
-
-    my $f = "$git_dir/$remote/$name";
-    if (open(my $fh, $f)) {
-	    chomp(my $r = <$fh>);
-	    is_sha1($r) or die "Cannot get head id for $name ($r): $!";
-	    return $r;
-    }
-    die "unable to open $f: $!" unless $! == POSIX::ENOENT;
-    return undef;
+sub get_headref ($) {
+	my $name = shift;
+	my $r = `git show-ref -s '$name'`;
+	return undef unless $? == 0;
+	chomp $r;
+	return $r;
 }
 
 -d $git_tree
@@ -698,7 +692,7 @@ my (@old,@new,@skipped,%ignorebranch);
 $ignorebranch{'#CVSPS_NO_BRANCH'} = 1;
 
 sub commit {
-	if ($branch eq $opt_o && !$index{branch} && !get_headref($branch, $git_dir)) {
+	if ($branch eq $opt_o && !$index{branch} && !get_headref($branch)) {
 	    # looks like an initial commit
 	    # use the index primed by git-init
 	    $ENV{GIT_INDEX_FILE} = "$git_dir/index";
@@ -722,7 +716,7 @@ sub commit {
 	update_index(@old, @new);
 	@old = @new = ();
 	my $tree = write_tree();
-	my $parent = get_headref($last_branch, $git_dir);
+	my $parent = get_headref($last_branch);
 	print "Parent ID " . ($parent ? $parent : "(empty)") . "\n" if $opt_v;
 
 	my @commit_args;
@@ -733,7 +727,7 @@ sub commit {
 	foreach my $rx (@mergerx) {
 		next unless $logmsg =~ $rx && $1;
 		my $mparent = $1 eq 'HEAD' ? $opt_o : $1;
-		if (my $sha1 = get_headref($mparent, $git_dir)) {
+		if (my $sha1 = get_headref($mparent)) {
 			push @commit_args, '-p', $mparent;
 			print "Merge parent branch: $mparent\n" if $opt_v;
 		}
diff --git a/t/t9600-cvsimport.sh b/t/t9600-cvsimport.sh
index 1ee06bb..3338d44 100755
--- a/t/t9600-cvsimport.sh
+++ b/t/t9600-cvsimport.sh
@@ -57,6 +57,8 @@ test_expect_success 'import a trivial module' '
 
 '
 
+test_expect_success 'pack refs' 'cd module-git && git gc && cd ..'
+
 test_expect_success 'update cvs module' '
 
 	cd module-cvs &&
-- 
1.5.3.6.2039.g0495
