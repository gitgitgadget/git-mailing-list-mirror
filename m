From: Junio C Hamano <junkio@cox.net>
Subject: Re: "fatal: Untracked working tree file 'so-and-so' would be overwritten by merge"
Date: Sun, 08 Oct 2006 22:20:09 -0700
Message-ID: <7vodsmdq0m.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0610081657400.3952@g5.osdl.org>
	<7v7izaf62c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 09 07:20:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWnYp-0006nF-AF
	for gcvg-git@gmane.org; Mon, 09 Oct 2006 07:20:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751658AbWJIFUN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Oct 2006 01:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbWJIFUN
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Oct 2006 01:20:13 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:63457 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751658AbWJIFUL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Oct 2006 01:20:11 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061009052010.XDJE18985.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>;
          Mon, 9 Oct 2006 01:20:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Y5LD1V0021kojtg0000000
	Mon, 09 Oct 2006 01:20:13 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7v7izaf62c.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 08 Oct 2006 21:48:11 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28562>

Junio C Hamano <junkio@cox.net> writes:

> But that is a bit tricky.  This is not on the aggressive path,
> and the merge result is decided by the policy implemented by the
> caller of read-tree.  So in that sense we should not be doing
> the working tree check ourselves either.  We just should leave
> that to the caller.
>
> Hence, I think removing the above "else if" part altogether is
> the right thing to do here.
>
> ---
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 3ac0289..b1d78b8 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -661,8 +661,6 @@ int threeway_merge(struct cache_entry **
>  	if (index) {
>  		verify_uptodate(index, o);
>  	}
> -	else if (path)
> -		verify_absent(path, "overwritten", o);
>  
>  	o->nontrivial_merge = 1;
>  

Note note note.  The above patch alone leaves merge risky to
remove an untracked working tree files, and needs to be
compensated by corresponding checks to the git-merge-xxx
strategies.  The original code was overcautious, but was
protecting valid cases too.

For example, you and I recently independently did something
called show-refs (mine was actually called show-ref but I could
have picked a name that happened to conflict with yours), and it
was when I had an uncommitted, not even in index, work-in-progress
when I saw your version.  If I pulled from you, the version of
read-tree without above check would have happily said it is OK
to do a three-way merge, and git-merge-one-file would have said
you added one while I haven't, and would have tried to overwrite
the file in my working tree.

But this still feels wrong, at two levels.

For one thing, the beauty of git merge was that if there is a
risk of local changes being lost, it was detected at read-tree
stage and we did not even touch index in that case.  Not
detecting problems at read-tree time and leaving it to
merge-one-file feels wrong.  Very wrong.

I suspect the other issue I have is easier to address -- if we
were to implement the check at merge-one-file level, it would be
something like the attached patch, but at the same time it
should take .gitignore file into account.

---

diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
index fba4b0c..25aedb7 100755
--- a/git-merge-one-file.sh
+++ b/git-merge-one-file.sh
@@ -23,6 +23,9 @@ #
 "$1.." | "$1.$1" | "$1$1.")
 	if [ "$2" ]; then
 		echo "Removing $4"
+	elif test -f "$4"
+		echo "ERROR: untracked $4 is removed by the merge."
+		exit 1
 	fi
 	if test -f "$4"; then
 		rm -f -- "$4" &&
@@ -34,8 +37,16 @@ #
 #
 # Added in one.
 #
-".$2." | "..$3" )
+".$2.")
+	# the other side did not add and we added so there is nothing
+	# to be done.
+	;;
+"..$3")
 	echo "Adding $4"
+	test -f "$4" || {
+		echo "ERROR: untracked $4 is overwritten by the merge."
+		exit 1
+	}
 	git-update-index --add --cacheinfo "$6$7" "$2$3" "$4" &&
 		exec git-checkout-index -u -f -- "$4"
 	;;
