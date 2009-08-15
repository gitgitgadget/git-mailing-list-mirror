From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] add -p: do not attempt to coalesce mode changes
Date: Sat, 15 Aug 2009 15:56:39 +0200
Message-ID: <770693df8f416615f57423141fb59f3d6eccc915.1250344341.git.trast@student.ethz.ch>
References: <1250339209-27962-1-git-send-email-kirr@mns.spb.ru>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, <git@vger.kernel.org>
To: <gitster@pobox.com>, Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Sat Aug 15 15:57:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McJkn-0003Pp-0s
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 15:57:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754490AbZHON4z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2009 09:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754373AbZHON4z
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 09:56:55 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:36650 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751597AbZHON4z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2009 09:56:55 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.1.375.2; Sat, 15 Aug
 2009 15:56:53 +0200
Received: from localhost.localdomain (77.56.221.170) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Sat, 15 Aug
 2009 15:56:53 +0200
X-Mailer: git-send-email 1.6.4.288.gc754a.dirty
In-Reply-To: <1250339209-27962-1-git-send-email-kirr@mns.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126003>

In 0392513 (add-interactive: refactor mode hunk handling, 2009-04-16),
we merged the interaction loops for mode changes and hunk staging.
This was fine at the time, because 0beee4c (git-add--interactive:
remove hunk coalescing, 2008-07-02) removed hunk coalescing.

However, in 7a26e65 (Revert "git-add--interactive: remove hunk
coalescing", 2009-05-16), we resurrected it.  Since then, the code
would attempt in vain to merge mode changes with diff hunks,
corrupting both in the process.

We add a check to the coalescing loop to ensure it only looks at diff
hunks, thus skipping mode changes.

Noticed-by: Kirill Smelkov <kirr@mns.spb.ru>
Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 git-add--interactive.perl  |    4 ++++
 t/t3701-add-interactive.sh |    2 +-
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index df9f231..06f7060 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -841,6 +841,10 @@
 	my ($last_o_ctx, $last_was_dirty);
 
 	for (grep { $_->{USE} } @in) {
+		if ($_->{TYPE} ne 'hunk') {
+			push @out, $_;
+			next;
+		}
 		my $text = $_->{TEXT};
 		my ($o_ofs) = parse_hunk_header($text->[0]);
 		if (defined $last_o_ctx &&
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index d5e9351..62fd65e 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -164,7 +164,7 @@ test_expect_success FILEMODE 'stage mode but not hunk' '
 '
 
 
-test_expect_failure FILEMODE 'stage mode and hunk' '
+test_expect_success FILEMODE 'stage mode and hunk' '
 	git reset --hard &&
 	echo content >>file &&
 	chmod +x file &&
-- 
1.6.4.288.gc754a.dirty
