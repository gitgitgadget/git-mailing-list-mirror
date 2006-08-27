From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Use @diff_opts, default ('M'), as git-diff and git-diff-tree paramete
Date: Sun, 27 Aug 2006 23:49:36 +0200
Message-ID: <200608272349.36887.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Aug 27 23:49:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHSVc-0004rM-VN
	for gcvg-git@gmane.org; Sun, 27 Aug 2006 23:49:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbWH0Vtd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Aug 2006 17:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbWH0Vtd
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Aug 2006 17:49:33 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:49430 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932299AbWH0Vtd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Aug 2006 17:49:33 -0400
Received: by nf-out-0910.google.com with SMTP id o25so1123803nfa
        for <git@vger.kernel.org>; Sun, 27 Aug 2006 14:49:31 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=t/JU6FXsNP4QDzemxB+AwZYwKK1LhrkP2iVioAKZB5ercrT8gPixy4jRFUx+qLMB3m0aX3Bs9w+OG2AmqcGzoecSDlnJclIIkaN2Eapj05N0U6iyTFVSVKn9i+IHJjE3ptKxuG0w7Fi1PwB9sS/Wi/X+u2AUkx38+OdXmH8lH7Q=
Received: by 10.48.210.20 with SMTP id i20mr8202863nfg;
        Sun, 27 Aug 2006 14:49:31 -0700 (PDT)
Received: from host-81-190-21-215.torun.mm.pl ( [81.190.21.215])
        by mx.gmail.com with ESMTP id h1sm11049629nfe.2006.08.27.14.49.30;
        Sun, 27 Aug 2006 14:49:31 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26117>

Added new global configuration variable @diff_opts, which holds
additional options (parameters) to git-diff and git-diff-tree, usually
dealing rename/copying detection.  Default value is '-M', taken from
git_commit subroutine.  Description of options and their approximate
cost by Junio C Hamano.

Changes:
* git_commitdiff, git_blobdiff and git_blobdiff_plain now use '-M'
  instead of '-M', '-C'
* git-diff now uses the same options as git-diff-tree
* git_comittdiff_plain now uses '-M' instead of '-B' 
  and is now rename-aware
* git_rss uses now '-M' instead of ()

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
Signed-off-by: Junio C Hamano <junkio@cox.net>
---
As requested, gitweb now uses '-M' without '-C' as option 
to git-diff-tree thorough the script.

I'm not that sure about last chunk, changing git_rss. I didn't review
that function, and I'm not sure if we should add '-M' there...

I've added Junio to sob, because the comments are his.


 gitweb/gitweb.perl |   33 ++++++++++++++++++++++++---------
 1 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 6918947..99c74f1 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -141,6 +141,16 @@ sub feature_snapshot {
 	return ($ctype, $suffix, $command);
 }
 
+# rename detection options for git-diff and git-diff-tree
+# - default is '-M', with the cost proportional to
+#   (number of removed files) * (number of new files).
+# - more costly is '-C' (or '-C', '-M'), with the cost proportional to
+#   (number of changed files + number of removed files) * (number of new files)
+# - even more costly is '-C', '--find-copies-harder' with cost
+#   (number of files in the original tree) * (number of new files)
+# - one might want to include '-B' option, e.g. '-B', '-M'
+our @diff_opts = ('-M'); # taken from git_commit
+
 our $GITWEB_CONFIG = $ENV{'GITWEB_CONFIG'} || "++GITWEB_CONFIG++";
 require $GITWEB_CONFIG if -e $GITWEB_CONFIG;
 
