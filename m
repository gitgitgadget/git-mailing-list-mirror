From: Linus Torvalds <torvalds@osdl.org>
Subject: Common option parsing..
Date: Wed, 12 Apr 2006 18:48:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604121828370.14565@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Apr 13 03:49:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FTqxF-0000Am-9P
	for gcvg-git@gmane.org; Thu, 13 Apr 2006 03:49:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbWDMBtB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Apr 2006 21:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbWDMBtB
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Apr 2006 21:49:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46988 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932424AbWDMBtA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Apr 2006 21:49:00 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3D1mutH016967
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 12 Apr 2006 18:48:57 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3D1msVq029780;
	Wed, 12 Apr 2006 18:48:55 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18646>


Junio,
 right now we actually haev very consistent command line options for git, 
but we have two (and in your "next" branch, three) different structures 
that they get parsed into, and lots of it is duplicated. We have 
"diff_options", "rev_info" and now "log_info".

To make matters worse, some things aren't actually in any of them, ie 
"--cc", "--abbrev" and friends actually end up being parsed into their own 
private flags in diff-files. Some are in _both_ rev_info and diff_options 
(the "--pretty" parsing), because both diff and rev-parse supported that 
option set.

And almost all commands that take any of those options at all end up 
actually taking the combination of them these days. Yeah, git-rev-parse 
doesn't, but quite frankly, with your "git log --diff" changes, that's 
actually the odd man out, and I think we should just make git-rev-parse 
basically do it too. 

And some things, like doing a builtin "git diff" would actually be quite 
easy to do, except for the fact that having three different option parsers 
_and_ having some options you parse by hand on top of that is just crazy 
("git diff" wants even the stage diff flags that git-diff-files takes).

The easiest way to just solve all this mess would be to 
 - add the diff-options into "struct rev_list" and make the 
   "setup_revisions()" parser parse the diff flags too.
 - get rid of "log_info" and "diff_options"
 - possibly rename the resulting super-options structure as "struct 
   git_options" or something if we want to.

At that point, it would become a lot easier to do things like a built-in 
"git diff", where command line parsing really is the biggest deal. It 
would become something like this:

	struct rev_info revs;
	struct commit *src, *dst;

	if (setup_revisions(&revs))
		die(git_diff_usage);

	/* No revision arguments: git-diff-files */
	if (!revs->commits)
		return diff_files(&revs);

	src = revs->commits->item;
	revs->commits = revs->commits->next;

	/* Just one rev: git-diff-index against that */
	if (!revs->commits)
		return diff_index(&revs, src);

	dst = revs->commits->item;
	revs->commits = revs->commits->next;

	/*
	 * More than two revs? Maybe that means a combined diff?
	 * Some day.. In the meantime, just make it an error.
	 */
	if (revs->commits->next)
		die(git_diff_usage);

	/*
	 * If it was "a..b" using git-rev-parse, the second commit
	 * on the list is the initial (and uninteresting) one, we
	 * need to make that the source..
	 */
	if (dst->object.flags & UNINTERESTING) {
		struct commit *tmp = dst;
		dst = src;
		src = tmp;
	}

	return diff_trees(&revs, src, dst);

where obviously we'd need to do some minor moving-around to make 
"diff_files()" be a function interface, but I actually did that, and it 
was really trivial. The bigger part would be to just change the structures 
around (which could be done first as a fairly big but trivial patch, kind 
of the same way the initial "struct rev_info" was done when the 
"revision.c" file was split away).

What do you think?

		Linus
