From: Jeff King <peff@peff.net>
Subject: Re: encrypted netrc for Git
Date: Fri, 15 Jul 2011 17:05:41 -0400
Message-ID: <20110715210541.GD356@sigill.intra.peff.net>
References: <877h82nlua.dlv@debian.org>
 <87aacygcfx.fsf@lifelogs.com>
 <87bowxt0sh.fsf_-_@lifelogs.com>
 <20110714150033.GA6797@sigill.intra.peff.net>
 <8762n379pa.fsf@lifelogs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 15 23:05:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qhpa0-0008Id-VB
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jul 2011 23:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752406Ab1GOVFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jul 2011 17:05:44 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37169
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751749Ab1GOVFn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2011 17:05:43 -0400
Received: (qmail 26996 invoked by uid 107); 15 Jul 2011 21:06:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 15 Jul 2011 17:06:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jul 2011 17:05:41 -0400
Content-Disposition: inline
In-Reply-To: <8762n379pa.fsf@lifelogs.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177232>

On Fri, Jul 15, 2011 at 12:08:49PM -0500, Ted Zlatanov wrote:

> JK> Check out:
> 
> JK>   https://github.com/peff/git/commits/jk/http-auth
> 
> JK> which provides an interface for getting credentials from external
> JK> helpers.
> 
> The API is good, but it's not clear from the docs how to configure
> credential helpers from the user side.  From the tests it looks like you
> set GIT_ASKPASS to them, is that right?  And you can also set
> credential.helper?

Yes, that is the documentation I need to write before I can send in the
patches. :)

The answer is that you use "credential.helper". For example:

  $ git config credential.helper cache

  $ git push https://your.server/repo.git
  Username: <input your username>
  Password: <input your password>
  ... push happens ...

  [five minutes pass]
  $ git push https://your.server/repo.git
  ... push happens, no auth required ...

> Where do those helpers fit with the .netrc file?  Are they called before
> or after or instead of the .netrc parse?

They are what git provides to curl, either because we have "user@" in
the URL, or because we tried curl once and got an HTTP 401. Curl uses
netrc automagically behind the scenes.

So for a URL without "user@" I believe the order would be:

  1. Curl tries the request with what's in your netrc (or maybe it
     transparently requests and uses the netrc after getting a 401; I'm
     not sure).

  2. Curl gives us a 401, and we ask for credentials via getpass(). Or a
     credential helper, if defined. Any username given in netrc will not
     be considered a partial credential (i.e., you will be prompted for
     username and password as if netrc didn't exist).

  3. If those credentials fail (i.e., we get a 401 again), we quit.

> Linking these with external libraries like GPGME and the Secrets API
> will be pretty easy and improve the user experience.  So I'll be glad to
> work on it and provide you with feedback.

Yes, exactly. I think somebody at GitHub will probably work on OS X
Keychain integration, too.

I personally use a home-grown password safe that is a searchable
gpg-encrypted file (which then gets unlocked by gpg-agent). My helper is
more or less:

-- >8 --
#!/bin/sh

unique=
for i in "$@"; do
  case "$i" in
    --unique=*) unique=${i#--unique=} ;;
  esac
done

# find lines of the form
# example.com.username=me
# example.com.password=mypass
gpg -qd --no-tty $HOME/.pass.gpg |
sed -n 's/^$unique.//p
-- >8 --

(actually, my file format is quite a bit more complex and robust than
that, and I use a perl script to parse it instead of sed, but this was
meant to be illustrative of how simple it could be).

Obviously something integrated with the secrets API would be way nicer,
if you are running GNOME Keyring (that's part of why I pushed it out to
an external helper; there are nearly as many password wallet solutions
as there are users, and everybody will have their favorite).

> Would you be interested in pushing your patches further after the
> testing?  They seem pretty complete.

Absolutely. I'm planning on finishing up the docs and posting the
patches in the next couple days, so hopefully they will get more
feedback and testing there, too.

-Peff
