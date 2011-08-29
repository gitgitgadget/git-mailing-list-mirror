From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] check-ref-format --print: Normalize refnames that
 start with slashes
Date: Mon, 29 Aug 2011 14:50:12 -0400
Message-ID: <20110829185011.GC756@sigill.intra.peff.net>
References: <1314418364-2532-1-git-send-email-mhagger@alum.mit.edu>
 <1314418364-2532-2-git-send-email-mhagger@alum.mit.edu>
 <4E58710B.60507@alum.mit.edu>
 <7vty92adv0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	cmn@elego.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 29 20:50:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qy6um-0005G1-K8
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 20:50:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754819Ab1H2SuR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 14:50:17 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34243
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754794Ab1H2SuP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 14:50:15 -0400
Received: (qmail 19277 invoked by uid 107); 29 Aug 2011 18:50:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 29 Aug 2011 14:50:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Aug 2011 14:50:12 -0400
Content-Disposition: inline
In-Reply-To: <7vty92adv0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180328>

On Sat, Aug 27, 2011 at 11:30:26AM -0700, Junio C Hamano wrote:

> It sometimes gets frustrating to see a re-rolled submission that ignores
> the fix-ups to messages and patches I make locally before queued to 'pu'.
> 
> It is easy for me to say that they should fetch 'pu' to see what is queued
> before resubmitting, but I've been wondering if there is a better way to
> communicate back such differences, so that submitters can easily sanity
> check to see if my fix-ups are sensible, and to ensure that the re-rolled
> patches do not discard them by mistake before submitting.

FWIW, I never do this, nor did I realize I was expected to. It takes
effort on the part of the submitter, which means they're probably not
inclined to do so unless there are changes that they know are pending.
I.e., if I see changes as replies on the list, I grab them and put them
into my re-roll. But I am not in the habit of poking through pu, trying
to match up equivalent patches, and then comparing them against my
versions, just on the off chance that some change has been made that
wasn't mentioned on the list. I always assumed that you did one of:

  1. Comment on the patch via email, just as any other reviewer, so it
     can go into the re-roll.

  2. Fix-up the patch or commit message during "am", with the assumption
     that it is ready to be merged at least to "next", at which point
     re-rolls are no longer OK, anyway.

I mentioned "it takes effort" above. I don't mean "submitters shouldn't
be expected to put in extra effort". But we should make sure the effort
is well-spent, which means:

  1. Giving them some indication that you tweaked things during
     application. It doesn't have to be an inclusive list. Even saying
     "Thanks, applied with some spelling fixes" instead of your usual
     "Thanks" is enough (actually, I think you frequently do so
     already).

  2. Having better tool support for picking out the topics. Right now
     we don't know the name of the topic branch you choose without
     hunting for it in pu (or seeing it later in a What's Cooking
     message). And even if we do, picking the tip commit out of pu
     requires a bit of scripting. Have you considered publishing the
     tips of topic branches you apply? Probably it makes sense to keep
     them out of refs/heads/ in git.git, but even having them available
     in refs/topics/ would allow interested parties to fetch them.

  3. Having better tool support for comparing two sets of commits. The
     ideal interface (to me) for this workflow would be something like:

         $ git compare-series my-topic origin/my-topic origin
         Patch 1: first patch subject...OK
         Patch 2: second patch subject...

         diff --git a/hello.c b/hello.c
         index cef8b34..4f08083 100644
         --- a/hello.c
         +++ b/hello.c
         @@ -1,6 +1,6 @@
          #include <stdio.h>
          int main(void)
          {
         -  printf("hello wrold\n!");
         +  printf("hello world\n!");
            return 0;
          }
         Accept change from upstream [y,n,q]?

         Patch 3: third patch subject...

         diff --git a/COMMIT_MSG b/COMMIT_MSG
         index 54c8fa2..fd7b9be 100644
         --- a/COMMIT_MSG
         +++ b/COMMIT_MSG
         @@ -1,3 +1,3 @@
          third patch subject

         -This patch has a commit message with a tpyo in it.
         +This patch has a commit message with a typo in it.

         Accept commit message update from upstream [y,n,q]?

     where the implementation would be something like:

       a. Get two series of commits as $3..$1 and $3..$2.

       b. Try to match commits from series one to series two, ending up
          with some ordered list of pairs like the one below (entries on
          the left would be commit sha1s from series 1; entries on the
          right would be commit sha1s from series 2).

            (P1, P1)  (an unmodified version of a patch)
            (P2, P2') (a modified version of a patch)
            (P3, )    (dropped P3 in series 2)
            (, P4)    (added P4 in series 2)

          The matching would probably involve some text similarity
          analysis of the commit messages (or possibly the patch
          itself, though that can get confused if an early patch is
          tweaked with a change that cascades through the series).

       c. Do a sort of interactive rebase over this list. For unmodified
          pairs, take the commit from either. For modified pairs,
          checkout the commit from series 1, then "checkout -p" the
          commit from series 2 on top of it. The resulting commit is
          then applied to the intermediate rebase result. For modified
          commit messages, do a "git add -p" in a one-off sub-repository
          with only COMMIT_MSG in it, and then use the result as the
          final commit message. For dropped patches, show the patch from
          series 1 and say "Drop this patch?" For added patches, do the
          same (but with "Add this patch?").

          I'm not sure how reordering of patches would be handled, if at
          all. Maybe just as a deletion and an addition.

Anyway, that's just an idea I had while writing this message. I wouldn't
be surprised if there are a ton of awful corner cases I didn't think
about, or that somebody has a much better way of accomplishing the same
thing.

I often end up with something close to this by rebasing my topic
branches on top of master. Once your version hits master, then I see
your changes as conflicts. It's a bit annoying, though, because the
conflicts are frequently annoying to resolve. E.g., you fix a typo in
the line, and then every patch in the series after that which modified
the same line (or even a nearby one) ends up conflicting.

-Peff
