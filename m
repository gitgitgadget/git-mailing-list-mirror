From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: [PATCHv2 1/5] Add a generic tree traversal to fetch SVN properties.
Date: Tue, 16 Oct 2007 16:36:48 +0200
Message-ID: <1192545412-10929-1-git-send-email-tsuna@lrde.epita.fr>
Cc: normalperson@yhbt.net, Benoit Sigoure <tsuna@lrde.epita.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 16 16:38:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhnZ2-0006fy-Cq
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 16:38:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932863AbXJPOhq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 10:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754137AbXJPOhp
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 10:37:45 -0400
Received: from 1.139.39-62.rev.gaoland.net ([62.39.139.1]:56268 "EHLO
	tsunaxbook.lrde.epita.fr" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1759311AbXJPOha (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Oct 2007 10:37:30 -0400
Received: by tsunaxbook.lrde.epita.fr (Postfix, from userid 501)
	id C33F7B93466; Tue, 16 Oct 2007 16:36:52 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.4.214.g6f43
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61183>

	* git-svn.perl (&traverse_ignore): Remove.
	(&prop_walk): New.
	(&cmd_show_ignore): Use prop_walk.

Signed-off-by: Benoit Sigoure <tsuna@lrde.epita.fr>
---
 git-svn.perl |   65 ++++++++++++++++++++++++++++++++++++++++-----------------
 1 files changed, 45 insertions(+), 20 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 777e436..95393b6 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -488,7 +488,15 @@ sub cmd_show_ignore {
 	my ($url, $rev, $uuid, $gs) = working_head_info('HEAD');
 	$gs ||= Git::SVN->new;
 	my $r = (defined $_revision ? $_revision : $gs->ra->get_latest_revnum);
-	$gs->traverse_ignore(\*STDOUT, $gs->{path}, $r);
+	$gs->prop_walk($gs->{path}, $r, sub {
+		my ($gs, $path, $props) = @_;
+		print STDOUT "\n# $path\n";
+		my $s = $props->{'svn:ignore'} or return;
+		$s =~ s/[\r\n]+/\n/g;
+		chomp $s;
+		$s =~ s#^#$path#gm;
+		print STDOUT "$s\n";
+	});
 }
 
 sub cmd_multi_init {
@@ -1480,28 +1488,45 @@ sub rel_path {
 	$url;
 }
 
-sub traverse_ignore {
-	my ($self, $fh, $path, $r) = @_;
-	$path =~ s#^/+##g;
-	my $ra = $self->ra;
-	my ($dirent, undef, $props) = $ra->get_dir($path, $r);
+# prop_walk(PATH, REV, SUB)
+# -------------------------
+# Recursively traverse PATH at revision REV and invoke SUB for each
+# directory that contains a SVN property.  SUB will be invoked as
+# follows:  &SUB(gs, path, props);  where `gs' is this instance of
+# Git::SVN, `path' the path to the directory where the properties
+# `props' were found.  The `path' will be relative to point of checkout,
+# that is, if url://repo/trunk is the current Git branch, and that
+# directory contains a sub-directory `d', SUB will be invoked with `/d/'
+# as `path' (note the trailing `/').
+sub prop_walk {
+	my ($self, $path, $rev, $sub) = @_;
+
+	my ($dirent, undef, $props) = $self->ra->get_dir($path, $rev);
+	$path =~ s#^/*#/#g;
 	my $p = $path;
-	$p =~ s#^\Q$self->{path}\E(/|$)##;
-	print $fh length $p ? "\n# $p\n" : "\n# /\n";
-	if (my $s = $props->{'svn:ignore'}) {
-		$s =~ s/[\r\n]+/\n/g;
-		chomp $s;
-		if (length $p == 0) {
-			$s =~ s#\n#\n/$p#g;
-			print $fh "/$s\n";
-		} else {
-			$s =~ s#\n#\n/$p/#g;
-			print $fh "/$p/$s\n";
-		}
-	}
+	# Strip the irrelevant part of the path.
+	$p =~ s#^/+\Q$self->{path}\E(/|$)#/#;
+	# Ensure the path is terminated by a `/'.
+	$p =~ s#/*$#/#;
+
+	# The properties contain all the internal SVN stuff nobody
+	# (usually) cares about.
+	my $interesting_props = 0;
+	foreach (keys %{$props}) {
+		# If it doesn't start with `svn:', it must be a
+		# user-defined property.
+		++$interesting_props and next if $_ !~ /^svn:/;
+		# FIXME: Fragile, if SVN adds new public properties,
+		# this needs to be updated.
+		++$interesting_props if /^svn:(?:ignore|keywords|executable
+		                                 |eol-style|mime-type
+						 |externals|needs-lock)$/x;
+	}
+	&$sub($self, $p, $props) if $interesting_props;
+
 	foreach (sort keys %$dirent) {
 		next if $dirent->{$_}->{kind} != $SVN::Node::dir;
-		$self->traverse_ignore($fh, "$path/$_", $r);
+		$self->prop_walk($path . '/' . $_, $rev, $sub);
 	}
 }
 
-- 
1.5.3.4.214.g6f43
