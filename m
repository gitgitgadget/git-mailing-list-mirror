From: Jeff King <peff@peff.net>
Subject: Re: [1.8.0] git checkout refs/heads/foo checks out branch foo
Date: Mon, 7 Feb 2011 18:45:26 -0500
Message-ID: <20110207234526.GA28336@sigill.intra.peff.net>
References: <alpine.DEB.1.10.1102062234010.3788@debian>
 <20110207205934.GD13461@sigill.intra.peff.net>
 <AANLkTinmqTi4cYbR6PtSxt6itCvFQDuT_sE1tjx45a3h@mail.gmail.com>
 <20110207220030.GA19357@elie>
 <7vaai7s9g4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 08 00:45:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pmam3-0006tt-9N
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 00:45:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755188Ab1BGXpb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 18:45:31 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:33773 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755092Ab1BGXpa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 18:45:30 -0500
Received: (qmail 31917 invoked by uid 111); 7 Feb 2011 23:45:30 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 07 Feb 2011 23:45:30 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Feb 2011 18:45:26 -0500
Content-Disposition: inline
In-Reply-To: <7vaai7s9g4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166311>

On Mon, Feb 07, 2011 at 03:37:15PM -0800, Junio C Hamano wrote:

> > Subject: commit: document --detach synonym for "git checkout foo^{commit}"
> >
> > For example, one might use this when making a temporary merge to test
> > that two topics work well together.
> >
> > This patch just documents the option.  It is not meant for application
> > without an implementation and tests for the option.
> 
> On top of v1.7.3.5-1-g0cb6ad3 (uk/checkout-ambiguous-ref)...

Well, I started on tests and your email came just as I was about to
actually implement. So here are the tests. We didn't seem to have any
explicit checkout-detached tests before, so I tried to cover existing
methods in addition to the new option (which means Martin will need to
tweak one of the tests below when implementing his proposal).

Jonathan, do you want to roll all of these up into a single patch?

---
 t/t2020-checkout-detach.sh |   62 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 62 insertions(+), 0 deletions(-)
 create mode 100755 t/t2020-checkout-detach.sh

diff --git a/t/t2020-checkout-detach.sh b/t/t2020-checkout-detach.sh
new file mode 100755
index 0000000..886e186
--- /dev/null
+++ b/t/t2020-checkout-detach.sh
@@ -0,0 +1,62 @@
+#!/bin/sh
+
+test_description='checkout into detached HEAD state'
+. ./test-lib.sh
+
+check_detached() {
+	! git symbolic-ref -q HEAD >/dev/null
+}
+
+check_not_detached() {
+	! check_detached
+}
+
+reset() {
+	git checkout master &&
+	check_not_detached
+}
+
+test_expect_success 'setup' '
+	test_commit one &&
+	test_commit two &&
+	git branch branch &&
+	git tag tag
+'
+
+test_expect_success 'checkout branch does not detach' '
+	reset &&
+	git checkout branch &&
+	check_not_detached
+'
+
+test_expect_success 'checkout tag detaches' '
+	reset &&
+	git checkout tag &&
+	check_detached
+'
+
+test_expect_success 'checkout branch by full name detaches' '
+	reset &&
+	git checkout refs/heads/branch &&
+	check_detached
+'
+
+test_expect_success 'checkout non-ref detaches' '
+	reset &&
+	git checkout branch^ &&
+	check_detached
+'
+
+test_expect_success 'checkout ref^0 detaches' '
+	reset &&
+	git checkout branch^0 &&
+	check_detached
+'
+
+test_expect_success 'checkout --detach detaches' '
+	reset &&
+	git checkout --detach branch &&
+	check_detached
+'
+
+test_done
-- 
1.7.4.rc2.27.gd0787
