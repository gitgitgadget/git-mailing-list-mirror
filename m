From: Jeff King <peff@peff.net>
Subject: Re: [bug] Working files created in bare repository when pushing to
	a rewound bare repository
Date: Mon, 31 Dec 2007 02:13:52 -0500
Message-ID: <20071231071352.GC4250@coredump.intra.peff.net>
References: <46dff0320712302242m34b5267dlb3f26488293d5d51@mail.gmail.com> <20071231064741.GA4250@coredump.intra.peff.net> <46dff0320712302302p4c125ee1n2abc1561ba10c47e@mail.gmail.com> <20071231070749.GB4250@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ping Yin <pkufranky@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 31 08:14:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9Eqw-0001RM-IG
	for gcvg-git-2@gmane.org; Mon, 31 Dec 2007 08:14:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752813AbXLaHN4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2007 02:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752786AbXLaHN4
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Dec 2007 02:13:56 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2787 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752688AbXLaHNz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2007 02:13:55 -0500
Received: (qmail 1150 invoked by uid 111); 31 Dec 2007 07:13:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 31 Dec 2007 02:13:54 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 31 Dec 2007 02:13:52 -0500
Content-Disposition: inline
In-Reply-To: <20071231070749.GB4250@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69391>

On Mon, Dec 31, 2007 at 02:07:50AM -0500, Jeff King wrote:

> I started on this when I realized that --soft doesn't even work. I

Er, sorry, I'm somehow incompetent and failed to perform my test
correctly. --soft does work. I think the following is probably worth
doing.

-- >8 --
git-reset: refuse to do hard reset in a bare repository

It makes no sense since there is no working tree. A soft
reset should be fine, though.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-reset.c       |    3 +++
 t/t7103-reset-bare.sh |   28 ++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 0 deletions(-)
 create mode 100755 t/t7103-reset-bare.sh

diff --git a/builtin-reset.c b/builtin-reset.c
index 713c2d5..10dba60 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -244,6 +244,9 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	if (reset_type == NONE)
 		reset_type = MIXED; /* by default */
 
+	if (reset_type == HARD && is_bare_repository())
+		die("hard reset makes no sense in a bare repository");
+
 	/* Soft reset does not touch the index file nor the working tree
 	 * at all, but requires them in a good order.  Other resets reset
 	 * the index file to the tree object we are switching to. */
diff --git a/t/t7103-reset-bare.sh b/t/t7103-reset-bare.sh
new file mode 100755
index 0000000..333d5ea
--- /dev/null
+++ b/t/t7103-reset-bare.sh
@@ -0,0 +1,28 @@
+#!/bin/sh
+
+test_description='git-reset in a bare repository'
+. ./test-lib.sh
+
+test_expect_success 'setup non-bare' '
+	echo one >file &&
+	git add file &&
+	git commit -m one
+	echo two >file &&
+	git commit -a -m two
+'
+
+test_expect_success 'setup bare' '
+	git clone --bare . bare.git &&
+	cd bare.git
+'
+
+test_expect_success 'hard reset is not allowed' '
+	! git reset --hard HEAD^
+'
+
+test_expect_success 'soft reset is allowed' '
+	git reset --soft HEAD^ &&
+	test "`git show --pretty=format:%s | head -n 1`" = "one"
+'
+
+test_done
-- 
1.5.4.rc2.1101.g236e-dirty
