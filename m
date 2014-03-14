From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Mar 2014, #01; Tue, 4)
Date: Fri, 14 Mar 2014 00:16:18 -0400
Message-ID: <20140314041618.GA32008@sigill.intra.peff.net>
References: <xmqqiortijxp.fsf@gitster.dls.corp.google.com>
 <CACsJy8Do8nL1CcZ=jNz=_A2j8EWgcSAZBsqYZMF=SvTv0itRpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 05:16:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOJY0-00041X-3o
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 05:16:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbaCNEQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 00:16:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:39222 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750739AbaCNEQU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 00:16:20 -0400
Received: (qmail 32664 invoked by uid 102); 14 Mar 2014 04:16:20 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 13 Mar 2014 23:16:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Mar 2014 00:16:18 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8Do8nL1CcZ=jNz=_A2j8EWgcSAZBsqYZMF=SvTv0itRpg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244072>

On Wed, Mar 12, 2014 at 07:55:51PM +0700, Duy Nguyen wrote:

> On Wed, Mar 5, 2014 at 7:10 AM, Junio C Hamano <gitster@pobox.com> wrote:
> > [Graduated to "master"]
> > * jk/pack-bitmap (2014-02-12) 26 commits
> >   (merged to 'next' on 2014-02-25 at 5f65d26)
> 
> And it's finally in! Shall we start thinking about the next on-disk
> format? It was put aside last time to focus on getting this series in.
> My concern is shallow support (surprise?) so that cloning from a
> 1-year-long shallow repo is not slower than a complete one. An
> extensible format is enough without going into details.

I'm open to suggestions. The most interesting followups for me are:

  1. Taking a look at Karsten's hashmap patches, which also graduated
     recently, to see if we can drop khash's macro nastiness without
     losing performance.

  2. Can we use bitmaps to increase our idea of which objects the other
     side has, and therefore get better delta reuse? I think the answer
     is yes from my limited experiments, but I want to do some more
     thorough ones[1].

  3. Cleaning up and submitting my patches to avoid writing deltas
     between "distinct" ref sets (e.g., between refs for two different
     forks in an alternates repo). This is somewhat orthogonal to
     bitmaps, but they touch overlapping areas, so I had held back until
     the dust settled on bitmaps.

  4. Packv4. :)

  5. Short of packv4, looking at whether we can encoding packv2 tree
     deltas in a way that lets us produce cheap tree diffs in a high
     percentage of instances. This may sound crazy, as packv4 is a
     better endgame, but there is going to be a long time where packv2
     is still the on-the-wire format, which means that servers will need
     to do v4-to-v2 translation, which I suspect may eliminate the v4
     benefits.

Shallow repos aren't really on my radar (nor am I really familiar with
some of the intricacies), but I'm happy to discuss and give my
ill-informed opinions. :)

[1] http://thread.gmane.org/gmane.comp.version-control.git/239647
