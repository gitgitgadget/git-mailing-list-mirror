From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/4] do not send client agent unless server does first
Date: Fri, 10 Aug 2012 17:09:53 -0400
Message-ID: <20120810210953.GA888@sigill.intra.peff.net>
References: <20120810075342.GA30072@sigill.intra.peff.net>
 <20120810075743.GB8399@sigill.intra.peff.net>
 <7vd32yjzu8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 23:10:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzwTA-0006Sv-N0
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 23:10:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757674Ab2HJVKD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 17:10:03 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:34025 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756370Ab2HJVKC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 17:10:02 -0400
Received: (qmail 2259 invoked by uid 107); 10 Aug 2012 21:10:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 10 Aug 2012 17:10:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Aug 2012 17:09:53 -0400
Content-Disposition: inline
In-Reply-To: <7vd32yjzu8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203260>

On Fri, Aug 10, 2012 at 12:45:19PM -0700, Junio C Hamano wrote:

> > diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
> > index fe56596..bc7a0f9 100644
> > --- a/builtin/fetch-pack.c
> > +++ b/builtin/fetch-pack.c
> > @@ -19,6 +19,7 @@ static int prefer_ofs_delta = 1;
> >  static int no_done;
> >  static int fetch_fsck_objects = -1;
> >  static int transfer_fsck_objects = -1;
> > +static int agent_supported;
> >  static struct fetch_pack_args args = {
> >  	/* .uploadpack = */ "git-upload-pack",
> >  };
> 
> This is only set to false once per process invocation.  We do not
> currently talk with more than one remote from the same process in
> the "fetch" codepath, and we must maintain that. This fix will be
> broken otherwise ("recursive submodule fetch" comes to mind; one
> more reason it should do its submodule business in a separate
> process).

Right; I followed the existing options in both fetch-pack and send-pack
(use_sideband, no_done, and others here have the same issue), with the
assumption that the current code was not broken (which may not be true,
if it is simply masked by the fact that in practice everybody happens to
support those older features).

I don't know off-hand whether that is actually a trigger-able bug in the
current code or not. It's probably a good topic for a follow-on series.

> > @@ -328,7 +329,8 @@ static int find_common(int fd[2], unsigned char *result_sha1,
> >  			if (args.no_progress)   strbuf_addstr(&c, " no-progress");
> >  			if (args.include_tag)   strbuf_addstr(&c, " include-tag");
> 
> This codepath still forgets to check if the other side advertised
> "thin-pack", "no-progress", and "include-tag", no?

Yes. I didn't realize it until Dave mentioned the "innocuous" list. I
think cleaning them up is reasonable, but probably a separate topic.

> > diff --git a/builtin/send-pack.c b/builtin/send-pack.c
> > index 5c69995..7d05064 100644
> > --- a/builtin/send-pack.c
> > +++ b/builtin/send-pack.c
> > @@ -252,6 +252,7 @@ int send_pack(struct send_pack_args *args,
> >  	int status_report = 0;
> >  	int use_sideband = 0;
> >  	int quiet_supported = 0;
> > +	int agent_supported = 0;
> >  	unsigned cmds_sent = 0;
> >  	int ret;
> >  	struct async demux;
> 
> This is initialied to 0 per communication, so having multiple
> remote.$there.pushURL configuration variables will work correctly.

Right. Not through me having thought about it, though, but by following
the existing convention.

-Peff