@@ -2613,7 +2623,7 @@ sub git_commit {
 	if (!defined $parent) {
 		$parent = "--root";
 	}
-	open my $fd, "-|", $GIT, "diff-tree", '-r', '-M', $parent, $hash
+	open my $fd, "-|", $GIT, "diff-tree", '-r', @diff_opts, $parent, $hash
 		or die_error(undef, "Open git-diff-tree failed");
 	my @difftree = map { chomp; $_ } <$fd>;
 	close $fd or die_error(undef, "Reading git-diff-tree failed");
@@ -2720,7 +2730,7 @@ sub git_blobdiff {
 	if (defined $hash_base && defined $hash_parent_base) {
 		if (defined $file_name) {
 			# read raw output
-			open $fd, "-|", $GIT, "diff-tree", '-r', '-M', '-C', $hash_parent_base, $hash_base,
+			open $fd, "-|", $GIT, "diff-tree", '-r', @diff_opts, $hash_parent_base, $hash_base,
 				"--", $file_name
 				or die_error(undef, "Open git-diff-tree failed");
 			@difftree = map { chomp; $_ } <$fd>;
@@ -2735,7 +2745,7 @@ sub git_blobdiff {
 			}
 
 			# read filtered raw output
-			open $fd, "-|", $GIT, "diff-tree", '-r', '-M', '-C', $hash_parent_base, $hash_base
+			open $fd, "-|", $GIT, "diff-tree", '-r', @diff_opts, $hash_parent_base, $hash_base
 				or die_error(undef, "Open git-diff-tree failed");
 			@difftree =
 				# ':100644 100644 03b21826... 3b93d5e7... M	ls-files.c'
@@ -2769,7 +2779,8 @@ sub git_blobdiff {
 		}
 
 		# open patch output
-		open $fd, "-|", $GIT, "diff-tree", '-r', '-p', '-M', '-C', $hash_parent_base, $hash_base,
+		open $fd, "-|", $GIT, "diff-tree", '-r', @diff_opts,
+			'-p', $hash_parent_base, $hash_base,
 			"--", $file_name
 			or die_error(undef, "Open git-diff-tree failed");
 	}
@@ -2804,7 +2815,7 @@ sub git_blobdiff {
 		}
 
 		# open patch output
-		open $fd, "-|", $GIT, "diff", '-p', $hash_parent, $hash
+		open $fd, "-|", $GIT, "diff", '-p', @diff_opts, $hash_parent, $hash
 			or die_error(undef, "Open git-diff failed");
 	} else  {
 		die_error('404 Not Found', "Missing one of the blob diff parameters")
@@ -2889,7 +2900,7 @@ sub git_commitdiff {
 	my $fd;
 	my @difftree;
 	if ($format eq 'html') {
-		open $fd, "-|", $GIT, "diff-tree", '-r', '-M', '-C',
+		open $fd, "-|", $GIT, "diff-tree", '-r', @diff_opts,
 			"--patch-with-raw", "--full-index", $hash_parent, $hash
 			or die_error(undef, "Open git-diff-tree failed");
 
@@ -2900,7 +2911,8 @@ sub git_commitdiff {
 		}
 
 	} elsif ($format eq 'plain') {
-		open $fd, "-|", $GIT, "diff-tree", '-r', '-p', '-B', $hash_parent, $hash
+		open $fd, "-|", $GIT, "diff-tree", '-r', @diff_opts,
+			'-p', $hash_parent, $hash
 			or die_error(undef, "Open git-diff-tree failed");
 
 	} else {
@@ -3209,9 +3221,12 @@ XML
 			last;
 		}
 		my %cd = parse_date($co{'committer_epoch'});
-		open $fd, "-|", $GIT, "diff-tree", '-r', $co{'parent'}, $co{'id'} or next;
+		open $fd, "-|", $GIT, "diff-tree", '-r', @diff_opts,
+			$co{'parent'}, $co{'id'}
+			or next;
 		my @difftree = map { chomp; $_ } <$fd>;
-		close $fd or next;
+		close $fd
+			or next;
 		print "<item>\n" .
 		      "<title>" .
 		      sprintf("%d %s %02d:%02d", $cd{'mday'}, $cd{'month'}, $cd{'hour'}, $cd{'minute'}) . " - " . esc_html($co{'title'}) .
-- 
1.4.1.1
