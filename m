From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] diff-highlight: match up lines before highlighting
Date: Tue, 3 Nov 2015 17:03:14 -0500
Message-ID: <20151103220314.GE22484@sigill.intra.peff.net>
References: <1446516334-27652-1-git-send-email-jonathan.lebon@gmail.com>
 <1446516334-27652-4-git-send-email-jonathan.lebon@gmail.com>
 <20151103214416.GC22484@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonathan Lebon <jonathan.lebon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 23:03:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ztjfl-0007Ix-K8
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 23:03:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932652AbbKCWDR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 17:03:17 -0500
Received: from cloud.peff.net ([50.56.180.127]:52336 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932536AbbKCWDR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 17:03:17 -0500
Received: (qmail 3400 invoked by uid 102); 3 Nov 2015 22:03:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 Nov 2015 16:03:16 -0600
Received: (qmail 29182 invoked by uid 107); 3 Nov 2015 22:03:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 Nov 2015 17:03:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Nov 2015 17:03:14 -0500
Content-Disposition: inline
In-Reply-To: <20151103214416.GC22484@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280826>

On Tue, Nov 03, 2015 at 04:44:16PM -0500, Jeff King wrote:

> Have you looked at a diff of the old/new output on something like
> git.git?

This should be pretty easy to do (and time). I tried:

  git log --oneline --color -p >base
  time perl highlight.old <base >old
  time perl highlight.new <base >new
  diff -c old new | less

where the "highlight.*" scripts are the versions at master, and master
with your series applied.

Your is _much_ slower. I get:

  real    0m25.538s
  user    0m25.420s
  sys     0m0.120s

for the old versus:

  real    2m3.580s
  user    2m3.548s
  sys     0m0.156s

for your series. In an interactive setting, the latency may not be that
noticeable, but if you are digging far into history (e.g., "git log -p",
then using "/" in less to search for a commit or some test), I suspect
it would be very noticeable.

I was thinking there was some low-hanging fruit in memoizing the
calculations, but even the prefix/suffix computation is pairwise. I'm
not really sure how to make this much faster.

As for the output itself, the diff between the two looks promising. The
first several cases I looked at ar strict improvements. Some of them are
kind of weird, especially in English text. For example, see the RelNotes
update in 2635c2b. The base diff is:

    * "git rebase -i" had a minor regression recently, which stopped
    considering a line that begins with an indented '#' in its insn
-   sheet not a comment, which is now fixed.
-   (merge 1db168e gr/rebase-i-drop-warn later to maint).
+   sheet not a comment. Further, the code was still too picky on
+   Windows where CRLF left by the editor is turned into a trailing CR
+   on the line read via the "read" built-in command of bash.  Both of
+   these issues are now fixed.
+   (merge 39743cf gr/rebase-i-drop-warn later to maint).

Before we highlighted nothing, and now we hone in on "now fixed". Which
is _sort of_ a match, but really the whole sentence structure has
changed. If this is the worst regression, I can certainly live with it.
And even a proper LCS diff would probably end up making spaghetti of a
text change like this.

In the other thread I mentioned earlier, the solution I cooked up was
dropping highlighting entirely for hunks over a certain percentage of
highlighting. I wonder if we could do something similar here (e.g.,
don't match lines where more than 50% of the line would be highlighted).

-Peff
