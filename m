From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH 2/3] cvsimport: standarize open() calls to external git tools
Date: Tue, 19 Jan 2010 14:03:09 -0500
Message-ID: <1263927790-1872-2-git-send-email-bwalton@artsci.utoronto.ca>
References: <7v8wbwzgnw.fsf@alter.siamese.dyndns.org>
 <1263927790-1872-1-git-send-email-bwalton@artsci.utoronto.ca>
Cc: Ben Walton <bwalton@artsci.utoronto.ca>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 19 20:03:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXJMs-0001jR-AS
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 20:03:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755305Ab0ASTDT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 14:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755295Ab0ASTDR
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 14:03:17 -0500
Received: from www.cquest.utoronto.ca ([192.82.128.5]:34873 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755088Ab0ASTDP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 14:03:15 -0500
Received: from ntdws12.chass.utoronto.ca ([128.100.160.253]:38912 ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1NXJMA-00045v-9s; Tue, 19 Jan 2010 14:03:14 -0500
Received: from localhost
	([127.0.0.1] helo=ntdws12.chass.utoronto.ca ident=505)
	by ntdws12.chass.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1NXJMA-0000Uu-7I; Tue, 19 Jan 2010 14:03:14 -0500
Received: (from bwalton@localhost)
	by ntdws12.chass.utoronto.ca (8.13.8/8.13.8/Submit) id o0JJ3EDN001912;
	Tue, 19 Jan 2010 14:03:14 -0500
X-Mailer: git-send-email 1.6.6
In-Reply-To: <1263927790-1872-1-git-send-email-bwalton@artsci.utoronto.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137487>

This patch standardizes calls to open() where git modules are used as
part of a pipeline.  Instead of open(X, "git foo ... |)", use open(X,
"-|", qw(git foo ...)).  This standarization should see all calls made
without the use of an 'sh -c' process to split the arguments.

Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
---
 git-cvsimport.perl |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index adffa0c..e838c2e 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -617,7 +617,7 @@ unless (-d $git_dir) {
 	$last_branch = $opt_o;
 	$orig_branch = "";
 } else {
-	open(F, "git symbolic-ref HEAD |") or
+	open(F, "-|", qw(git symbolic-ref HEAD)) or
 		die "Cannot run git symbolic-ref: $!\n";
 	chomp ($last_branch = <F>);
 	$last_branch = basename($last_branch);
@@ -631,8 +631,8 @@ unless (-d $git_dir) {
 
 	# Get the last import timestamps
 	my $fmt = '($ref, $author) = (%(refname), %(author));';
-	open(H, "git for-each-ref --perl --format='$fmt' $remote |") or
-		die "Cannot run git for-each-ref: $!\n";
+	my @cmd = ('git', 'for-each-ref', '--perl', "--format=$fmt", $remote);
+	open(H, "-|", @cmd) or die "Cannot run git for-each-ref: $!\n";
 	while (defined(my $entry = <H>)) {
 		my ($ref, $author);
 		eval($entry) || die "cannot eval refs list: $@";
@@ -730,7 +730,7 @@ sub update_index (\@\@) {
 }
 
 sub write_tree () {
-	open(my $fh, '-|', "git write-tree")
+	open(my $fh, '-|', qw(git write-tree))
 		or die "unable to open git write-tree: $!";
 	chomp(my $tree = <$fh>);
 	is_sha1($tree)
-- 
1.6.5.3
