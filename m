From: Sam Vilain <sam@vilain.net>
Subject: [BRAINFART PATCH] git-svn: support SVN 1.5+ merge attributes
Date: Wed, 28 May 2008 21:00:59 +1200
Message-ID: <483D1F4B.3060701@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>,
	Git Mailing List <git@vger.kernel.org>
To: Alexey Morozov <morozov_ml@ngs.ru>
X-From: git-owner@vger.kernel.org Wed May 28 11:21:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1Hq6-0002rt-GD
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 11:20:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766AbYE1JUG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 05:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751722AbYE1JUG
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 05:20:06 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:47510 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751414AbYE1JUE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 05:20:04 -0400
X-Greylist: delayed 1130 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 May 2008 05:20:04 EDT
Received: by mail.utsl.gen.nz (Postfix, from userid 1003)
	id CE56FFC038; Wed, 28 May 2008 21:01:12 +1200 (NZST)
FCC: imap://sam@mail.utsl.gen.nz/INBOX/Sent
X-Identity-Key: id1
X-Mozilla-Draft-Info: internal/draft; vcard=0; receipt=0; uuencode=0
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83084>

Alexey,

I had a look at how svnmerge.py merge tickets / SVN 1.5+ merge tickets
might be supported in current git-svn.  I think something along these
lines might work, but it needs completion - much of the code there is
psuedocode.  It doesn't address the issue of pushing git-land merges
back to SVN, but I think this is also a sorely missing feature, as it
could mean people could start pushing their nice git merges back to
SVN.

Subject: [PATCH] git-svn: sketch out support for SVN 1.5+ merge properties

They may not exist in the wild much yet, but it is probably about time
git-svn supported SVN 1.5+ merge tickets.  Sketch out where they might
go, for discussion's sake only.

Signed-off-but-disowned-by: Sam Vilain <sam@vilain.net>
---
 git-svn.perl |   45 +++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 37976f2..acd9784 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1907,11 +1907,12 @@ sub prop_walk {
 	foreach (keys %{$props}) {
 		# If it doesn't start with `svn:', it must be a
 		# user-defined property.
-		++$interesting_props and next if $_ !~ /^svn:/;
+		++$interesting_props and next if $_ !~ /^(svn:|svk:merge)/;
 		# FIXME: Fragile, if SVN adds new public properties,
 		# this needs to be updated.
 		++$interesting_props if /^svn:(?:ignore|keywords|executable
 		                                 |eol-style|mime-type
+						 |mergeinfo
 						 |externals|needs-lock)$/x;
 	}
 	&$sub($self, $p, $props) if $interesting_props;
@@ -2353,7 +2354,9 @@ sub get_untracked {
 		foreach my $path (sort keys %$h) {
 			my $ppath = $path eq '' ? '.' : $path;
 			foreach my $prop (sort keys %{$h->{$path}}) {
-				next if $SKIP_PROP{$prop};
+				next if $SKIP_PROP{$prop}
+					or ($t eq "dir_prop" and !$path
+					    and $prop eq "svn:mergeinfo");
 				my $v = $h->{$path}->{$prop};
 				my $t_ppath_prop = "$t: " .
 				                    uri_encode($ppath) . ' ' .
@@ -2403,6 +2406,44 @@ sub make_log_entry {
 	my ($self, $rev, $parents, $ed) = @_;
 	my $untracked = $self->get_untracked($ed);
 
+	if ( my $mergeinfo = $ed->{dir_prop}{""}{"svn:mergeinfo"} ) {
+		my %mergeinfo = map { m{^([^:]*):\s*([\d,\-]+)} }
+			split "\n", $mergeinfo;
+
+		# check if any new line introduces a new complete merge
+		foreach my $path ( sort keys %mergeinfo ) {
+			my @merged = split ",", $mergeinfo{$path};
+
+			my @untracked;
+			for my $merge ( @merged ) {
+				my ($first, $last) = ($merge =~ m{\d+(-\d+)?$});
+				$last ||= $first;
+
+				# this function doesn't exist yet
+				my $svn_rev = $self->find_rev_on_path($path, $rev);
+				# it is a complete new cross-merge if;
+
+				#  a) the first revision specified is NOT in
+				#  the history of the commit we are making
+				my @commits = `git rev-list -1 $svn_rev --not @$parents`;
+				next if @commits;
+
+				#  b) the parents of that revision are also in
+				#  our history.
+				@commits = `git rev-list -1 $svn_rev^ --not @$parents`;
+				if ( @commits ) {
+					push @untracked, $merge;
+					next;
+				}
+
+				# ok - go ahead and make it a parent
+				push @$parents, $svn_rev;
+			}
+			push @$untracked, "svn:mergeinfo ticket for $path: "
+				.join(",", @untracked);
+		}
+	}
+
 	open my $un, '>>', "$self->{dir}/unhandled.log" or croak $!;
 	print $un "r$rev\n" or croak $!;
 	print $un $_, "\n" foreach @$untracked;
-- 
1.5.4.rc2.85.g7c8f5
