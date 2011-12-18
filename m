From: Jeff King <peff@peff.net>
Subject: Re: BUG: Git command causes crash
Date: Sun, 18 Dec 2011 00:38:04 -0500
Message-ID: <20111218053804.GA4462@sigill.intra.peff.net>
References: <CAOgd6zFr5LorTK6X5o6NQE3L61KhaUZG9tX4LEB4_Na_YKPPpA@mail.gmail.com>
 <20111218050322.GA1787@sigill.intra.peff.net>
 <20111218050728.GB1787@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ryan O'Hara <minitech.me@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 18 06:38:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rc9S5-00084W-VB
	for gcvg-git-2@lo.gmane.org; Sun, 18 Dec 2011 06:38:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194Ab1LRFiI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Dec 2011 00:38:08 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45233
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750767Ab1LRFiH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Dec 2011 00:38:07 -0500
Received: (qmail 18510 invoked by uid 107); 18 Dec 2011 05:44:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 18 Dec 2011 00:44:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 18 Dec 2011 00:38:04 -0500
Content-Disposition: inline
In-Reply-To: <20111218050728.GB1787@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187414>

On Sun, Dec 18, 2011 at 12:07:28AM -0500, Jeff King wrote:

> -static struct strbuf merge_msg;
> +static struct strbuf merge_msg = STRBUF_INIT;
> [...]
> 
> I'm not sure if you can actually trigger a segfault, but it clearly
> violates the strbuf API.

One note on this: that line by itself doesn't violate the strbuf API.
You can always initialize it by hand later.  But it's easy to look
through the code in this case and see that we don't.

A grep of "static struct strbuf" doesn't show any other similar cases. I
also did a grep of "struct strbuf [a-z]*;" to find stack and struct
member variables. Most of the stack ones get initialized right away
(which is not too surprising, as they would contain random garbage and
not work at all). A few of the ones in structs are hard to track down,
and could be problematic (I expected to maybe find a memset-to-zero
initialization), but I followed all of them to an actual strbuf_init.

Which isn't to say my looking was exhaustive, as there might be other
code paths I missed. But at least these two are the low-hanging fruit.

Here's a commit which does them both together (they are really the same
bug).

-- >8 --
Subject: [PATCH] initialize static strbufs

Strbufs cannot rely on static all-zero initialization;
instead, they must use STRBUF_INIT to point to the
"slopbuf". This failure can go undetected in most code
paths, as only some of the strbuf functions assume the
slopbuf is in place (e.g., "strbuf_add" works). In
particular, calling "strbuf_setlen" will cause a segfault.

Without this patch, "git commit --no-message" and "git merge
--no-message" segfault reliably.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/commit.c |    2 +-
 builtin/merge.c  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index d0f27f9..336faff 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -104,7 +104,7 @@
 static int use_editor = 1, include_status = 1;
 static int show_ignored_in_status;
 static const char *only_include_assumed;
-static struct strbuf message;
+static struct strbuf message = STRBUF_INIT;
 
 static int null_termination;
 static enum {
diff --git a/builtin/merge.c b/builtin/merge.c
index 2457940..28a3a7e 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -50,7 +50,7 @@ struct strategy {
 static int fast_forward_only, option_edit;
 static int allow_trivial = 1, have_message;
 static int overwrite_ignore = 1;
-static struct strbuf merge_msg;
+static struct strbuf merge_msg = STRBUF_INIT;
 static struct commit_list *remoteheads;
 static struct strategy **use_strategies;
 static size_t use_strategies_nr, use_strategies_alloc;
-- 
1.7.8.rc3.14.gd2470
