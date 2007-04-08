From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: fix log command to avoid infinite loop on long commit messages
Date: Sun,  8 Apr 2007 00:59:22 -0700
Message-ID: <11760191623184-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 08 09:59:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HaSJJ-0002uk-Oy
	for gcvg-git@gmane.org; Sun, 08 Apr 2007 09:59:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752689AbXDHH7k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Apr 2007 03:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752741AbXDHH7j
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Apr 2007 03:59:39 -0400
Received: from hand.yhbt.net ([66.150.188.102]:50222 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752689AbXDHH7X (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Apr 2007 03:59:23 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 614007DC091;
	Sun,  8 Apr 2007 00:59:22 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 08 Apr 2007 00:59:22 -0700
X-Mailer: git-send-email 1.5.1.82.g8c65-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43998>

This bug has been around since the the conversion to use the
Git.pm library back in October or November.  Eventually I'd like
"git rev-list/log" to have the option to not truncate overly
long messages.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index e4079fb..ac44f60 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3263,12 +3263,19 @@ my $l_fmt;
 sub cmt_showable {
 	my ($c) = @_;
 	return 1 if defined $c->{r};
+
+	# big commit message got truncated by the 16k pretty buffer in rev-list
 	if ($c->{l} && $c->{l}->[-1] eq "...\n" &&
 				$c->{a_raw} =~ /\@([a-f\d\-]+)>$/) {
+		@{$c->{l}} = ();
 		my @log = command(qw/cat-file commit/, $c->{c});
-		shift @log while ($log[0] ne "\n");
+
+		# shift off the headers
+		shift @log while ($log[0] ne '');
 		shift @log;
-		@{$c->{l}} = grep !/^git-svn-id: /, @log;
+
+		# TODO: make $c->{l} not have a trailing newline in the future
+		@{$c->{l}} = map { "$_\n" } grep !/^git-svn-id: /, @log;
 
 		(undef, $c->{r}, undef) = ::extract_metadata(
 				(grep(/^git-svn-id: /, @log))[-1]);
-- 
1.5.1.82.g8c65-dirty
