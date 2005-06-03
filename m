From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix -B "very-different" logic.
Date: Thu, 02 Jun 2005 18:33:18 -0700
Message-ID: <7vis0wusv5.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org>
	<m1psv7bjb6.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0505312002160.1876@ppc970.osdl.org>
	<7vmzqau3es.fsf@assigned-by-dhcp.cox.net>
	<7vll5sz54z.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506021716140.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 03 03:31:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1De112-0001D5-0w
	for gcvg-git@gmane.org; Fri, 03 Jun 2005 03:30:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261477AbVFCBdb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 21:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261478AbVFCBdb
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 21:33:31 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:40093 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261477AbVFCBdU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2005 21:33:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050603013319.OGYN12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 2 Jun 2005 21:33:19 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506021716140.1876@ppc970.osdl.org> (Linus
 Torvalds's message of "Thu, 2 Jun 2005 17:21:43 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> Careful. 

LT> I think the amount of new code _should_ matter. Otherwise, an old empty
LT> file would always be considered the source of a new file, since the diff 
LT> doesn't remove anything. Similarly, just because we have a boilerplate 
LT> file shouldn't make that always be considered a "wonderful source", when 
LT> people add the real meat to it.

Yes, I agree that rename/copy logic should use different
heuristics from the one I proposed for breaking.

It is my assumption that people in practice tend to make only
small edits after a rename/copy just to adjust things like:

 - filenames mentioned in the comment of the file itself,

 - include paths that refer other files if the file was
   moved/copied from a different directory,

 - names of functions and variables.

and making sure there would not be too much new stuff is quite
useful to detect rename/copy source correctly as the current
similarity estimator in diffcore-rename does.  I do not intend
to touch that.

The boilderplate example you mention is a very good reason not
to dismiss the amount of new material when doing rename/copy
detection.

LT> In particular, let's say that I used to have two files:

LT> 	a.c - small helper functions
LT> 	b.c - the "meat" of the thing

LT> and I end up deciding that I might as well collapse it all into one file, 
LT> a.c. What happens? There's almost no deletes from a.c, but there's a lot 
LT> of new code in it. 

LT> See what I'm saying?

Yes.  I think I do.

When git-diff-tree -B -C runs your example, it feeds diffcore
with these:

  :100644 100644 sha1-a-helper-only sha1-a-and-meat M   a.c
  :100644 000000 sha1-b-stale-meat  0{40}           D   b.c

The ideal diffcore-break breaks a.c because it looks at
insertions as well:

  :100644 000000 sha1-a-helper-only 0{40}           D   a.c
  :000000 100644 0{40}              sha1-a-and-meat N   a.c
  :100644 000000 sha1-b-stale-meat  0{40}           D   b.c

Then diffcore-rename notices that sha1-b-stale-meat is better
match than sha1-a-helper-only to produce sha1-a-and-meat, and
resolves the above to:

  :100644 100644 sha1-b-stale-meat  sha1-a-and-meat R   b.c	a.c

Up to this point is just a demonstration that I see your point.

But I still want to keep the example I gave in the original
commit message.  Suppose you did not have b.c file under version
control, and did the same operation.  I.e. a.c acquired a lot of
good stuff.  git-diff-tree -B -C feeds:

  :100644 100644 sha1-a-helper-only sha1-a-and-meat M   a.c

which is broken into:

  :100644 000000 sha1-a-helper-only 0{40}           D   a.c
  :000000 100644 0{40}              sha1-a-and-meat N   a.c

Unfortunately, in this case nobody absorbs these pairs.  I want
to allow you to add 1000 lines of new stuff to a file (which was
originally 100 lines long) as long as you do not remove too many
lines from the original 100 lines without triggering "this is a
rewrite" logic in this case.  So after rename/copy runs, we need
to match these up and merge them back into the original.

  :100644 100644 sha1-a-helper-only sha1-a-and-meat M   a.c

We should carry a bit more information about broken entries than
we currently do.  We would break a pair based on both deletion
and insertion, just like the current code (i.e. without the
patch you are responding to) does.  But when we do break a pair,
we need to mark them if the "new" side have enough original
source material remaining.  If we have such mark to tell us that
"these were broken but there are a good chunk of source material
remaining", the clean-up phase, to run after diffcore-rename
finishes, should be able to notice surviving broken pairs and
merge them back accordingly.

