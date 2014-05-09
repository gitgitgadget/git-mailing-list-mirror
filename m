From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 07/17] contrib: remove 'stats'
Date: Fri,  9 May 2014 14:11:33 -0500
Message-ID: <1399662703-355-8-git-send-email-felipe.contreras@gmail.com>
References: <1399662703-355-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 21:12:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiqDa-0001Gh-Uo
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 21:12:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757157AbaEITMT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 15:12:19 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:64144 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756837AbaEITMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 15:12:16 -0400
Received: by mail-yk0-f169.google.com with SMTP id 200so3885944ykr.28
        for <git@vger.kernel.org>; Fri, 09 May 2014 12:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ew+GFBopcnwKlwpFRZ/VJ15DNzycwQkJq0wQoV28J/s=;
        b=mVEr/NjtWBdCouXHjEiDwFfb3/+aZBoCow4KpIF8RuIHgoSQJ5rmw7g14Z4tD/gTAT
         RJ/kDS5FoJ32OgGi5oDaQldsoS28NHT5+7pHvAAGb6NByjWl7D6yI2v6UczTFwgRIHSh
         wt1dkbJgsQeECqPoRl9uXI3retcSC2hxkw8r/OhPna24OWVfHJ5kV6gf4Jdi/zRa70g4
         xHcnRXAEGqL21uNYa5NC1DezjEkGc/Sp3stxoB6JMaFqjMEe+7A/fNgesb/CuDAUXlvh
         NVz+EpyWFU5UksoqzT8RQ/Uq6qm5gDNSO3jA/DRilxJZ84bibn0S1lLMFeiPZIGoE0A6
         oc3g==
X-Received: by 10.236.112.37 with SMTP id x25mr17998588yhg.26.1399662736235;
        Fri, 09 May 2014 12:12:16 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id a104sm7423638yhq.5.2014.05.09.12.12.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 May 2014 12:12:15 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.28.g12374c0
In-Reply-To: <1399662703-355-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248618>

No real activity since 2012 (or ever), no tests, no documentation.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/stats/git-common-hash |  26 ------
 contrib/stats/mailmap.pl      |  70 --------------
 contrib/stats/packinfo.pl     | 212 ------------------------------------------
 3 files changed, 308 deletions(-)
 delete mode 100755 contrib/stats/git-common-hash
 delete mode 100755 contrib/stats/mailmap.pl
 delete mode 100755 contrib/stats/packinfo.pl

