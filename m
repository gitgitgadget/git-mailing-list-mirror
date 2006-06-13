From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 4/13] git-svn: support manually placed initial trees from fetch
Date: Tue, 13 Jun 2006 11:02:06 -0700
Message-ID: <11502217403634-git-send-email-normalperson@yhbt.net>
References: <11502217352245-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Jun 13 20:03:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqDDz-0004t6-IH
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 20:02:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWFMSCY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Jun 2006 14:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbWFMSCX
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 14:02:23 -0400
Received: from hand.yhbt.net ([66.150.188.102]:46021 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932069AbWFMSCW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jun 2006 14:02:22 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 1EC287DC005;
	Tue, 13 Jun 2006 11:02:21 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 13 Jun 2006 11:02:21 -0700
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11502217352245-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Sometimes I don't feel like downloading an entire tree again when
I actually decide a branch is worth tracking, so some users can
get around it more easily with this.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 contrib/git-svn/git-svn.perl |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index d4b9323..54f3d63 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -262,7 +262,14 @@ sub fetch {
 	} else {
 		chdir $SVN_WC or croak $!;
 		read_uuid();
-		$last_commit = file_to_s("$REV_DIR/$base->{revision}");
+		eval { $last_commit = file_to_s("$REV_DIR/$base->{revision}") };
+		# looks like a user manually cp'd and svn switch'ed
+		unless ($last_commit) {
+			sys(qw/svn revert -R ./);
+			assert_svn_wc_clean($base->{revision});
+			$last_commit = git_commit($base, @parents);
+			assert_tree($last_commit);
+		}
 	}
 	my @svn_up = qw(svn up);
 	push @svn_up, '--ignore-externals' unless $_no_ignore_ext;
-- 
1.4.0
