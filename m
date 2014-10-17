From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/25] prune-safety
Date: Thu, 16 Oct 2014 20:03:41 -0400
Message-ID: <20141017000341.GA7848@peff.net>
References: <20141015223244.GA25368@peff.net>
 <xmqqsiinsoyk.fsf@gitster.dls.corp.google.com>
 <20141016212112.GA16054@peff.net>
 <20141016213918.GA29397@peff.net>
 <xmqq8ukfslol.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 17 02:03:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xev1J-0007q3-QV
	for gcvg-git-2@plane.gmane.org; Fri, 17 Oct 2014 02:03:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752796AbaJQADp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2014 20:03:45 -0400
Received: from cloud.peff.net ([50.56.180.127]:59445 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752448AbaJQADo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2014 20:03:44 -0400
Received: (qmail 3109 invoked by uid 102); 17 Oct 2014 00:03:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Oct 2014 19:03:44 -0500
Received: (qmail 3873 invoked by uid 107); 17 Oct 2014 00:03:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Oct 2014 20:03:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Oct 2014 20:03:41 -0400
Content-Disposition: inline
In-Reply-To: <xmqq8ukfslol.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 16, 2014 at 03:18:34PM -0700, Junio C Hamano wrote:

> > We should probably add a test for cloning a tag of an otherwise
> > unreferenced object, too.
> 
> Yeah, that too ;-)

Here's that test (after the scissors below). It can be applied totally
separately, though I stuck it in as patch "18.5/25" in the existing
series to confirm that my original series does cause the test to fail,
and that it passes with the patch I posted earlier.

Do you want to just squash the fix I posted earlier (into patch 19, the
"traverse_commit_list: ..." one)? I'm happy to repost the revised patch,
but my impression of your workflow is that squashing is just as easy
than replacing a patch (i.e., you're running "rebase -i" either way).

Or I'm happy to re-post the whole series, but it's rather long. :)

> Thanks for a quick diag.

I'm impressed that you found the bug so quickly. :) My biggest fear with
the whole series is that it's disrupting and refactoring some
fundamental parts of the code that might cause regressions. I put a lot
of my faith in the test suite, but that did not work out here (I do
still feel pretty good about the series overall, though I think I'd cook
it longer than usual given the complexity and the areas it touches).

-- >8 --
Subject: t5516: test pushing a tag of an otherwise unreferenced blob

It's not unreasonable to have a tag that points to a blob
that is not part of the normal history. We do this in
git.git to distribute gpg keys. However, we never explicitly
checked in our test suite that this actually works (i.e.,
that pack-objects actually sends the blob because of the tag
mentioning it).

It does in fact work fine, but a recent patch under
discussion broke this, and the test suite didn't notice.
Let's make the test suite more complete.

Signed-off-by: Jeff King <peff@peff.net>
---
The "should have" below is belt-and-suspenders. The test actually fails
with my series without the cat-file check, but I'm concerned a bug
that affects pack-objects could also affect the connectivity check on
the receiving side.

 t/t5516-fetch-push.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 67e0ab3..7c8a769 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1277,4 +1277,17 @@ EOF
 	git push --no-thin --receive-pack="$rcvpck" no-thin/.git refs/heads/master:refs/heads/foo
 '
 
+test_expect_success 'pushing a tag pushes the tagged object' '
+	rm -rf dst.git &&
+	blob=$(echo unreferenced | git hash-object -w --stdin) &&
+	git tag -m foo tag-of-blob $blob &&
+	git init --bare dst.git &&
+	git push dst.git tag-of-blob &&
+	# the receiving index-pack should have noticed
+	# any problems, but we double check
+	echo unreferenced >expect &&
+	git --git-dir=dst.git cat-file blob tag-of-blob >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.1.2.596.g7379948
