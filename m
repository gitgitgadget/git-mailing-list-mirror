From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] diff.c: output correct index lines for a split diff
Date: Mon, 26 Jan 2009 04:07:12 -0500
Message-ID: <20090126090712.GA12648@coredump.intra.peff.net>
References: <lyhc3q9pl1.fsf@leia.mandriva.com> <20090126003556.GA19368@coredump.intra.peff.net> <7vy6wy8qmm.fsf@gitster.siamese.dyndns.org> <7vhc3m8o0b.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Pixel <pixel@mandriva.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 10:08:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRNST-0006L9-Pm
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 10:08:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790AbZAZJHR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 04:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751546AbZAZJHQ
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 04:07:16 -0500
Received: from peff.net ([208.65.91.99]:42881 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751498AbZAZJHO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 04:07:14 -0500
Received: (qmail 1519 invoked by uid 107); 26 Jan 2009 09:07:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 26 Jan 2009 04:07:22 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Jan 2009 04:07:12 -0500
Content-Disposition: inline
In-Reply-To: <7vhc3m8o0b.fsf_-_@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107180>

On Mon, Jan 26, 2009 at 12:33:56AM -0800, Junio C Hamano wrote:

> This moves the code to generate metainfo lines around, so that two
> independent sets of metainfo lines are used for the split halves.

The patch and the generated output look correct to me, so

Acked-by: Jeff King <peff@peff.net>

> I did not include your new test script here; perhaps we can add it to an
> existing typechange diff/apply test, like t4114?

I think it makes sense to add to t4114. Please squash in the test below.

One think to note, though: test 8 (binary -> symlink) shows breakage
with the current master, but test 9 (symlink -> binary) does not.
However, if you run the test under "-d" you can see that the diff has
bogus metainfo. It's just that "apply" doesn't care.

Your test fixes the test failure, and I verified manually that the diff
output is sensible. I don't think an additional test is worth it, but we
could add one that explicitly checks the metainfo if you want to be
extra paranoid.

---
diff --git a/t/t4114-apply-typechange.sh b/t/t4114-apply-typechange.sh
index 5533492..0f185ca 100755
--- a/t/t4114-apply-typechange.sh
+++ b/t/t4114-apply-typechange.sh
@@ -25,6 +25,10 @@ test_expect_success 'setup repository and commits' '
 	git update-index foo &&
 	git commit -m "foo back to file" &&
 	git branch foo-back-to-file &&
+	printf "\0" > foo &&
+	git update-index foo &&
+	git commit -m "foo becomes binary" &&
+	git branch foo-becomes-binary &&
 	rm -f foo &&
 	git update-index --remove foo &&
 	mkdir foo &&
@@ -85,6 +89,20 @@ test_expect_success 'symlink becomes file' '
 	'
 test_debug 'cat patch'
 
+test_expect_success 'binary file becomes symlink' '
+	git checkout -f foo-becomes-binary &&
+	git diff-tree -p --binary HEAD foo-symlinked-to-bar > patch &&
+	git apply --index < patch
+	'
+test_debug 'cat patch'
+
+test_expect_success 'symlink becomes binary file' '
+	git checkout -f foo-symlinked-to-bar &&
+	git diff-tree -p --binary HEAD foo-becomes-binary > patch &&
+	git apply --index < patch
+	'
+test_debug 'cat patch'
+
 
 test_expect_success 'symlink becomes directory' '
 	git checkout -f foo-symlinked-to-bar &&
