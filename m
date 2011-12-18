From: Jeff King <peff@peff.net>
Subject: Re: BUG: Git command causes crash
Date: Sun, 18 Dec 2011 00:07:28 -0500
Message-ID: <20111218050728.GB1787@sigill.intra.peff.net>
References: <CAOgd6zFr5LorTK6X5o6NQE3L61KhaUZG9tX4LEB4_Na_YKPPpA@mail.gmail.com>
 <20111218050322.GA1787@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ryan O'Hara <minitech.me@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 18 06:07:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rc8yF-0002Js-Jj
	for gcvg-git-2@lo.gmane.org; Sun, 18 Dec 2011 06:07:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984Ab1LRFHb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Dec 2011 00:07:31 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45230
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750814Ab1LRFHa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Dec 2011 00:07:30 -0500
Received: (qmail 18377 invoked by uid 107); 18 Dec 2011 05:14:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 18 Dec 2011 00:14:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 18 Dec 2011 00:07:28 -0500
Content-Disposition: inline
In-Reply-To: <20111218050322.GA1787@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187413>

On Sun, Dec 18, 2011 at 12:03:22AM -0500, Jeff King wrote:

> Subject: [PATCH] commit: initialize static strbuf
> 
> Strbufs cannot rely on static all-zero initialization;
> instead, they must use STRBUF_INIT to point to the
> "slopbuf".
> 
> Without this patch, "git commit --no-message" segfaults
> reliably.

This one, too:

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

I'm not sure if you can actually trigger a segfault, but it clearly
violates the strbuf API.

-Peff
