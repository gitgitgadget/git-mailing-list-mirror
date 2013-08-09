From: Jeff King <peff@peff.net>
Subject: Re: git should not use a default user.email config value
Date: Fri, 9 Aug 2013 18:37:58 -0400
Message-ID: <20130809223758.GB7160@sigill.intra.peff.net>
References: <20130809134236.28143.75775.reportbug@tglase.lan.tarent.de>
 <20130809194214.GV14690@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thorsten Glaser <tg@mirbsd.de>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 10 00:38:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7vJv-0007B8-DW
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 00:38:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031369Ab3HIWiC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 18:38:02 -0400
Received: from cloud.peff.net ([50.56.180.127]:51013 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031355Ab3HIWiA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 18:38:00 -0400
Received: (qmail 2957 invoked by uid 102); 9 Aug 2013 22:38:01 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 09 Aug 2013 17:38:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Aug 2013 18:37:58 -0400
Content-Disposition: inline
In-Reply-To: <20130809194214.GV14690@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232047>

On Fri, Aug 09, 2013 at 12:42:14PM -0700, Jonathan Nieder wrote:

> I wonder if it's too gentle and long to get the point across.  Would
> something the following (including the guesses in the message for
> easier copy-pasting) help?
> 
> 	No name and email address configured, so I had to guess.  You
> 	can suppress this message by setting your identity explicitly:
> 
> 		git config --global user.name "Thorsten Glaser"
> 		git config --global user.email tg@mirbsd.de
> 
> 	After doing so, you may fix the identity used for this commit
> 	with "git commit --amend --reset-author".

I don't know if including the name and email helps that much. It should
already be printed along with that message, like:

  $ git commit --allow-empty -m foo
  [master ba77f94] foo
   Committer: Jeff King <peff@sigill.intra.peff.net>
  Your name and email address were configured automatically based
  on your username and hostname. Please check that they are accurate.
  You can suppress this message by setting them explicitly:

      git config --global user.name "Your Name"
      git config --global user.email you@example.com

  After doing this, you may fix the identity used for this commit with:

      git commit --amend --reset-author

> It may also make sense to distinguish between cases where a mailname
> is set and not set.  Git already notices the cases where the guessed
> email address ends with ".(none)" and errors out, and it could make
> sense to be more aggressive.

Yeah, there are basically three levels of ident:

  1. The user told us explicitly (e.g., $EMAIL, user.email). Trust it.

  2. We guessed and it looks reasonable (e.g., hostname is FQDN). Warn
     but use it.

  3. It looks obviously bogus (e.g., we do not have a domain name).
     Reject it.

We can move some cases from (2) down to (3), like when we use
gethostname rather than /etc/mailname.  But we risk breaking people's
existing setups. I don't think we know how many people rely on the
implicit hostname selection and would be affected. I don't know if there
is a good way to find out short of changing it and seeing who screams.
We can put a deprecation warning in the release notes, but people tend
to ignore those. Or perhaps now that we have had the long obnoxious
implicit-ident warning for several versions, everybody has finally set
user.email and the time is right to change.

Another option could to add an option to control the strictness. We
usually have a chicken-and-egg problem here with individual installs
(i.e., any person who could set "user.trustHostname = false" could just
as easily have set "user.email"). But in an institutional setting, the
admin could set such a config in /etc/gitconfig for everybody. Or for a
system like Debian, the packager could include the option, knowing that
any reasonably configured system should have /etc/mailname set up (which
is not something we can necessarily count on for other operating
systems).

-Peff
