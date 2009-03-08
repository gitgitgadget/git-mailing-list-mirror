From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFD] builtin-revert.c: release index lock when
	cherry-picking an empty commit
Date: Sun, 8 Mar 2009 10:42:40 -0400
Message-ID: <20090308144240.GA30794@coredump.intra.peff.net>
References: <1236418251-16947-1-git-send-email-chris_johnsen@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Chris Johnsen <chris_johnsen@pobox.com>,
	Miklos Vajna <vmiklos@frugalware.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 15:44:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgKEs-0000ts-LR
	for gcvg-git-2@gmane.org; Sun, 08 Mar 2009 15:44:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752154AbZCHOm6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2009 10:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752148AbZCHOm6
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Mar 2009 10:42:58 -0400
Received: from peff.net ([208.65.91.99]:47915 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752090AbZCHOm5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2009 10:42:57 -0400
Received: (qmail 22625 invoked by uid 107); 8 Mar 2009 14:42:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 08 Mar 2009 10:42:58 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Mar 2009 10:42:40 -0400
Content-Disposition: inline
In-Reply-To: <1236418251-16947-1-git-send-email-chris_johnsen@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112621>

On Sat, Mar 07, 2009 at 03:30:51AM -0600, Chris Johnsen wrote:

> +test_expect_code 1 'cherry-pick an empty commit' '
> +
> +	git checkout master &&
> +	git cherry-pick empty-branch
> +
> +'

Hmm. This test fails for me on FreeBSD. However, it seems to be related
to a shell portability issue with the test suite. The extra newline
inside the shell snippet seems to lose the last status. The following
works fine for me with bash or dash:

-- >8 --
#!/bin/sh

test_description='test that shell handles whitespace in eval'
. ./test-lib.sh

test_expect_code 1 'no newline' 'false'
test_expect_code 1 'one newline' 'false
'
test_expect_code 1 'extra newline' 'false

'

test_done
-- 8< --

but on a FreeBSD 6.1 box generates:

  *   ok 1: no newline
  *   ok 2: one newline
  * FAIL 3: 1
          extra newline false

With this minimal example, you can see that the problem is not some
subtle bug in the test suite:

-- >8 --
#!/bin/sh

eval 'false'
echo status is $?
eval 'false
'
echo status is $?
eval 'false

'
echo status is $?
-- 8< --

generates:

  status is 1
  status is 1
  status is 0

which means that any tests of the form

  test_expect_success description '

      contents

  '

are not actually having their exit code checked properly, and are just
claiming success regardless of what happened. So this definitely needs
to be addressed, I think. I'm not sure of the best course of action,
though. Our options include:

  1. Declare appended newline a forbidden style, fix all existing cases
     in the test suite, and be on the lookout for new ones.

     The biggest problem with this option is that we have no automated
     way of policing. Such tests will just silently pass on the broken
     platform.

  2. Have test_run_ canonicalize the snippet by removing trailing
     newlines.

  3. Declare FreeBSD's /bin/sh unfit for git consumption, and require
     bash for the test suite.

I think (2) is the most reasonable option of those choices.

We could also try to convince FreeBSD that it's a bug, but that doesn't
change the fact that the tests are broken on every existing version.

-Peff
