From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] revision: add --grep-reflog to filter commits by
 reflog messages
Date: Sat, 29 Sep 2012 01:30:13 -0400
Message-ID: <20120929053013.GB3330@sigill.intra.peff.net>
References: <7vr4pmm3qz.fsf@alter.siamese.dyndns.org>
 <1348893689-20240-1-git-send-email-pclouds@gmail.com>
 <1348893689-20240-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 29 07:30:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THpdE-0008DV-7S
	for gcvg-git-2@plane.gmane.org; Sat, 29 Sep 2012 07:30:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752836Ab2I2FaR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2012 01:30:17 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:34269 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752737Ab2I2FaP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2012 01:30:15 -0400
Received: (qmail 25747 invoked by uid 107); 29 Sep 2012 05:30:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 29 Sep 2012 01:30:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 29 Sep 2012 01:30:13 -0400
Content-Disposition: inline
In-Reply-To: <1348893689-20240-3-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206626>

On Sat, Sep 29, 2012 at 11:41:28AM +0700, Nguyen Thai Ngoc Duy wrote:

> @@ -2210,10 +2213,23 @@ static int rewrite_parents(struct rev_info *revs, struct commit *commit)
>  
>  static int commit_match(struct commit *commit, struct rev_info *opt)
>  {
> +	int retval;
> +	struct strbuf buf = STRBUF_INIT;
>  	if (!opt->grep_filter.pattern_list && !opt->grep_filter.header_list)
>  		return 1;
> -	return grep_buffer(&opt->grep_filter,
> -			   commit->buffer, strlen(commit->buffer));
> +	if (opt->reflog_info) {
> +		strbuf_addstr(&buf, "reflog ");
> +		get_reflog_message(&buf, opt->reflog_info);
> +		strbuf_addch(&buf, '\n');
> +		strbuf_addstr(&buf, commit->buffer);
> +	}
> +	if (buf.len)
> +		retval = grep_buffer(&opt->grep_filter, buf.buf, buf.len);
> +	else
> +		retval = grep_buffer(&opt->grep_filter,
> +				     commit->buffer, strlen(commit->buffer));
> +	strbuf_release(&buf);
> +	return retval;

I like how callers not doing a reflog walk do not have to pay the price
to do the extra allocating. We could further limit it to only when
--grep-reflog is in effect, but I guess that would mean wading through
grep_filter's patterns, since it could be buried amidst ANDs and ORs?

One alternative would be to set a bit in the grep_opt when we call
append_header_grep_pattern. It feels a bit like a layering violation,
though. I guess the bit could also go into rev_info. It may not even be
a measurable slowdown, though. Premature optimization and all that.

Other than that, I didn't notice anything wrong in the patch.

-Peff
