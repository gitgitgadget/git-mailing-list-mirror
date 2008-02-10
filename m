From: "George Spelvin" <linux@horizon.com>
Subject: Re: Upcoming memcached releases + rambling.
Date: Sun, 10 Feb 2008 04:47:53 -0500
Message-ID: <20080210094753.23234.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, memcached@lists.danga.com
X-From: git-owner@vger.kernel.org Sun Feb 10 10:48:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JO8na-0004rt-Jz
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 10:48:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752599AbYBJJr4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 04:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752238AbYBJJr4
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 04:47:56 -0500
Received: from science.horizon.com ([192.35.100.1]:11288 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751724AbYBJJrz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 04:47:55 -0500
Received: (qmail 23235 invoked by uid 1000); 10 Feb 2008 04:47:53 -0500
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73327>

A few notes about git that may be causing confusion:

1) "git pull" does more than you think, and is for developers only.

   To just follow some other work, use only "git fetch".

   "git pull" does a fetch, and then merges the fetched branch into your
   current HEAD.  If your current HEAD is a copy of the remote branch,
   this will be harmless, but if it's not, it will produce code changes.

   "git fetch" will fetch the remote branch, and then do a "fast-forward"
   update of the corresponding local tracking branch.  If the local
   tracking branch is not an ancestor of the fetched branch, it will
   abort with an error.

   So, in summary, don't use "pull" unless you want to do a merge.
   It will suppress the merge in the obvious trivial cases (no changes
   on one side or the other), but will happily combine things.

   (The reason that "pull" is such a prominent command is that it's what
   Linus does all day: merges other people's development into his tree.)


2) "git log old..new" is a special case of a very general mechanism
   for specifying a set of commits to examine.  See the man page for
   "git-rev-parse" for the full complete rules.  You specify a set of
   commits to include, and a set to exclude.

   The syntax is "include1 include2 ^exclude1 ^exclude2 include3...".

   A commit is included in the final set if it is an ancestor of one of
   the explicitly listed "include" commits, *and* it is *not* an ancestor
   of any of the listed "exclude" commits.

   old..new is a convenient equivalent for "^old new": everything in new's
   history that is not included in old's history.  Thus, "old1..new1
   old2..new2" is exactly synonymous with "old1..new2 old2..new1".
   They both mean that new1, new2, and all their ancestors are included,
   except that old1, old2, and all their ancestors are excluded.

   There is one magic bit of syntax, the symmetric difference operator
   "rev1...rev2" (note three dots).  That means all ancestors of rev1,
   and all ancestors of rev2, but excluding all common ancestors of both.
   It's also equivalent to an include-exclude list, but the computation
   of the exclude set is a bit more complicated.  (It's usually just
   one common ancestor, but there can be multiples in nasty criss-cross
   merge cases.)

3) "git diff old..new" uses the same syntax for a different purpose.
   diff only works with two commits, so that's simply an alias for
   "git diff old new".  (Whether this is a useful conveience or is too
   misleading for the beginner has been the subject of heated discussion
   on the git mailing list.)
