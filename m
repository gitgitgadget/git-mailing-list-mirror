From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] t0303: set reason for skipping tests
Date: Tue, 13 Mar 2012 17:53:32 -0400
Message-ID: <20120313215331.GC27752@sigill.intra.peff.net>
References: <1331553907-19576-1-git-send-email-zbyszek@in.waw.pl>
 <1331553907-19576-2-git-send-email-zbyszek@in.waw.pl>
 <20120312123031.GA14456@sigill.intra.peff.net>
 <4F5E65AE.8050401@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Tue Mar 13 22:53:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7Zf2-0004K1-Sr
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 22:53:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759848Ab2CMVxg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Mar 2012 17:53:36 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48736
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755927Ab2CMVxg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 17:53:36 -0400
Received: (qmail 2569 invoked by uid 107); 13 Mar 2012 21:53:45 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Mar 2012 17:53:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Mar 2012 17:53:32 -0400
Content-Disposition: inline
In-Reply-To: <4F5E65AE.8050401@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193073>

On Mon, Mar 12, 2012 at 10:07:58PM +0100, Zbigniew J=C4=99drzejewski-Sz=
mek wrote:

> OK, it seems this might be more complicated than I expected. I admit
> that I didn't test this (apart from failing without the variables
> defined) and assumed that it more or less works already.

This script is not very well tested, as it is meant to be run manually
when testing an out-of-tree helper. I used it to test the osx-keychain
helper, but that's it.

> I think that the tests are not very robust:
>     ln -s /bin/true ~/bin/git-credential-fooooooo
>     GIT_TEST_CREDENTIAL_HELPER=3Dfooooooo\
>       GIT_TEST_CREDENTIAL_HELPER_TIMEOUT=3Dfooooooo\
>       ./t0303-credential-external.sh
>=20
> gives me:
> ok 1 - helper (fooooooo) has no existing data
> ok 2 - helper (fooooooo) stores password
> not ok - 3 helper (fooooooo) can retrieve password
> ok 4 - helper (fooooooo) requires matching protocol
> ok 5 - helper (fooooooo) requires matching host
> ok 6 - helper (fooooooo) requires matching username
> ok 7 - helper (fooooooo) requires matching path
> ok 8 - helper (fooooooo) can forget host
> not ok - 9 helper (fooooooo) can store multiple users
> ok 10 - helper (fooooooo) can forget user
> not ok - 11 helper (fooooooo) remembers other user
> ok 12 - helper (fooooooo) times out
> # failed 3 among 12 test(s)
> 1..12
>=20
> I guess that the fact that #1 succeeds reflects reality, but e.g.
> 4-7 and 12 probably should fail.

The reason is that the individual tests do not verify all of the
preconditions themselves, but rather build on each other. So in test 2,
we ask to store some data. The helper tells us it did so successfully
(which is a lie, of course). And then in test 3 we ask it to tell us
what it stored, but of course it can't, and we notice. And then in test
4, we ask again with a restricted query, expecting to see no answer. An=
d
we get it, because of course, the helper will never give us an answer.
If you really wanted to know whether that feature worked, you would
check that we can get anything at all, but not with the restricted quer=
y.

In an ideal world, each test snippet would be totally independent and
check its preconditions. That would give us an accurate count of how
many tests actually passed or failed. But fundamentally we only care
about "did they all succeed or not?", which the current script does tel=
l
us (either test 2 fails, or if it succeeds, then we have checked the
precondition for test 4). And the tests end up way shorter, because we
don't repeat the preconditions over and over.

If you want to try to make the tests more robust, you can (for example,
you can tighten the precondition on 4 to check "does it give the right
answer with the right protocol" instead of just "does it ever give us
the right answer"). But personally, I'm not sure it's worth that much
effort.

> >Should they actually say "# SKIP ..." to tell prove what's going on?=
 I
> >don't know very much about TAP.
> # SKIP is used when skipping individual tests (IIUC), but when we
> skip a group of tests, we simply jump over them and this message is
> purely informative output that is not interpreted by the harness.

Just looking at test-lib.sh, it seems like we output "# SKIP" when we d=
o
skip_all. But I think you would have to give a count of which tests you
skipped (e.g., try "./t5541-http-push.sh" to see its TAP output). Which
means when skipping a subset, you'd have to deal with test numbering,
which is a pain. So it's probably not worth worrying about.

-Peff
