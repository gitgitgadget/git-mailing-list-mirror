From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Added an option to cvsimport to specify email domain
Date: Fri, 30 Sep 2005 01:48:57 -0700
Message-ID: <7v64sj6iva.fsf@assigned-by-dhcp.cox.net>
References: <u5tzmqp8fzx.fsf@lysator.liu.se>
	<200509270834.55486.snake@penza-gsm.ru>
	<1127825656.30421.15.camel@gandalf.cobite.com>
	<200509301219.42087.snake@penza-gsm.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 30 10:50:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELGZw-0008PJ-38
	for gcvg-git@gmane.org; Fri, 30 Sep 2005 10:49:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932580AbVI3ItA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Sep 2005 04:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932581AbVI3ItA
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Sep 2005 04:49:00 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:59274 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932580AbVI3Is7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2005 04:48:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050930084859.UOGN9260.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 30 Sep 2005 04:48:59 -0400
To: Alexey Nezhdanov <snake@penza-gsm.ru>
In-Reply-To: <200509301219.42087.snake@penza-gsm.ru> (Alexey Nezhdanov's
	message of "Fri, 30 Sep 2005 12:19:41 +0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9550>

Alexey Nezhdanov <snake@penza-gsm.ru> writes:

> Unfortunately I do not know perl so I can not write a patch for git-cvsimport-script.
> So I asking you, Matthias, to help with this or may somebody on this list can do it instead.

Untested, but something like this?

------------
[PATCH] Pass CVSps generated A U Thor <author@domain.xz> intact.

Alexey Nezhdanov updated CVSps to generate author-name and
author-email information in its output.

If the input looks like it has that already properly formatted,
use that without our own munging.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -510,7 +510,7 @@ unless($pid) {
 
 my $state = 0;
 
-my($patchset,$date,$author,$branch,$ancestor,$tag,$logmsg);
+my($patchset,$date,$author_name,$author_email,$branch,$ancestor,$tag,$logmsg);
 my(@old,@new);
 my $commit = sub {
 	my $pid;
@@ -591,11 +591,11 @@ my $commit = sub {
 		}
 
 		exec("env",
-			"GIT_AUTHOR_NAME=$author",
-			"GIT_AUTHOR_EMAIL=$author",
+			"GIT_AUTHOR_NAME=$author_name",
+			"GIT_AUTHOR_EMAIL=$author_email",
 			"GIT_AUTHOR_DATE=".strftime("+0000 %Y-%m-%d %H:%M:%S",gmtime($date)),
-			"GIT_COMMITTER_NAME=$author",
-			"GIT_COMMITTER_EMAIL=$author",
+			"GIT_COMMITTER_NAME=$author_name",
+			"GIT_COMMITTER_EMAIL=$author_email",
 			"GIT_COMMITTER_DATE=".strftime("+0000 %Y-%m-%d %H:%M:%S",gmtime($date)),
 			"git-commit-tree", $tree,@par);
 		die "Cannot exec git-commit-tree: $!\n";
@@ -638,7 +638,7 @@ my $commit = sub {
 		print $out "object $cid\n".
 		    "type commit\n".
 		    "tag $xtag\n".
-		    "tagger $author <$author>\n"
+		    "tagger $author_name <$author_email>\n"
 		    or die "Cannot create tag object $xtag: $!\n";
 		close($out)
 		    or die "Cannot create tag object $xtag: $!\n";
@@ -683,7 +683,11 @@ while(<CVS>) {
 		$state=3;
 	} elsif($state == 3 and s/^Author:\s+//) {
 		s/\s+$//;
-		$author = $_;
+		if (/^(.*?)\s+<(.*)>/) {
+		    ($author_name, $author_email) = ($1, $2);
+		} else {
+		    $author_name = $author_email = $_;
+		}
 		$state = 4;
 	} elsif($state == 4 and s/^Branch:\s+//) {
 		s/\s+$//;
