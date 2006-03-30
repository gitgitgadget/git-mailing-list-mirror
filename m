From: Junio C Hamano <junkio@cox.net>
Subject: Re: Rebase semantic and cherry-pick
Date: Wed, 29 Mar 2006 19:40:38 -0800
Message-ID: <7vmzf84n2h.fsf@assigned-by-dhcp.cox.net>
References: <1143596622.2481.10.camel@mattlaptop.metaesthetics.net>
	<Pine.LNX.4.64.0603281749060.15714@g5.osdl.org>
	<7vlkutc36w.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603291102440.15714@g5.osdl.org>
	<e0fe1h$d5r$1@sea.gmane.org> <7vwtec7j37.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603291852140.27203@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 30 05:40:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOo1k-00084A-IV
	for gcvg-git@gmane.org; Thu, 30 Mar 2006 05:40:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWC3Dkn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Mar 2006 22:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWC3Dkn
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Mar 2006 22:40:43 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:17911 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750702AbWC3Dkm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Mar 2006 22:40:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060330034040.OKJE6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 29 Mar 2006 22:40:40 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603291852140.27203@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 29 Mar 2006 18:54:12 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18189>

Linus Torvalds <torvalds@osdl.org> writes:

> For consistency reasons, we should probably allow that to be written as 
> just "..branch", the same way we can write "branch.." to mean "everything 
> in HEAD but not in "branch".

Something like this, perhaps.

-- >8 --
revision arguments: ..B means HEAD..B, just like A.. means A..HEAD

For consistency reasons, we should probably allow that to be written as 
just "..branch", the same way we can write "branch.." to mean "everything 
in HEAD but not in "branch".

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
diff --git a/rev-parse.c b/rev-parse.c
index f176c56..e956cd5 100644
--- a/rev-parse.c
+++ b/rev-parse.c
@@ -315,16 +315,17 @@ int main(int argc, char **argv)
 		dotdot = strstr(arg, "..");
 		if (dotdot) {
 			unsigned char end[20];
-			char *n = dotdot+2;
+			char *next = dotdot + 2;
+			char *this = arg;
 			*dotdot = 0;
-			if (!get_sha1(arg, sha1)) {
-				if (!*n)
-					n = "HEAD";
-				if (!get_sha1(n, end)) {
-					show_rev(NORMAL, end, n);
-					show_rev(REVERSED, sha1, arg);
-					continue;
-				}
+			if (!*next)
+				next = "HEAD";
+			if (dotdot == arg)
+				this = "HEAD";
+			if (!get_sha1(this, sha1) && !get_sha1(next, end)) {
+				show_rev(NORMAL, end, next);
+				show_rev(REVERSED, sha1, this);
+				continue;
 			}
 			*dotdot = '.';
 		}
diff --git a/revision.c b/revision.c
index 745b0d2..2cda7e0 100644
--- a/revision.c
+++ b/revision.c
@@ -642,14 +642,19 @@ int setup_revisions(int argc, const char
 		if (dotdot) {
 			unsigned char from_sha1[20];
 			char *next = dotdot + 2;
+			char *this = arg;
+			static const char HEAD[] = "HEAD";
 			*dotdot = 0;
 			if (!*next)
-				next = "HEAD";
-			if (!get_sha1(arg, from_sha1) && !get_sha1(next, sha1)) {
+				next = HEAD;
+			if (dotdot == arg)
+				this = HEAD;
+			if (!get_sha1(this, from_sha1) &&
+			    !get_sha1(next, sha1)) {
 				struct commit *exclude;
 				struct commit *include;
 
-				exclude = get_commit_reference(revs, arg, from_sha1, flags ^ UNINTERESTING);
+				exclude = get_commit_reference(revs, this, from_sha1, flags ^ UNINTERESTING);
 				include = get_commit_reference(revs, next, sha1, flags);
 				if (!exclude || !include)
 					die("Invalid revision range %s..%s", arg, next);
