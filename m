From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-repack -a -d produces unusable packs with 1.4.0
Date: Sun, 25 Jun 2006 05:23:52 -0700
Message-ID: <7vbqshtodj.fsf@assigned-by-dhcp.cox.net>
References: <20060625113522.GC19210@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 25 14:24:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuTef-0004Tx-OZ
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 14:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWFYMXz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Jun 2006 08:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWFYMXz
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jun 2006 08:23:55 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:47300 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750768AbWFYMXy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jun 2006 08:23:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060625122353.CTHH19057.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 25 Jun 2006 08:23:53 -0400
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: <20060625113522.GC19210@cip.informatik.uni-erlangen.de> (Thomas
	Glanzmann's message of "Sun, 25 Jun 2006 13:35:22 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22619>

Thomas Glanzmann <sithglan@stud.uni-erlangen.de> writes:

>         Pack pack-ce49d2efd5af06ed6093049050b5ba41da8b683f created.
>         mv: overwrite `.git/objects/pack/pack-ce49d2efd5af06ed6093049050b5ba41da8b683f.pack', overriding mode 0444? y
>         mv: overwrite `.git/objects/pack/pack-ce49d2efd5af06ed6093049050b5ba41da8b683f.idx', overriding mode 0444? y
>         fatal: packfile .git/objects/pack/pack-ce49d2efd5af06ed6093049050b5ba41da8b683f.pack does not match index.

I would understand if you answer 'y' to one but 'n' to the other
it would result in a situation with unmatching .pack and .idx
and you would see something like the above (by the way, the
"fatal" is coming from update-server-info that tries to read
from freshly moved packfiles); but the above is different, so it
does not explain the symptom.  I am worried and curious as to
what happened, since you are answering 'y' to both of them.
This would trigger immediately after a clone which creates pack
and idx unwritable; repack leaves the results writable unless
your umask is 0222, so "mv" would not even ask the silly
questions.

Did you happen to have .tmp-pack-ce49d2ef... at the project root
level after this failure?  If so which one (either .pack or .idx)?

If you had .tmp-pack-*.pack then .git/objects/pack/pack-ce49...pack
is from the old round and .git/objects/pack/pack-ce49...idx is
from the new one.  Moving .tmp-pack-* to .git/objects/pack/pack-*
would hopefully solve this problem.

Nevertheless, this _is_ a dangerous and grave bug, and thanks
for reporting it.

Maybe we would want to do something like this:

-- >8 --
git-repack: Be careful when updating the same pack as existing one.

After clone, packfiles are read-only by default and "mv" went
interactive asking if the user wants to replace it with a
repacked copy.  If one is successfully moved and the other is
not, the pack and its idx would become out-of-sync and corrupts
the repository.

Recovering is straightforward -- it is just the matter of
finding the remaining .tmp-pack-* and make sure they are both
moved -- but we should be extra careful not to do something so
alarming to the users.

---
diff --git a/git-repack.sh b/git-repack.sh
index eb75c8c..b58cf91 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -54,9 +54,21 @@ else
 	fi
 	mkdir -p "$PACKDIR" || exit
 
-	mv .tmp-pack-$name.pack "$PACKDIR/pack-$name.pack" &&
-	mv .tmp-pack-$name.idx  "$PACKDIR/pack-$name.idx" ||
-	exit
+	for sfx in pack idx
+	do
+		if test -f "$PACKDIR/pack-$name.$sfx"
+		then
+			mv -f "$PACKDIR/pack-$name.$sfx" "$PACKDIR/old-pack-$name.$sfx"
+		fi
+	done
+	mv -f .tmp-pack-$name.pack "$PACKDIR/pack-$name.pack" &&
+	mv -f .tmp-pack-$name.idx  "$PACKDIR/pack-$name.idx" || {
+		echo >&2 "Couldn't replace the existing pack with updated one."
+		echo >&2 "The original set of packs have been saved as"
+		echo >&2 "old-pack-$name.{pack,idx} in $PACKDIR."
+		exit 1
+	}
+	rm -f "$PACKDIR/old-pack-$name.pack" "$PACKDIR/old-pack-$name.idx" 
 fi
 
 if test "$remove_redundant" = t
