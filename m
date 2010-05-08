From: Eli Barzilay <eli@barzilay.org>
Subject: Re: Re: git log -M -- filename is not working?
Date: Sat, 8 May 2010 03:08:53 -0400
Message-ID: <19429.3589.823244.270582@winooski.ccs.neu.edu>
References: <z2w76c5b8581005071107w79d30963g725269febe746f0@mail.gmail.com>
	<h2m8c9a061005071110nf7e63220ked03598bfa66fbc9@mail.gmail.com>
	<z2r76c5b8581005071131q15524cb8td6711dbb9142b28e@mail.gmail.com>
	<19428.24021.324557.517627@winooski.ccs.neu.edu>
	<20100508044434.GC14998@coredump.intra.peff.net>
	<19428.62170.654092.308682@winooski.ccs.neu.edu>
	<20100508053025.GG14998@coredump.intra.peff.net>
	<7v39y3c5p1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Eugene Sajine <euguess@gmail.com>,
	Bo Yang <struggleyb.nku@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 08 09:09:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAe9r-0002ha-N4
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 09:09:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056Ab0EHHJA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 May 2010 03:09:00 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:38145 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750919Ab0EHHI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 03:08:59 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1OAe9d-0004oR-R0; Sat, 08 May 2010 03:08:53 -0400
In-Reply-To: <7v39y3c5p1.fsf@alter.siamese.dyndns.org>,
	<20100508053025.GG14998@coredump.intra.peff.net>
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146646>

On May  7, Junio C Hamano wrote:
> Eli Barzilay <eli@barzilay.org> writes:
> 
> > So if there was some single
> >
> >   --do-whatever-you-can-as-much-as-you-can-to-find-all-renames
> 
> If I am not mistaken, that is exactly the point of Bo's patch:
> 
>     Message-Id: <1273207949-18500-4-git-send-email-struggleyb.nku@gmail.com>

(Actually, I was talking about some meta option that always turns on
whatever can be done to track copies; but given the clarification from
Jeff below, it's not as important as I first thought.)


On May  8, Jeff King wrote:
> On Sat, May 08, 2010 at 01:12:58AM -0400, Eli Barzilay wrote:
> 
> > > > BTW, I've had at least 4 people now who got confused by this.  Is
> > > > there any use for -M/-C without --follow?  In any case, it will be
> > > > very helpful if the -M/-C descriptions said "see also --follow".
> > > 
> > > Yes, it detects renames when doing diffs.
> > 
> > OK, so just to clear this up: -C and -M (and --find-copies-harder)
> > are for `diff', and --follow is for `log' with a single file (and
> > each will pass it on to the other)?
> 
> Yes (well, diff can never pass --follow to log, since diff never
> invokes log, but yes, the per-commit diff shown by log uses the -C
> and -M given to log).

Aha -- I now see what makes most of this confusion, and an easy way to
improve it considerably: looking at the `git-log' man page, I have to
wade through 11 pages of general diff options (well, 11 is so high
because I like big fonts in my emacs...) before I get to the log
options, and even worse, there is no clear indication that those
options are only relevant if I want to get patches, which is (at least
in my interactive use cases) far from being something I do often.
(Googling around, I see more than a few examples of confused uses of
`git log -M', even the git faq says "'git log -M' will give the commit
history with rename information" -- no mention of it not making any
sense with a file that went through a rename.)

So I think that it would really help if (1) the diff options in the
git-log man page move to after its own options, and (2) they appeared
after a title saying that these are the diff options, (3) `--follow'
moves up before the few preceding options that seem to me less
important.  To clarify, I added a simple patch to the end of this
message.  (`git-format-patch' has the same thing, but there it looks
more sensible to leave it as is.)


> > So if there was some single
> > 
> >   --do-whatever-you-can-as-much-as-you-can-to-find-all-renames
> 
> But I think all you really wanted was "--follow". I'd have to check the
> code, but I'm not even sure whether "-C" will impact --follow at all.

If -C/-M are really only affecting the patches, then yes, I'd probably
be happy with only `--follow' (or a way to have --follow on by default
when possible).


> No, copy detection can be _really_ slow. There is a reason it isn't
> on by default. Try "git log -1000 -p" versus "git log -1000 -p -C -M
> --find-copies-harder" in some repository. In a simple git.git test,
> it is almost 5x slower (about 1 second versus 5 seconds on my
> machine). For large repositories, it can be much worse, because now
> each diff is O(size of repository) instead of O(size of changes).

Yes, I see that.  I was talking about interactive uses, where I'd
never want to see a 1000 diffs, or even 2.  But given that -C/-M are
only for patches, then I agree with that.


> Still, I see your point that you might want it on all the time, if you
> have a sufficiently small repo. There is "diff.renames" to turn on
> rename detection all the time.

(Ah, I missed that...)


> But I think a log.follow option doesn't make sense at this
> point. For example:
> 
>   $ git config log.follow true
>   $ git log foo.c ;# ok, follow foo.c
>   $ git log foo.c bar.c ;# uh oh, now what?
> 
> Does the last one just barf, and make you say "git log --no-follow
> foo.c bar.c"? Does it quietly turn off --follow, making the user
> guess why "git log foo.c" finds some history that "git log foo.c
> bar.c" doesn't?

How about these options:

  git config log.follow if-single-file
    makes it use --follow only when there's a single file path given,
    ignoring it otherwise (with no confusion about it now)

  git config log.follow if-possible
    makes it do the same, but might also do it for more cases if/when
    they become available (so this is the "do the best you can"
    option)

  git config log.follow true
    invalid until it is always possible to use --follow

?



[this is the patch that I mentioned above]

-------------------------------------------------------------------------------
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index fb184ba..6bc7064 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -24,7 +24,6 @@ OPTIONS
 -------
 
 :git-log: 1
-include::diff-options.txt[]
 
 -<n>::
 	Limits the number of commits to show.
@@ -37,6 +36,10 @@ include::diff-options.txt[]
 	and <until>, see "SPECIFYING REVISIONS" section in
 	linkgit:git-rev-parse[1].
 
+--follow::
+	Continue listing the history of a file beyond renames
+	(works only for a single file).
+
 --decorate[=short|full]::
 	Print out the ref names of any commits that are shown. If 'short' is
 	specified, the ref name prefixes 'refs/heads/', 'refs/tags/' and
@@ -55,9 +58,6 @@ include::diff-options.txt[]
 	the specified paths; this means that "<path>..." limits only
 	commits, and doesn't limit diff for those commits.
 
---follow::
-	Continue listing the history of a file beyond renames.
-
 --log-size::
 	Before the log message print out its size in bytes. Intended
 	mainly for porcelain tools consumption. If git is unable to
@@ -71,6 +71,10 @@ include::diff-options.txt[]
 	to be prefixed with "\-- " to separate them from options or
 	refnames.
 
+Common diff options
+~~~~~~~~~~~~~~~~~~~
+
+include::diff-options.txt[]
 
 include::rev-list-options.txt[]
 
-------------------------------------------------------------------------------


-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
