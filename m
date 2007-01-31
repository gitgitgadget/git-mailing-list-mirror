From: Junio C Hamano <junkio@cox.net>
Subject: Re: Fix "git tag -u" breakage
Date: Tue, 30 Jan 2007 20:56:37 -0800
Message-ID: <7vsldrx08q.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0701301957320.3611@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jan 31 05:56:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HC7WU-0004q3-31
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 05:56:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752145AbXAaE4j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 23:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752158AbXAaE4j
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 23:56:39 -0500
Received: from fed1rmmtai14.cox.net ([68.230.241.45]:33439 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752145AbXAaE4i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 23:56:38 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070131045636.KGBZ4586.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Tue, 30 Jan 2007 23:56:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Hgwd1W0091kojtg0000000; Tue, 30 Jan 2007 23:56:37 -0500
In-Reply-To: <Pine.LNX.4.64.0701301957320.3611@woody.linux-foundation.org>
	(Linus Torvalds's message of "Tue, 30 Jan 2007 20:00:22 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38227>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> The recent cleanup to understand
>
> 	[user]
> 		signingkey = ..
>
> sadly broke the old "-u signingkey" syntax. Admittedly the config file 
> approach is nicer, and I should probably use it, but even so, there's 
> really no reason to break the old syntax either.
>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
>
> This fixes it for me, and _looks_ obvious enough, but I didn't actually 
> test the other cases (ie tagger name and the config file). Caveat patchor.

Sorry, and thanks.

There was no reason to introduce a separate variable keyid to
begin with.  I should have been more careful to read what was
outside of the patch.

diff --git a/git-tag.sh b/git-tag.sh
index 988bf4c..4a0a7b6 100755
--- a/git-tag.sh
+++ b/git-tag.sh
@@ -113,8 +113,9 @@ object=$(git-rev-parse --verify --default HEAD "$@") || exit 1
 type=$(git-cat-file -t $object) || exit 1
 tagger=$(git-var GIT_COMMITTER_IDENT) || exit 1
 
-keyid=$(git-repo-config user.signingkey) ||
-	keyid=$(expr "z$tagger" : 'z\(.*>\)')
+test -n "$username" ||
+	username=$(git-repo-config user.signingkey) ||
+	username=$(expr "z$tagger" : 'z\(.*>\)')
 
 trap 'rm -f "$GIT_DIR"/TAG_TMP* "$GIT_DIR"/TAG_FINALMSG "$GIT_DIR"/TAG_EDITMSG' 0
 
@@ -141,7 +142,7 @@ if [ "$annotate" ]; then
       cat "$GIT_DIR"/TAG_FINALMSG ) >"$GIT_DIR"/TAG_TMP
     rm -f "$GIT_DIR"/TAG_TMP.asc "$GIT_DIR"/TAG_FINALMSG
     if [ "$signed" ]; then
-	gpg -bsa -u "$keyid" "$GIT_DIR"/TAG_TMP &&
+	gpg -bsa -u "$username" "$GIT_DIR"/TAG_TMP &&
 	cat "$GIT_DIR"/TAG_TMP.asc >>"$GIT_DIR"/TAG_TMP ||
 	die "failed to sign the tag with GPG."
     fi
