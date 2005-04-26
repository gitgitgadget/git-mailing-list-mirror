From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/2] diff-tree/diff-cache helper
Date: Tue, 26 Apr 2005 00:39:59 -0700
Message-ID: <7vll76ouk0.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0504232202340.19877@ppc970.osdl.org>
	<7v1x8zsamn.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504251832480.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 26 09:42:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQKgB-0008S6-LG
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 09:40:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbVDZHoo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 03:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbVDZHl4
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 03:41:56 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:27362 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261383AbVDZHkB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2005 03:40:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050426073959.JWXJ20235.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 26 Apr 2005 03:39:59 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504251832480.18901@ppc970.osdl.org> (Linus
 Torvalds's message of "Mon, 25 Apr 2005 18:38:05 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> Good, applied.

LT> This also makes me think that we should just make "show-diff" show the
LT> same format, at which point show-diff actually matches all the other
LT> tools, and it is likely to make show-diff more useful to boot.

Matching is good, ...

LT> Maybe rename the "show-diff" command to be "cache-diff", and if somebody
LT> wants the old "show-diff" thing, just have a script that does

LT> 	#!/bin/sh
LT> 	cache-diff | diff-tree-helper

LT> and nothing more.

Well, great minds do not think alike ;-) I was actually going in
quite the opposite way for the same goal of "matching".  My plan
was to rewrite the external diff interface once more to make it
more generic.  Then to add -p (patch) flag to diff-tree and
diff-cache, so that we do not need diff-tree-helper anymore.  My
ultimate motive for all of this is to make the core GIT useful
enough to render Cogito or any other wrapper layer more or less
irrelevant ;-).  Well type ^W a couple of times and rephrase
that to make things easier for the wrapper layer.

Jokes aside, I have updated the external diff interface and will
be sending you a patch in a separate message.  The existing
external diff interface had a horrible interface to the callers,
and it had a hardcoded knowledge of how to call diff and what
parameters to pass in which order, so the customization the end
user or the scripts could make was quite limited.  The updated
interface allows pretty much arbitrary formatting, so "git diff"
can put SHA1 instead of short-and-sweet 'a' or 'b' as directory
prefix in the patch output, for example.

When an environment variable GIT_EXTERNAL_DIFF exists, it names
a script that takes 7 parameters:

    name file1 sha1-1 mode1 file2 sha1-2 mode2

This is essentially the same idea you used for merge-cache.
Then the named command can use these information to generate and
format the diff any way it wants.  See how it interfaces using
the examples like this:

    GIT_EXTERNAL_DIFF=echo show-diff
    diff-cache $(cat .git/HEAD) | \
    GIT_EXTERNAL_DIFF=./jit-external-diff-script diff-tree-helper

The patch comes with a sample script, jit-external-diff-script,
but it is not much better than the built-in one; I do not expect
it to be used for anything other than starting point for wrapper
writers.

Without the environment variable, it uses a built-in
implementation that behaves exactly like the traditional
show-diff, and it can be customized via GIT_DIFF_CMD and
GIT_DIFF_OPTS as before.

