From: Jeff King <peff@peff.net>
Subject: Re: concurrent fetches to update same mirror
Date: Thu, 6 Jan 2011 18:45:12 -0500
Message-ID: <20110106234512.GA17231@sigill.intra.peff.net>
References: <ig2kjt$f2u$1@dough.gmane.org>
 <20110105204738.GA7629@sigill.intra.peff.net>
 <AANLkTini61q+NtDr6oytTcfA6QNGN74L60exdLrNmakd@mail.gmail.com>
 <20110105205324.GA7808@sigill.intra.peff.net>
 <20110105211313.GB7808@sigill.intra.peff.net>
 <7vbp3vc4k4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>,
	Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 07 00:45:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PazWG-0004bK-Bh
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 00:45:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752317Ab1AFXpQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 18:45:16 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:60164 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751699Ab1AFXpP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 18:45:15 -0500
Received: (qmail 9993 invoked by uid 111); 6 Jan 2011 23:45:14 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 06 Jan 2011 23:45:14 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Jan 2011 18:45:12 -0500
Content-Disposition: inline
In-Reply-To: <7vbp3vc4k4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164686>

On Wed, Jan 05, 2011 at 03:29:47PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Interestingly, in the case of ref _creation_, not update, like this:
> >
> >   mkdir repo && cd repo && git init
> >   git remote add origin some-remote-repo-that-takes-a-few-seconds
> >   xterm -e 'git fetch -v; read' & xterm -e 'git fetch -v; read'
> >
> > then both will happily update, the second one overwriting the results of
> > the first. It seems in the case of locking a ref which previously didn't
> > exist, we don't enforce that it still doesn't exist.
> 
> We probably should, especially when there is no --force or +prefix is
> involved.

Hmph. So I created the test below to try to exercise this, expecting to
see at least one failure: according to the above example, we aren't
actually checking "null sha1 means ref must not exist", so we should get
an erroneous success for that case. And there is the added complication
that the null sha1 may also mean "don't care what the old one was". So
even if I changed the code, we would get erroneous failures the other
way.

But much to my surprise, it actually passes with stock git. Which means
I need to dig a little further to see exactly what is going on.

Hooray for test-driven development, I guess? :)

diff --git a/t/t1403-concurrent-refs.sh b/t/t1403-concurrent-refs.sh
new file mode 100755
index 0000000..7fb4424
--- /dev/null
+++ b/t/t1403-concurrent-refs.sh
@@ -0,0 +1,49 @@
+#!/bin/sh
+
+test_description='test behavior of concurrent ref updates'
+. ./test-lib.sh
+
+ref=refs/heads/foo
+null=0000000000000000000000000000000000000000
+
+check_ref() {
+	echo $2 >expect &&
+	git rev-parse --verify $1 >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success setup '
+	for name in A B C; do
+		test_tick &&
+		T=$(git write-tree) &&
+		sha1=$(echo $name | git commit-tree $T) &&
+		eval $name=$sha1
+	done
+'
+
+test_expect_success '(create ref, expecting non-null sha1) should fail' '
+	test_must_fail git update-ref $ref $A $C &&
+	test_must_fail git rev-parse --verify $ref
+'
+
+test_expect_success '(create ref, expecting null sha1) should work' '
+	git update-ref $ref $A $null &&
+	check_ref $ref $A
+'
+
+test_expect_success '(update ref, expecting null sha1) should fail' '
+	test_must_fail git update-ref $ref $B $null &&
+	check_ref $ref $A
+'
+
+test_expect_success '(update ref, expecting wrong sha1) should fail' '
+	test_must_fail git update-ref $ref $B $C &&
+	check_ref $ref $A
+'
+
+test_expect_success '(update ref, expecting current sha1) should work' '
+	git update-ref $ref $B $A &&
+	check_ref $ref $B
+'
+
+test_done
