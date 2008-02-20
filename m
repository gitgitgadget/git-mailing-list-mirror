From: Jeff King <peff@peff.net>
Subject: [PATCH 0/3] solaris test results
Date: Wed, 20 Feb 2008 18:59:44 -0500
Message-ID: <20080220235944.GA6278@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Whit Armstrong <armstrong.whit@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 01:00:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRyrN-0001F5-VK
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 01:00:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753811AbYBTX7r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 18:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753299AbYBTX7r
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 18:59:47 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3729 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752469AbYBTX7q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 18:59:46 -0500
Received: (qmail 9359 invoked by uid 111); 20 Feb 2008 23:59:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 20 Feb 2008 18:59:45 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Feb 2008 18:59:44 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74574>

I have now run every test script <= t9001 using the current 'master' on
the SunOS 5.8 box available to me. It _mostly_ passed. Following are
three patches:

  1/3: git_config_*: don't assume we are parsing a config file

       This is an actual minor bug which was covered by most platforms'
       ability to print (null) for NULL. I posted this earlier, but with
       a typo.

  2/3: t3404: use configured shell instead of /bin/sh

       This is a problem purely in the test script, not git itself.

  3/3: diff: fix java funcname pattern for solaris

       This is a Solaris-specific bug in git.

With these fixes, everything passes for me with a few exceptions:

  - Sun's diff doesn't understand "-u". I was able to use GNU diff.
    Since comparing actual and expected output is so common, we could
    potentially abstract this with a "test_cmp()" function and use
    something platform specific. It's probably not worth the trouble, as
    it impacts only the test suite, and only on systems with a totally
    broken diff.

  - t4020 fails without gnu grep, as it requires "grep -a"

  - t4024 fails unless /usr/xpg4/bin is in your path, as the regular
    version of 'expr' is unhappy with us (I didn't investigate too
    closely)

  - t4118, t4200, t8001, and t8002 fail unless you have GNU sed. The
    xpg4 sed barfs if there's no newline at the end of input (and this
    is specifically part of these tests)

  - I couldn't personally run t5502, t5505, t5512, t5520, or t9001, all
    of which require the Git.pm module; the version of perl on this
    machine is old (5.005_02) and complained about the 'our' keyword

  - t7505 uses a hook which hard-codes /bin/sh but uses syntax that
    the Solaris /bin/sh doesn't like. Maybe hooks should get their
    $SHELL value replaced?

  - t3900 mostly passes, but fails to correctly convert between EUCJP
    and ISO-2022-JP (in either direction). I didn't investigate very
    far.

  - git-filter-branch invokes "sh" for the commit filter, which invokes
    the broken Solaris /bin/sh. This isn't wrong, exactly, but it might
    make more sense to invoke $SHELL.

Now I must go gouge out my eyes, so that I may never see the output of
Solaris /bin/sh ever again.

-Peff
