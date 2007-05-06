From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/6] gitweb: Add combined diff support to git_difftree_body
Date: Mon,  7 May 2007 01:10:04 +0200
Message-ID: <11784930112401-git-send-email-jnareb@gmail.com>
References: <11784930091585-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 07 01:05:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hkpnf-00082c-AL
	for gcvg-git@gmane.org; Mon, 07 May 2007 01:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751943AbXEFXFu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 19:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751975AbXEFXFu
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 19:05:50 -0400
Received: from nz-out-0506.google.com ([64.233.162.235]:18946 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943AbXEFXFr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 19:05:47 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1374488nzf
        for <git@vger.kernel.org>; Sun, 06 May 2007 16:05:47 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HiY4MgnGHcu/pUbWNwSXjgfqEUdAM8ARYu3svQMUDTHb7DSp6kLTJc2ZHaoqrKUI7wPiJ0oF/hv7aourL63Ki4WSl7/cBSJP3UM6CjDxSu4m4PGkf22NU2/cbp0QANoUUVajwtWl8jzhTraSix3S+6ALZ8DyOYnSP//zfDrE0+A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rFszco/QT13gSoTiPwUwqwI1dPiMydUov68PbhFCBnAoC1MODvC2PxwyiuwbaD7ZZTv6jznU5uJYnnunkC6GcXxJPzJ84iwpyqXw3CG/uadXW/XYW66WyVKe+J4rRWy+qBbqLbH9BYrtR7WsbhYzE3CMeFTZARyDw5q+T0SkhnA=
Received: by 10.65.81.10 with SMTP id i10mr900089qbl.1178492746849;
        Sun, 06 May 2007 16:05:46 -0700 (PDT)
Received: from roke.D-201 ( [89.229.25.173])
        by mx.google.com with ESMTP id f15sm4773173qba.2007.05.06.16.05.44;
        Sun, 06 May 2007 16:05:45 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l46NACKi015912;
	Mon, 7 May 2007 01:10:12 +0200
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l46NAB4V015911;
	Mon, 7 May 2007 01:10:11 +0200
X-Mailer: git-send-email 1.5.1.3
In-Reply-To: <11784930091585-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46387>

You have to pass all parents as final parameters of git_difftree_body
subroutine; the number of parents of a diff must be equal to the
number derived from parsing git-diff-tree output, raw combined diff
for git_difftree_body to display combined diff correctly (but it is
not checked).

Currently the possibility of displaying diffree of combined diff is
not used in gitweb code; git_difftree_body is always caled for
ordinary diff, and with only one parent.


Description of output for combined diff:
----------------------------------------

The difftree table for combined diff starts with a cell with pathname
of changed blob (changed file), which if possible is hidden link
(class="list") to the 'blob' view of final version (if it exists),
like for difftree for ordinary diff. If file was deleted in the final
commit then filename is not hyperlinked.

There is no cell with single file status (new, deleted, mode change,
rename), as for combined diff as there is no single status: different
parents might have different status.

If git_difftree_body was called from git_commitdiff (for 'commitdiff'
action) there is inner link to anchor to appropriate fragment (patch)
in patchset body; the "patch" link does not replace "diff" link like
for ordinary diff.

Each of "diff" links is in separate cell, contrary to output for
ordinary diff in which all links are (at least for now) in a single
cell.

For each parent, if file was not present we leave cell empty. If file
was deleted in the result, we provide link to 'blob' view. Otherwise
we provide link to 'commitdiff' view, even if patch (diff) consist
only of extended diff header, and contents is not changed (pure
rename, pure mode change). The only difference is that link to
"blobdiff" view with no contents change is with 'nochange' class.

At last, there is provided link to current version of file as "blob"
link, if the file was not deleted in the result, and lik to history of
a file, if there exists one. (The link to file history might be
confused, at least for now, by renames.)

Note that git-diff-tree raw output dor combined diff does not provide
filename before change for renames and copies; we use
git_get_path_by_hash to get "src" filename for renames (this means
additional call to git-ls-tree for a _whole_ tree).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Currently the work to find filename _before_ rename for renames (and
copies) in combined diff is done during difftree generation (link
generation). It is possible to change it to have this calculation done
on link target, in 'blobdiff' and 'blob' views which lack 'fp' or 'f'
parameter, and have 'hpb' and 'hp' or 'hb' and 'h' parameters needed
to find path by hash. Nevertheless renames in combined diff format are
rare I think, and non-empty combined diff for merge commit
(non-trivial merge result) is also usually rare.

[The above paragraph should perhaps be added to commit message, but is
quite long even without it.]


This is preliminary version: difftree output for combined diff is a
bit crude, and does not display all the information (mode changes,
renames, etc.). Nevertheless I think it is a good start.

CSS styling is a bit crude.

Patches (or corrections) and ideas how should HTML output of difftree
(whatchanged-like output) for combined diff look like are very
welcome.

 gitweb/gitweb.css  |   17 +++++++
 gitweb/gitweb.perl |  121 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 136 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 2b023bd..e795b70 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -181,6 +181,23 @@ table.diff_tree {
 	font-family: monospace;
 }
 
+table.combined.diff_tree td {
+	padding-right: 24px;
+}
+
+table.combined.diff_tree td.link {
+	padding: 0px 2px;
+}
+
+table.combined.diff_tree td.nochange a {
+	color: #6666ff;
+}
+
+table.combined.diff_tree td.nochange a:hover,
+table.combined.diff_tree td.nochange a:visited {
+	color: #d06666;
+}
+
 table.blame {
 	border-collapse: collapse;
 }
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index dfba399..c6a2fef 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1015,6 +1015,30 @@ sub git_get_hash_by_path {
 	return $3;
 }
 
+# get path of entry with given hash at given tree-ish (ref)
+# used to get 'from' filename for combined diff (merge commit) for renames
+sub git_get_path_by_hash {
+	my $base = shift || return;
+	my $hash = shift || return;
+
+	local $/ = "\0";
+
+	open my $fd, "-|", git_cmd(), "ls-tree", '-r', '-t', '-z', $base
+		or return undef;
+	while (my $line = <$fd>) {
+		chomp $line;
+
+		#'040000 tree 595596a6a9117ddba9fe379b6b012b558bac8423	gitweb'
+		#'100644 blob e02e90f0429be0d2a69b76571101f20b8f75530f	gitweb/README'
+		if ($line =~ m/(?:[0-9]+) (?:.+) $hash\t(.+)$/) {
+			close $fd;
+			return $1;
+		}
+	}
+	close $fd;
+	return undef;
+}
+
 ## ......................................................................
 ## git utility functions, directly accessing git repository
 
@@ -2210,7 +2234,8 @@ sub git_print_tree_entry {
 ## functions printing large fragments of HTML
 
 sub git_difftree_body {
-	my ($difftree, $hash, $parent) = @_;
+	my ($difftree, $hash, @parents) = @_;
+	my ($parent) = $parents[0];
 	my ($have_blame) = gitweb_check_feature('blame');
 	print "<div class=\"list_head\">\n";
 	if ($#{$difftree} > 10) {
@@ -2218,7 +2243,9 @@ sub git_difftree_body {
 	}
 	print "</div>\n";
 
-	print "<table class=\"diff_tree\">\n";
+	print "<table class=\"" .
+	      (@parents > 1 ? "combined " : "") .
+	      "diff_tree\">\n";
 	my $alternate = 1;
 	my $patchno = 0;
 	foreach my $line (@{$difftree}) {
@@ -2231,6 +2258,96 @@ sub git_difftree_body {
 		}
 		$alternate ^= 1;
 
+		if (exists $diff{'nparents'}) { # combined diff
+
+			if ($diff{'to_id'} ne ('0' x 40)) {
+				# file exists in the result (child) commit
+				print "<td>" .
+				      $cgi->a({-href => href(action=>"blob", hash=>$diff{'to_id'},
+				                             file_name=>$diff{'to_file'},
+				                             hash_base=>$hash),
+				              -class => "list"}, esc_path($diff{'to_file'})) .
+				      "</td>\n";
+			} else {
+				print "<td>" .
+				      esc_path($diff{'to_file'}) .
+				      "</td>\n";
+			}
+
+			if ($action eq 'commitdiff') {
+				# link to patch
+				$patchno++;
+				print "<td class=\"link\">" .
+				      $cgi->a({-href => "#patch$patchno"}, "patch") .
+				      " | " .
+				      "</td>\n";
+			}
+
+			my $has_history = 0;
+			my $not_deleted = 0;
+			for (my $i = 0; $i < $diff{'nparents'}; $i++) {
+				my $hash_parent = $parents[$i];
+				my $from_hash = $diff{'from_id'}[$i];
+				my $from_path = undef;
+				my $status = $diff{'status'}[$i];
+
+				$has_history ||= ($status ne 'A');
+				$not_deleted ||= ($status ne 'D');
+
+				if ($status eq 'R' || $status eq 'C') {
+					$from_path = git_get_path_by_hash($hash_parent, $from_hash);
+				}
+
+				if ($status eq 'A') {
+					print "<td  class=\"link\" align=\"right\"> | </td>\n";
+				} elsif ($status eq 'D') {
+					print "<td class=\"link\">" .
+					      $cgi->a({-href => href(action=>"blob",
+					                             hash_base=>$hash,
+					                             hash=>$from_hash,
+					                             file_name=>$from_path)},
+					              "blob" . ($i+1)) .
+					      " | </td>\n";
+				} else {
+					if ($diff{'to_id'} eq $from_hash) {
+						print "<td class=\"link nochange\">";
+					} else {
+						print "<td class=\"link\">";
+					}
+					print $cgi->a({-href => href(action=>"blobdiff",
+					                             hash=>$diff{'to_id'},
+					                             hash_parent=>$from_hash,
+					                             hash_base=>$hash,
+					                             hash_parent_base=>$hash_parent,
+					                             file_name=>$diff{'to_file'},
+					                             file_parent=>$from_path)},
+					              "diff" . ($i+1)) .
+					      " | </td>\n";
+				}
+			}
+
+			print "<td class=\"link\">";
+			if ($not_deleted) {
+				print $cgi->a({-href => href(action=>"blob",
+				                             hash=>$diff{'to_id'},
+				                             file_name=>$diff{'to_file'},
+				                             hash_base=>$hash)},
+				              "blob");
+				print " | " if ($has_history);
+			}
+			if ($has_history) {
+				print $cgi->a({-href => href(action=>"history",
+				                             file_name=>$diff{'to_file'},
+				                             hash_base=>$hash)},
+				              "history");
+			}
+			print "</td>\n";
+
+			print "</tr>\n";
+			next; # instead of 'else' clause, to avoid extra indent
+		}
+		# else ordinary diff
+
 		my ($to_mode_oct, $to_mode_str, $to_file_type);
 		my ($from_mode_oct, $from_mode_str, $from_file_type);
 		if ($diff{'to_mode'} ne ('0' x 6)) {
-- 
1.5.1.3
