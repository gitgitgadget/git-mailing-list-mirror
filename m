From: Jeff King <peff@peff.net>
Subject: Re: Diagnosing stray/stale .keep files -- explore what is in a pack?
Date: Tue, 21 Jan 2014 00:19:56 -0500
Message-ID: <20140121051956.GA5878@sigill.intra.peff.net>
References: <CACPiFCLa3X-Xt5GwrHHA-PFj-Bi9_sW+=y2xidZ7tDbFfM26rA@mail.gmail.com>
 <CACPiFCJVx0dkkPQ=LosbAAKq7CvK6_yQL5QDHMYr5oJAS6wb6Q@mail.gmail.com>
 <201401141236.44393.mfick@codeaurora.org>
 <CACPiFCLxiCOqv=wLeq9LxisWn5T62hk8xDYwXmeFRNT05HY0iQ@mail.gmail.com>
 <20140115091220.GB14335@sigill.intra.peff.net>
 <CACPiFCKeOYHUb22d_Ea0PcbU-uAn=fVAn0QP1qbLAiNh1KEoqQ@mail.gmail.com>
 <xmqqr4892l0u.fsf@gitster.dls.corp.google.com>
 <CACPiFC+koU1Fan+tbE2YgOstWGsDtDihpK-7CMOct7XAEpwJ2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin Fick <mfick@codeaurora.org>,
	Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 21 06:20:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5Tko-0000t9-Sm
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jan 2014 06:20:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbaAUFT7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jan 2014 00:19:59 -0500
Received: from cloud.peff.net ([50.56.180.127]:36052 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750769AbaAUFT6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 00:19:58 -0500
Received: (qmail 5743 invoked by uid 102); 21 Jan 2014 05:19:58 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 20 Jan 2014 23:19:58 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Jan 2014 00:19:56 -0500
Content-Disposition: inline
In-Reply-To: <CACPiFC+koU1Fan+tbE2YgOstWGsDtDihpK-7CMOct7XAEpwJ2A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240742>

On Wed, Jan 15, 2014 at 06:50:33PM -0500, Martin Langhoff wrote:

> On Wed, Jan 15, 2014 at 12:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > As long as we can reliably determine that it is safe to do so
> > without risking races, automatically cleaning .lock files is a good
> > thing to do.
> 
> If the .lock file is a day old, it seems to me that it should be safe
> to call it stale.

Probably. The way our "lease" system works, nobody should be
holding a ref lock for more than a few milliseconds.

That being said, we do lock other things, like the index. Generally I
think the index lock should be quick, too. And similar for config file
rewrites, and shallow files. And rerere files, it looks like. My, "git
grep commit_lock_file" turns up a lot of hits. :)

So I think all of the existing uses are fine, and I suppose that most
new cases should be fine, too, because git processes tend not to last a
long time.

You asked earlier if I had a script for cleaning locks. No code worth
sharing, but I'll give an outline of what we do at GitHub. We basically
do:

  find -name *.lock -mmin +60 | xargs rm

I.e., we give only an hour.  For keep files, we give a day (since things
like hooks may run for a while under the lock, though a day is probably
excessive). And we check that it begins with "^receive-pack".

As far as I know, neither of these has ever caused any problems. Of
course, any problems might not be immediately obvious.

> Can anyone "take the lock" if there is already a lock file?

Git never takes an existing lock. It expects you to clean it up
yourself.

> For the keep files, I already drafted a script that looks inside the
> keep file, if it reads 'receive-pack [pid] [host]' it checks whether
> the hostname matches, and if so whether the pid matches a running
> process.
> 
> Only if the host matches and the pid is dead we call it stale.

That sounds reasonable.

> Seems fairly conservative to me. Are there scenarios where we think
> this can misfire?

I cannot think of any.

-Peff
