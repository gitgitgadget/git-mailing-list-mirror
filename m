From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Detect renames in diff family.
Date: Thu, 19 May 2005 17:48:30 -0700
Message-ID: <7vy8aawwm9.fsf@assigned-by-dhcp.cox.net>
References: <7vu0kz1p6k.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505190901340.2322@ppc970.osdl.org>
	<7v4qcz16n6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.62.0505191426000.20274@localhost.localdomain>
	<7vsm0jyryf.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.62.0505191456040.20274@localhost.localdomain>
	<7vy8abx8ay.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.62.0505191643030.20274@localhost.localdomain>
	<7vll6ayjok.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505191516350.2322@ppc970.osdl.org>
	<7vhdgyyeom.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505191656310.2322@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 02:48:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYvgN-0004ph-TL
	for gcvg-git@gmane.org; Fri, 20 May 2005 02:48:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbVETAs6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 20:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbVETAs6
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 20:48:58 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:57013 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261219AbVETAsd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2005 20:48:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050520004831.ETHL12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 19 May 2005 20:48:31 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505191656310.2322@ppc970.osdl.org> (Linus
 Torvalds's message of "Thu, 19 May 2005 17:10:53 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> Hmm.. You're right, but it feels kind of wrong. Clearly we
LT> support removals in diff-files, but you're right, we can
LT> never have something show up as an addition, since we only
LT> ever compare against files that are already mentioned in the
LT> cache.

LT> Or am I just being confused and/or stupid?

No, you are not confused nor stupid.  We discussed something
related to this about three weeks ago.  We ended up not doing
what we discussed, but if we had adopted the convention of the
delayed addition to the cache I described as "magic SHA1" in the
quoted message below, that would have been the "intent to add"
that diff-files would report as an addition.

To:	Linus Torvalds <torvalds@osdl.org>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH] Really fix git-merge-one-file-script this time.
From:	Junio C Hamano <junkio@cox.net>
Date:	Sun, 01 May 2005 11:38:15 -0700
Message-ID: <7vzmveu6zs.fsf@assigned-by-dhcp.cox.net>

 (... some discussion omitted ...)
I am wondering if the following changes would make sense and
make things easier for you:

 * git-merge-one-file-script is changed to register the path
   with --cacheinfo using magic SHA1 0{40} instead of using the
   resulting file on the filesystem.  Do keep the current
   behaviour of leaving the merge results of trivial merges
   (both kind) in the work tree.

 * git-write-tree is changed to refuse to write from a cache
   that records the magic SHA1.

 * git-ls-files acquires a new option --merged to notice the
   magic SHA1 and shows the paths that have such SHA1.

 * git-update-cache acquires a new option --resolve to notice
   the magic SHA1 and:

   - if the named path is not in the work tree anymore, delete
     the entry.

   - if the named path exists in the work tree, compute the
     latest SHA1 for that file and update the entry.

Changes other than the first two listed above are purely
optional, since the Porcelain layer can implement them without
the Plumbing support.  Not doing them would keep the Plumbing
somewhat cleaner by not having to know about this magic SHA1
convention.  On the other hand, we already use that convention
in git-diff-cache, so it may even be a consistent change to make
these optional changes.  Essentially, the magic SHA1 in the
cache means "I know the user wants me to keep an eye on this
path when it matters" [*2*].

[Footnotes]

 (... footnote *1* omitted ...)

*2* This convention would also make an implementation of "SCM
add" in the Porcelain layer a bit more efficient.  A typical
workflow without such a convention would consist of:

 * Create a file and start editing.
 * "SCM add" file, causing "git-update-cache --add -- file".
 * Do more changes, and review.
 * "SCM commit" which does"git-update-cache" changed files,
   "git-write-tree" and "git-commit-tree" to commit.

which wastes one extra blob object per "SCM add".  My gut
feeling is that more than 80% of the time "SCM add" is followed
by some edit to the added file before "SCM commit", unless it is
the initial import.  If we adopt that convention, "SCM add"
would register with --cacheinfo with the magic SHA1 without
creating the useless blob, and "SCM commit" will be written to
lazily pick things up from the work tree.

