From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] connect: treat generic proxy processes like ssh
 processes
Date: Wed, 18 May 2011 04:57:44 -0400
Message-ID: <20110518085743.GH27482@sigill.intra.peff.net>
References: <20110516063944.GB25731@sigill.intra.peff.net>
 <20110516064607.GA19078@sigill.intra.peff.net>
 <4DD181C6.4020104@kdbg.org>
 <20110517055422.GD10048@sigill.intra.peff.net>
 <4DD2D733.3070004@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed May 18 10:57:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMcZm-0003bb-UC
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 10:57:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755528Ab1ERI5t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 04:57:49 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48005
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755174Ab1ERI5t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 04:57:49 -0400
Received: (qmail 3296 invoked by uid 107); 18 May 2011 08:59:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 May 2011 04:59:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 May 2011 04:57:44 -0400
Content-Disposition: inline
In-Reply-To: <4DD2D733.3070004@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173864>

On Tue, May 17, 2011 at 10:14:43PM +0200, Johannes Sixt wrote:

> Am 17.05.2011 07:54, schrieb Jeff King:
> > On Mon, May 16, 2011 at 09:57:58PM +0200, Johannes Sixt wrote:
> >> In my implementation, I xmalloced the pointer array and leaked it.
> 
> I noticed that it actually isn't leaked because finish_connect() frees
> it. For this reason, I actually have to wonder why your version that
> stored a pointer to automatic storage in ->argv worked.

It probably didn't. As a simple refactoring, I didn't test the proxy
codepath, and apparently nothing in our test suite does, either. :(

We can put the patch below on top (it fails with my original series, but
passes with the bugfix you noticed).

> I would not worry too much today. Of course, functions other than
> start_command() might begin to access ->argv[i] with i > 0 later, but
> then we have to audit all users of struct child_process anyway.
> Currently, only start_command() uses these values, which is always
> called at a time when they are still valid.

That makes sense.

-- >8 --
Subject: [PATCH] test core.gitproxy configuration

This is just a basic sanity test to see whether
core.gitproxy works at all. Until now, we were not testing
anywhere.

Signed-off-by: Jeff King <peff@peff.net>
---
This is really basic. Apparently you can do horrible things like

  git config core.gitproxy "./proxy for kernel.org"
  git config core.gitproxy "./other-proxy for example.com"

I can make it more elaborate if we really want to care.

 t/t5532-fetch-proxy.sh |   42 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 42 insertions(+), 0 deletions(-)
 create mode 100755 t/t5532-fetch-proxy.sh

diff --git a/t/t5532-fetch-proxy.sh b/t/t5532-fetch-proxy.sh
new file mode 100755
index 0000000..07119d9
--- /dev/null
+++ b/t/t5532-fetch-proxy.sh
@@ -0,0 +1,42 @@
+#!/bin/sh
+
+test_description='fetching via git:// using core.gitproxy'
+. ./test-lib.sh
+
+test_expect_success 'setup remote repo' '
+	git init remote &&
+	(cd remote &&
+	 echo content >file &&
+	 git add file &&
+	 git commit -m one
+	)
+'
+
+cat >proxy <<'EOF'
+#!/bin/sh
+echo >&2 "proxying for $*"
+cmd=`perl -e '
+	read(STDIN, $buf, 4);
+	my $n = hex($buf) - 4;
+	read(STDIN, $buf, $n);
+	my ($cmd, $other) = split /\0/, $buf;
+	# drop absolute-path on repo name
+	$cmd =~ s{ /}{ };
+	print $cmd;
+'`
+exec $cmd
+EOF
+chmod +x proxy
+test_expect_success 'setup local repo' '
+	git remote add fake git://example.com/remote &&
+	git config core.gitproxy ./proxy
+'
+
+test_expect_success 'fetch through proxy works' '
+	git fetch fake &&
+	echo one >expect &&
+	git log -1 --format=%s FETCH_HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
1.7.5.8.ga95ab
