From: Junio C Hamano <junkio@cox.net>
Subject: Re: modifying commit's author
Date: Mon, 22 Jan 2007 13:03:31 -0800
Message-ID: <7vwt3ercyk.fsf@assigned-by-dhcp.cox.net>
References: <20070122203734.GB23187@fieldses.org>
	<7v8xfuss84.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 22 22:04:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H96KS-0003HH-2a
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 22:03:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932647AbXAVVDe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 16:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932659AbXAVVDe
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 16:03:34 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:45855 "EHLO
	fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932647AbXAVVDc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 16:03:32 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070122210332.IINS16632.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>;
          Mon, 22 Jan 2007 16:03:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id EM3p1W00z1kojtg0000000; Mon, 22 Jan 2007 16:03:50 -0500
To: "J. Bruce Fields" <bfields@fieldses.org>
In-Reply-To: <7v8xfuss84.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 22 Jan 2007 12:48:27 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37454>

Junio C Hamano <junkio@cox.net> writes:

> "J. Bruce Fields" <bfields@fieldses.org> writes:
>
>> If I got the author wrong on a commit, is there a quick way to fix it
>> (e.g. by passing the right arguments or environment variables to commit
>> --amend)?
>
> I usually do "format-patch -$n; reset --hard HEAD~$n; edit
> 00??-*.patch; am 00??-*.patch" myself when I got into that
> situation to rebuild the branch, and haven't personally felt
> need for an option to --amend, but it might make sense to teach
> git-commit --amend to allow --author option to override it; I
> think it currently ignores --author when given without erroring
> out.
>
> It may become a question if we would want to allow updating the
> timestamp as well, but when people asked for --author I did not
> hear from anybody who wanted to have --authortime, so not being
> able to do so probably is Ok.

Untested, but something along this line.

-- >8 --
[PATCH] honor --author even with --amend, -C, and -c.

Earlier code discarded GIT_AUTHOR_DATE taken from the base
commit when --author was specified.  This was often wrong as
that use is likely to fix the spelling of author's name.

---

diff --git a/git-commit.sh b/git-commit.sh
index e23918c..6f4dcdb 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -462,15 +462,7 @@ if test -f "$GIT_DIR/MERGE_HEAD" && test -z "$no_edit"; then
 fi >>"$GIT_DIR"/COMMIT_EDITMSG
 
 # Author
-if test '' != "$force_author"
-then
-	GIT_AUTHOR_NAME=`expr "z$force_author" : 'z\(.*[^ ]\) *<.*'` &&
-	GIT_AUTHOR_EMAIL=`expr "z$force_author" : '.*\(<.*\)'` &&
-	test '' != "$GIT_AUTHOR_NAME" &&
-	test '' != "$GIT_AUTHOR_EMAIL" ||
-	die "malformed --author parameter"
-	export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL
-elif test '' != "$use_commit"
+if test '' != "$use_commit"
 then
 	pick_author_script='
 	/^author /{
@@ -501,6 +493,15 @@ then
 	export GIT_AUTHOR_EMAIL
 	export GIT_AUTHOR_DATE
 fi
+if test '' != "$force_author"
+then
+	GIT_AUTHOR_NAME=`expr "z$force_author" : 'z\(.*[^ ]\) *<.*'` &&
+	GIT_AUTHOR_EMAIL=`expr "z$force_author" : '.*\(<.*\)'` &&
+	test '' != "$GIT_AUTHOR_NAME" &&
+	test '' != "$GIT_AUTHOR_EMAIL" ||
+	die "malformed --author parameter"
+	export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL
+fi
 
 PARENTS="-p HEAD"
 if test -z "$initial_commit"
