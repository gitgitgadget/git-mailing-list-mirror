From: Junio C Hamano <junkio@cox.net>
Subject: Necessity of "evil" merge and topic branches
Date: Wed, 17 May 2006 23:25:55 -0700
Message-ID: <7vy7wz6e8c.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0605172120160.10823@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 18 08:26:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fgbxb-0000h3-Qj
	for gcvg-git@gmane.org; Thu, 18 May 2006 08:26:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbWERGZ5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 May 2006 02:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751077AbWERGZ5
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 02:25:57 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:12025 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750843AbWERGZ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 May 2006 02:25:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060518062556.ILAW27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 18 May 2006 02:25:56 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605172120160.10823@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 17 May 2006 21:21:04 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20263>

When you are maintaining two codebases (one is slightly ahead of
the other, e.g. "master" and "next"), you would expect that a
topic branch based on "master" would apply well to "next".

So your "make guts of ls-files accessible from others, and make
git-add a built-in" is stored in "lt/dirwalk" topic branch,
based on a commit on "master".  By itself, it passes all tests.

When it is merged into "next", which has other stuff, literal
merging did not really work (not your fault).  Many tests that
involve writing trees (typically to create new commits) fail
miserably.

   o---o---o---o---o---o---o---o master
  .     \
  .      o---o---o lt/dirwalk -- contains builtin-add
  \               \ 
   o---o---o---o---o next -- up to date with "master" but
                             has many other stuff in it.

This is because the rule to manupulate the index is a bit
different on "next" branch, where it has jc/cache-tree topic.

With cache-tree, when you modify the index, you need to either
invalidate the path (and its parent directories up to root) in
the cached tree information, or discard the whole cache-tree,
whichever is easier [*1*].  So I have an "evil merge" that
merges the lt/dirwalk topic to next (it is ae12e59a).  It
changes the code like this:

        $ git diff lt/dirwalk next -- builtin-add.c
        diff --git a/builtin-add.c b/builtin-add.c
        index 089c7a8..7083820 100644
        --- a/builtin-add.c
        +++ b/builtin-add.c
        @@ -8,6 +8,7 @@ #include <fnmatch.h>
         #include "cache.h"
         #include "builtin.h"
         #include "dir.h"
        +#include "cache-tree.h"

         static const char builtin_add_usage[] =
         "git-add [-n] [-v] <filepattern>...";
        @@ -197,6 +198,7 @@ static int add_file_to_index(const char 
                        die("unable to add %s to index",path);
                if (verbose)
                        printf("add '%s'\n", path);
        +	cache_tree_invalidate_path(active_cache_tree, path);
                return 0;
         }

Obviously, this is a semantic adjustment, not a simple textual
merge, so no automated merge algorithm would help doing this for
me.  I literally edited the automerged builtin-add.c (the merge
is "one adds a new file, the other does not do anything" case,
so it trivially automerges at the tree level) and amended the
commit when I made the merge.

Now, unlike "pu", I never rewind "next", so once I did this
"evil merge", I do not have to worry about this anymore while
the topic is still on "next".  However, when jc/cache-tree topic
and lt/dirwalk topic both graduate to "master", I will somehow
need to remember to do this again.  That sounds somewhat painful
and quite error prone.

I am not going to rewind "next", so this evil merge will stay
there, but I am wondering if there was a better way I could have
handled this.

If I _know_ lt/dirwalk is going to graduate first (and I think
that is the case), I could have pulled lt/dirwalk into
jc/cache-tree topic, done an equivalent "evil merge" as the
above on jc/cache-tree topic, and pulled the result into "next".
That way, when lt/dirwalk alone graduates, I can just pull it
into "master".  Later, when the jc/cache-tree graduates, the
necessary "evil merge" will be pulled along with it, so I can
truly forget and not worry about it after I do the evil merge
once.

But in general, you would not know which one will graduate
first, so pulling one topic into another is not always a good
idea.  If I pull lt/dirwalk into jc/cache-tree, making
jc/cache-tree graduate alone becomes impossible.  Depending on
the readiness of these two topics, it may not be acceptable to
create such a dependency between topics.

One possibility I can think of is that I could have created
another topic branch that merged jc/cache-tree and lt/dirwalk in
the evil way, and pulled that into "next".  Then either one of
the topics can independently graduate to "master" without
waiting for the other.  I still have to remember that I need to
merge the third topic with evil merge when I make both of them
graduate to "master", but at least I do not have to remember the
details of how that evil merge should look like when I do so.  I
only need to remember that it needs to be done.

In practice, when I merge a topic branch into "master", I note
the paths that merge touches from "master", and run diff between
"master" and "next" for them to see if the remaining changes on
them are reasonable.  I will hopefully remember the need for
(and the details of) the evil merge that way when I pull these
two branches to "master", so what I did would not cause trouble
down the road (with some luck ;-), but I feel there should be a
better way to handle this situation.

Thoughts?


[Footnotes]

*1* In this message, let's not discuss if cache-tree is a good
  idea to begin with, if we should rip it out and/or if we
  should replace it with tree objects in the index.  I'd like to
  discuss SCM issue to handle somewhat interrelated topic
  branches here, not cache-tree.
