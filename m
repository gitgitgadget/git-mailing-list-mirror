From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: Intermittent Failures in t1450-fsck (Bisected)
Date: Thu, 5 May 2011 16:04:33 -0400
Message-ID: <60194977-A4A9-4E18-9878-C1CDE77B75C2@silverinsanity.com>
References: <115C364B-E910-4A9C-949E-3B10E5E6116C@silverinsanity.com> <2838BCC7-FB14-401B-9498-D0FB78C98D91@silverinsanity.com> <20110505093226.GA29595@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 05 22:05:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI4nC-0006yU-Ph
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 22:04:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753136Ab1EEUEx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 16:04:53 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:42962 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297Ab1EEUEx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 May 2011 16:04:53 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 272CD1FFC134; Thu,  5 May 2011 20:04:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.5 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-74-65-60-43.rochester.res.rr.com [74.65.60.43])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 126F31FFC0F6;
	Thu,  5 May 2011 20:04:32 +0000 (UTC)
In-Reply-To: <20110505093226.GA29595@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172900>


On May 5, 2011, at 5:32 AM, Jeff King wrote:

> On Thu, May 05, 2011 at 02:46:52AM -0400, Brian Gernhardt wrote:
>>> t1450-fsck fails in test 10 "tag pointing to something else than its type", but only if I run it as part of the full test suite (with either `make test` or `make prove`).  If I run the test separately, it passes.
>>> 
>>> The output from running with GIT_TEST_OPTS="-v" is:
>>> 
>>> expecting success: 
>>> 	sha=$(echo blob | git hash-object -w --stdin) &&
>>> 	test_when_finished "remove_object $sha" &&
>>> 	cat >wrong-tag <<-EOF &&
>>> 	object $sha
>>> 	type commit
>>> 	tag wrong
>>> 	tagger T A Gger <tagger@example.com> 1234567890 -0000
>>> 
>>> 	This is an invalid tag.
>>> 	EOF
>>> 
>>> 	tag=$(git hash-object -t tag -w --stdin <wrong-tag) &&
>>> 	test_when_finished "remove_object $tag" &&
>>> 	echo $tag >.git/refs/tags/wrong &&
>>> 	test_when_finished "git update-ref -d refs/tags/wrong" &&
>>> 	test_must_fail git fsck --tags 2>out &&
>>> 	cat out &&
>>> 	grep "error in tag.*broken links" out
>>> 
>>> tagged commit 63499e4ea8e096b831515ceb1d5a7593e4d87ae5 (wrong) in 66f6581d549f70e05ca586bc2df5c15a95662c36
>>> missing commit 63499e4ea8e096b831515ceb1d5a7593e4d87ae5
>>> error: Object 63499e4ea8e096b831515ceb1d5a7593e4d87ae5 is a commit, not a blob
>>> error: 63499e4ea8e096b831515ceb1d5a7593e4d87ae5: object corrupt or missing
>>> not ok - 10 tag pointing to something else than its type
> 
> So how did you bisect down to it? You said reverting e96c19c fixes it,
> which does seem like strong evidence, but what I am wondering is if a
> _different_ test in t1450 fails at e96c19c. That would point to
> something else funny going on.

I actually bisected the test failure to "c5a5f12e: Merge branch 'ef/maint-strbuf-init'", and then rebased e96c19c on top of 2a2dbd2 to see what actually caused the error.  I re-ran it like this again today and got the exact same error.

> Double weird is that my output for t1450.10 is totally different from
> that.  Which commit are you testing on?

The original e-mail was from next at that point.  The output from the rebased version and current next (76e37e2) is identical.

> Given that the problem seems racy and intermittent, have you tried
> running under valgrind?

This is on my OS X laptop and last I knew valgrind was very buggy on OS X, so I've never tried it.  I'll install it now and see if I can get anything useful out of it.

~~ Brian