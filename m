From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] t0006: test timezone parsing
Date: Tue, 6 Jul 2010 03:28:49 -0400
Message-ID: <20100706072849.GA3567@sigill.intra.peff.net>
References: <20100704104834.GA23070@sigill.intra.peff.net>
 <7vpqz13xgw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 09:28:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OW2aO-0004Au-Uy
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 09:28:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753685Ab0GFH2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 03:28:52 -0400
Received: from peff.net ([208.65.91.99]:45456 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753074Ab0GFH2v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 03:28:51 -0400
Received: (qmail 25305 invoked by uid 107); 6 Jul 2010 07:29:47 -0000
Received: from c-67-172-213-4.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (67.172.213.4)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 06 Jul 2010 03:29:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Jul 2010 03:28:49 -0400
Content-Disposition: inline
In-Reply-To: <7vpqz13xgw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150331>

On Tue, Jul 06, 2010 at 12:01:35AM -0700, Junio C Hamano wrote:

> >  		time_t t;
> > +		int tz;
> [...]
> > +		if (sscanf(result, "%ld %d", &t, &tz) == 2)
> 
> Gah...
> 
> On FreeBSD 8.0, we now see this.
> 
>    cc1: warnings being treated as errors
>    test-date.c: In function 'parse_dates':
>    test-date.c:28: warning: format '%ld' expects type 'long int *', but argument 3 has type 'time_t *'

Meh. I was worried about that when I used sscanf. I think we can just do
this:

diff --git a/test-date.c b/test-date.c
index ac6854a..6bcd5b0 100644
--- a/test-date.c
+++ b/test-date.c
@@ -20,12 +20,12 @@ static void parse_dates(char **argv, struct timeval *now)
 {
 	for (; *argv; argv++) {
 		char result[100];
-		time_t t;
+		unsigned long t;
 		int tz;
 
 		result[0] = 0;
 		parse_date(*argv, result, sizeof(result));
-		if (sscanf(result, "%ld %d", &t, &tz) == 2)
+		if (sscanf(result, "%lu %d", &t, &tz) == 2)
 			printf("%s -> %s\n",
 			       *argv, show_date(t, tz, DATE_ISO8601));
 		else

as show_date takes an unsigned long anyway.

-Peff
