From: Jeff King <peff@peff.net>
Subject: Re: Disabling credential helper?
Date: Tue, 2 Dec 2014 20:21:48 -0500
Message-ID: <20141203012148.GB29427@peff.net>
References: <20141203000310.GE90134@vauxhall.crustytoothpaste.net>
 <20141203005953.GB6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 02:21:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xvydf-0001gB-LU
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 02:21:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbaLCBVv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 20:21:51 -0500
Received: from cloud.peff.net ([50.56.180.127]:47527 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750730AbaLCBVu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 20:21:50 -0500
Received: (qmail 8406 invoked by uid 102); 3 Dec 2014 01:21:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 Dec 2014 19:21:50 -0600
Received: (qmail 20820 invoked by uid 107); 3 Dec 2014 01:21:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 Dec 2014 20:21:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Dec 2014 20:21:48 -0500
Content-Disposition: inline
In-Reply-To: <20141203005953.GB6527@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260611>

On Tue, Dec 02, 2014 at 04:59:53PM -0800, Jonathan Nieder wrote:

> brian m. carlson wrote:
> 
> > We've used GIT_ASKPASS=/bin/echo, which seems to solve the problem,
> > although it's ugly and I'm concerned it might break in the future.  Is
> > there a better way to do this?
> 
> That's a good question.  Before falling back to the askpass based
> prompt, Git tries each credential helper matching the URL in turn, and
> there doesn't seem to be an option to override that behavior and disable
> credential helpers.

I think this has nothing at all to do with credential helpers. Git tries
the helpers, of which there are none, and falls back to askpass and
prompting on the terminal. There is no way to design a helper to say "I
tried and failed; do not bother prompting on the terminal". Git only
sees that no helper provided an answer and uses its internal methods.

I did at one point consider making the terminal prompt a credential
helper (since it is, after all, no different from git's perspective;
it's just a mechanism for "somehow" coming up with a username/password
pair).  But people generally thought that was unnecessarily complicated
(and it certainly is for the common cases).

> As long as you have no credential helpers configured, your GIT_ASKPASS
> based approach should work fine.

Yeah, it's fine (as is GIT_ASKPASS=true). You could also provide a
credential helper that gives you an empty username and password. But in
both cases, I think that git will then feed the empty password to the
server again, resulting in an extra useless round-trip. You probably
instead want to say "stop now, git, there is nothing else to be done".

We could teach the credential-helper code to do that (e.g., a helper
returns "stop=true" and we respect that). But I think you can do it
reasonably well today by making the input process fail. Sadly setting
GIT_ASKPASS to "false" just makes git complain and then try harder[1].
But you can dissociate git from the terminal, like:

  $ setsid -w git ls-remote https://github.com/private/repo
  fatal: could not read Username for 'https://github.com': No such device or address

That might have other fallouts if you use process groups for anything. I
have no problem with either an option to disable the terminal prompting,
or teaching the credential-helper interface to allow helpers to stop
lookup, either of which would be cleaner.

-Peff

[1] Courtesy of 84d7273 (prompt: fall back to terminal if askpass fails,
2012-02-03).
