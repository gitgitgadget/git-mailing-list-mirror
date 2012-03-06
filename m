From: Jeff King <peff@peff.net>
Subject: Re: A possible fmt-merge-msg update?
Date: Tue, 6 Mar 2012 02:59:40 -0500
Message-ID: <20120306075940.GA21199@sigill.intra.peff.net>
References: <7vvcmj68iz.fsf@alter.siamese.dyndns.org>
 <CA+55aFzQ3+EFBVyE9PWOyH0XEC_oW+kUaBTYfixmi2wgMmiZvw@mail.gmail.com>
 <7vipii27ka.fsf@alter.siamese.dyndns.org>
 <CA+55aFw-sS_p7JXNXbSbpiwh9_bZhSrTtC3is4NtLa_n9Hzk5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Mar 06 08:59:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4pJD-000296-T1
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 08:59:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758418Ab2CFH7n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 02:59:43 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38212
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757972Ab2CFH7m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 02:59:42 -0500
Received: (qmail 5172 invoked by uid 107); 6 Mar 2012 07:59:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 06 Mar 2012 02:59:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Mar 2012 02:59:40 -0500
Content-Disposition: inline
In-Reply-To: <CA+55aFw-sS_p7JXNXbSbpiwh9_bZhSrTtC3is4NtLa_n9Hzk5A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192308>

On Mon, Mar 05, 2012 at 12:33:42PM -0800, Linus Torvalds wrote:

> On Mon, Mar 5, 2012 at 11:04 AM, Junio C Hamano <gitster@pobox.com> wrote:
> >
> > The attached would give me:
> 
> So this isn't interesting to me.
> 
> Authorship is less relevant than submaintainership. So I'm more
> interested in *committer* information than authorship information.
> 
> Of course, since you do it in branches that you maintain, to you
> committer information is pointless. But I pull from submaintainers,
> and then it really is the committer part that is way more relevant.

If you're interested in the sub-maintainer, and the sub-maintainer is
who you pulled from, then isn't the right solution to better annotate
the source of the pull? For the kernel workflow, that often comes in the
form of pulled tags; would providing the tagger in that case be helpful?
(it's often already included in the commit template via the
commented-out GPG output, but there might be many UIDs attached to a
given GPG key).

That wouldn't help the git.git workflow, of course, but I think you are
talking about two fundamentally different things. The kernel thing is
about annotating the source of the pull. The git.git thing (and Junio's
patch) is about summarizing the contents of the branch not just with the
subject lines, but also with the author's names[1].

But looking through some recent kernel merges, the useful new thing in
the message doesn't seem to me to be the _who_, but rather the _what_.
For example, from f3969bf7:

  Pull perf fixes from Ingo Molnar:
   "It contains three cherry-picked fixes from perf/core, which turned out
    to be more urgent than we originally thought."

So rather than focus on the identity of the sub-maintainer, perhaps a
more useful thing is to make it easier to pass information from a pull
request into the resulting merge message. We already have "git am" for
regular patches, and it relies on a few easy-to-generate microformats,
so it's natural to use with "git format-patch", your own custom script,
or even by hand.  Could we do the same thing and have a "git
apply-pull-request" (or something with a less horrible name)?

Ingo's original message looked like:

    From: Ingo Molnar <mingo@elte.hu>
    Subject: [GIT PULL] perf fixes

    Linus,

    Please pull the latest perf-urgent-for-linus git tree from:

       git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

       HEAD: b7c924274c456499264d1cfa3d44063bb11eb5db Merge tag 'perf-urgent-for-mingo' of
    git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent

    It contains three cherry-picked fixes from perf/core, which 
    turned out to be more urgent than we originally thought.

     Thanks,

            Ingo

If this were instead formatted as:

  From: Ingo Molnar <mingo@elte.hu>
  Subject: [GIT PULL] perf fixes

  Here are three cherry-picked fixes from perf/core, which turned out to
  be more urgent than we originally thought.

  ---
    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

    HEAD: b7c924274c456499264d1cfa3d44063bb11eb5db Merge tag 'perf-urgent-for-mingo'
      of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent

we could trivially convert that into the same commit message you ended
up writing.  The format is simple enough that people who aren't
running it through a script can read and write it, and we retain the
single line with the repo and ref name for those who want to just cut
and paste.

-Peff
