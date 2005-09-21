From: Petr Baudis <pasky@suse.cz>
Subject: [Core GIT] Long-term cherrypicking
Date: Wed, 21 Sep 2005 18:40:15 +0200
Message-ID: <20050921164015.GC21971@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kkeil@suse.de
X-From: git-owner@vger.kernel.org Wed Sep 21 18:40:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EI7dt-0003t0-Ew
	for gcvg-git@gmane.org; Wed, 21 Sep 2005 18:40:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbVIUQkT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 12:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbVIUQkT
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 12:40:19 -0400
Received: from w241.dkm.cz ([62.24.88.241]:57782 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751133AbVIUQkS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2005 12:40:18 -0400
Received: (qmail 2749 invoked by uid 2001); 21 Sep 2005 18:40:15 +0200
To: git@vger.kernel.org
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9062>

  Hello,

  I've been working out some workflow possibilities with Karsten Keil at
the SuSE Labs conference, and I'd like to see your opinions. His
position does not seem unique at all, so I'm a bit surprised that noone
solved this before, or at least I didn't find any documentation about
this in the tutorial and howtos (or perhaps I missed it?).

  His situation is that he has some patches in the ISDN subsystem, a
public repository, but sends the patches over e-mail to Linus. So he is
something between the subsystem maintainer and individual developer in
the categories listed out in the tutorial. What should be his merging
strategy?

  Since he has public repository, he cannot rebase, but he needs to
be cherrypicking. The trouble is, git-cherry really does not work
"through" merges now - it stops at his last merge with Linus. The
obvious solution would be something like this patch:


diff --git a/git-cherry.sh b/git-cherry.sh
--- a/git-cherry.sh
+++ b/git-cherry.sh
@@ -5,18 +5,22 @@
 
 . git-sh-setup || die "Not a git archive."
 
-usage="usage: $0 "'[-v] <upstream> [<head>]
+usage="usage: $0 "'[-v] <upstream> [<head>] [<base>]
 
              __*__*__*__*__> <upstream>
-            /
-  fork-point
+            /         \
+      <base>           \ fork-point
             \__+__+__+__+__+__+__+__> <head>
 
 Each commit between the fork-point and <head> is examined, and
-compared against the change each commit between the fork-point and
+compared against the change each commit between the <base> and
 <upstream> introduces.  If the change seems to be in the upstream,
 it is shown on the standard output with prefix "+".  Otherwise
 it is shown with prefix "-".
+
+If no <base> is specified, it is assumed to be the same as fork-point.
+This is the case if you run git-cherry only before you merge the
+upstream.
 '
 
 case "$1" in -v) verbose=t; shift ;; esac 
@@ -35,12 +39,16 @@ case "$#" in
 2) upstream=`git-rev-parse --verify "$1"` &&
    ours=`git-rev-parse --verify "$2"` || exit
    ;;
+3) upstream=`git-rev-parse --verify "$1"` &&
+   ours=`git-rev-parse --verify "$2"` &&
+   base=`git-rev-parse --verify "$3"` || exit
 *) echo >&2 "$usage"; exit 1 ;;
 esac
 
 # Note that these list commits in reverse order;
 # not that the order in inup matters...
-inup=`git-rev-list ^$ours $upstream` &&
+[ -z "$base" ] && base=$ours
+inup=`git-rev-list ^$base $upstream` &&
 ours=`git-rev-list $ours ^$upstream` || exit
 
 tmp=.cherry-tmp$$


  Then you would invoke it like

	git cherry origin master forkpoint

where forkpoint is a tag pointing at the last known point in Linus'
branch when he had all my (well, Karsten's) patches integrated in his
tree. I tested it briefly and it seems to work - I suppose that I will
leave more testing to him. :-) If GIT wants to be even cooler, it could
remember the last forkpoint and automatically advance it.

  Opinions?


PS: Perex hints over my shoulder that the ALSA guys are just manually
recording which patches were merged and which weren't. It's a shame that
GIT has no UI to do that for them if it can. Anyway, I'll be thinking
about if/how to implement the cherrypicking workflow support for Cogito.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
