From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] contrib: add a pair of credential helpers for Mac OS X's
 keychain
Date: Thu, 29 Sep 2011 03:56:27 -0400
Message-ID: <20110929075627.GB14022@sigill.intra.peff.net>
References: <1316055113-2353-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	John Szakmeister <john@szakmeister.net>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 29 09:56:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9BTv-00072Y-FM
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 09:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754702Ab1I2H4a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Sep 2011 03:56:30 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47955
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754256Ab1I2H4a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2011 03:56:30 -0400
Received: (qmail 17708 invoked by uid 107); 29 Sep 2011 08:01:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 29 Sep 2011 04:01:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Sep 2011 03:56:27 -0400
Content-Disposition: inline
In-Reply-To: <1316055113-2353-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182387>

On Wed, Sep 14, 2011 at 10:51:53PM -0400, Jay Soffian wrote:

> This credential helper adds, searches, and removes entries from
> the Mac OS X keychain. The C version links against the Security
> framework and is probably the best choice for daily use.
> 
> A python version is also included primarily as a more readable
> example and uses the /usr/bin/security CLI to access the keychain.
> 
> Tested with 10.6.8.

So I finally got a nice working OS X setup (10.7) to play around with
these. Overall, works as advertised. :) I have a few comments, though.

> Here's a C version that no longer links to git. I also kept the original
> Python version as an example. I decided not to call out to
> 'git credential-gitpass' as it was simple enough to manage /dev/tty
> and there's no portability issues since this is OS X specific.

This was my first one. I kind of expected there to be some kind of
graphical password dialog. Especially because keychain will pop up a
dialog and ask you "is it OK for git to access this password?". So I
sort of assumed that people would assume that credentials happened
outside of the regular terminal session (I see the same thing on Linux,
for example, with gpg-agent, which will open a new window and grab
focus).

But I have no idea what's "normal" on OS X.

I wondered if you were trying to be friendly to people who were
connecting via ssh. But that doesn't seem to work at all. I couldn't get
either version of your helper to actually do anything in an ssh session
(even with the same user logged in on console).  I guess there is some
magic to hook it into the keychain manager.

Also, regarding opening /dev/tty yourself versus using getpass. There
are a few magic things getpass will do that your helper won't:

  1. It respects core.askpass, GIT_ASKPASS, and SSH_ASKPASS if they are
     set.

  2. The "get the username from the config" feature is triggered at the
     time of prompting the user (so instead of asking for the username,
     we check the config and pretend the user told us).

     I did it this way originally so that helpers would have the first
     crack at setting a username, and we would fall back to the config.
     Thinking on it more, that may be backwards. If the user has told
     git "for github.com, I am user 'foo'", then that should probably
     take effect first, and --username=foo get passed to the helper.

     It doesn't make a big difference with long-term storage helpers,
     because you tell them your username once and they remember it. But
     for things like credential-cache, it lets you store the username
     for a long time, but only cache the password (which means not
     typing the username every time).

So I think maybe reason (2) should go away. But (1) is definitely worth
considering.

> +       if (!unique)
> +               die("Must specify --unique=TOKEN; try --help");

My test harness checks that this case just asks for the password without
bothering to do any lookup or storage. It probably doesn't really matter
in practice; I think git should always be providing _some_ context.

> +	hostname = strchr(unique, ':');
> +	if (!hostname)
> +		die("Invalid token `%s'", unique);
> +	*hostname++ = '\0';

Hrm. I was really hoping people wouldn't need to pick apart the "unique"
token, and it could remain an opaque blob. If helpers are going to do
this sort of parsing, then I'd just as soon have git break it down for
them, and do something like:

  git credential-osxkeychain \
    --protocol=https \
    --host=github.com \
    --path=peff/git.git
    --username=peff

to just hand over as much information as possible, and let the helper
throw it all together if it wants to.

> +	/* "GitHub for Mac" compatibility */
> +	if (!strcmp(hostname, "github.com"))
> +		hostname = "github.com/mac";

Nice touch. :)

> +	if (!strcmp(unique, "https")) {
> +		protocol = kSecProtocolTypeHTTPS;
> +	} else if (!strcmp(unique, "http")) {
> +		protocol = kSecProtocolTypeHTTP;
> +	}
> +	else
> +		die("Unrecognized protocol `%s'", unique);

My series will also produce "cert:/path/to/certificate" when unlocking a
certificate. The other candidates for conversion are smtp-auth (for
send-email) and imap (for imap-send).  I guess for certs, you'd want to
use the "generic" keychain type.

I wonder if some people would not want to cache cert passwords. Speaking
of which, I remember keychain asking me "do you want to let git see this
password?", but I don't ever remember it asking "do you want to save
this password?". Is that usually automatic? Again, I was kind of
expecting a dialog with a "remember this" checkbox.

> +def add_internet_password(protocol, hostname, username, password):
> +    # We do this over a pipe so that we can provide the password more
> +    # securely than as an argument which would show up in ps output.
> +    # Unfortunately this is possibly less robust since the security man
> +    # page does not document how to quote arguments. Emprically it seems
> +    # that using the double-quote, escaping \ and " works properly.
> +    username = username.replace('\\', '\\\\').replace('"', '\\"')
> +    password = password.replace('\\', '\\\\').replace('"', '\\"')
> +    command = ' '.join([
> +        'add-internet-password', '-U',
> +        '-r', protocol,
> +        '-s', hostname,
> +        '-a "%s"' % username,
> +        '-w "%s"' % password,
> +        '-j default',
> +        '-l "%s (%s)"' % (hostname, username),
> +    ]) + '\n'
> +    args = ['/usr/bin/security', '-i']
> +    p = Popen(args, stdin=PIPE, stdout=PIPE, stderr=PIPE)
> +    p.communicate(command)

I noticed that when using the python helper, the dialog asking something
like: "security wants to know this password. Allow it?"

Which was kind of lame. I would hope we could convince it to say "git".
But I didn't see any option in the "security" tool for specifying the
context[1]. The C helper says "git-credential-osxkeychain". Which isn't
the end of the world, but it would be prettier if it just said "git".

-Peff

[1] I can kind of see why they might not want you to set this for
security reasons (because it makes impersonating other programs easy).
On the other hand, saying "security" conveys absolutely nothing. And as
far as I can tell, I could just call my program /tmp/iTunes, and it
would say "iTunes wants to know this password...".
