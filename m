From: Jeff King <peff@peff.net>
Subject: Re: bug: transform a binary file into a symlink in one commit =>
	invalid binary patch
Date: Sun, 25 Jan 2009 19:35:56 -0500
Message-ID: <20090126003556.GA19368@coredump.intra.peff.net>
References: <lyhc3q9pl1.fsf@leia.mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Pixel <pixel@mandriva.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 01:37:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRFTo-0006FX-PG
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 01:37:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbZAZAgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 19:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbZAZAgA
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 19:36:00 -0500
Received: from peff.net ([208.65.91.99]:58939 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750786AbZAZAf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 19:35:59 -0500
Received: (qmail 29729 invoked by uid 107); 26 Jan 2009 00:36:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 25 Jan 2009 19:36:05 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 25 Jan 2009 19:35:56 -0500
Content-Disposition: inline
In-Reply-To: <lyhc3q9pl1.fsf@leia.mandriva.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107146>

On Fri, Jan 23, 2009 at 01:25:30PM +0100, Pixel wrote:

> i hit a bug (git 1.6.1): when you transform a binary file into a
> symlink in one commit, the binary patch can't be used in "git apply".
> Is it a known issue?

Not that I know of.

Below is a patch against the test suite that fairly neatly displays the
problem. I didn't get a chance to look into actually fixing it, though
(I'm not even sure the problem is in apply, and not in the generated
patch).

---
diff --git a/t/t4130-apply-symlink-binary.sh b/t/t4130-apply-symlink-binary.sh
new file mode 100755
index 0000000..0ee2ba1
--- /dev/null
+++ b/t/t4130-apply-symlink-binary.sh
@@ -0,0 +1,30 @@
+#!/bin/sh
+
+test_description='apply handles binary to symlink conversion'
+. ./test-lib.sh
+
+test_expect_success 'create commit with binary' '
+	echo content >file && git add file &&
+	printf "\0" > binary && git add binary &&
+	git commit -m one
+'
+
+test_expect_success 'convert binary to symlink' '
+	rm binary &&
+	ln -s file binary &&
+	git add binary &&
+	git commit -m two
+'
+
+test_expect_success 'create patch' '
+	git diff-tree --binary HEAD^ HEAD >patch
+'
+
+test_expect_success 'apply patch' '
+	git reset --hard HEAD^ &&
+	git apply patch &&
+	test -h binary &&
+	test_cmp binary file
+'
+
+test_done
