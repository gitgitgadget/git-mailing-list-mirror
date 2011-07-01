From: Jeff King <peff@peff.net>
Subject: Re: [Wishlist] could git tell which password it is asking when
 asking a password.
Date: Fri, 1 Jul 2011 16:46:24 -0400
Message-ID: <20110701204624.GA32731@sigill.intra.peff.net>
References: <877h82nlua.dlv@debian.org>
 <7v62nmos0k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	=?utf-8?B?UsOpbWk=?= Vanicat <vanicat@debian.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 01 22:46:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qckbj-000166-4F
	for gcvg-git-2@lo.gmane.org; Fri, 01 Jul 2011 22:46:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756779Ab1GAUq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jul 2011 16:46:29 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50123
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756745Ab1GAUq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2011 16:46:29 -0400
Received: (qmail 6745 invoked by uid 107); 1 Jul 2011 20:46:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Jul 2011 16:46:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Jul 2011 16:46:24 -0400
Content-Disposition: inline
In-Reply-To: <7v62nmos0k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176535>

On Fri, Jul 01, 2011 at 10:00:27AM -0700, Junio C Hamano wrote:

> > It would be interesting also to plug some sort of password-safe unto
> > git, or some "git-agent". 
> 
> I am not particularly interested in seeing git specific agent. Something
> that can be called as an external process that talks with existing
> practices (gpg agent and friends) would be nice.

Coincidentally, I am working on a big patch series for exactly this.

It is still lacking some docs and tests, but if you want to take a peek,
it's at:

  https://github.com/peff/git.git jk/http-auth

It runs external credential helpers, giving them a unique context (like
the protocol and hostname for http connections), as well as a username,
if we already have one. The goal is two-fold:

  1. Plug into existing password wallets that are going to be
     user- and OS- specific.

  2. Provide a few stock helpers to implement simple policies in a
     pluggable way.

Right now I have two helpers: "store", and "cache". Both will check
internal storage for a password; if we don't have one, they will prompt
and put the result in internal storage. In either case, the password is
sent back to git.  They differ in what "internal storage" means.

In the case of "store", it is a mode 600 ~/.git-credentials file.  Yes,
this is horribly insecure. But it's what some people want, it's no worse
than .netrc, and it's what svn does (and what gitter wouldn't be swayed
by that last argument? :) ). It's a little more friendly than netrc
because the storage happens transparently. I think the docs for this
should discourage it because of the security implications, and it should
definitely never become the default.

For "cache", we fork off a storage daemon which keeps the password in
memory for a specified period of time. The password never touches the
disk. It doesn't mlock() right now, but it could on platforms that
support it.

Both are obviously mediocre solutions in comparison to a real password
wallet[1]. But they're really simple to implement and give us a better
baseline to ship with git. I'm hoping users of individual keychains will
implement helpers to use them. Somebody from GitHub is going to work on
an OS X keychain helper. I personally use a home-grown password safe;
writing a read-only helper was about 10 lines of shell code.

Anyway, if people want to try it out, build the branch I mentioned above
and configure it like:

  # horribly insecure
  git config http.credentialhelper store

or

  # a little better
  git config http.credentialhelper cache

  # we will now cache results for 15 minutes, but there's no reason not
  # to store the username all the time, to avoid having to type it on a
  # cache miss
  git config credential.https:github.com.username peff

I've been using it for the past week or so, but I'm sure there are
lurking bugs. If you run into any, let me know.

-Peff

[1] Obviously this entire exercise is an attempt to make https
authentication as nice a user-experience as ssh with keys and ssh-agent.
So it's tempting to say "just use ssh with keys". But I think the
reality is that ssh and keys are just too challenging for a subset of
the user population (especially ones on operating systems without good
support). Apparently GitHub's most common tech support issues are people
unable to figure out how to make ssh keys, set up an agent, etc.
