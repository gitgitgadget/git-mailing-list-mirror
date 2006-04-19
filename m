From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC/PATCH] Add git-unresolve <paths>...
Date: Wed, 19 Apr 2006 14:43:14 -0700
Message-ID: <7v8xq16y31.fsf@assigned-by-dhcp.cox.net>
References: <7vu08p72sn.fsf@assigned-by-dhcp.cox.net>
	<87acah6zk6.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 19 23:44:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWKSQ-00020k-0G
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 23:43:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWDSVnR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Apr 2006 17:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbWDSVnR
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Apr 2006 17:43:17 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:33728 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751202AbWDSVnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Apr 2006 17:43:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060419214315.CHEE8241.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 19 Apr 2006 17:43:15 -0400
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <87acah6zk6.wl%cworth@cworth.org> (Carl Worth's message of "Wed,
	19 Apr 2006 14:11:21 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18941>

Carl Worth <cworth@cworth.org> writes:

> But this does introduce an unfortunate semantic clash with the
> existing git-resolve, (which is an automated merge tool of some sort).
> I don't know much about the existing git-resolve, but a recent thread
> suggests it is a non-useful relic and people shouldn't be using it.

It is useful in a quick-and-dirty way, but does the same thing
as 'git merge -s resolve' and that is why people discussed
about removing it.  It has semantics quite different from
update-index, so I'd ignore the synonym part of your
discussion.

Time for a quick raise-hand.  Does anybody still use 'git
resolve'?  Maybe we could remove it by 1.4?

> It would be nice if the complementary operations of manually
> resolving and unresolving a merge conflict had complementary command
> names.

True.  I considered two other possibilities.

 * "git unmerge", because it creates unmerged index entries, and

 * "git update-index --unmerge", because this is just a special
   kind of updates to the index file.

> ... For example, it might also complain if it notices
> conflict markers in the file. That seems like it would be a useful
> convenience.

Since you should compile test the merge result before going
anywhere, and the primary target of git is to manage sources, it
might not matter in most of the case, but for non-sources and non
compiled languages, that certainly is an issue.

When it _does_ matter, you can have a customized pre-commit hook
to look for the conflict markers, like this:

diff --git a/templates/hooks--pre-commit b/templates/hooks--pre-commit
index 43d3b6e..723a9ef 100644
--- a/templates/hooks--pre-commit
+++ b/templates/hooks--pre-commit
@@ -61,6 +61,9 @@ perl -e '
 	    if (/^\s* 	/) {
 		bad_line("indent SP followed by a TAB", $_);
 	    }
+	    if (/^(?:[<>=]){7}/) {
+		bad_line("unresolved merge conflict", $_);
+	    }
 	}
     }
     exit($found_bad);

As usual, you can defeat the check with "git commit --no-verify"
for unlikely false matches.

> That's not much guidance for a new user that perhaps is only used to
> "git commit -a" and "git pull" that usually works. Without getting too
> verbose, this might be improved with something like:
>
> 	Automatic merge failed; fix conflicts by hand, then commit the result

That should be an easy patch ;-).

diff --git a/git-merge.sh b/git-merge.sh
index 78ab422..b834e79 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -335,5 +335,5 @@ Conflicts:
 	then
 		git-rerere
 	fi
-	die "Automatic merge failed; fix up by hand"
+	die "Automatic merge failed; fix conflicts and then commit the result."
 fi
