From: Jeff King <peff@peff.net>
Subject: credential helper tests
Date: Fri, 23 Sep 2011 18:15:13 -0400
Message-ID: <20110923221513.GA3087@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lukas =?utf-8?Q?Sandstr=C3=B6m?= <luksan@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	John Szakmeister <john@szakmeister.net>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ted Zlatanov <tzz@lifelogs.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 24 00:15:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7E1n-0003VA-Ak
	for gcvg-git-2@lo.gmane.org; Sat, 24 Sep 2011 00:15:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752634Ab1IWWPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Sep 2011 18:15:19 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41895
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752573Ab1IWWPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2011 18:15:16 -0400
Received: (qmail 22097 invoked by uid 107); 23 Sep 2011 22:20:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 23 Sep 2011 18:20:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Sep 2011 18:15:13 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182006>

Since we've had a few credential helpers posted to the list recently, I
really want to try them all out. This can be a little bit tricky for
automated testing, though, for two reasons:

  - they run on lots of platforms with lots of dependencies

  - they interact with parts of the systems that are opaque to git. So
    we can't make a test that reliably simulates "and then the user
    types 'foo' into a dialog box" across all platforms.

Instead, I came up with a separate test script that is intended to be
run interactively with the user. It runs the helpers through a battery
of tests, and tells the user what to expect and what to input to any
dialogs or prompts.

I've run it already on the helpers I've written. I plan on running it
with the helpers that have been posted, as well. But I also wanted to
make it public so that authors could use it as a development aid.

It's not integrated with git's tests at all. In theory it could be part
of t/, but disabled unless the user asks for it. However, I'm not sure
that makes much sense. It's intended to test helpers that aren't
necessarily even shipped with git, and wouldn't necessarily even need
git to run.

Also, it is by no means a strict set of tests. A helper that did not
store credentials, but only presented dialogs in a different way, or one
that was about accessing a read-only store of credentials would not
pass. So think of it as a best-practices guide and an exercise script
for certain types of helpers, not necessarily as a set of tests that
must be passed.

-- >8 --
#!/bin/sh

# e.g., "cache"
helper=$1

say() {
  echo >&2 "==> $*"
}

check() {
  for i in username password; do
    v=$1; shift
    case "$v" in
    auto:*)
      v=${v#auto:}
      say "  $i should be automatic ($v)"
      ;;
    *)
      say "  Input $i=$v"
      ;;
    esac
    echo $i=$v
  done >expect
  if git credential-$helper "$@" >actual &&
     git --no-pager diff --no-index expect actual; then
    say OK
  else
    say FAIL
  fi
}

reject() {
  git credential-$helper --reject "$@" || exit 1
}

say 'Cleaning old invocations...'
reject --unique=https:foo.tld
reject --unique=https:bar.tld

say 'No context (initial, should ask)'
check user pass
say 'No context (again, should ask)'
check user2 pass2

say 'Context foo.tld (initial, should ask)'
check foo-user foo-pass --unique=https:foo.tld
say 'Context foo.tld (again)'
check auto:foo-user auto:foo-pass --unique=https:foo.tld

say 'Context bar.tld (should ask)'
check bar-user bar-pass --unique=https:bar.tld
say 'Context bar.tld (again)'
check auto:bar-user auto:bar-pass --unique=https:bar.tld
say 'Context foo.tld (should still remember)'
check auto:foo-user auto:foo-pass --unique=https:foo.tld

say 'Forget foo.tld (should ask)'
reject --unique=https:foo.tld
check foo-user2 foo-pass2 --unique=https:foo.tld
say 'Context foo.tld (again)'
check auto:foo-user2 auto:foo-pass2 --unique=https:foo.tld
say 'Context bar.tld (should still remember)'
check auto:bar-user auto:bar-pass --unique=https:bar.tld

say 'Alternate user at foo.tld (should ask)'
check auto:foo-user3 foo-pass3 --unique=https:foo.tld --username=foo-user3
say 'Remember new user'
check auto:foo-user3 auto:foo-pass3 --unique=https:foo.tld --username=foo-user3
say 'Remember old user'
check auto:foo-user2 auto:foo-pass2 --unique=https:foo.tld --username=foo-user2
say 'Forget new user (should ask)'
reject --unique=https:foo.tld --username=foo-user3
check auto:foo-user3 foo-pass4 --unique=https:foo.tld --username=foo-user3
say 'New user is now remembered'
check auto:foo-user3 auto:foo-pass4 --unique=https:foo.tld --username=foo-user3
say 'Remember old user'
check auto:foo-user2 auto:foo-pass2 --unique=https:foo.tld --username=foo-user2