diff --git a/contrib/stats/git-common-hash b/contrib/stats/git-common-hash
deleted file mode 100755
index e27fd08..0000000
--- a/contrib/stats/git-common-hash
+++ /dev/null
@@ -1,26 +0,0 @@
-#!/bin/sh
-
-# This script displays the distribution of longest common hash prefixes.
-# This can be used to determine the minimum prefix length to use
-# for object names to be unique.
-
-git rev-list --objects --all | sort | perl -lne '
-  substr($_, 40) = "";
-  # uncomment next line for a distribution of bits instead of hex chars
-  # $_ = unpack("B*",pack("H*",$_));
-  if (defined $p) {
-    ($p ^ $_) =~ /^(\0*)/;
-    $common = length $1;
-    if (defined $pcommon) {
-      $count[$pcommon > $common ? $pcommon : $common]++;
-    } else {
-      $count[$common]++; # first item
-    }
-  }
-  $p = $_;
-  $pcommon = $common;
-  END {
-    $count[$common]++; # last item
-    print "$_: $count[$_]" for 0..$#count;
-  }
-'
diff --git a/contrib/stats/mailmap.pl b/contrib/stats/mailmap.pl
deleted file mode 100755
index 9513f5e..0000000
--- a/contrib/stats/mailmap.pl
+++ /dev/null
@@ -1,70 +0,0 @@
-#!/usr/bin/perl
-
-use warnings 'all';
-use strict;
-use Getopt::Long;
-
-my $match_emails;
-my $match_names;
-my $order_by = 'count';
-Getopt::Long::Configure(qw(bundling));
-GetOptions(
-	'emails|e!' => \$match_emails,
-	'names|n!'  => \$match_names,
-	'count|c'   => sub { $order_by = 'count' },
-	'time|t'    => sub { $order_by = 'stamp' },
-) or exit 1;
-$match_emails = 1 unless $match_names;
-
-my $email = {};
-my $name = {};
-
-open(my $fh, '-|', "git log --format='%at <%aE> %aN'");
-while(<$fh>) {
-	my ($t, $e, $n) = /(\S+) <(\S+)> (.*)/;
-	mark($email, $e, $n, $t);
-	mark($name, $n, $e, $t);
-}
-close($fh);
-
-if ($match_emails) {
-	foreach my $e (dups($email)) {
-		foreach my $n (vals($email->{$e})) {
-			show($n, $e, $email->{$e}->{$n});
-		}
-		print "\n";
-	}
-}
-if ($match_names) {
-	foreach my $n (dups($name)) {
-		foreach my $e (vals($name->{$n})) {
-			show($n, $e, $name->{$n}->{$e});
-		}
-		print "\n";
-	}
-}
-exit 0;
-
-sub mark {
-	my ($h, $k, $v, $t) = @_;
-	my $e = $h->{$k}->{$v} ||= { count => 0, stamp => 0 };
-	$e->{count}++;
-	$e->{stamp} = $t unless $t < $e->{stamp};
-}
-
-sub dups {
-	my $h = shift;
-	return grep { keys($h->{$_}) > 1 } keys($h);
-}
-
-sub vals {
-	my $h = shift;
-	return sort {
-		$h->{$b}->{$order_by} <=> $h->{$a}->{$order_by}
-	} keys($h);
-}
-
-sub show {
-	my ($n, $e, $h) = @_;
-	print "$n <$e> ($h->{$order_by})\n";
-}
diff --git a/contrib/stats/packinfo.pl b/contrib/stats/packinfo.pl
deleted file mode 100755
index be188c0..0000000
--- a/contrib/stats/packinfo.pl
+++ /dev/null
@@ -1,212 +0,0 @@
-#!/usr/bin/perl
-#
-# This tool will print vaguely pretty information about a pack.  It
-# expects the output of "git verify-pack -v" as input on stdin.
-#
-# $ git verify-pack -v | packinfo.pl
-#
-# This prints some full-pack statistics; currently "all sizes", "all
-# path sizes", "tree sizes", "tree path sizes", and "depths".
-#
-# * "all sizes" stats are across every object size in the file;
-#   full sizes for base objects, and delta size for deltas.
-# * "all path sizes" stats are across all object's "path sizes".
-#   A path size is the sum of the size of the delta chain, including the
-#   base object.  In other words, it's how many bytes need be read to
-#   reassemble the file from deltas.
-# * "tree sizes" are object sizes grouped into delta trees.
-# * "tree path sizes" are path sizes grouped into delta trees.
-# * "depths" should be obvious.
-#
-# When run as:
-#
-# $ git verify-pack -v | packinfo.pl -tree
-#
-# the trees of objects are output along with the stats.  This looks
-# like:
-#
-#   0 commit 031321c6...      803      803
-#
-#   0   blob 03156f21...     1767     1767
-#   1    blob f52a9d7f...       10     1777
-#   2     blob a8cc5739...       51     1828
-#   3      blob 660e90b1...       15     1843
-#   4       blob 0cb8e3bb...       33     1876
-#   2     blob e48607f0...      311     2088
-#      size: count 6 total 2187 min 10 max 1767 mean 364.50 median 51 std_dev 635.85
-# path size: count 6 total 11179 min 1767 max 2088 mean 1863.17 median 1843 std_dev 107.26
-#
-# The first number after the sha1 is the object size, the second
-# number is the path size.  The statistics are across all objects in
-# the previous delta tree.  Obviously they are omitted for trees of
-# one object.
-#
-# When run as:
-#
-# $ git verify-pack -v | packinfo.pl -tree -filenames
-#
-# it adds filenames to the tree.  Getting this information is slow:
-#
-#   0   blob 03156f21...     1767     1767 Documentation/git-lost-found.txt @ tags/v1.2.0~142
-#   1    blob f52a9d7f...       10     1777 Documentation/git-lost-found.txt @ tags/v1.5.0-rc1~74
-#   2     blob a8cc5739...       51     1828 Documentation/git-lost+found.txt @ tags/v0.99.9h^0
-#   3      blob 660e90b1...       15     1843 Documentation/git-lost+found.txt @ master~3222^2~2
-#   4       blob 0cb8e3bb...       33     1876 Documentation/git-lost+found.txt @ master~3222^2~3
-#   2     blob e48607f0...      311     2088 Documentation/git-lost-found.txt @ tags/v1.5.2-rc3~4
-#      size: count 6 total 2187 min 10 max 1767 mean 364.50 median 51 std_dev 635.85
-# path size: count 6 total 11179 min 1767 max 2088 mean 1863.17 median 1843 std_dev 107.26
-#
-# When run as:
-#
-# $ git verify-pack -v | packinfo.pl -dump
-#
-# it prints out "sha1 size pathsize depth" for each sha1 in lexical
-# order.
-#
-# 000079a2eaef17b7eae70e1f0f635557ea67b644 30 472 7
-# 00013cafe6980411aa6fdd940784917b5ff50f0a 44 1542 4
-# 000182eacf99cde27d5916aa415921924b82972c 499 499 0
-# ...
-#
-# This is handy for comparing two packs.  Adding "-filenames" will add
-# filenames, as per "-tree -filenames" above.
-
-use strict;
-use Getopt::Long;
-
-my $filenames = 0;
-my $tree = 0;
-my $dump = 0;
-GetOptions("tree" => \$tree,
-           "filenames" => \$filenames,
-           "dump" => \$dump);
-
-my %parents;
-my %children;
-my %sizes;
-my @roots;
-my %paths;
-my %types;
-my @commits;
-my %names;
-my %depths;
-my @depths;
-
-while (<STDIN>) {
-    my ($sha1, $type, $size, $space, $offset, $depth, $parent) = split(/\s+/, $_);
-    next unless ($sha1 =~ /^[0-9a-f]{40}$/);
-    $depths{$sha1} = $depth || 0;
-    push(@depths, $depth || 0);
-    push(@commits, $sha1) if ($type eq 'commit');
-    push(@roots, $sha1) unless $parent;
-    $parents{$sha1} = $parent;
-    $types{$sha1} = $type;
-    push(@{$children{$parent}}, $sha1);
-    $sizes{$sha1} = $size;
-}
-
-if ($filenames && ($tree || $dump)) {
-    open(NAMES, "git name-rev --all|");
-    while (<NAMES>) {
-        if (/^(\S+)\s+(.*)$/) {
-            my ($sha1, $name) = ($1, $2);
-            $names{$sha1} = $name;
-        }
-    }
-    close NAMES;
-
-    for my $commit (@commits) {
-        my $name = $names{$commit};
-        open(TREE, "git ls-tree -t -r $commit|");
-        print STDERR "Plumbing tree $name\n";
-        while (<TREE>) {
-            if (/^(\S+)\s+(\S+)\s+(\S+)\s+(.*)$/) {
-                my ($mode, $type, $sha1, $path) = ($1, $2, $3, $4);
-                $paths{$sha1} = "$path @ $name";
-            }
-        }
-        close TREE;
-    }
-}
-
-sub stats {
-    my @data = sort {$a <=> $b} @_;
-    my $min = $data[0];
-    my $max = $data[$#data];
-    my $total = 0;
-    my $count = scalar @data;
-    for my $datum (@data) {
-        $total += $datum;
-    }
-    my $mean = $total / $count;
-    my $median = $data[int(@data / 2)];
-    my $diff_sum = 0;
-    for my $datum (@data) {
-        $diff_sum += ($datum - $mean)**2;
-    }
-    my $std_dev = sqrt($diff_sum / $count);
-    return ($count, $total, $min, $max, $mean, $median, $std_dev);
-}
-
-sub print_stats {
-    my $name = shift;
-    my ($count, $total, $min, $max, $mean, $median, $std_dev) = stats(@_);
-    printf("%s: count %s total %s min %s max %s mean %.2f median %s std_dev %.2f\n",
-           $name, $count, $total, $min, $max, $mean, $median, $std_dev);
-}
-
-my @sizes;
-my @path_sizes;
-my @all_sizes;
-my @all_path_sizes;
-my %path_sizes;
-
-sub dig {
-    my ($sha1, $depth, $path_size) = @_;
-    $path_size += $sizes{$sha1};
-    push(@sizes, $sizes{$sha1});
-    push(@all_sizes, $sizes{$sha1});
-    push(@path_sizes, $path_size);
-    push(@all_path_sizes, $path_size);
-    $path_sizes{$sha1} = $path_size;
-    if ($tree) {
-        printf("%3d%s %6s %s %8d %8d %s\n",
-               $depth, (" " x $depth), $types{$sha1},
-               $sha1, $sizes{$sha1}, $path_size, $paths{$sha1});
-    }
-    for my $child (@{$children{$sha1}}) {
-        dig($child, $depth + 1, $path_size);
-    }
-}
-
-my @tree_sizes;
-my @tree_path_sizes;
-
-for my $root (@roots) {
-    undef @sizes;
-    undef @path_sizes;
-    dig($root, 0, 0);
-    my ($aa, $sz_total) = stats(@sizes);
-    my ($bb, $psz_total) = stats(@path_sizes);
-    push(@tree_sizes, $sz_total);
-    push(@tree_path_sizes, $psz_total);
-    if ($tree) {
-        if (@sizes > 1) {
-            print_stats("     size", @sizes);
-            print_stats("path size", @path_sizes);
-        }
-        print "\n";
-    }
-}
-
-if ($dump) {
-    for my $sha1 (sort keys %sizes) {
-        print "$sha1 $sizes{$sha1} $path_sizes{$sha1} $depths{$sha1} $paths{$sha1}\n";
-    }
-} else {
-    print_stats("      all sizes", @all_sizes);
-    print_stats(" all path sizes", @all_path_sizes);
-    print_stats("     tree sizes", @tree_sizes);
-    print_stats("tree path sizes", @tree_path_sizes);
-    print_stats("         depths", @depths);
-}
-- 
1.9.2+fc1.28.g12374c0
