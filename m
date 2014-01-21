From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] setup_pager: set MORE=R
Date: Tue, 21 Jan 2014 00:49:27 -0500
Message-ID: <20140121054927.GD5878@sigill.intra.peff.net>
References: <20140117041430.GB19551@sigill.intra.peff.net>
 <20140117042153.GB23443@sigill.intra.peff.net>
 <xmqqvbxiwh8y.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Yuri <yuri@rawbw.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 21 06:49:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5UDi-0003IM-3c
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jan 2014 06:49:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbaAUFta (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jan 2014 00:49:30 -0500
Received: from cloud.peff.net ([50.56.180.127]:36076 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750740AbaAUFt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 00:49:29 -0500
Received: (qmail 7239 invoked by uid 102); 21 Jan 2014 05:49:29 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 20 Jan 2014 23:49:29 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Jan 2014 00:49:27 -0500
Content-Disposition: inline
In-Reply-To: <xmqqvbxiwh8y.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240745>

On Fri, Jan 17, 2014 at 11:17:01AM -0800, Junio C Hamano wrote:

> > +#ifdef PAGER_MORE_UNDERSTANDS_R
> > +	if (!getenv("MORE"))
> > +		argv_array_push(&env, "MORE=R");
> > +#endif
> >  	pager_process.env = argv_array_detach(&env, NULL);
> >  
> >  	if (start_command(&pager_process))
> 
> Let me repeat from $gmane/240110:
> 
>  - Can we generalize this a bit so that a builder can pass a list
>    of var=val pairs and demote the existing LESS=FRSX to just a
>    canned setting of such a mechanism?
> 
> As we need to maintain this "set these environments when unset" here
> and also in git-sh-setup.sh, I think it is about time to do that
> clean-up.  Duplicating two settings was borderline OK, but seeing
> the third added fairly soon after the second was added tells me that
> the clean-up must come before adding the third.

Wow, I somehow _completely_ missed that thread. When I looked at the
code with LV, I assumed it was just something that had happened long ago
and I had forgotten about. I didn't even bother reading "git log".

Yeah, I agree that git-sh-setup should be consistent with what the C
porcelains do. However, adding build-time variables like:

  PAGER_ENV = LESS=-FRSX LV=-c

does complicate the point of my series, which was to add more intimate
logic about how we handle LESS. With the current code, I can know that
an unset "LESS" variable means we will set "R" ourselves and turn on
color. We can get around that with something like:

  int pager_can_handle_color(void)
  {
        const char *pager = get_pager();

        if (!strcmp(pager, "less")) {
                const char *x = getenv("LESS");
                if (!x) {
                        const char *e;
                        for (e = pager_env; *e; e++)
                                if ((x = skip_prefix(e, "LESS=")))
                                        break;
                }
                return !x || strchr(x, 'R');
    }

    [...]
  }

but we are still hard-coding a lot of intelligence about "less" here. I
wonder if the abstraction provided by the Makefile variable is really
worthwhile. Anybody adding a new line to it would also want to tweak
pager_can_handle_color to add similar logic.

Taking a step back for a moment, we are getting two things out of such a
Makefile variable:

  1. An easy way for packager to add intelligence about common pagers on
     their system.

  2. DRY between git-sh-setup and the C code.

I do like (1), but I do not know if we want to try to encode the "can
handle color" logic into a Makefile variable. What would it look like?

For (2), an alternate method would be to simply provide "git pager" as C
code, which spawns the appropriate pager as the C code would. Then
git-sh-setup can easily build around that.

-Peff
