From: Jeff King <peff@peff.net>
Subject: Re: Clueless bisect error message
Date: Wed, 11 Oct 2006 05:14:12 -0400
Message-ID: <20061011091411.GA21527@coredump.intra.peff.net>
References: <fcaeb9bf0610110008g642da719pb17f7f52169097e2@mail.gmail.com> <7vpsczuxj9.fsf@assigned-by-dhcp.cox.net> <fcaeb9bf0610110050h4c3a56fbge19607ff0bc094af@mail.gmail.com> <7v1wpfuv9d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 11 11:15:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXaAv-0002uj-8R
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 11:14:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965212AbWJKJOu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 05:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965214AbWJKJOt
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 05:14:49 -0400
Received: from [66.23.211.5] ([66.23.211.5]:26548 "HELO peff.net")
	by vger.kernel.org with SMTP id S965212AbWJKJOt (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Oct 2006 05:14:49 -0400
Received: (qmail 27485 invoked from network); 11 Oct 2006 05:14:12 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 11 Oct 2006 05:14:12 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Oct 2006 05:14:12 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v1wpfuv9d.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28707>

On Wed, Oct 11, 2006 at 01:11:42AM -0700, Junio C Hamano wrote:

> But I suspect that doing either of these things would harm
> Cogito users.  After cg-seek the user is not "in the middle of
> another bisect", and if we run "git bisect --reset" when we see
> head-name, it would probably break it too.

Maybe expand head-name to include a "reason" field? Unfortunately we
can't just stick it in the same file and remain compatible with all
versions, so we'll have to use a new file. Something like:

-- >8 --
git-bisect: use head-reason to explain use of head-name

Since many different programs may use head-name to indicate that the working
tree should not be modified, head-reason gives them a chance to explain what
they're doing. This can improve the accuracy of error messages (such as won't
bisect a seeked tree).

Signed-off-by: Jeff King <peff@peff.net>
---
Alternatively, the actual message to show the user could be placed in
head-reason. I think it makes more sense as it is, as it provides the
ability for the message to say "can't X because of Y" in plain English.

And of course we need cogito to start supporting this (but we print
something sane for older versions with don't support head-reason).

 git-bisect.sh |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 06a8d26..9f49dd3 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -57,8 +57,21 @@ bisect_start() {
 		git checkout $branch || exit
 		;;
 	refs/heads/*)
-		[ -s "$GIT_DIR/head-name" ] && die "won't bisect on seeked tree"
+		if [ -s "$GIT_DIR/head-name" ]; then
+		    case "$(cat "$GIT_DIR/head-reason" 2>/dev/null)" in
+		    bisect)
+			die "You are already in the middle of another bisect!"
+			;;
+		    seek)
+			die "You can't bisect a seeked tree!"
+			;;
+		    *)
+			die "head-name already exists"
+			;;
+		    esac
+		fi
 		echo "$head" | sed 's#^refs/heads/##' >"$GIT_DIR/head-name"
+		echo bisect >"$GIT_DIR/head-reason"
 		;;
 	*)
 		die "Bad HEAD - strange symbolic ref"
@@ -182,6 +195,7 @@ bisect_reset() {
 	git checkout "$branch" &&
 	rm -fr "$GIT_DIR/refs/bisect"
 	rm -f "$GIT_DIR/refs/heads/bisect" "$GIT_DIR/head-name"
+	rm -f "$GIT_DIR/head-reason"
 	rm -f "$GIT_DIR/BISECT_LOG"
 	rm -f "$GIT_DIR/BISECT_NAMES"
 }
-- 
1.4.2.3.g2c59-dirty



> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
