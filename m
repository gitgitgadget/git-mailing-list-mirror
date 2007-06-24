From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] git-svnimport: added explicit merge graph option -G
Date: Sun, 24 Jun 2007 00:06:20 -0700
Message-ID: <7vk5tt25n7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stas Maximov <smaximov@yahoo.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 24 09:06:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2MB2-0006t7-0v
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 09:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753823AbXFXHGX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 03:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753744AbXFXHGX
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 03:06:23 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:33066 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753490AbXFXHGW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 03:06:22 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070624070622.MQQ3993.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sun, 24 Jun 2007 03:06:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id FK6M1X0011kojtg0000000; Sun, 24 Jun 2007 03:06:21 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50772>

From: Stas Maximov <smaximov@yahoo.com>
Date: Sat, 23 Jun 2007 09:06:30 -0700

Allows explicit merge graph information to be provided. Each line
of merge graph file must contain a pair of SVN revision numbers
separated by space. The first number is child (merged to) SVN rev
number and the second is the parent (merged from) SVN rev number.
Comments can be started with '#' and continue to the end of line.
Empty and space-only lines are allowed and will be ignored.
---

 * Stas, please give a "Signed-off-by" line, and get in the
   habit of always CC the list.

   I received a format-patch output as attachment from Stas.  As
   I cannot comment on the patch in that format, I am making a
   verbatim forward to the list.

   I'll comment on the patch separately when I am through it,
   but would appreciate comments from people who were involved
   in git-svnimport in the past, and still use it.

   "You should use git-svn instead" people can repeat that as
   usual, but at the same time it might be worth realizing that
   there are people who maintain git-svnimport being better for
   one-short importing.

 Documentation/git-svnimport.txt |   11 +++++-
 git-svnimport.perl              |   71 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 78 insertions(+), 4 deletions(-)
 mode change 100644 => 100755 Documentation/git-svnimport.txt

diff --git a/Documentation/git-svnimport.txt b/Documentation/git-svnimport.txt
old mode 100644
new mode 100755
index e97d15e..c902b64
--- a/Documentation/git-svnimport.txt
+++ b/Documentation/git-svnimport.txt
@@ -13,7 +13,8 @@ SYNOPSIS
 'git-svnimport' [ -o <branch-for-HEAD> ] [ -h ] [ -v ] [ -d | -D ]
 		[ -C <GIT_repository> ] [ -i ] [ -u ] [-l limit_rev]
 		[ -b branch_subdir ] [ -T trunk_subdir ] [ -t tag_subdir ]
-		[ -s start_chg ] [ -m ] [ -r ] [ -M regex ]
+		[ -s start_chg ] [ -r ]
+		[ -m ] [ -M regex ] [-G merge_graph_file ]
 		[ -I <ignorefile_name> ] [ -A <author_file> ]
 		[ -R <repack_each_revs>] [ -P <path_from_trunk> ]
 		<SVN_repository_URL> [ <path> ]
@@ -102,6 +103,14 @@ repository without -A.
 	regex. It can be used with -m to also see the default regexes.
 	You must escape forward slashes.
 
+-G <merge_graph_file>::
+	Allows explicit merge graph information to be provided. Each line
+	of merge graph file must contain a pair of SVN revision numbers
+	separated by space. The first number is child (merged to) SVN rev
+	number and the second is the parent (merged from) SVN rev number.
+	Comments can be started with '#' and continue to the end of line.
+	Empty and space-only lines are allowed and will be ignored.
+
 -l <max_rev>::
 	Specify a maximum revision number to pull.
 +
