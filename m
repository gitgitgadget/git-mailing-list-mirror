From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] allow hooks to ignore their standard input stream
Date: Fri, 13 Nov 2015 01:17:29 -0500
Message-ID: <20151113061729.GC32157@sigill.intra.peff.net>
References: <20151111143920.GA30409@musxeris015.imu.intel.com>
 <20151111144222.GA24717@musxeris015.imu.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, junio@pobox.com
To: Clemens Buchacher <clemens.buchacher@intel.com>
X-From: git-owner@vger.kernel.org Fri Nov 13 07:17:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zx7g1-0005tO-7L
	for gcvg-git-2@plane.gmane.org; Fri, 13 Nov 2015 07:17:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753138AbbKMGRd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 01:17:33 -0500
Received: from cloud.peff.net ([50.56.180.127]:56970 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752871AbbKMGRc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 01:17:32 -0500
Received: (qmail 17204 invoked by uid 102); 13 Nov 2015 06:17:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Nov 2015 00:17:32 -0600
Received: (qmail 21966 invoked by uid 107); 13 Nov 2015 06:18:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Nov 2015 01:18:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Nov 2015 01:17:30 -0500
Content-Disposition: inline
In-Reply-To: <20151111144222.GA24717@musxeris015.imu.intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281241>

On Wed, Nov 11, 2015 at 03:42:22PM +0100, Clemens Buchacher wrote:

> On Wed, Nov 11, 2015 at 03:39:20PM +0100, Clemens Buchacher wrote:
> > +		if (write_in_full(proc.in, buf.buf, buf.len) < 0) {
> > +			/* We do not mind if a hook does not read all refs. */
> > +			if (errno != EPIPE)
> > +				ret = -1;
> 
> I can reproduce the pipe error reliably with the test below. I did not
> include it in the patch since I am in doubt if we should add an optional
> sleep to the code.

Yeah, we definitely do not want to do so. The reliable way to get a
SIGPIPE is:

  1. Have one process write more than a pipe buffer's worth of data.

  2. Have the other process exit without reading anything.

Then even if the writer process goes first, it will block, and
eventually get EPIPE when the other side closes the descriptor.

Unfortunately, the pipe buffer size varies from system to system. It's
128K by default on modern Linux platforms. Using that is probably
enough. The worst case is that the system has a larger buffer, and the
test will succeed even without the fix. But that is OK as long as
somebody somewhere is running the test with a smaller buffer and would
catch a regression.

Of course, convincing git to generate 128K worth of hook input is often
quite inefficient. The existing test in t5571 is quite painful because
it calls "git branch" in a loop. We can do much better than that.
The test below reliably fails without your patch and passes with it, and
seems to run reasonably quickly for me:

diff --git a/t/t5571-pre-push-hook.sh b/t/t5571-pre-push-hook.sh
index 6f9916a..61df2f9 100755
--- a/t/t5571-pre-push-hook.sh
+++ b/t/t5571-pre-push-hook.sh
@@ -109,23 +109,28 @@ test_expect_success 'push to URL' '
 	diff expected actual
 '
 
-# Test that filling pipe buffers doesn't cause failure
-# Too slow to leave enabled for general use
-if false
-then
-	printf 'parent1\nrepo1\n' >expected
-	nr=1000
-	while test $nr -lt 2000
-	do
-		nr=$(( $nr + 1 ))
-		git branch b/$nr $COMMIT3
-		echo "refs/heads/b/$nr $COMMIT3 refs/heads/b/$nr $_z40" >>expected
-	done
-
-	test_expect_success 'push many refs' '
-		git push parent1 "refs/heads/b/*:refs/heads/b/*" &&
-		diff expected actual
-	'
-fi
+test_expect_success 'set up many-ref tests' '
+	{
+		echo >&3 parent1 &&
+		echo >&3 repo1 &&
+		nr=1000
+		while test $nr -lt 2000
+		do
+			nr=$(( $nr + 1 ))
+			echo "create refs/heads/b/$nr $COMMIT3"
+			echo >&3 "refs/heads/b/$nr $COMMIT3 refs/heads/b/$nr $_z40"
+		done
+	} 3>expected | git update-ref --stdin
+'
+
+test_expect_success 'filling pipe buffer does not cause failure' '
+	git push parent1 "refs/heads/b/*:refs/heads/b/*" &&
+	test_cmp expected actual
+'
+
+test_expect_success 'sigpipe does not cause pre-push hook failure' '
+	echo "exit 0" | write_script "$HOOK" &&
+	git push parent1 "refs/heads/b/*:refs/heads/c/*"
+'
 
 test_done
