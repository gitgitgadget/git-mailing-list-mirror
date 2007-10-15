From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: [PATCH 1/5] Add a generic tree traversal to fetch SVN properties.
Date: Mon, 15 Oct 2007 17:35:02 +0200
Message-ID: <1192462506-3783-1-git-send-email-tsuna@lrde.epita.fr>
Cc: normalperson@yhbt.net, Benoit Sigoure <tsuna@lrde.epita.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 16 16:37:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhnYE-0006VL-5u
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 16:37:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932670AbXJPOha (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 10:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbXJPOh3
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 10:37:29 -0400
Received: from 1.139.39-62.rev.gaoland.net ([62.39.139.1]:56255 "EHLO
	tsunaxbook.lrde.epita.fr" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1759122AbXJPOh2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Oct 2007 10:37:28 -0400
Received: by tsunaxbook.lrde.epita.fr (Postfix, from userid 501)
	id 006F0B411B3; Mon, 15 Oct 2007 17:35:06 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.4.214.g6f43
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61177>

	* git-svn.perl (&traverse_ignore): Remove.
	(&prop_walk): New.
	(&cmd_show_ignore): Use prop_walk.

Signed-off-by: Benoit Sigoure <tsuna@lrde.epita.fr>
---
 git-svn.perl |   66 ++++++++++++++++++++++++++++++++++++++++-----------------
 1 files changed, 46 insertions(+), 20 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 777e436..abc83ec 100755
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
@@ -1480,28 +1488,46 @@ sub rel_path {
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
+	foreach(keys %{$props})
+	{
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
