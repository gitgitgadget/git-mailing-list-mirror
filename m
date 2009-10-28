From: Jeff King <peff@peff.net>
Subject: [PATCH] add-interactive: handle deletion of empty files
Date: Tue, 27 Oct 2009 20:52:57 -0400
Message-ID: <20091028005257.GA5002@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 01:53:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2wmg-0004Ty-J1
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 01:53:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756669AbZJ1Aw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 20:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754356AbZJ1Aw4
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 20:52:56 -0400
Received: from peff.net ([208.65.91.99]:47579 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756206AbZJ1Awz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 20:52:55 -0400
Received: (qmail 5193 invoked by uid 107); 28 Oct 2009 00:56:38 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (216.239.45.19)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 27 Oct 2009 20:56:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Oct 2009 20:52:57 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131397>

Usually we show deletion as a big hunk deleting all of the
file's text. However, for files with no content, the diff
shows just the 'deleted file mode ...' line. This patch
cause "add -p" (and related commands) to recognize that line
and explicitly ask about deleting the file.

We only add the "stage this deletion" hunk for empty files,
since other files will already ask about the big content
deletion hunk. We could also change those files to simply
display "stage this deletion", but showing the actual
deleted content is probably what an interactive user wants.

Signed-off-by: Jeff King <peff@peff.net>
---
This bit me today. I expect it's pretty rare, but I don't see a reason
not to handle the corner case (and nor do I see a reason to change the
non-corner case, as explained above).

 git-add--interactive.perl  |   18 +++++++++++++-----
 t/t3701-add-interactive.sh |   17 +++++++++++++++++
 2 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 69aeaf0..8ce1ec9 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -731,14 +731,17 @@ sub parse_diff_header {
 
 	my $head = { TEXT => [], DISPLAY => [], TYPE => 'header' };
 	my $mode = { TEXT => [], DISPLAY => [], TYPE => 'mode' };
+	my $deletion = { TEXT => [], DISPLAY => [], TYPE => 'deletion' };
 
 	for (my $i = 0; $i < @{$src->{TEXT}}; $i++) {
-		my $dest = $src->{TEXT}->[$i] =~ /^(old|new) mode (\d+)$/ ?
-			$mode : $head;
+		my $dest =
+		   $src->{TEXT}->[$i] =~ /^(old|new) mode (\d+)$/ ? $mode :
+		   $src->{TEXT}->[$i] =~ /^deleted file/ ? $deletion :
+		   $head;
 		push @{$dest->{TEXT}}, $src->{TEXT}->[$i];
 		push @{$dest->{DISPLAY}}, $src->{DISPLAY}->[$i];
 	}
-	return ($head, $mode);
+	return ($head, $mode, $deletion);
 }
 
 sub hunk_splittable {
@@ -1206,7 +1209,7 @@ sub patch_update_file {
 	my ($ix, $num);
 	my $path = shift;
 	my ($head, @hunk) = parse_diff($path);
-	($head, my $mode) = parse_diff_header($head);
+	($head, my $mode, my $deletion) = parse_diff_header($head);
 	for (@{$head->{DISPLAY}}) {
 		print;
 	}
@@ -1214,6 +1217,9 @@ sub patch_update_file {
 	if (@{$mode->{TEXT}}) {
 		unshift @hunk, $mode;
 	}
+	if (@{$deletion->{TEXT}} && !@hunk) {
+		@hunk = ($deletion);
+	}
 
 	$num = scalar @hunk;
 	$ix = 0;
@@ -1267,7 +1273,9 @@ sub patch_update_file {
 			print;
 		}
 		print colored $prompt_color, $patch_mode_flavour{VERB},
-		  ($hunk[$ix]{TYPE} eq 'mode' ? ' mode change' : ' this hunk'),
+		  ($hunk[$ix]{TYPE} eq 'mode' ? ' mode change' :
+		   $hunk[$ix]{TYPE} eq 'deletion' ? ' deletion' :
+		   ' this hunk'),
 		  $patch_mode_flavour{TARGET},
 		  " [y,n,q,a,d,/$other,?]? ";
 		my $line = prompt_single_character;
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 687bd7a..768236b 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -228,4 +228,21 @@ test_expect_success 'add first line works' '
 	test_cmp expected diff
 '
 
+cat >expected <<EOF
+diff --git a/empty b/empty
+deleted file mode 100644
+index e69de29..0000000
+EOF
+
+test_expect_success 'deleting an empty file' '
+	git reset --hard &&
+	> empty &&
+	git add empty &&
+	git commit -m empty &&
+	rm empty &&
+	echo y | git add -p empty &&
+	git diff --cached >diff &&
+	test_cmp expected diff
+'
+
 test_done
-- 
1.6.5.2.193.g57820
