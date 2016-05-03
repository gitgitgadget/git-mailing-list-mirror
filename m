From: Jeff King <peff@peff.net>
Subject: Re: Git 2.8.1 fails test 32 of t7300-clean.sh, breaks profile build
Date: Tue, 3 May 2016 15:00:53 -0400
Message-ID: <20160503190053.GC30530@sigill.intra.peff.net>
References: <CAA6PgK7b=ithSYREV5axaE3fmRG5Vp06UtWiZXD-aJuZKfEVYA@mail.gmail.com>
 <CAA6PgK4of46eEJOJstnVvPvDFqU_OC5QVz9LWxyKgqHt9V5ySQ@mail.gmail.com>
 <CAGZ79kYy=+xz5k0pN+MZTRBALd-sqbQ0TePNjkx6itjQpbRUvA@mail.gmail.com>
 <CAA6PgK4M2Ag6anEFYakW9NJe0ehTtS1UEQmDWe387W_uV-MCXA@mail.gmail.com>
 <CAGZ79kav27h+_eswTd3hRWjYhH5aApVcERa1bSxKD8p2R50HTw@mail.gmail.com>
 <CAPc5daX4noqHaOZCrZ78s0ytFBkeU7znXs0QY1LXEw8w3RnQ1A@mail.gmail.com>
 <20160503184841.GA30530@sigill.intra.peff.net>
 <CAGZ79kYxSCsXGLBoBTAOLfe_pOu7YNBQoccs_fA0btEzpnU=-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Jan Keromnes <janx@linux.com>,
	Erik =?utf-8?B?RWxmc3Ryw7Zt?= <erik.elfstrom@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue May 03 21:01:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axfZ7-0007d0-B2
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 21:01:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934078AbcECTA4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 15:00:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:33293 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933595AbcECTA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 15:00:56 -0400
Received: (qmail 21623 invoked by uid 102); 3 May 2016 19:00:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 May 2016 15:00:55 -0400
Received: (qmail 339 invoked by uid 107); 3 May 2016 19:01:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 May 2016 15:01:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 May 2016 15:00:53 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79kYxSCsXGLBoBTAOLfe_pOu7YNBQoccs_fA0btEzpnU=-w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293437>

On Tue, May 03, 2016 at 11:53:36AM -0700, Stefan Beller wrote:

> > is related or worth doing on top. But I don't think so. That code is
> > just trying to convert some error-cases into "let's err on the side of
> > assuming it is a repo". Doing that for all values of gitfile_error is
> > definitely the wrong thing (it would treat a totally non-existent
> > ".git" file as "yes, it's there", which is clearly bogus).
> 
> The proposed change is overly eager indeed.
> What if we get back a READ_GITFILE_ERR_STAT_FAILED ?
> I would think that is a reasonable indicator of a submodule being there?
> (The stat failure may be transient ENOMEM Out of memory (i.e., kernel memory).)

That would certainly be wrong with read_gitfile_gently() as it is today;
it does not distinguish various values of errno for stat(), so that
would get the "there's not even a .git file here at all" case wrong.

So the first step would be to have read_gitfile_gently() start looking
for ENOENT versus other errors. I don't know if that's worth the
trouble; we're pretty cavalier about treating stat failure as "file does
not exist" in the rest of the code.

-Peff
