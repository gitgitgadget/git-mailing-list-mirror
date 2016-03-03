From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 03/10] lazily load core.sharedrepository
Date: Thu, 3 Mar 2016 13:23:44 -0500
Message-ID: <20160303182343.GA24171@sigill.intra.peff.net>
References: <20160301143546.GA30806@sigill.intra.peff.net>
 <20160301143954.GC12887@sigill.intra.peff.net>
 <CACsJy8DM4sG5MztfQnZHpaj3NAveS9S4-qLtSCmLEWhFyfKwTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 03 19:23:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abXui-0005Us-Ai
	for gcvg-git-2@plane.gmane.org; Thu, 03 Mar 2016 19:23:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758186AbcCCSXs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2016 13:23:48 -0500
Received: from cloud.peff.net ([50.56.180.127]:54297 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755214AbcCCSXr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2016 13:23:47 -0500
Received: (qmail 8462 invoked by uid 102); 3 Mar 2016 18:23:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 03 Mar 2016 13:23:46 -0500
Received: (qmail 8343 invoked by uid 107); 3 Mar 2016 18:23:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 03 Mar 2016 13:23:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Mar 2016 13:23:44 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8DM4sG5MztfQnZHpaj3NAveS9S4-qLtSCmLEWhFyfKwTw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288200>

On Thu, Mar 03, 2016 at 08:00:03PM +0700, Duy Nguyen wrote:

> On Tue, Mar 1, 2016 at 9:39 PM, Jeff King <peff@peff.net> wrote:
> > +       if (need_shared_repository_from_config) {
> > +               const char *var = "core.sharedrepository";
> > +               const char *value;
> > +               if (!git_config_get_value(var, &value))
> > +                       the_shared_repository = git_config_perm(var, value);
> > +               need_shared_repository_from_config = 0;
> > +       }
> 
> If config cache is invalidated and reloaded by some crazy code (alias
> code, most likely, but I didn't check), we could be in trouble. Is
> there any clean way we could hook in git_config_clear() and reset
> need_shared..  back  to 1 (or something of similar effect)? Or perhaps
> maintain a "clear counter", increased at every clear, and we keep a
> copy here, so we know if any more clear() has been called between
> get_shared..() calls.

Yeah, this caches forever. But I'm not sure that's really different from
the existing code, which sets it in check_repository_format_gently(),
which is only called during setup_git_directory(), which cannot be
called twice. So it was effectively static for the full program anyway
(modulo people tweaking the integer variable manually, which is
supported here).

I think something like the "clear counter" you describe is also not
quite sufficient. We have two sources for the variable: the config, and
manually setting it. Once it has been manually set, I think we don't
want to auto-read it from the config anymore (and stomp over what
somebody set). I'm not sure even git_config_clear() is enough of a
single to say "...and also reset everything that might have been set
from these config variables in the past". I think we'd want to do
per-variable invalidation, depending on what the caller wants.

So I'd rather punt on it for now, unless this is breaking a specific
case. I think it should behave the same as the status quo.

-Peff
