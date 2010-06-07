From: Jeff King <peff@peff.net>
Subject: Re: rebase --continue confusion
Date: Sun, 6 Jun 2010 20:41:46 -0400
Message-ID: <20100607004146.GA25106@coredump.intra.peff.net>
References: <4C01B855.7080409@gmail.com>
 <m3bpbo1f3f.fsf@winooski.ccs.neu.edu>
 <20100606221853.GG6993@coredump.intra.peff.net>
 <19468.8730.59682.76355@winooski.ccs.neu.edu>
 <20100606224601.GB11424@coredump.intra.peff.net>
 <19468.12912.509183.102990@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Mon Jun 07 02:48:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLQVj-0003jE-48
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 02:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753452Ab0FGAlv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jun 2010 20:41:51 -0400
Received: from peff.net ([208.65.91.99]:54289 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753243Ab0FGAlu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jun 2010 20:41:50 -0400
Received: (qmail 14391 invoked by uid 107); 7 Jun 2010 00:41:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 06 Jun 2010 20:41:57 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 06 Jun 2010 20:41:46 -0400
Content-Disposition: inline
In-Reply-To: <19468.12912.509183.102990@winooski.ccs.neu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148565>

On Sun, Jun 06, 2010 at 07:42:40PM -0400, Eli Barzilay wrote:

> > Probably it would be helpful in the case of an amend to indicate
> > what has happened (you have no changes, but it is not immediately
> > obvious that you have no changes against HEAD^, not HEAD). We could
> > even suggest "git reset HEAD^", which is probably what you want (the
> > only other thing you could want is to create a commit with no
> > changes, which we generally try to avoid).
> 
> Yes, that sounds reasonable.  (When I realized what happened I
> wondered why it didn't do the reset itself, but that would obviously
> be a bad idea.)

I'm not convinced this comes up often enough to really be worth worrying
about, but the patch is quite trivial, so why not?

-- >8 --
Subject: [PATCH] commit: give advice on empty amend

We generally disallow empty commits with "git commit". The
output produced by the wt_status functions is generally
sufficient to explain what happened.

With --amend commits, however, things are a little more
confusing. We would create an empty commit not if you
actually have staged changes _now_, but if your staged
changes match HEAD^. In this case, it is not immediately
obvious why "git commit" claims no changes, but "git status"
does not. Furthermore, we should point the user in the
direction of git reset, which would eliminate the empty
commit entirely.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/commit.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 4b2a468..10b09b9 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -48,6 +48,11 @@ static const char implicit_ident_advice[] =
 "\n"
 "    git commit --amend --author='Your Name <you@example.com>'\n";
 
+static const char empty_amend_advice[] =
+"You asked to amend the most recent commit, but doing so would make\n"
+"it empty. You can repeat your command with --allow-empty, or you can\n"
+"remove the commit entirely with \"git reset HEAD^\".\n";
+
 static unsigned char head_sha1[20];
 
 static char *use_message_buffer;
@@ -706,6 +711,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	if (!commitable && !in_merge && !allow_empty &&
 	    !(amend && is_a_merge(head_sha1))) {
 		run_status(stdout, index_file, prefix, 0, s);
+		if (amend)
+			fputs(empty_amend_advice, stderr);
 		return 0;
 	}
 
-- 
1.7.1.458.g792cd.dirty
