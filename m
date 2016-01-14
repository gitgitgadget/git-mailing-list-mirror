From: Jeff King <peff@peff.net>
Subject: Re: [PREVIEW v3 7/9] update-index: there are only two line
 terminators
Date: Thu, 14 Jan 2016 05:09:08 -0500
Message-ID: <20160114100907.GA30772@sigill.intra.peff.net>
References: <1450303398-25900-1-git-send-email-gitster@pobox.com>
 <1452740590-16827-1-git-send-email-gitster@pobox.com>
 <1452740590-16827-8-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 11:09:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJeqF-0000Ww-I2
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 11:09:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753334AbcANKJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 05:09:14 -0500
Received: from cloud.peff.net ([50.56.180.127]:53548 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753013AbcANKJL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 05:09:11 -0500
Received: (qmail 14283 invoked by uid 102); 14 Jan 2016 10:09:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Jan 2016 05:09:11 -0500
Received: (qmail 5465 invoked by uid 107); 14 Jan 2016 10:09:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Jan 2016 05:09:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jan 2016 05:09:08 -0500
Content-Disposition: inline
In-Reply-To: <1452740590-16827-8-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284026>

On Wed, Jan 13, 2016 at 07:03:07PM -0800, Junio C Hamano wrote:

> -static void read_index_info(int line_termination)
> +static void read_index_info(int nul_term_line)
>  {
>  	struct strbuf buf = STRBUF_INIT;
>  	struct strbuf uq = STRBUF_INIT;
> +	strbuf_getline_fn getline_fn;
>  
> -	while (strbuf_getline(&buf, stdin, line_termination) != EOF) {
> +	getline_fn = nul_term_line ? strbuf_getline_nul : strbuf_getline_lf;
> +	while (getline_fn(&buf, stdin) != EOF) {
>  		char *ptr, *tab;
>  		char *path_name;
>  		unsigned char sha1[20];
> @@ -522,7 +524,7 @@ static void read_index_info(int line_termination)
>  			goto bad_line;
>  
>  		path_name = ptr;
> -		if (line_termination && path_name[0] == '"') {
> +		if (!nul_term_line && path_name[0] == '"') {

Yikes. The original used "line_termination" both as a character and as a
boolean. I think the postimage is much more obvious here.

> -		OPT_SET_INT('z', NULL, &line_termination,
> -			N_("with --stdin: input lines are terminated by null bytes"), '\0'),
> +		OPT_SET_INT('z', NULL, &nul_term_line,
> +			    N_("with --stdin: input lines are terminated by null bytes"), 1),

Should this just become OPT_BOOL now?

-Peff
