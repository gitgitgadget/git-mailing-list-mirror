From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] replace --edit: respect core.editor
Date: Tue, 19 Apr 2016 23:53:54 -0400
Message-ID: <20160420035353.GA31890@sigill.intra.peff.net>
References: <909769abaff1babdab77625bebd04e2013c6e344.1461076425.git.johannes.schindelin@gmx.de>
 <xmqqoa9536wi.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 05:54:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asjDL-0007To-4k
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 05:54:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754194AbcDTDx7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 23:53:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:52606 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753958AbcDTDx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 23:53:57 -0400
Received: (qmail 14540 invoked by uid 102); 20 Apr 2016 03:53:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Apr 2016 23:53:56 -0400
Received: (qmail 23306 invoked by uid 107); 20 Apr 2016 03:54:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Apr 2016 23:54:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Apr 2016 23:53:54 -0400
Content-Disposition: inline
In-Reply-To: <xmqqoa9536wi.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291978>

On Tue, Apr 19, 2016 at 09:22:37AM -0700, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > We simply need to read the config, is all.
> >
> > This fixes https://github.com/git-for-windows/git/issues/733
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  builtin/replace.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/builtin/replace.c b/builtin/replace.c
> > index 748c6ca..02b13f6 100644
> > --- a/builtin/replace.c
> > +++ b/builtin/replace.c
> > @@ -475,6 +475,7 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
> >  		return replace_object(argv[0], argv[1], force);
> >  
> >  	case MODE_EDIT:
> > +		git_config(git_default_config, NULL);
> >  		if (argc != 1)
> >  			usage_msg_opt("-e needs exactly one argument",
> >  				      git_replace_usage, options);
> 
> The placement of git_config() makes me wonder why.
> 
> I can understand "we only know edit mode needs config, and we know
> it will never affect other modes to have the new call here", and it
> would be good for an emergency patch for ancient maintenance track
> that will not get any other changes or enhancements.  I do not think
> it is a sound reasoning to maintain the codefor the longer term,
> though.

Yeah. I agree the patch here is not wrong, but I would prefer to just
have git-replace load the config when it starts. It's _possible_ that
something might break or misbehave, but IMHO any program which breaks
when git_default_config() is run is probably in need of fixing.

And I cannot recall any reason we did not read config when "--edit"
was added; we just didn't think of it.

-Peff
