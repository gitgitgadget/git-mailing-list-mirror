From: Jeff King <peff@peff.net>
Subject: Re: Intermittent Failures in t1450-fsck (Bisected)
Date: Wed, 11 May 2011 07:43:47 -0400
Message-ID: <20110511114347.GA24161@sigill.intra.peff.net>
References: <115C364B-E910-4A9C-949E-3B10E5E6116C@silverinsanity.com>
 <2838BCC7-FB14-401B-9498-D0FB78C98D91@silverinsanity.com>
 <20110505093226.GA29595@sigill.intra.peff.net>
 <60194977-A4A9-4E18-9878-C1CDE77B75C2@silverinsanity.com>
 <20110505210317.GE1770@sigill.intra.peff.net>
 <E577B7D7-423E-4E9E-AE47-30E4DB4D21BC@silverinsanity.com>
 <A3947D3B-B434-4C13-A069-6B3C731DABF0@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Wed May 11 17:44:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKBa2-0001xX-He
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 17:44:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754538Ab1EKPnv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2011 11:43:51 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34718
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751799Ab1EKPnu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2011 11:43:50 -0400
Received: (qmail 3247 invoked by uid 107); 11 May 2011 11:45:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 11 May 2011 07:45:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 May 2011 07:43:47 -0400
Content-Disposition: inline
In-Reply-To: <A3947D3B-B434-4C13-A069-6B3C731DABF0@silverinsanity.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173394>

On Sat, May 07, 2011 at 04:25:28PM -0400, Brian Gernhardt wrote:

> I've tried to narrow it down even further.  I cut the test down to
> just the setup and failing test. Then I removed all
> "test_when_finished" and replaced the "test_must_fail" with "!" so I
> can directly copy/paste the test into a window.  When the test runs,
> it fails.  When I run it manually, even with using /bin/sh and eval,
> it succeeds.  Can anybody else think of what difference there might be
> between a shell and the test script that I should test?  (I did
> remember to set GIT_EXEC_PATH and my PATH to run the same version as
> the script is.)

Could be something in the environment. You might want to try pulling the
environment variable setup from test-lib.sh into your interactive shell.

I would suspect earlier tests might have created some weird state, but
it looks in your output like you removed most of them and still see the
problem.

> expecting success: 
> 	sha=$(echo blob | git hash-object -w --stdin) &&
> 	cat >wrong-tag <<-EOF &&
> 	object $sha
> 	type commit
> 	tag wrong
> 	tagger T A Gger <tagger@example.com> 1234567890 -0000
> 
> 	This is an invalid tag.
> 	EOF
> 
> 	tag=$(git hash-object -t tag -w --stdin <wrong-tag) &&
> 	echo $tag >.git/refs/tags/wrong &&
> 	! git fsck --tags 2>out &&
> 	cat out &&
> 	grep "error in tag.*broken links" out
> 
> tagged commit 63499e4ea8e096b831515ceb1d5a7593e4d87ae5 (wrong) in 66f6581d549f70e05ca586bc2df5c15a95662c36
> missing commit 63499e4ea8e096b831515ceb1d5a7593e4d87ae5
> error: Object 63499e4ea8e096b831515ceb1d5a7593e4d87ae5 is a commit, not a blob
> error: 63499e4ea8e096b831515ceb1d5a7593e4d87ae5: object corrupt or missing
> not ok - 3 tag pointing to something else than its type

Thanks for narrowing it down more. One thing I'd try is to see what "git
cat-file -t $sha" and "git cat-file -p $sha" say right before the fsck
is run (they should both print "blob").

Beyond that I think I'd try gdb, with breakpoints near the places those
messages are generated (you can find them by grepping for "tagged %s %s"
and "is a %s, not a").

Other than that, I'm a bit stumped. The whole "it breaks on a ramdisk"
thing is just odd.

-Peff
