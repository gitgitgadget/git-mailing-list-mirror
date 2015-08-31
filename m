From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] date: allow any format to display local time
Date: Mon, 31 Aug 2015 14:56:57 -0400
Message-ID: <20150831185657.GC20555@sigill.intra.peff.net>
References: <d3b9f8f6524e45c9fc7a3e104669572c8c4ddd8a.1440942688.git.john@keeping.me.uk>
 <xmqqtwrfweo7.fsf@gitster.mtv.corp.google.com>
 <20150831185018.GA20555@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 20:57:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWUGP-0007pM-Au
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 20:57:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754089AbbHaS5A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 14:57:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:52520 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752428AbbHaS5A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 14:57:00 -0400
Received: (qmail 15025 invoked by uid 102); 31 Aug 2015 18:56:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 31 Aug 2015 13:56:59 -0500
Received: (qmail 25314 invoked by uid 107); 31 Aug 2015 18:57:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 31 Aug 2015 14:57:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 31 Aug 2015 14:56:57 -0400
Content-Disposition: inline
In-Reply-To: <20150831185018.GA20555@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276913>

On Mon, Aug 31, 2015 at 02:50:18PM -0400, Jeff King wrote:

> diff --git a/fast-import.c b/fast-import.c
> index 6c7c3c9..b19a1b5 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -412,6 +412,10 @@ static void write_crash_report(const char *err)
>  	struct branch *b;
>  	unsigned long lu;
>  	struct recent_command *rc;
> +	struct date_mode dm;
> +
> +	dm.type = DATE_NORMAL;
> +	dm.local = 1;
>  
>  	if (!rpt) {
>  		error("can't write crash report %s: %s", loc, strerror(errno));
> @@ -424,7 +428,7 @@ static void write_crash_report(const char *err)
>  	fprintf(rpt, "fast-import crash report:\n");
>  	fprintf(rpt, "    fast-import process: %"PRIuMAX"\n", (uintmax_t) getpid());
>  	fprintf(rpt, "    parent process     : %"PRIuMAX"\n", (uintmax_t) getppid());
> -	fprintf(rpt, "    at %s\n", show_date(time(NULL), 0, DATE_MODE(LOCAL)));
> +	fprintf(rpt, "    at %s\n", show_date(time(NULL), 0, &dm));
>  	fputc('\n', rpt);
>  
>  	fputs("fatal: ", rpt);

I also considered just switching this hunk to another format. I doubt
that anybody cares what format the fast-import crash-report timestamp is
in. And in fact LOCAL is kind of a bad choice. Using the user's timezone
is fine, but _omitting_ the timezone in a crash report seems like a
recipe for confusion. Probably iso8601-local would be saner.

-Peff
