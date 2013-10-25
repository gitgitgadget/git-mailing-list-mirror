From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] add-interactive: handle unborn branch in patch mode
Date: Fri, 25 Oct 2013 02:52:30 -0400
Message-ID: <20131025065229.GA15253@sigill.intra.peff.net>
References: <20131025065117.GA15192@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Maarten de Vries <maarten@de-vri.es>,
	git mailing list <git@vger.kernel.org>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 25 08:52:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZbG9-0003bl-0J
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 08:52:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509Ab3JYGwd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 02:52:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:55364 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751168Ab3JYGwc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 02:52:32 -0400
Received: (qmail 5845 invoked by uid 102); 25 Oct 2013 06:52:33 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 25 Oct 2013 01:52:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Oct 2013 02:52:30 -0400
Content-Disposition: inline
In-Reply-To: <20131025065117.GA15192@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236685>

The list_modified function already knows how to handle an
unborn branch by diffing against the empty tree. However,
the diff we perform to get the actual hunks does not. Let's
use the same logic for both diffs.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-add--interactive.perl | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 5156384..24bb1ab 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -263,6 +263,17 @@ sub get_empty_tree {
 	return '4b825dc642cb6eb9a060e54bf8d69288fbee4904';
 }
 
+sub get_diff_reference {
+	my $ref = shift;
+	if (defined $ref and $ref ne 'HEAD') {
+		return $ref;
+	} elsif (is_initial_commit()) {
+		return get_empty_tree();
+	} else {
+		return 'HEAD';
+	}
+}
+
 # Returns list of hashes, contents of each of which are:
 # VALUE:	pathname
 # BINARY:	is a binary path
@@ -286,14 +297,7 @@ sub list_modified {
 		return if (!@tracked);
 	}
 
-	my $reference;
-	if (defined $patch_mode_revision and $patch_mode_revision ne 'HEAD') {
-		$reference = $patch_mode_revision;
-	} elsif (is_initial_commit()) {
-		$reference = get_empty_tree();
-	} else {
-		$reference = 'HEAD';
-	}
+	my $reference = get_diff_reference($patch_mode_revision);
 	for (run_cmd_pipe(qw(git diff-index --cached
 			     --numstat --summary), $reference,
 			     '--', @tracked)) {
@@ -737,7 +741,7 @@ sub parse_diff {
 		splice @diff_cmd, 1, 0, "--diff-algorithm=${diff_algorithm}";
 	}
 	if (defined $patch_mode_revision) {
-		push @diff_cmd, $patch_mode_revision;
+		push @diff_cmd, get_diff_reference($patch_mode_revision);
 	}
 	my @diff = run_cmd_pipe("git", @diff_cmd, "--", $path);
 	my @colored = ();
-- 
1.8.4.1.898.g8bf8a41.dirty
