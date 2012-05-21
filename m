From: Jeff King <peff@peff.net>
Subject: Re: remove_duplicates() in builtin/fetch-pack.c is O(N^2)
Date: Mon, 21 May 2012 18:14:17 -0400
Message-ID: <20120521221417.GA22664@sigill.intra.peff.net>
References: <4FB9F92D.8000305@alum.mit.edu>
 <20120521174525.GA22643@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Tue May 22 00:14:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWary-0004eW-3s
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 00:14:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408Ab2EUWOV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 May 2012 18:14:21 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51119
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755465Ab2EUWOU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 18:14:20 -0400
Received: (qmail 6850 invoked by uid 107); 21 May 2012 22:14:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 21 May 2012 18:14:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 May 2012 18:14:17 -0400
Content-Disposition: inline
In-Reply-To: <20120521174525.GA22643@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198134>

On Mon, May 21, 2012 at 01:45:25PM -0400, Jeff King wrote:

> > I don't plan to work on this, but I thought I would point it out in
> > case it is causing somebody pain.
>=20
> I'll clean up the patch and make one for the filter_refs case, too.

Here are the patches. I tested these with three repositories:

  - the rails/rails network repo, with ~400K refs

  - the git/git network repo, with ~220 refs

  - a fake repo made from git.git, with 3 numbered refs pointing at eac=
h
    commit for a total of ~100K refs (I didn't have a real dataset that
    was ~100K).

Before these patches, I never managed to complete a "git clone --mirror
file://$repo" on the first two, as I got impatient after 5-10 minutes
and killed the process. The third one completed in ~110s.

  [1/5]: fetch-pack: sort incoming heads
  [2/5]: fetch-pack: avoid quadratic behavior in remove_duplicates

After this one, the "fake" case was down to ~63s.

  [3/5]: add sorting infrastructure for list refs
  [4/5]: fetch-pack: sort the list of incoming refs
  [5/5]: fetch-pack: avoid quadratic loop in filter_refs

And after this one, the "fake" case was down to ~32s. Notably, most of
the time was spent on the actual object transfer (i.e., before it would
hang before even getting to "Counting objects...", and now it starts
that almost immediately). Perf corroborates this by showing most of the
time in zlib inflate and delta resolution.

The rails and git cases run in ~28s and ~37s, respectively, again mostl=
y
going to the actual object transfer. So I think this series removes all
of the asymptotically bad behavior from this code path.

One thing to note about all of these repos is that they tend to have
several refs pointing to a single commit. None of the speedups in this
series depends on that fact, but it may be that on a repo with more
independent refs, we may uncover other code paths (e.g., I know that my
fix for mark_complete in ea5f220 improves the case with duplicate refs,
but would not help if you really have 400K refs pointing to unique
commits[1]).

Martin, let me know if this improves things for your many-ref cases (an=
d
if you are still seeing slowness in your repos with many refs, let me
know which operations cause it).

-Peff

[1] At the time of that commit, I proposed a fix with a priority queue
    replacing the commit_list, but we deemed it too much code for
    a case that was unlikely to happen. But now it sounds like that cas=
e
    is less unlikely than we thought, and now that we have Ren=C3=A9's
    linked-list merge-sort code, I think we could fix it with a 2-line
    change. I'll look into it.
