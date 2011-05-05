From: Jeff King <peff@peff.net>
Subject: Re: Intermittent Failures in t1450-fsck (Bisected)
Date: Thu, 5 May 2011 05:32:26 -0400
Message-ID: <20110505093226.GA29595@sigill.intra.peff.net>
References: <115C364B-E910-4A9C-949E-3B10E5E6116C@silverinsanity.com>
 <2838BCC7-FB14-401B-9498-D0FB78C98D91@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Thu May 05 11:32:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHuvH-0004AV-AH
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 11:32:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752939Ab1EEJcd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 05:32:33 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57010
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751744Ab1EEJcc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 05:32:32 -0400
Received: (qmail 29456 invoked by uid 107); 5 May 2011 09:34:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 05 May 2011 05:34:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 May 2011 05:32:26 -0400
Content-Disposition: inline
In-Reply-To: <2838BCC7-FB14-401B-9498-D0FB78C98D91@silverinsanity.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172823>

On Thu, May 05, 2011 at 02:46:52AM -0400, Brian Gernhardt wrote:

> I finally managed to pin down what triggers the bug and bisect it to
> its beginning.
> 
> I see this failure only when the test suite is run in parallel.  (make
> -j or -j in GIT_PROVE_OPTS)
> 
> The bug starts happening in "e96c19c: config: support values longer than 1023 bytes".

I'm slightly confused. Commit e96c19c predates the test that you
reported as failing here:

> > t1450-fsck fails in test 10 "tag pointing to something else than its type", but only if I run it as part of the full test suite (with either `make test` or `make prove`).  If I run the test separately, it passes.
> > 
> > The output from running with GIT_TEST_OPTS="-v" is:
> > 
> > expecting success: 
> > 	sha=$(echo blob | git hash-object -w --stdin) &&
> > 	test_when_finished "remove_object $sha" &&
> > 	cat >wrong-tag <<-EOF &&
> > 	object $sha
> > 	type commit
> > 	tag wrong
> > 	tagger T A Gger <tagger@example.com> 1234567890 -0000
> > 
> > 	This is an invalid tag.
> > 	EOF
> > 
> > 	tag=$(git hash-object -t tag -w --stdin <wrong-tag) &&
> > 	test_when_finished "remove_object $tag" &&
> > 	echo $tag >.git/refs/tags/wrong &&
> > 	test_when_finished "git update-ref -d refs/tags/wrong" &&
> > 	test_must_fail git fsck --tags 2>out &&
> > 	cat out &&
> > 	grep "error in tag.*broken links" out
> > 
> > tagged commit 63499e4ea8e096b831515ceb1d5a7593e4d87ae5 (wrong) in 66f6581d549f70e05ca586bc2df5c15a95662c36
> > missing commit 63499e4ea8e096b831515ceb1d5a7593e4d87ae5
> > error: Object 63499e4ea8e096b831515ceb1d5a7593e4d87ae5 is a commit, not a blob
> > error: 63499e4ea8e096b831515ceb1d5a7593e4d87ae5: object corrupt or missing
> > not ok - 10 tag pointing to something else than its type

So how did you bisect down to it? You said reverting e96c19c fixes it,
which does seem like strong evidence, but what I am wondering is if a
_different_ test in t1450 fails at e96c19c. That would point to
something else funny going on.

Double weird is that my output for t1450.10 is totally different from
that.  Which commit are you testing on?

Given that the problem seems racy and intermittent, have you tried
running under valgrind?

-Peff
