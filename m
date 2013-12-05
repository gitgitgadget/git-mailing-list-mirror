From: Jeff King <peff@peff.net>
Subject: Re: How to resume broke clone ?
Date: Thu, 5 Dec 2013 14:08:24 -0500
Message-ID: <20131205190824.GA19039@sigill.intra.peff.net>
References: <5297004F.4090003@gmail.com>
 <CACsJy8AdOAPT-RfD0NfZj_cQPBSUrVKn8yS7JRe=-4k8C8TvQg@mail.gmail.com>
 <211D44CB-64A2-4FCA-B4A7-40845B97E9A1@ancientrocklab.com>
 <CACsJy8AOVWF2HssWNeYkVvYdmAXJOQ8HOehxJ0wpBFchA87ZWw@mail.gmail.com>
 <20131128092935.GC11444@sigill.intra.peff.net>
 <CAJo=hJuBTjGfF2PvaCn_v4hy4qDfFyB=FXbY0=Oz3hcE0L=L4Q@mail.gmail.com>
 <20131204200850.GB16603@sigill.intra.peff.net>
 <CAJo=hJuRz9Qc8ztQATkEs8huDfiANMA6gZEOapoofVdoY82k4g@mail.gmail.com>
 <20131205160418.GA27869@sigill.intra.peff.net>
 <xmqqeh5ri3d3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>, Duy Nguyen <pclouds@gmail.com>,
	zhifeng hu <zf@ancientrocklab.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	=?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 05 20:08:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoeHn-0000nc-Dc
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 20:08:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257Ab3LETI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Dec 2013 14:08:27 -0500
Received: from cloud.peff.net ([50.56.180.127]:51093 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751109Ab3LETI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 14:08:26 -0500
Received: (qmail 27071 invoked by uid 102); 5 Dec 2013 19:08:26 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 05 Dec 2013 13:08:26 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Dec 2013 14:08:24 -0500
Content-Disposition: inline
In-Reply-To: <xmqqeh5ri3d3.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238896>

On Thu, Dec 05, 2013 at 10:01:28AM -0800, Junio C Hamano wrote:

> > You could have a "git-advertise-upstream" that generates a mirror blob
> > from your remotes config and pushes it to your publishing point. That
> > may be overkill, but I don't think it's possible with a
> > .git/config-based solution.
> 
> I do not think I follow.  The upload-pack service could be taught to
> pay attention to the uploadpack.advertiseUpstream config at runtime,
> advertise 'mirror' capability, and then respond with the list of
> remote.*.url it uses when asked (if we go with the pkt-line based
> approach).

I was assuming a triangular workflow, where your publishing point (that
other people will fetch from) does not know anything about the upstream.
Like:

  $ git clone git://git.kernel.org/pub/scm/git/git.git
  $ hack hack hack; commit commit commit
  $ git remote add me myserver:/var/git/git.git
  $ git push me
  $ git advertise-upstream origin me

If your publishing point is already fetching from another upstream, then
yeah, I'd agree that dynamically generating it from the config is fine.

> Alternatively, it could also be taught to pay attention
> to the same config at runtime, create an blob to advertise the list
> of remote.*.url it uses and store it in refs/mirror (or do this
> purely in-core without actually writing to the refs/ namespace), and
> emit an entry for refs/mirror using that blob object name in the
> ls-remote part of the response (if we go with the magic blob based
> approach).

Yes. The pkt-line versus refs distinction is purely a protocol issue.
You can do anything you want on the backend with either of them,
including faking the ref (you can also accept fake pushes to
refs/mirror, too, if you really want people to be able to upload that
way).

But it is worth considering what implementation difficulties we would
run across in either case. Producing a fake refs/mirror blob that
responds like a normal ref is more work than just dumping the lines. If
we're always just going to generate it dynamically anyway, then we can
save ourselves some effort.

-Peff
