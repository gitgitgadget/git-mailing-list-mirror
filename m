From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v4.1 09/12] sequencer.c: teach append_signoff to avoid
 adding a duplicate newline
Date: Thu, 14 Feb 2013 17:58:49 +0000
Message-ID: <20130214175849.GA27958@farnsworth.metanate.com>
References: <1360664260-11803-10-git-send-email-drafnel@gmail.com>
 <1360665222-3166-1-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
	jrnieder@gmail.com, Brandon Casey <bcasey@nvidia.com>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 14 18:59:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U635Z-0000s8-QC
	for gcvg-git-2@plane.gmane.org; Thu, 14 Feb 2013 18:59:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761486Ab3BNR6y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2013 12:58:54 -0500
Received: from dougal.metanate.com ([90.155.101.14]:8183 "EHLO metanate.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758193Ab3BNR6x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2013 12:58:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/simple; d=metanate.com; s=stronger;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=OizYUDwcekMUKghaCI7f9A8EFMcLCtX9hmK8fWXLxEs=;
	b=rUywrXtxZxFBQoTLnWt61TadbU+SCynFqCQ9sAA0YRgZDhb6O0XYzj4dd5h6uyoUnwnpURkpETiuGpmAEXndVVmpjnRuVcaltLNqYr0x+a9PSmDXqzaha9mcO46EX1RwH4UPpt/8gmn1vdaDbL8kUeZA3L0wFJ+XP/WAbfaOxfFkdAfxGaXmhsvN8o8RWQuJezo9taHRht769WECK/6hb1guFcyeBZ1HS6QmNg5XP4lRbmYytVy5+e8doY+/s4PxPAdVQZBnadFX8rAKvuh4XrqTaYWVrpqfLwqZAgrdulC319wbBUInI5Ek9CA7t2s8CLvYOB9VqvFy/0H8C3KsIA==;
Received: from brian.metanate.com ([192.168.88.1] helo=farnsworth.metanate.com)
	by shrek.metanate.com with esmtps (TLSv1:DHE-RSA-AES128-SHA:128)
	(Exim 4.80.1)
	(envelope-from <john@keeping.me.uk>)
	id 1U6356-0002xI-Uv; Thu, 14 Feb 2013 17:58:48 +0000
Content-Disposition: inline
In-Reply-To: <1360665222-3166-1-git-send-email-drafnel@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216327>

On Tue, Feb 12, 2013 at 02:33:42AM -0800, Brandon Casey wrote:
> Teach append_signoff to detect whether a blank line exists at the position
> that the signed-off-by line will be added, and refrain from adding an
> additional one if one already exists.  Or, add an additional line if one
> is needed to make sure the new footer is separated from the message body
> by a blank line.
> 
> Signed-off-by: Brandon Casey <bcasey@nvidia.com>
> ---

As Jonathan Nieder wondered before [1], this changes the behaviour when
the commit message is empty.  Before this commit, there is an empty line
followed by the S-O-B line; now the S-O-B is on the first line of the
commit.

The previous behaviour seems better to me since the empty line is
hinting that the user should fill something in.  It looks particularly
strange if your editor has syntax highlighting for commit messages such
that the first line is in a different colour.

[1] http://article.gmane.org/gmane.comp.version-control.git/214796

> diff --git a/sequencer.c b/sequencer.c
> index 3364faa..084573b 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1127,8 +1127,19 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag)
>  	else
>  		has_footer = has_conforming_footer(msgbuf, &sob, ignore_footer);
>  
> -	if (!has_footer)
> -		strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0, "\n", 1);
> +	if (!has_footer) {
> +		const char *append_newlines = NULL;
> +		size_t len = msgbuf->len - ignore_footer;
> +
> +		if (len && msgbuf->buf[len - 1] != '\n')
> +			append_newlines = "\n\n";
> +		else if (len > 1 && msgbuf->buf[len - 2] != '\n')
> +			append_newlines = "\n";

To restore the old behaviour this needs something like this:

		else if (!len)
			append_newlines = "\n";

> +		if (append_newlines)
> +			strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0,
> +				append_newlines, strlen(append_newlines));
> +	}
>  
>  	if (has_footer != 3 && (!no_dup_sob || has_footer != 2))
>  		strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0,
