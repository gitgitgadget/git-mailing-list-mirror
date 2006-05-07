From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] get_pathspec(): free() old buffer if rewriting
Date: Sat, 06 May 2006 21:26:12 -0700
Message-ID: <7viroipijf.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0605070003430.6357@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0605061532190.16343@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 07 06:26:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fcaqt-0006I3-Be
	for gcvg-git@gmane.org; Sun, 07 May 2006 06:26:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbWEGE0U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 00:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750967AbWEGE0U
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 00:26:20 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:53748 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750830AbWEGE0U (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 May 2006 00:26:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060507042618.WEWK25666.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 7 May 2006 00:26:18 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605061532190.16343@g5.osdl.org> (Linus Torvalds's
	message of "Sat, 6 May 2006 15:37:19 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19690>

Linus Torvalds <torvalds@osdl.org> writes:

> On Sun, 7 May 2006, Johannes Schindelin wrote:
>> 
>> This might be the wrong way to do it, but as it is without this patch,
>> get_pathspec() is leaking memory.
>
> I'm not at all convinced we want to do somethng like this.
>
> get_pathspec() is a one-time event. It doesn't "leak" memory. To me, 
> "leaking" is when you continually lose a bit of memory, and you eventually 
> run out. I don't see that happening here.

I agree with that, except that blame does use it for each
commit and loses memory with deep history.

I have been contemplating to revamp pathspec stuff to deal with
not just an array pointers to strings.  tree-diff already uses a
parallel array of ints (pathlens) to optimize away the repeated
use of strlen() for each pathspec elements, and I think we would
be better off using something like that everywhere.  The API I
have in mind goes like this:

struct pathspec; /* opaque */ 

	A type opaque to the caller.

struct pathspec **get_pathspec(const char *prefix,
			       const char **pathspec,
			       int wildcard);

	The caller gives the prefix (return value from
	setup_git_directory(), the user supplied pathspec list,
	and if it wants to use ls-files style wildcard or
	tree-diff style directory prefix bahaviour.  A newly
	allocated array is returned and the caller can free() it
	when done.

int match_pathspec(const char *path, int len,
	           struct pathspec **pathspec);

	See if the path (with length) matches the given spec.
	path[len-1] == '/' signals that the caller is traversing
	a tree and checking if it is worth descending into the
	tree.  In that case, original spec string "foo/bar/baz"
	matches path = "foo/" (with len = 4).  Otherwise the full
	path is checked so that original spec string would match
	path = "foo/bar/baz" (with len = 11), but not "foo"
	(with len = 3).  If the get_pathspec() was called with
	wildcard support, spec string "foo/bar*" matches these:

                "foo/" (i.e. should descend into it),
                "foo/barboz/" (ditto)
                "foo/bar.txt" (matches)

        but not these:

		"fob/" (no point descending into it)
                "foo/bax" (does not match)

A wildcard aware diff-tree, when invoked like this:

	cd Documentation
        git-diff-tree -r A B -- 'ho*'

might do:

	struct pathspec **spec;
        const char *(paths[2]);
	paths[0] = "how*"; paths[1] = NULL;
	spec = get_pathspec("Documentation/", argv, 1);

and when traversing the tree for A and B, upon seeing "Documentation"
entry in the topleve tree object buffers, call:

	path_match("Documentation", 14, 1, spec)

which would return true (worth descending into the directory).
The recursive call would, upon seeing "hooks.txt" entry, call:

	path_match("Documentation/hooks.txt", 23, 0, spec)

which would say true and compares the entry from two trees.
Also, the same recursive invocation would call

	path_match("Documentation/howto", 19, 1, spec)

which would return true to cause it further recurse into it.
