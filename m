From: Jeff King <peff@peff.net>
Subject: [PATCH] for_each_reflog_ent_reverse: turn leftover check into
 assertion
Date: Thu, 4 Dec 2014 20:32:44 -0500
Message-ID: <20141205013244.GA16642@peff.net>
References: <547C8610.8080301@cs.uni-saarland.de>
 <20141201233515.GV6527@google.com>
 <xmqqvblrrwxu.fsf@gitster.dls.corp.google.com>
 <5480C60E.3070903@cs.uni-saarland.de>
 <20141204215805.GD19953@peff.net>
 <xmqq388vrrj9.fsf@gitster.dls.corp.google.com>
 <20141205012854.GA16590@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christoph Mallon <mallon@cs.uni-saarland.de>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 02:32:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwhlL-0003wA-DP
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 02:32:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754735AbaLEBcr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 20:32:47 -0500
Received: from cloud.peff.net ([50.56.180.127]:48703 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751824AbaLEBcq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 20:32:46 -0500
Received: (qmail 32135 invoked by uid 102); 5 Dec 2014 01:32:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Dec 2014 19:32:46 -0600
Received: (qmail 11249 invoked by uid 107); 5 Dec 2014 01:32:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Dec 2014 20:32:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Dec 2014 20:32:44 -0500
Content-Disposition: inline
In-Reply-To: <20141205012854.GA16590@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260850>

On Thu, Dec 04, 2014 at 08:28:54PM -0500, Jeff King wrote:

> The minimal fix here would be to add this special case to
> the conditional that checks whether we found a newline.
> But we can make the flow a little clearer by rearranging a
> bit: we first handle lines that we are going to show, and
> then at the end of each loop, stuff away any leftovers if
> necessary. That lets us fold this special-case in with the
> more common "we ended in the middle of a line" case.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I really needed this rearranging to figure out what the fix
> _should_ be. Now that I did that, I was able to write the above
> paragraph explaining what the minimal fix would be. And I can do that if
> we prefer. But I think the fact that I had to go through the untangling
> step first is an indication that maybe the end result is better. Of
> course that's all subjective. :)

I _think_ the patch below is also applicable to the code before my
boundary-fixing patch. But the rearranging also made me more confident
in it.

-- >8 --
Subject: for_each_reflog_ent_reverse: turn leftover check into assertion

Our loop should always process all lines, even if we hit the
beginning of the file. We have a conditional after the loop
ends to double-check that there is nothing left and to
process it. But this should never happen, and is a sign of a
logic bug in the loop. Let's turn it into a BUG assertion.

Signed-off-by: Jeff King <peff@peff.net>
---
Of course I cannot say something like "this can never happen; the old
code was wrong to handle this case" without a nagging feeling that I am
missing something, so extra careful eyes are appreciated (and are why I
would rather have an assert here than removing the code and silently
dropping lines if I am wrong).

 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index ccb8834..1f77fa6 100644
--- a/refs.c
+++ b/refs.c
@@ -3451,7 +3451,7 @@ int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void
 
 	}
 	if (!ret && sb.len)
-		ret = show_one_reflog_ent(&sb, fn, cb_data);
+		die("BUG: reverse reflog parser had leftover data");
 
 	fclose(logfp);
 	strbuf_release(&sb);
-- 
2.2.0.390.gf60752d
