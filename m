From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] gitweb: fix commitdiff_plain for root commits
Date: Sun, 6 Aug 2006 19:24:47 +0200
Message-ID: <20060806172447.GA12085@moooo.ath.cx>
References: <20060806155505.GA9548@moooo.ath.cx> <11548799921728-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 06 19:25:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9mMy-0003Qn-77
	for gcvg-git@gmane.org; Sun, 06 Aug 2006 19:24:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbWHFRYw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Aug 2006 13:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbWHFRYw
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Aug 2006 13:24:52 -0400
Received: from moooo.ath.cx ([85.116.203.178]:35484 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1751283AbWHFRYv (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Aug 2006 13:24:51 -0400
To: Jakub Narebski <jnareb@gmail.com>
Mail-Followup-To: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <11548799921728-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24986>

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
See [PATCH] gitweb: fix commitdiff for root commits from Jakub:
> No checking for empty $hash_parent in git_commitdiff_plain -- we
> rely on gitweb to give correct parameters for commitdiff_plain
> action.
I think we should always check the input and prevent any warnings.
This patch is on top of Jakubs patch, mine just did the if (!($line =~
m/..)) { next; } to be consistent with the other ifs.
---
 gitweb/gitweb.perl |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d9648a0..b3bfc6b 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2200,6 +2200,13 @@ sub git_commitdiff {
 
 sub git_commitdiff_plain {
 	mkdir($git_temp, 0700);
+	my %co = git_read_commit($hash);
+	if (!%co) {
+		die_error(undef, "Unknown commit object");
+	}
+	if (!defined $hash_parent) {
+		$hash_parent = $co{'parent'} || '--root';
+	}
 	open my $fd, "-|", $GIT, "diff-tree", '-r', $hash_parent, $hash
 		or die_error(undef, "Open git-diff-tree failed");
 	my @difftree = map { chomp; $_ } <$fd>;
@@ -2221,7 +2228,6 @@ sub git_commitdiff_plain {
 	}
 
 	print $cgi->header(-type => "text/plain", -charset => 'utf-8', '-content-disposition' => "inline; filename=\"git-$hash.patch\"");
-	my %co = git_read_commit($hash);
 	my %ad = date_str($co{'author_epoch'}, $co{'author_tz'});
 	my $comment = $co{'comment'};
 	print "From: $co{'author'}\n" .
-- 
1.4.1.gfd699
