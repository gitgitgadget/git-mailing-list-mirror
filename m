From: Junio C Hamano <junkio@cox.net>
Subject: Re: Some Commit Messages Scare git-rev-list
Date: Wed, 12 Apr 2006 11:46:12 -0700
Message-ID: <7v3bgi4op7.fsf@assigned-by-dhcp.cox.net>
References: <1144847462.5213.6.camel@localhost.localdomain>
	<Pine.LNX.4.64.0604121002220.14565@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Darrin Thompson <darrint@progeny.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 12 20:46:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FTkM7-0004An-T5
	for gcvg-git@gmane.org; Wed, 12 Apr 2006 20:46:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbWDLSqP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Apr 2006 14:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbWDLSqP
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Apr 2006 14:46:15 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:9423 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932158AbWDLSqO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Apr 2006 14:46:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060412184613.NJAE20569.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 12 Apr 2006 14:46:13 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604121002220.14565@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 12 Apr 2006 10:23:38 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18635>

Linus Torvalds <torvalds@osdl.org> writes:

> Fixed like so..

Thanks.

> However, your script shows another problem: the "#" added at the end of 
> the line for a 
>
> 	echo -n "duh" | git-commit -F - -a
>
> seems to be because we append the "git status" output to it, and then we 
> drop the lines that start with a '#', but due to the "-n", the first # 
> ends up being at the end of the line. 
>
> I suspect that when we get the commit message like that, we should _not_ 
> do any of the commit message editing at all.

True.

-- >8 --
[PATCH] git-commit: do not muck with commit message when no_edit is set.

Spotted by Linus and Darrin Thompson.  When we took a commit
message from -F <file> with an incomplete line, we appended "git
status" output, which ended up attaching a lone "#" at the end.

We still need the "do we have anything to commit?" check by
running "status" (which has to know what to do in different
cases with -i/-o/-a), but there is no point appending its output
to the proposed commit message given by the user.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 git-commit.sh |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

475443c8489d9167b944367d8ec8bfef77bee0a5
diff --git a/git-commit.sh b/git-commit.sh
index 1e7c09e..bd3dc71 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -537,7 +537,7 @@ t)
 	;;
 esac
 
-if [ -f "$GIT_DIR/MERGE_HEAD" ]; then
+if test -f "$GIT_DIR/MERGE_HEAD" && test -z "$no_edit"; then
 	echo "#"
 	echo "# It looks like you may be committing a MERGE."
 	echo "# If this is not correct, please remove the file"
@@ -605,16 +605,23 @@ else
 	current=
 fi
 
-{
-	test -z "$only_include_assumed" || echo "$only_include_assumed"
-	run_status
-} >>"$GIT_DIR"/COMMIT_EDITMSG
+if test -z "$no_edit"
+then
+	{
+		test -z "$only_include_assumed" || echo "$only_include_assumed"
+		run_status
+	} >>"$GIT_DIR"/COMMIT_EDITMSG
+else
+	# we need to check if there is anything to commit
+	run_status >/dev/null 
+fi
 if [ "$?" != "0" -a ! -f "$GIT_DIR/MERGE_HEAD" -a -z "$amend" ]
 then
 	rm -f "$GIT_DIR/COMMIT_EDITMSG"
 	run_status
 	exit 1
 fi
+
 case "$no_edit" in
 '')
 	case "${VISUAL:-$EDITOR},$TERM" in
-- 
1.3.0.rc3.g72c1
