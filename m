From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: fix --file/-F option in commit-diff
Date: Sun,  9 Jul 2006 20:20:48 -0700
Message-ID: <11525016483767-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Jul 10 05:21:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzmKQ-0008C7-I3
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 05:20:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161317AbWGJDUw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Jul 2006 23:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161318AbWGJDUw
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 23:20:52 -0400
Received: from hand.yhbt.net ([66.150.188.102]:64203 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1161317AbWGJDUv (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jul 2006 23:20:51 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 2EED57DC021;
	Sun,  9 Jul 2006 20:20:49 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun,  9 Jul 2006 20:20:49 -0700
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.1.gda58
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23585>

Also, allow messages from tags to be used as
commit messages.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 contrib/git-svn/git-svn.perl |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index 8bc4188..7cbfb6e 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -760,7 +760,7 @@ sub commit_diff {
 		exit 1;
 	}
 	if (defined $_file) {
-		$_message = file_to_s($_message);
+		$_message = file_to_s($_file);
 	} else {
 		$_message ||= get_commit_message($tb,
 					"$GIT_DIR/.svn-commit.tmp.$$")->{msg};
@@ -1518,12 +1518,12 @@ sub get_commit_message {
 	open my $msg, '>', $commit_msg or croak $!;
 
 	chomp(my $type = `git-cat-file -t $commit`);
-	if ($type eq 'commit') {
+	if ($type eq 'commit' || $type eq 'tag') {
 		my $pid = open my $msg_fh, '-|';
 		defined $pid or croak $!;
 
 		if ($pid == 0) {
-			exec(qw(git-cat-file commit), $commit) or croak $!;
+			exec('git-cat-file', $type, $commit) or croak $!;
 		}
 		my $in_msg = 0;
 		while (<$msg_fh>) {
-- 
1.4.1.gda58
