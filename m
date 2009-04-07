From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] for-each-ref: remove multiple xstrdup() in
	get_short_ref()
Date: Tue, 7 Apr 2009 17:41:44 -0400
Message-ID: <20090407214144.GA17962@coredump.intra.peff.net>
References: <20090407070254.GA2870@coredump.intra.peff.net> <1239089599-24760-1-git-send-email-bert.wesarg@googlemail.com> <20090407074435.GB7327@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Apr 07 23:44:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrJ5Y-00080q-LS
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 23:44:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761799AbZDGVlt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 17:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761728AbZDGVls
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 17:41:48 -0400
Received: from peff.net ([208.65.91.99]:51708 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761770AbZDGVlr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 17:41:47 -0400
Received: (qmail 9591 invoked by uid 107); 7 Apr 2009 21:41:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 07 Apr 2009 17:41:46 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Apr 2009 17:41:44 -0400
Content-Disposition: inline
In-Reply-To: <20090407074435.GB7327@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115995>

On Tue, Apr 07, 2009 at 03:44:35AM -0400, Jeff King wrote:

> +		if (1 != sscanf(ref, scanf_fmts[i], short_name))
> [...]
> +		if (j == i) {
> +			ref += strlen(ref) - strlen(short_name);
> +			break;
> +		}

Actually, I am not sure this is correct, either. It is making the
assumption that the short_name is always a suffix of the ref. But one of
the rev_parse_rules is:

     "refs/remotes/%.*s/HEAD"

for which this is not true. _But_ as it happens, this rule doesn't
actually work in reverse because of the way scanf works with %s. The
code:

    sscanf("refs/remotes/origin/HEAD", "refs/remotes/%s/HEAD", buf);

will put "origin/HEAD" in buf, not "origin"; %s eats until it sees
whitespace (which should not be occuring in a ref, fortunately).

So it actually _is_ correct to assume with the current code that the
short_name is always a suffix, but I am not sure if that is what we
actually want. We will always see "$remote/HEAD" instead of "$remote".

Part of me actually thinks the "incorrect" behavior we are doing now is
actually more explicit and readable. But if that is the case, we should
perhaps simply be excluding that final rule explicitly, and then our
"suffix" assumption will hold.

-Peff
