From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] add--interactive: ignore mode change in 'p'atch command
Date: Thu, 27 Mar 2008 03:30:43 -0400
Message-ID: <20080327073043.GB22444@coredump.intra.peff.net>
References: <cover.1206602393.git.peff@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?SsO2cmc=?= Sommer <joerg@alea.gnuu.de>,
	Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 27 08:31:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jema6-0007ge-Ga
	for gcvg-git-2@gmane.org; Thu, 27 Mar 2008 08:31:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753863AbYC0Haq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2008 03:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbYC0Hap
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Mar 2008 03:30:45 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1135 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751287AbYC0Hap (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2008 03:30:45 -0400
Received: (qmail 15625 invoked by uid 111); 27 Mar 2008 07:30:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 27 Mar 2008 03:30:44 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Mar 2008 03:30:43 -0400
Content-Disposition: inline
In-Reply-To: <cover.1206602393.git.peff@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78339>

When a path is examined in the patch subcommand, any mode
changes in the file are given to use in the diff header by
git-diff. If no hunks are staged, then we throw out that
header. But if _any_ hunks are staged, we use the header,
and the mode is changed.

Since the 'p'atch command should just be dealing with hunks
that are shown to the user, it makes sense to just ignore
mode changes entirely. We do squirrel away the mode, though,
since a future patch will allow users to select the mode
update.

Signed-off-by: Jeff King <peff@peff.net>
---
Like I said, I don't necessarily like this behavior, but it is a
stepping stone to 1/2.

 git-add--interactive.perl  |   16 ++++++++++++++++
 t/t3701-add-interactive.sh |    9 +++++++++
 2 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index a0a81f1..5cdda29 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -550,6 +550,21 @@ sub parse_diff {
 	return @hunk;
 }
 
+sub parse_diff_header {
+	my $src = shift;
+
+	my $head = { TEXT => [], DISPLAY => [] };
+	my $mode = { TEXT => [], DISPLAY => [] };
+
+	for (my $i = 0; $i < @{$src->{TEXT}}; $i++) {
+		my $dest = $src->{TEXT}->[$i] =~ /^(old|new) mode (\d+)$/ ?
+			$mode : $head;
+		push @{$dest->{TEXT}}, $src->{TEXT}->[$i];
+		push @{$dest->{DISPLAY}}, $src->{DISPLAY}->[$i];
+	}
+	return ($head, $mode);
+}
+
 sub hunk_splittable {
 	my ($text) = @_;
 
@@ -795,6 +810,7 @@ sub patch_update_file {
 	my ($ix, $num);
 	my $path = shift;
 	my ($head, @hunk) = parse_diff($path);
+	($head, my $mode) = parse_diff_header($head);
 	for (@{$head->{DISPLAY}}) {
 		print;
 	}
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 77c90f6..d920d06 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -66,4 +66,13 @@ test_expect_success 'revert works (commit)' '
 	grep "unchanged *+3/-0 file" output
 '
 
+test_expect_success 'patch does not affect mode' '
+	git reset --hard &&
+	echo content >>file &&
+	chmod +x file &&
+	printf "y\\n" | git add -p &&
+	git show :file | grep content &&
+	git diff file | grep "new mode"
+'
+
 test_done
-- 
1.5.5.rc1.141.g50ecd.dirty
