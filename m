From: Jeff King <peff@peff.net>
Subject: Re: [RFC] diff: support custom callbacks for output
Date: Mon, 7 Aug 2006 05:19:53 -0400
Message-ID: <20060807091953.GA31137@coredump.intra.peff.net>
References: <20060807075002.GA29693@coredump.intra.peff.net> <7vr6zt3oz5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 07 11:20:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GA1HE-000833-0j
	for gcvg-git@gmane.org; Mon, 07 Aug 2006 11:20:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbWHGJT4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 05:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWHGJT4
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 05:19:56 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:11139 "HELO
	peff.net") by vger.kernel.org with SMTP id S1751173AbWHGJTz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Aug 2006 05:19:55 -0400
Received: (qmail 6770 invoked from network); 7 Aug 2006 05:19:20 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 7 Aug 2006 05:19:20 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon,  7 Aug 2006 05:19:53 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vr6zt3oz5.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25004>

On Mon, Aug 07, 2006 at 01:54:38AM -0700, Junio C Hamano wrote:

> "output format" in the form of a callback hook is a very good
> idea.  I am not sure if a callback per filepair is a good
> interface, or passing the q (that is &diff_queued_diff) and let
> the hook iterate over it might be better, though.  It probably
> would not be such a big deal either way.

Looking through the diff_flush code, many of the formats want to do
something slightly more interesting than simply looping (and one would
assume that any gitlib users might want to do similar things), so I
think passing q makes more sense. As a bonus, it helps avoid contortions
like:
  void my_callback(...) {
    static int header_shown = 0;
    if (!header_shown) ... /* make sure we show header exactly once iff
                              we have any diff items */
    header_shown = 1;
  }

One could, of course, implement the current diff output formats as
callbacks. I'm not sure if it's worth the effort, though, as we
currently support multiple simultaneous outputs (which the flags do
fine, but which would require a list of callbacks).

> Having said that, I am wondering how much of "git status" you
> are doing in C.  Initially, I was going to do the whole thing
> (one good reason to do so is that then we do not have to write
> out a temporary index file; we can do everything in-core.
> However I came to realize it is quite a big undertaking.  In

I'm starting by writing run_status in C. Once that is working (which
should be soon), I believe it should suffice as a vanilla git-status
(do people actually do things like git-status with flags? It's not
documented, but it does work). My plan is:
  1. get working builtin git-status
  2. remove git-status from git-commit.sh
  3. naively replace run_status with call to git-status, with
     git-commit handling things like TMP_INDEX
  4. one by one, expand git-status options to handle special cases
     from git-commit.sh

> the initial commit) and the working tree files.  The program
> would run (internally) diff-index --cached, diff-files and
> ls-files -o to do "Will commit", "Changed" and "Untracked".

Yes, that is step 1 above (and is almost done -- I needed to figure out
this diff interface first).

> By the way, I was pondering about making the git status output a
> bit more readable by making it shorter.  Instead of listing the

I'm definitely in favor.

>         Will commit
>                 modified: Makefile (warning: further changed)

I like it (the double-mention of files which were changed, updated, then
changed has always bothered me). However, I'm not sure how we can get
the diff machinery to figure this out easily. Getting the knowledge for
the line above requires diffing tree to cache and cache to working
directory. Is there a better way than saving the queue from one diff and
cross-referencing it with the other?

-Peff