diff --git a/git-svnimport.perl b/git-svnimport.perl
index f459762..113b252 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -32,7 +32,7 @@ $ENV{'TZ'}="UTC";
 
 our($opt_h,$opt_o,$opt_v,$opt_u,$opt_C,$opt_i,$opt_m,$opt_M,$opt_t,$opt_T,
     $opt_b,$opt_r,$opt_I,$opt_A,$opt_s,$opt_l,$opt_d,$opt_D,$opt_S,$opt_F,
-    $opt_P,$opt_R);
+    $opt_P,$opt_R,$opt_G);
 
 sub usage() {
 	print STDERR <<END;
@@ -40,12 +40,13 @@ Usage: ${\basename $0}     # fetch/update GIT from SVN
        [-o branch-for-HEAD] [-h] [-v] [-l max_rev] [-R repack_each_revs]
        [-C GIT_repository] [-t tagname] [-T trunkname] [-b branchname]
        [-d|-D] [-i] [-u] [-r] [-I ignorefilename] [-s start_chg]
-       [-m] [-M regex] [-A author_file] [-S] [-F] [-P project_name] [SVN_URL]
+       [-m] [-M regex] [-G merge_graph_file] [-A author_file]
+       [-S] [-F] [-P project_name] [SVN_URL]
 END
 	exit(1);
 }
 
-getopts("A:b:C:dDFhiI:l:mM:o:rs:t:T:SP:R:uv") or usage();
+getopts("A:b:C:dDFhiI:l:mM:G:o:rs:t:T:SP:R:uv") or usage();
 usage if $opt_h;
 
 my $tag_name = $opt_t || "tags";
@@ -80,6 +81,39 @@ if ($opt_M) {
 	unshift (@mergerx, qr/$opt_M/);
 }
 
+
+# merge_graph will be used for finding all parent SVN revisions for a given SVN
+# revision. It will be implemented as a hash of hashes. First level hash will
+# be keyed with the child SVN rev and contain a hash keyed with the parent SVN
+# revisions. Values of the second level hash are not important (1 will be
+# used). The keys will be used to store the parent revs for uniqueness.
+our %merge_graph;
+
+
+# read-in the explicit merge graph specified with -G option
+if ($opt_G) {
+    open(F,"cat $opt_G | sed -e 's/#.*\$//' -e '/^\$/d' |") or
+        die("Can not open $opt_G");
+    while(<F>) {
+        chomp;
+        die "ERROR: invalid line in $opt_G: $_" unless /^\s*(\d+)\s+(\d+)\s*$/;
+        # $merge_graph{child_rev}{parent_rev} = 1;
+        $merge_graph{$1}{$2} = 1;
+    }
+    close(F);
+}
+
+
+# Given an SVN revision (string), finds all its parent SVN revisions in the
+# merge graph.
+sub merge_graph_get_parents($)
+{
+    my $child_svnrev = shift;
+    my @parents = keys(%{$merge_graph{$child_svnrev}});
+    return @parents;
+}
+
+
 # Absolutize filename now, since we will have chdir'ed by the time we
 # get around to opening it.
 $opt_A = File::Spec->rel2abs($opt_A) if $opt_A;
@@ -356,6 +390,24 @@ if ($opt_A) {
 
 open BRANCHES,">>", "$git_dir/svn2git";
 
+
+# Given an SVN revision (string), returns all corresponding GIT revisions.
+#
+# Note that it is possible that one SVN revision needs to be split into two or
+# more GIT commits (revision). For example, this will happen if SVN user
+# commits two branches at once.
+sub svnrev_to_gitrevs($)
+{
+    my $svnrev = shift;
+    my @gitrevs;
+    for my $b (keys(%branches)) {
+        push (@gitrevs, $branches{$b}{$svnrev})
+            if defined($branches{$b}{$svnrev});
+    }
+    return @gitrevs;
+}
+
+
 sub node_kind($$) {
 	my ($svnpath, $revision) = @_;
 	my $pool=SVN::Pool->new;
@@ -815,6 +867,19 @@ sub commit {
 					}
 				}
 			}
+
+            # add parents from explicit merge graph (-G)
+            {
+                my @svnpars = merge_graph_get_parents($revision);
+                foreach my $svnp (@svnpars) {
+                    my @gitpars = svnrev_to_gitrevs($svnp);
+                    foreach my $gitp (@gitpars) {
+                        push (@parents, $gitp);
+                        #print OUT "MG: $svnp -merge-> $revision\n";
+                    }
+                }
+            }
+
 			my %seen_parents = ();
 			my @unique_parents = grep { ! $seen_parents{$_} ++ } @parents;
 			foreach my $bparent (@unique_parents) {
-- 
1.5.1.3
