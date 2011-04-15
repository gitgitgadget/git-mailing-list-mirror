From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] combine-diff: use textconv for combined diff format
Date: Fri, 15 Apr 2011 19:56:28 -0400
Message-ID: <20110415235628.GA9334@sigill.intra.peff.net>
References: <20110414213006.GA7709@sigill.intra.peff.net>
 <36a715a966a22207135f60532e723f6d87dd1ffb.1302881295.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Apr 16 01:56:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAssZ-0001WD-OG
	for gcvg-git-2@lo.gmane.org; Sat, 16 Apr 2011 01:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752610Ab1DOX4f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2011 19:56:35 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58835
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751400Ab1DOX4e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2011 19:56:34 -0400
Received: (qmail 14426 invoked by uid 107); 15 Apr 2011 23:57:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 15 Apr 2011 19:57:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Apr 2011 19:56:28 -0400
Content-Disposition: inline
In-Reply-To: <36a715a966a22207135f60532e723f6d87dd1ffb.1302881295.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171649>

On Fri, Apr 15, 2011 at 05:29:05PM +0200, Michael J Gruber wrote:

> Currently, we ignore textconv and binary status for the combined diff
> formats (-c, -cc) which was never intended.

Thanks for working on this.

I think it would be simpler to work on the binary half first. Then it
would be clear where the binary codepath diverges, and sticking the
textconv helpers in there would be easier (the helpers were, after all,
written because it was retrofitting existing diff code that already
handled binaries differently).

The whole grab_blob() thing seems like an unnecessary duplication of the
diff_filespec code. I think if we can switch to a more uniform use of
diff_filespec code, the memory management might end up simpler.

> +	if (DIFF_OPT_TST(opt, ALLOW_TEXTCONV) && elem->textconv) {
> +		struct diff_filespec *df = alloc_filespec(elem->path);
> +		fill_filespec(df, elem->sha1, elem->mode);
> +		result_size = fill_textconv(elem->textconv, df, &result);
> +	}

The memory management with fill_textconv is kind of ugly. Sometimes it
returns memory which must be freed, and sometimes not. Looking at the
diff.c code, I think in this case it will always need freed (because
elem->textconv is non-NULL). Sorry, that was a mess I created a long
time ago that you now get to deal with. :)

-Peff
