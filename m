From: Brian Downing <bdowning@lavos.net>
Subject: [PATCH] Pack information tool
Date: Wed, 11 Jul 2007 22:02:25 -0500
Message-ID: <11842093453843-git-send-email-bdowning@lavos.net>
References: <7vwsx61u7l.fsf@assigned-by-dhcp.cox.net>
Cc: Brian Downing <bdowning@lavos.net>, Nicolas Pitre <nico@cam.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 05:10:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8p4P-0005BT-QV
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 05:10:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933915AbXGLDJt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 23:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934538AbXGLDJr
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 23:09:47 -0400
Received: from 74-134-246-243.dhcp.insightbb.com ([74.134.246.243]:55985 "EHLO
	silvara" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964809AbXGLDJp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 23:09:45 -0400
X-Greylist: delayed 440 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Jul 2007 23:09:45 EDT
Received: by silvara (Postfix, from userid 1000)
	id DA3FA52135; Wed, 11 Jul 2007 22:02:25 -0500 (CDT)
X-Mailer: git-send-email 1.5.2.GIT
In-Reply-To: <7vwsx61u7l.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52235>

This tool will print vaguely pretty information about a pack.  It
expects the output of "git-verify-pack -v" as input on stdin.

$ git-verify-pack -v | packinfo.pl

See the documentation in the script (contrib/stats/packinfo.pl)
for more information.

Signed-off-by: Brian Downing <bdowning@lavos.net>
---
   I've been fighting with the mail configuraton on my laptop so that 
   "git send-email" can send email that vger will accept.  My apologies 
   if anybody got dupes or mangled messages.

 contrib/stats/packinfo.pl |  212 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 212 insertions(+), 0 deletions(-)
 create mode 100755 contrib/stats/packinfo.pl

diff --git a/contrib/stats/packinfo.pl b/contrib/stats/packinfo.pl
new file mode 100755
index 0000000..792673a
--- /dev/null
+++ b/contrib/stats/packinfo.pl
@@ -0,0 +1,212 @@
+#!/bin/perl
+#
+# This tool will print vaguely pretty information about a pack.  It
+# expects the output of "git-verify-pack -v" as input on stdin.
+#
+# $ git-verify-pack -v | packinfo.pl
+#
+# This prints some full-pack statistics; currently "all sizes", "all
+# path sizes", "tree sizes", "tree path sizes", and "depths".
+#
+# * "all sizes" stats are across every object size in the file;
+#   full sizes for base objects, and delta size for deltas.
+# * "all path sizes" stats are across all object's "path sizes".
+#   A path size is the sum of the size of the delta chain, including the
+#   base object.  In other words, it's how many bytes need be read to
+#   reassemble the file from deltas.
+# * "tree sizes" are object sizes grouped into delta trees.
+# * "tree path sizes" are path sizes grouped into delta trees.
+# * "depths" should be obvious.
+#
+# When run as:
+#
+# $ git-verify-pack -v | packinfo.pl -tree
+#
+# the trees of objects are output along with the stats.  This looks
+# like:
+#
+#   0 commit 031321c6...      803      803
+#
+#   0   blob 03156f21...     1767     1767
+#   1    blob f52a9d7f...       10     1777
+#   2     blob a8cc5739...       51     1828
+#   3      blob 660e90b1...       15     1843
+#   4       blob 0cb8e3bb...       33     1876
+#   2     blob e48607f0...      311     2088
+#      size: count 6 total 2187 min 10 max 1767 mean 364.50 median 51 std_dev 635.85
+# path size: count 6 total 11179 min 1767 max 2088 mean 1863.17 median 1843 std_dev 107.26
+#
+# The first number after the sha1 is the object size, the second
+# number is the path size.  The statistics are across all objects in
+# the previous delta tree.  Obviously they are omitted for trees of
+# one object.
+#
+# When run as:
+#
+# $ git-verify-pack -v | packinfo.pl -tree -filenames
+#
+# it adds filenames to the tree.  Getting this information is slow:
+#
+#   0   blob 03156f21...     1767     1767 Documentation/git-lost-found.txt @ tags/v1.2.0~142
+#   1    blob f52a9d7f...       10     1777 Documentation/git-lost-found.txt @ tags/v1.5.0-rc1~74
+#   2     blob a8cc5739...       51     1828 Documentation/git-lost+found.txt @ tags/v0.99.9h^0
+#   3      blob 660e90b1...       15     1843 Documentation/git-lost+found.txt @ master~3222^2~2
+#   4       blob 0cb8e3bb...       33     1876 Documentation/git-lost+found.txt @ master~3222^2~3
+#   2     blob e48607f0...      311     2088 Documentation/git-lost-found.txt @ tags/v1.5.2-rc3~4
+#      size: count 6 total 2187 min 10 max 1767 mean 364.50 median 51 std_dev 635.85
+# path size: count 6 total 11179 min 1767 max 2088 mean 1863.17 median 1843 std_dev 107.26
+#
+# When run as:
+#
+# $ git-verify-pack -v | packinfo.pl -dump
+#
+# it prints out "sha1 size pathsize depth" for each sha1 in lexical
+# order.
+#
+# 000079a2eaef17b7eae70e1f0f635557ea67b644 30 472 7
+# 00013cafe6980411aa6fdd940784917b5ff50f0a 44 1542 4
+# 000182eacf99cde27d5916aa415921924b82972c 499 499 0
+# ...
+#
+# This is handy for comparing two packs.  Adding "-filenames" will add
+# filenames, as per "-tree -filenames" above.
+
+use strict;
+use Getopt::Long;
+
+my $filenames = 0;
+my $tree = 0;
+my $dump = 0;
+GetOptions("tree" => \$tree,
+           "filenames" => \$filenames,
+           "dump" => \$dump);
+
+my %parents;
+my %children;
+my %sizes;
+my @roots;
+my %paths;
+my %types;
+my @commits;
+my %names;
+my %depths;
+my @depths;
+
+while (<STDIN>) {
+    my ($sha1, $type, $size, $offset, $depth, $parent) = split(/\s+/, $_);
+    next unless ($sha1 =~ /^[0-9a-f]{40}$/);
+    $depths{$sha1} = $depth || 0;
+    push(@depths, $depth || 0);
+    push(@commits, $sha1) if ($type eq 'commit');
+    push(@roots, $sha1) unless $parent;
+    $parents{$sha1} = $parent;
+    $types{$sha1} = $type;
+    push(@{$children{$parent}}, $sha1);
+    $sizes{$sha1} = $size;
+}
+
+if ($filenames && ($tree || $dump)) {
+    open(NAMES, "git-name-rev --all|");
+    while (<NAMES>) {
+        if (/^(\S+)\s+(.*)$/) {
+            my ($sha1, $name) = ($1, $2);
+            $names{$sha1} = $name;
+        }
+    }
+    close NAMES;
+
+    for my $commit (@commits) {
+        my $name = $names{$commit};
+        open(TREE, "git-ls-tree -t -r $commit|");
+        print STDERR "Plumbing tree $name\n";
+        while (<TREE>) {
+            if (/^(\S+)\s+(\S+)\s+(\S+)\s+(.*)$/) {
+                my ($mode, $type, $sha1, $path) = ($1, $2, $3, $4);
+                $paths{$sha1} = "$path @ $name";
+            }
+        }
+        close TREE;
+    }
+}
+
+sub stats {
+    my @data = sort {$a <=> $b} @_;
+    my $min = $data[0];
+    my $max = $data[$#data];
+    my $total = 0;
+    my $count = scalar @data;
+    for my $datum (@data) {
+        $total += $datum;
+    }
+    my $mean = $total / $count;
+    my $median = $data[int(@data / 2)];
+    my $diff_sum = 0;
+    for my $datum (@data) {
+        $diff_sum += ($datum - $mean)**2;
+    }
+    my $std_dev = sqrt($diff_sum / $count);
+    return ($count, $total, $min, $max, $mean, $median, $std_dev);
+}
+
+sub print_stats {
+    my $name = shift;
+    my ($count, $total, $min, $max, $mean, $median, $std_dev) = stats(@_);
+    printf("%s: count %s total %s min %s max %s mean %.2f median %s std_dev %.2f\n",
+           $name, $count, $total, $min, $max, $mean, $median, $std_dev);
+}
+
+my @sizes;
+my @path_sizes;
+my @all_sizes;
+my @all_path_sizes;
+my %path_sizes;
+
+sub dig {
+    my ($sha1, $depth, $path_size) = @_;
+    $path_size += $sizes{$sha1};
+    push(@sizes, $sizes{$sha1});
+    push(@all_sizes, $sizes{$sha1});
+    push(@path_sizes, $path_size);
+    push(@all_path_sizes, $path_size);
+    $path_sizes{$sha1} = $path_size;
+    if ($tree) {
+        printf("%3d%s %6s %s %8d %8d %s\n",
+               $depth, (" " x $depth), $types{$sha1},
+               $sha1, $sizes{$sha1}, $path_size, $paths{$sha1});
+    }
+    for my $child (@{$children{$sha1}}) {
+        dig($child, $depth + 1, $path_size);
+    }
+}
+
+my @tree_sizes;
+my @tree_path_sizes;
+
+for my $root (@roots) {
+    undef @sizes;
+    undef @path_sizes;
+    dig($root, 0, 0);
+    my ($aa, $sz_total) = stats(@sizes);
+    my ($bb, $psz_total) = stats(@path_sizes);
+    push(@tree_sizes, $sz_total);
+    push(@tree_path_sizes, $psz_total);
+    if ($tree) {
+        if (@sizes > 1) {
+            print_stats("     size", @sizes);
+            print_stats("path size", @path_sizes);
+        }
+        print "\n";
+    }
+}
+
+if ($dump) {
+    for my $sha1 (sort keys %sizes) {
+        print "$sha1 $sizes{$sha1} $path_sizes{$sha1} $depths{$sha1} $paths{$sha1}\n";
+    }
+} else {
+    print_stats("      all sizes", @all_sizes);
+    print_stats(" all path sizes", @all_path_sizes);
+    print_stats("     tree sizes", @tree_sizes);
+    print_stats("tree path sizes", @tree_path_sizes);
+    print_stats("         depths", @depths);
+}
-- 
1.5.2.GIT
