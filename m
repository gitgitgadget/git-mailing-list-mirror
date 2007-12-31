From: Jeff King <peff@peff.net>
Subject: Re: [bug] Working files created in bare repository when pushing to
	a rewound bare repository
Date: Mon, 31 Dec 2007 02:26:32 -0500
Message-ID: <20071231072632.GA11451@coredump.intra.peff.net>
References: <46dff0320712302242m34b5267dlb3f26488293d5d51@mail.gmail.com> <20071231064741.GA4250@coredump.intra.peff.net> <46dff0320712302302p4c125ee1n2abc1561ba10c47e@mail.gmail.com> <20071231070749.GB4250@coredump.intra.peff.net> <20071231071352.GC4250@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ping Yin <pkufranky@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 31 08:27:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9F35-0003Ai-7D
	for gcvg-git-2@gmane.org; Mon, 31 Dec 2007 08:26:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753364AbXLaH0g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2007 02:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753363AbXLaH0g
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Dec 2007 02:26:36 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4799 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753319AbXLaH0f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2007 02:26:35 -0500
Received: (qmail 1210 invoked by uid 111); 31 Dec 2007 07:26:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 31 Dec 2007 02:26:33 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 31 Dec 2007 02:26:32 -0500
Content-Disposition: inline
In-Reply-To: <20071231071352.GC4250@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69393>

On Mon, Dec 31, 2007 at 02:13:52AM -0500, Jeff King wrote:

> git-reset: refuse to do hard reset in a bare repository
> 
> It makes no sense since there is no working tree. A soft
> reset should be fine, though.

And then on top of this (plus one-liner fix I posted), as Ping Yin
suggested, we can do:

-- >8 --
git-reset: default to --soft in a bare repo

--mixed doesn't make sense, since we don't generally have an
index.

Signed-off-by: Jeff King <peff@peff.net>
---
This is a bit more contentious. There's no reason you can't have an
index in a bare repo, and this is changing the behavior of those who do.
They can always explicitly specify --mixed (since we haven't disallowed
that), but it might break some scripts.

 builtin-reset.c       |    2 +-
 t/t7103-reset-bare.sh |    9 ++++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/builtin-reset.c b/builtin-reset.c
index 10dba60..44e4eb4 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -242,7 +242,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		return read_from_tree(prefix, argv + i, sha1);
 	}
 	if (reset_type == NONE)
-		reset_type = MIXED; /* by default */
+		reset_type = is_bare_repository() ? SOFT : MIXED;
 
 	if (reset_type == HARD && is_bare_repository())
 		die("hard reset makes no sense in a bare repository");
diff --git a/t/t7103-reset-bare.sh b/t/t7103-reset-bare.sh
index b25a77f..c2cdba4 100755
--- a/t/t7103-reset-bare.sh
+++ b/t/t7103-reset-bare.sh
@@ -7,8 +7,10 @@ test_expect_success 'setup non-bare' '
 	echo one >file &&
 	git add file &&
 	git commit -m one &&
+	git tag one &&
 	echo two >file &&
-	git commit -a -m two
+	git commit -a -m two &&
+	git tag two
 '
 
 test_expect_success 'setup bare' '
@@ -25,4 +27,9 @@ test_expect_success 'soft reset is allowed' '
 	test "`git show --pretty=format:%s | head -n 1`" = "one"
 '
 
+test_expect_success 'default to soft reset' '
+	git reset two &&
+	test "`git show --pretty=format:%s | head -n 1`" = "two"
+'
+
 test_done
-- 
1.5.4.rc2.1102.g4735f-dirty
