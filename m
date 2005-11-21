From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] git-format-patch options
Date: Mon, 21 Nov 2005 11:27:12 -0800
Message-ID: <7vhda5ssxb.fsf@assigned-by-dhcp.cox.net>
References: <20051121162540.4722.qmail@web31812.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Nov 21 20:28:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeHJu-0005Fl-As
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 20:27:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbVKUT1P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 14:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbVKUT1P
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 14:27:15 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:59568 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932183AbVKUT1O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 14:27:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051121192637.JFIU6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 21 Nov 2005 14:26:37 -0500
To: Luben Tuikov <ltuikov@yahoo.com>
In-Reply-To: <20051121162540.4722.qmail@web31812.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Mon, 21 Nov 2005 08:25:40 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12469>

Luben Tuikov <ltuikov@yahoo.com> writes:

> I was wondering about the value of
>
>   git-format-patch <commit-ish>
>
> to output/prepare a diff patch between the indicated commit
> and its parent.  As opposed to the current behaviour giving
> all changes between the indicated commit and HEAD.

Yes, that would be "git-format-patch $commit^1 $commit", but it
might deserve better shortcuts.

Later Andreas quoted the backward compatibility constraints:

> # Backward compatible argument parsing hack.
> #
> # Historically, we supported:
> # 1. "rev1"     is equivalent to "rev1..HEAD"
> # 2. "rev1..rev2"
> # 3. "rev1" "rev2   is equivalent to "rev1..rev2"
> #
> # We want to take a sequence of "rev1..rev2" in general.
> # Also, "rev1.." should mean "rev1..HEAD"; git-diff users are
> # familiar with that syntax.

The case statement that follows that comment is not quite right,
BTW.  "format-patch foo bar..baz" should mean sequence of "foo"
and then "bar..baz", but it incorrectly translates to a
malformed "foo..bar..baz".

Modulo that bug, what the current code does is to special case
one or two arguments case and rewrite them in that case
statement, and then iterate over the resulting "$@".  We barf if
each 'revpair' is not in rev1..rev2 format.

But it might make sense to (still keeping the above three
backward compatibility syntax exceptions) interpret "rev" to
mean "rev^1..rev", like this:

---

diff --git a/git-format-patch.sh b/git-format-patch.sh
index 7ee5d32..351790c 100755
--- a/git-format-patch.sh
+++ b/git-format-patch.sh
@@ -99,7 +99,7 @@ filelist=$tmp-files
 # Also, "rev1.." should mean "rev1..HEAD"; git-diff users are
 # familiar with that syntax.
 
-case "$#,$1" in
+case "$#,$1$2" in
 1,?*..?*)
 	# single "rev1..rev2"
 	;;
@@ -131,7 +131,8 @@ do
 		rev2=`expr "$revpair" : '.*\.\.\(.*\)'`
 		;;
 	*)
-		usage
+		rev1="$revpair^"
+		rev2="$revpair"
 		;;
 	esac
 	git-rev-parse --verify "$rev1^0" >/dev/null 2>&1 ||
