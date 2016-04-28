From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 2/2] submodule: pass on http.extraheader config
 settings
Date: Thu, 28 Apr 2016 09:49:53 -0400
Message-ID: <20160428134953.GB25364@sigill.intra.peff.net>
References: <3b71deffa5d07cf73a793773cc3d60ff611843fa.1461759454.git.johannes.schindelin@gmx.de>
 <cover.1461837783.git.johannes.schindelin@gmx.de>
 <89d0024450b0e6e9997ad9e3d681248bde1bafc0.1461837783.git.johannes.schindelin@gmx.de>
 <20160428112912.GB11522@sigill.intra.peff.net>
 <alpine.DEB.2.20.1604281405540.2896@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Apr 28 15:50:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avmKW-00019a-9I
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 15:50:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752668AbcD1Nt5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 09:49:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:58333 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752634AbcD1Nt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 09:49:57 -0400
Received: (qmail 26177 invoked by uid 102); 28 Apr 2016 13:49:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Apr 2016 09:49:55 -0400
Received: (qmail 9719 invoked by uid 107); 28 Apr 2016 13:49:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Apr 2016 09:49:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Apr 2016 09:49:53 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1604281405540.2896@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292883>

On Thu, Apr 28, 2016 at 02:19:37PM +0200, Johannes Schindelin wrote:

> > Should we consider just white-listing all of "http.*"?
> > 
> > That would help other cases which have come up, like:
> > 
> >   http://thread.gmane.org/gmane.comp.version-control.git/264840
> > 
> > which wants to turn off http.sslverify. That would mean it turns off for
> > every submodule, too, but if you want to be choosy about your http
> > variables, you should be using the "http.$URL.sslverify" form, to only
> > affect specific servers (whether they are in submodules or not).
> 
> I considered that, and thought that it might be dangerous, what with me
> not vetting carefully which http.* variables are safe to pass on to the
> submodules' update and which are not.
> 
> So I had a look now, and the most prominent potential problem is the
> http.cookieFile setting, which could be reused all of a sudden if we
> made my patch more general.
> 
> But then, we are talking about the code that filters what gets passed via
> the *command-line*. And to be quite honest, I am not sure that we should
> actually filter out *any* of these settings.

The intent of the whitelist (from my recollection of the discussion) is
to filter out config that must be repo-specific. E.g., core.worktree or
core.bare should definitely _not_ be passed to a submodule.

I don't know if there are others. We started with a whitelist because it
was the smallest and safest change away from the status quo. A blacklist
would also work, with the risk that we might let through nonsense in
some cases (but only if the user triggers us to do so).

> The commit message that introduced this particular filtering has this
> rationale to let only credential.* through:
> 
>     GIT_CONFIG_PARAMETERS is special, and we actually do want to
>     preserve these settings. However, we do not want to preserve all
>     configuration as many things should be left specific to the parent
>     project.
> 
>     Add a git submodule--helper function, sanitize-config, which shall be
>     used to sanitize GIT_CONFIG_PARAMETERS, removing all key/value pairs
>     except a small subset that are known to be safe and necessary.
> 
> Dunno. I tried to err on the side of caution... But this sounds maybe a
> bit *too* cautious?

So if we all agree that the sanitizing is really about preventing
repo-specific variables from leaking, and not any kind of security
boundary, I think we should generally be pretty liberal in whitelisting
things.

I can certainly come up with a pathological case where using it as a
security boundary may have some practical use, but in general I think it
is mostly getting in the way of what users are trying to do.

-Peff
