From: Jeff King <peff@peff.net>
Subject: Re: Problem listing GIT repository with accents
Date: Mon, 1 Feb 2010 08:44:54 -0500
Message-ID: <20100201134454.GA796@coredump.intra.peff.net>
References: <7E88665723814E46BCBA1A39E84C27A5@elrond>
 <20100201113213.GA22663@coredump.intra.peff.net>
 <20100201121933.GA9995@coredump.intra.peff.net>
 <4B66CD81.3010005@viscovery.net>
 <20100201133903.GA923@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?RWxsacOp?= Computing Open Source Program 
	<opensource@elliecomputing.com>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Feb 01 14:45:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbwaO-0006MO-9P
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 14:45:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754422Ab0BANo5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 08:44:57 -0500
Received: from peff.net ([208.65.91.99]:53906 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753066Ab0BANo5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 08:44:57 -0500
Received: (qmail 25213 invoked by uid 107); 1 Feb 2010 13:45:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 01 Feb 2010 08:45:00 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Feb 2010 08:44:54 -0500
Content-Disposition: inline
In-Reply-To: <20100201133903.GA923@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138610>

On Mon, Feb 01, 2010 at 08:39:03AM -0500, Jeff King wrote:

> If you want to keep the "!p[len]" condition, then yes. If we want to
> properly quote internal NULs (which again, I am not sure is of practical
> use), then you would also have to make that condition "(maxlen >= 0 &&
> !p[len])".  Which is really not that bad, but I was trying to make it
> easier to read. I am OK with any of the three combinations of fixes.
> 
> And the fact that I am using the word "combination" probably means it
> should be a separate patch anyway.
> 
> So here is the minimal patch to go on 'maint', for Junio's convenience.

And here is what the "quote embedded NULs" patch would look like on top.
It's actually pretty straightforward, but the more I think of it, the
more I think it is probably not worthwhile. Not only are we quoting
paths, which should not have embedded NULs, but it requires that the
caller always pass the length explicitly, and clearly we are not doing
that all or even most of the time. So while this would fix the low-level
"this function quotes an arbitrary string" case, for it to be of any use
all of the code paths leading to it would need to be audited to handle
NUL-embedded strings.

---
diff --git a/quote.c b/quote.c
index 723bb4f..fc93435 100644
--- a/quote.c
+++ b/quote.c
@@ -213,7 +213,7 @@ static size_t quote_c_style_counted(const char *name, ssize_t maxlen,
 		int ch;
 
 		len = next_quote_pos(p, maxlen);
-		if (len == maxlen || !p[len])
+		if (len == maxlen || (maxlen < 0 && !p[len]))
 			break;
 
 		if (!no_dq && p == name)
