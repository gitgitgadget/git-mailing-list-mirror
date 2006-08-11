From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: bugfix: allow SVN:: lib users to track the root of the repository
Date: Fri, 11 Aug 2006 11:11:29 -0700
Message-ID: <11553198912549-git-send-email-normalperson@yhbt.net>
References: <11553198891741-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Aug 11 20:11:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBbU1-0002nw-KT
	for gcvg-git@gmane.org; Fri, 11 Aug 2006 20:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbWHKSLg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Aug 2006 14:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbWHKSLg
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Aug 2006 14:11:36 -0400
Received: from hand.yhbt.net ([66.150.188.102]:53125 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751223AbWHKSLe (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Aug 2006 14:11:34 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 2DA087DC029;
	Fri, 11 Aug 2006 11:11:31 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri, 11 Aug 2006 11:11:31 -0700
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.2.rc1.g018f
In-Reply-To: <11553198891741-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25233>

I'm not sure if anybody has hit this (besides me), but this
fixes the problem where I ran into while attempting to import a
small repo at the root level:  I ended up with all the commits, but
with no file/tree changes at all throughout the entire history.

Also, fix a warning if the commit message is not defined for revision 0.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index a033237..fb792be 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2614,7 +2614,9 @@ sub libsvn_connect {
 sub libsvn_get_file {
 	my ($gui, $f, $rev) = @_;
 	my $p = $f;
-	return unless ($p =~ s#^\Q$SVN_PATH\E/##);
+	if (length $SVN_PATH > 0) {
+		return unless ($p =~ s#^\Q$SVN_PATH\E/##);
+	}
 
 	my ($hash, $pid, $in, $out);
 	my $pool = SVN::Pool->new;
@@ -2661,6 +2663,7 @@ sub libsvn_log_entry {
 	if (defined $_authors && ! defined $users{$author}) {
 		die "Author: $author not defined in $_authors file\n";
 	}
+	$msg = '' if ($rev == 0 && !defined $msg);
 	return { revision => $rev, date => "+0000 $Y-$m-$d $H:$M:$S",
 		author => $author, msg => $msg."\n", parents => $parents || [] }
 }
-- 
1.4.2.rc1.g018f
