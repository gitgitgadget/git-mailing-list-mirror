From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/5] submodule: helper to run foreach in parallel
Date: Wed, 26 Aug 2015 13:06:48 -0400
Message-ID: <20150826170647.GA1870@sigill.intra.peff.net>
References: <1440523706-23041-1-git-send-email-sbeller@google.com>
 <1440523706-23041-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, jrnieder@gmail.com, gitster@pobox.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 19:07:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUeA3-0002Gb-V5
	for gcvg-git-2@plane.gmane.org; Wed, 26 Aug 2015 19:06:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752142AbbHZRGw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2015 13:06:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:50457 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751121AbbHZRGv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2015 13:06:51 -0400
Received: (qmail 8743 invoked by uid 102); 26 Aug 2015 17:06:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 26 Aug 2015 12:06:50 -0500
Received: (qmail 16506 invoked by uid 107); 26 Aug 2015 17:06:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 26 Aug 2015 13:06:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Aug 2015 13:06:48 -0400
Content-Disposition: inline
In-Reply-To: <1440523706-23041-4-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276619>

On Tue, Aug 25, 2015 at 10:28:24AM -0700, Stefan Beller wrote:

> +int module_foreach_parallel(int argc, const char **argv, const char *prefix)
> +{
> [...]
> +	for (i = 0; i < ce_used; i++) {
> +		const struct submodule *sub;
> +		const struct cache_entry *ce = ce_entries[i];
> +		struct submodule_args *args = malloc(sizeof(*args));
> +
> +		if (ce_stage(ce))
> +			args->sha1 = xstrdup(sha1_to_hex(null_sha1));
> +		else
> +			args->sha1 = xstrdup(sha1_to_hex(ce->sha1));
> +
> +		strbuf_reset(&sb);
> +		strbuf_addf(&sb, "%s/.git", ce->name);
> +		if (!file_exists(sb.buf))
> +			continue;

"args" and "args->sha1" go out of scope and leak here.

> +		args->name = sub->name;
> +		args->toplevel = xstrdup(xgetcwd());

Another xgetcwd leak. :) I think this one can just drop the xstrdup.

(Both of these were spotted by Coverity. I know you have played with it
a little, so if you are actually reading the emails it sends, I'll stop
relaying them).

-Peff
