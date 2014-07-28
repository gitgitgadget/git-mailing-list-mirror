From: Jeff King <peff@peff.net>
Subject: Re: git diff-tree commit detail bug in 2.0.2 and 2.0.3
Date: Mon, 28 Jul 2014 14:01:57 -0400
Message-ID: <20140728180157.GA11265@peff.net>
References: <CAGyf7-HKpfyi5OqXS9BhtfXUEZXbisawpTPK9UFOQObz1qhRUw@mail.gmail.com>
 <20140728103504.GB10737@peff.net>
 <xmqqtx614cea.fsf@gitster.dls.corp.google.com>
 <20140728173734.GA10309@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Bryan Turner <bturner@atlassian.com>,
	Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 28 20:02:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBpFR-000107-9f
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 20:02:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751776AbaG1SCF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 14:02:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:41857 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751734AbaG1SCB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 14:02:01 -0400
Received: (qmail 23139 invoked by uid 102); 28 Jul 2014 18:02:01 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 Jul 2014 13:02:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Jul 2014 14:01:57 -0400
Content-Disposition: inline
In-Reply-To: <20140728173734.GA10309@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254331>

On Mon, Jul 28, 2014 at 01:37:34PM -0400, Jeff King wrote:

> On Mon, Jul 28, 2014 at 10:32:45AM -0700, Junio C Hamano wrote:
> 
> > > Junio, we should consider a v2.0.4 with that series, I think. This is a
> > > pretty serious regression in diff-tree (I didn't even realize that the
> > > buffer-slab work went into the maint series; that may have been a little
> > > ambitious).
> > 
> > Or v2.0.4 without that series, which is how we usually do things,
> > but let me see if jk/alloc-commit-id is easily applicable there
> > first.
> 
> Yeah, I'm fine with a straight revert, too (I think it is fine to keep
> in master, though). I think jk/alloc-commit-id is built right on top of
> the original commit-slab topic, so it should be easy to do either way.
> 
> Thanks for dealing with it.

Whatever we do, perhaps it is worth applying the test below on top?

-- >8 --
Subject: t4013: test diff-tree's --stdin commit formatting

Once upon a time, git-log was just "rev-list | diff-tree",
and we did not bother to test it separately. These days git-log
is implemented internally, but we want to make sure that the
rev-list to diff-tree pipeline continues to function. Let's
add a basic sanity test.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t4013-diff-various.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 805b055..6ec6072 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -324,4 +324,14 @@ test_expect_success 'diff --cached -- file on unborn branch' '
 	test_cmp "$TEST_DIRECTORY/t4013/diff.diff_--cached_--_file0" result
 '
 
+test_expect_success 'diff-tree --stdin with log formatting' '
+	cat >expect <<-\EOF &&
+	Side
+	Third
+	Second
+	EOF
+	git rev-list master | git diff-tree --stdin --format=%s -s >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.0.0.566.gfe3e6b2
