From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] ident: check for useConfigOnly before auto-detection
 of name/email
Date: Thu, 31 Mar 2016 12:31:56 -0400
Message-ID: <20160331163156.GA1189@sigill.intra.peff.net>
References: <1459366183-15451-1-git-send-email-redneb@gmx.com>
 <20160331144003.GE31116@sigill.intra.peff.net>
 <20160331150109.GA7235@zeno>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Marios Titas <redneb@gmx.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 18:32:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alfVr-0002jD-HW
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 18:32:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756516AbcCaQcA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 12:32:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:41641 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753118AbcCaQb7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 12:31:59 -0400
Received: (qmail 26989 invoked by uid 102); 31 Mar 2016 16:31:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 31 Mar 2016 12:31:58 -0400
Received: (qmail 14530 invoked by uid 107); 31 Mar 2016 16:31:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 31 Mar 2016 12:31:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Mar 2016 12:31:56 -0400
Content-Disposition: inline
In-Reply-To: <20160331150109.GA7235@zeno>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290412>

On Thu, Mar 31, 2016 at 06:01:09PM +0300, Marios Titas wrote:

> On Thu, Mar 31, 2016 at 10:40:03AM -0400, Jeff King wrote:
> >On Wed, Mar 30, 2016 at 10:29:42PM +0300, Marios Titas wrote:
> >
> >>If user.useConfigOnly is set, it does not make sense to try to
> >>auto-detect the name and/or the email. So it's better to do the
> >>useConfigOnly checks first.
> >
> >It might be nice to explain how it is better here. I'd guess it is
> >because we may fail during xgetpwuid(), giving a message that is much
> >less informative?
> 
> Oops sorry, my bad, I should have included an example in the commit message.
> So with git 2.8.0, if you provide a name and set useConfigOnly to true in
> your ~/.gitconfig file, then if try to commit something in a new git repo,
> it will fail with the following message:
> 
>    *** Please tell me who you are.
>    Run
>      git config --global user.email "you@example.com"
>      git config --global user.name "Your Name"
>    to set your account's default identity.
>    Omit --global to set the identity only in this repository.
>    fatal: unable to auto-detect email address (got 'XXX@YYY.(none)')
> 
> (provided of course that auto-detection of email fails). This wrong, because
> auto-detection is disabled anyway.

Ah, right. We used to die in xgetpwuid, but now we just set
default_name_is_bogus. So I think bumping the use_config_only check
above the name_is_bogus check would be sufficient. Where you put it
(above ident_default_name) is fine, though it would be a problem if we
later lazily loaded the config in that function (I don't have any
particular plans to do so, though).

-Peff
