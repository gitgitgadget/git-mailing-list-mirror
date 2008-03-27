From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] add--interactive: allow user to choose mode update
Date: Thu, 27 Mar 2008 03:32:25 -0400
Message-ID: <20080327073225.GC22444@coredump.intra.peff.net>
References: <cover.1206602393.git.peff@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?SsO2cmc=?= Sommer <joerg@alea.gnuu.de>,
	Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 27 08:33:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jembl-00083G-E7
	for gcvg-git-2@gmane.org; Thu, 27 Mar 2008 08:33:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754689AbYC0Hc2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2008 03:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754615AbYC0Hc2
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Mar 2008 03:32:28 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1137 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751308AbYC0Hc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2008 03:32:27 -0400
Received: (qmail 15751 invoked by uid 111); 27 Mar 2008 07:32:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 27 Mar 2008 03:32:26 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Mar 2008 03:32:25 -0400
Content-Disposition: inline
In-Reply-To: <cover.1206602393.git.peff@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78340>

When using the 'p'atch command, instead of just throwing out
any mode change, let's present it to the user in the same
way that we show hunks.

Signed-off-by: Jeff King <peff@peff.net>
---
This is the "minimal intrusion" implementation. It always asks about the
mode just once at the beginning of the file. I think you could probably
refactor the hunk handling so that the mode change went into the main
hunk loop, and you could skip it, go back to it, etc, like a regular
hunk.

 git-add--interactive.perl  |   33 +++++++++++++++++++++++++++++++++
 t/t3701-add-interactive.sh |   12 +++++++++++-
 2 files changed, 44 insertions(+), 1 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 5cdda29..903953e 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -814,6 +814,36 @@ sub patch_update_file {
 	for (@{$head->{DISPLAY}}) {
 		print;
 	}
+
+	if (@{$mode->{TEXT}}) {
+		while (1) {
+			print @{$mode->{DISPLAY}};
+			print colored $prompt_color,
+				"Stage mode change [y/n/a/d/?]? ";
+			my $line = <STDIN>;
+			if ($line =~ /^y/i) {
+				$mode->{USE} = 1;
+				last;
+			}
+			elsif ($line =~ /^n/i) {
+				$mode->{USE} = 0;
+				last;
+			}
+			elsif ($line =~ /^a/i) {
+				$_->{USE} = 1 foreach ($mode, @hunk);
+				last;
+			}
+			elsif ($line =~ /^d/i) {
+				$_->{USE} = 0 foreach ($mode, @hunk);
+				last;
+			}
+			else {
+				help_patch_cmd('');
+				next;
+			}
+		}
+	}
+
 	$num = scalar @hunk;
 	$ix = 0;
 
@@ -936,6 +966,9 @@ sub patch_update_file {
 
 	my $n_lofs = 0;
 	my @result = ();
+	if ($mode->{USE}) {
+		push @result, @{$mode->{TEXT}};
+	}
 	for (@hunk) {
 		my $text = $_->{TEXT};
 		my ($o_ofs, $o_cnt, $n_ofs, $n_cnt) =
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index d920d06..f15be93 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -70,9 +70,19 @@ test_expect_success 'patch does not affect mode' '
 	git reset --hard &&
 	echo content >>file &&
 	chmod +x file &&
-	printf "y\\n" | git add -p &&
+	printf "n\\ny\\n" | git add -p &&
 	git show :file | grep content &&
 	git diff file | grep "new mode"
 '
 
+test_expect_success 'stage mode but not hunk' '
+	git reset --hard &&
+	echo content >>file &&
+	chmod +x file &&
+	printf "y\\nn\\n" | git add -p &&
+	git diff --cached file | grep "new mode" &&
+	git diff          file | grep "+content"
+'
+
+
 test_done
-- 
1.5.5.rc1.141.g50ecd.dirty
