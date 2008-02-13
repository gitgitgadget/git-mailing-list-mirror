From: Jeff King <peff@peff.net>
Subject: Re: [Bug] git add -i fails in multiple ways prior to first commit.
Date: Wed, 13 Feb 2008 05:16:49 -0500
Message-ID: <20080213101649.GA18444@coredump.intra.peff.net>
References: <C50196C5-B0C5-4536-AD4A-0F9C553782EE@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Rhodes, Kate" <masukomi@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 11:17:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPEgD-0000j4-Jk
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 11:17:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753322AbYBMKQz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 05:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752910AbYBMKQz
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 05:16:55 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1654 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752845AbYBMKQy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 05:16:54 -0500
Received: (qmail 13232 invoked by uid 111); 13 Feb 2008 10:16:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 13 Feb 2008 05:16:51 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Feb 2008 05:16:49 -0500
Content-Disposition: inline
In-Reply-To: <C50196C5-B0C5-4536-AD4A-0F9C553782EE@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73766>

On Mon, Feb 11, 2008 at 07:59:46PM -0500, Rhodes, Kate wrote:

> * status fails to report the current status
> * update fails to work at all

Below is a patch to address these two. It works by simulating the
diff as if HEAD contained nothing. The 'diff' command is still broken
(it would need to generate fake diff output against an empty tree).

However, I wonder if this is the best approach. It would be nice if
there were a shorthand for "the empty tree" for diffing, so you could
just diff against that rather than HEAD, and have the regular plumbing
generate.

I suppose we could just create that tree object, though it adds a slight
amount of cruft to the object database.

---
 git-add--interactive.perl |   62 ++++++++++++++++++++++++++++++++-------------
 1 files changed, 44 insertions(+), 18 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 17ca5b8..b9f9abe 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -82,6 +82,17 @@ sub list_untracked {
 my $status_fmt = '%12s %12s %s';
 my $status_head = sprintf($status_fmt, 'staged', 'unstaged', 'path');
 
+sub is_initial_commit {
+	return system('git rev-parse HEAD -- >/dev/null 2>&1') != 0;
+}
+
+sub count_blob_lines {
+	my $sha1 = shift;
+	my @lines = run_cmd_pipe(qw(git cat-file blob), $sha1);
+	return scalar(@lines);
+}
+
+
 # Returns list of hashes, contents of each of which are:
 # VALUE:	pathname
 # BINARY:	is a binary path
@@ -103,27 +114,42 @@ sub list_modified {
 		return if (!@tracked);
 	}
 
-	for (run_cmd_pipe(qw(git diff-index --cached
-			     --numstat --summary HEAD --), @tracked)) {
-		if (($add, $del, $file) =
-		    /^([-\d]+)	([-\d]+)	(.*)/) {
-			my ($change, $bin);
-			if ($add eq '-' && $del eq '-') {
-				$change = 'binary';
-				$bin = 1;
-			}
-			else {
-				$change = "+$add/-$del";
-			}
+	if (is_initial_commit()) {
+		for (run_cmd_pipe(qw(git ls-files --stage --exclude-standard
+				     --), @tracked)) {
+			my ($sha1, $file) = /\d+ ([0-9a-f]+) \d\t(.*)/
+				or die "invalid ls-files output: $_";
+			my $n = count_blob_lines($sha1);
 			$data{$file} = {
-				INDEX => $change,
-				BINARY => $bin,
+				INDEX => "+$n/-0",
 				FILE => 'nothing',
-			}
+				INDEXADDDEL => 'create',
+			};
 		}
-		elsif (($adddel, $file) =
-		       /^ (create|delete) mode [0-7]+ (.*)$/) {
-			$data{$file}{INDEX_ADDDEL} = $adddel;
+	}
+	else {
+		for (run_cmd_pipe(qw(git diff-index --cached
+				     --numstat --summary HEAD --), @tracked)) {
+			if (($add, $del, $file) =
+			    /^([-\d]+)	([-\d]+)	(.*)/) {
+				my ($change, $bin);
+				if ($add eq '-' && $del eq '-') {
+					$change = 'binary';
+					$bin = 1;
+				}
+				else {
+					$change = "+$add/-$del";
+				}
+				$data{$file} = {
+					INDEX => $change,
+					BINARY => $bin,
+					FILE => 'nothing',
+				}
+			}
+			elsif (($adddel, $file) =
+			       /^ (create|delete) mode [0-7]+ (.*)$/) {
+				$data{$file}{INDEX_ADDDEL} = $adddel;
+			}
 		}
 	}
 
-- 
1.5.4.1.1296.g34f89-dirty
