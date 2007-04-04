From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] display shortlog after git-commit
Date: Wed, 04 Apr 2007 01:15:53 -0700
Message-ID: <7vd52k7dxi.fsf@assigned-by-dhcp.cox.net>
References: <20070322104021.GJ29341@mellanox.co.il>
	<7v7it7kkl9.fsf@assigned-by-dhcp.cox.net>
	<20070404060213.GB31984@mellanox.co.il>
	<7v7iss8xo6.fsf@assigned-by-dhcp.cox.net>
	<20070404070135.GF31984@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Wed Apr 04 10:16:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZ0ev-0006wd-5O
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 10:16:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992730AbXDDIP5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 04:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992734AbXDDIP5
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 04:15:57 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:64022 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992730AbXDDIPz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 04:15:55 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070404081554.GOZS27119.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Wed, 4 Apr 2007 04:15:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id iwFt1W0071kojtg0000000; Wed, 04 Apr 2007 04:15:54 -0400
In-Reply-To: <20070404070135.GF31984@mellanox.co.il> (Michael S. Tsirkin's
	message of "Wed, 4 Apr 2007 10:01:35 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43722>

"Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:

>> I actually find it awkward that author/summary information is never
>> shown during git commit - sometimes one does git commit
>> on a machine where GIT_AUTHOR_EMAIL has not been setup
>> correctly, and the result often is mst@mst-desktop.(none).

That is something that needs to be set up once.  I do not think
it justifies wasting three more lines (one of them being an
empty line) per every commit.

>> Or people sometimes forget that the first line will show up
>> in the pretty=short summary and the result is that what
>> ends up being there is just 2 first lines of the long description.
>>
>> One has to remember to always do git log --pretty=short
>> after commit to verify that one did get these details right.

>> Ideas:
>> - Maybe have git-commit display shortlog summary for commit just created?
>
> Hopefully this will make people fix the git config up and amend their commits themselves.
> Does this sound like a good idea?

Maybe protect it with "[user] novice" in .git/config?  Otherwise
I think it gets too noisy once you get used to it. 

I think reviewing and fixing is best done in the editor (that's
why git-commit does not start reading from stdin when it expects
you to type a log message, but gives you an editor), and
pointing out a mistake after the fact, while it is probably
better than not pointing out at all, is not all that useful.  If
there is no mistake, it is just an added noise, and if there is
a mistake, the user needs to take another action (i.e. --amend)
to correct it.

I think a much better thing you could do is to have a mode that
the commit log message editor is started with something like
this...

	----------------------------------------------------------------
	From: A U Thor <au.thor@example.com>
        Subject: << the summary of the commit comes here >>
        
	# << more detailed explanations come here >>
	# Please enter the commit message for your changes.
        # (comment lines starting with '#' will not be included)
	# On branch 'master'
        # Changes to be committed:
        # ...
	----------------------------------------------------------------

and teach git-commit to notice the first paragraph that is
formatted like RFC2822 headers, and do appropriate things.

"Something like" this patch, although this time I have these two
words in quotes because I know the part to unmunge the buffer
needs more work.

diff --git a/git-commit.sh b/git-commit.sh
index 292cf96..d7a7b0b 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -546,10 +546,13 @@ else
 fi
 set_reflog_action "$rloga"
 
+summary_mark='<< the summary of the commit comes here >>'
 if test -z "$no_edit"
 then
 	{
+		echo "$summary_mark"
 		echo ""
+		echo "# << more detailed explanations come here >>"
 		echo "# Please enter the commit message for your changes."
 		echo "# (Comment lines starting with '#' will not be included)"
 		test -z "$only_include_assumed" || echo "$only_include_assumed"
@@ -579,7 +582,34 @@ case "$no_edit" in
 	esac
 	git-var GIT_AUTHOR_IDENT > /dev/null  || die
 	git-var GIT_COMMITTER_IDENT > /dev/null  || die
-	${VISUAL:-${EDITOR:-vi}} "$GIT_DIR/COMMIT_EDITMSG"
+	{
+		echo "From: $(expr "$(git-var GIT_AUTHOR_IDENT)" : '\(.*>\)')"
+		sed -e '1s/^/Subject: /' "$GIT_DIR/COMMIT_EDITMSG"
+		echo ""
+	} >"$GIT_DIR/COMMIT_EDITMSG+"
+	mv "$GIT_DIR/COMMIT_EDITMSG+" "$GIT_DIR/COMMIT_EDITMSG"
+	${VISUAL:-${EDITOR:-vi}} "$GIT_DIR/COMMIT_EDITMSG" || exit
+
+	AU=$(sed -n -e '
+		/^$/q
+		/^From: /{
+			s///p
+			q
+	}' "$GIT_DIR/COMMIT_EDITMSG")
+	if	test -n "$AU" &&
+		AN=$(expr "$AU" : '\(.*[^ ]\)  *<') &&
+		AE=$(expr "$AU" : '.*[^ ]  *<\(.*\)>$')
+	then
+		GIT_AUTHOR_NAME=$AN
+		GIT_AUTHOR_EMAIL=$AE
+		export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL
+	fi
+	sed -e '
+		/^From: /d
+		/^Subject: '"$summary_mark"'/d
+		s/^Subject: //
+	' "$GIT_DIR/COMMIT_EDITMSG" >"$GIT_DIR/COMMIT_EDITMSG+"
+	mv "$GIT_DIR/COMMIT_EDITMSG+" "$GIT_DIR/COMMIT_EDITMSG"
 	;;
 esac
 
