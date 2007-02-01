From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: do not let Git.pm warn if we prematurely close pipes
Date: Thu,  1 Feb 2007 13:12:26 -0800
Message-ID: <11703643463997-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 01 22:12:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCjEX-0001Zq-1j
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 22:12:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423009AbXBAVM3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 16:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423018AbXBAVM3
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 16:12:29 -0500
Received: from hand.yhbt.net ([66.150.188.102]:49667 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423009AbXBAVM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 16:12:28 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 19A6F7DC094;
	Thu,  1 Feb 2007 13:12:27 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Thu, 01 Feb 2007 13:12:26 -0800
X-Mailer: git-send-email 1.5.0.rc2.133.gca07-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38405>

This mainly quiets down warnings when running git svn log.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---

 This is backported from my development branch and should
 be trivial enough for 1.5.0.

 git-svn.perl |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 68156fc..8ebaae9 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -681,7 +681,7 @@ sub show_log {
 		process_commit($_, $r_min, $r_max) foreach reverse @k;
 	}
 out:
-	eval { command_close_pipe($log) };
+	close $log;
 	print '-' x72,"\n" unless $_incremental || $_oneline;
 }
 
@@ -1475,7 +1475,7 @@ sub map_tree_joins {
 				$seen{$commit} = 1;
 			}
 		}
-		eval { command_close_pipe($pipe) };
+		close $pipe;
 	}
 }
 
@@ -1669,7 +1669,7 @@ sub write_grafts {
 				last unless /^\S/;
 			}
 		}
-		eval { command_close_pipe($ch) }; # breaking the pipe
+		close $ch; # breaking the pipe
 
 		# if real parents are the only ones in the grafts, drop it
 		next if join(' ',sort keys %$p) eq join(' ',sort keys %x);
@@ -1766,7 +1766,7 @@ sub get_commit_time {
 		} elsif ($tz =~ s/^\-//) {
 			$s -= tz_to_s_offset($tz);
 		}
-		eval { command_close_pipe($fh) };
+		close $fh;
 		return $s;
 	}
 	die "Can't get commit time for commit: $cmt\n";
@@ -2846,7 +2846,7 @@ sub rmdirs {
 			delete $rm->{join '/', @dn};
 		}
 		unless (%$rm) {
-			eval { command_close_pipe($fh) };
+			close $fh;
 			return;
 		}
 	}
-- 
1.5.0.rc2.133.gca07-dirty
