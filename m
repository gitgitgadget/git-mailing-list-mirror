From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] attr: don't confuse prefixes with leading directories
Date: Tue, 10 Jan 2012 17:31:04 -0500
Message-ID: <20120110223104.GA28592@sigill.intra.peff.net>
References: <20120110070300.GA17086@sigill.intra.peff.net>
 <4F0BFE6E.6080904@alum.mit.edu>
 <20120110171100.GA18962@sigill.intra.peff.net>
 <20120110180820.GA15273@sigill.intra.peff.net>
 <20120110182140.GB15273@sigill.intra.peff.net>
 <7vlipf9xbe.fsf@alter.siamese.dyndns.org>
 <20120110192810.GA16018@sigill.intra.peff.net>
 <7v7h0z9ufu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 10 23:31:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkkDq-0007yg-Ay
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 23:31:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361Ab2AJWbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 17:31:09 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33986
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754943Ab2AJWbH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 17:31:07 -0500
Received: (qmail 15450 invoked by uid 107); 10 Jan 2012 22:38:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 Jan 2012 17:38:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jan 2012 17:31:04 -0500
Content-Disposition: inline
In-Reply-To: <7v7h0z9ufu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188299>

On Tue, Jan 10, 2012 at 12:25:09PM -0800, Junio C Hamano wrote:

> Sorry for sending a half-baked response.  The initial draft of my response
> had just "that makes sense" and nothing else in the first paragraph.
> 
> If the original meant to be defensive, it should have had your "extra
> defensive" die(), but it didn't.
> [...]
> diff --git a/attr.c b/attr.c
> index ad7eb9c..4d3b61a 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -566,7 +567,9 @@ static void prepare_attr_stack(const char *path, int dirlen)
>  
>  	/*
>  	 * Pop the ones from directories that are not the prefix of
> -	 * the path we are checking.
> +	 * the path we are checking. Break out of the loop when we see
> +	 * the root one (whose origin is an empty string "") or the builtin
> +	 * one (whose origin is NULL) without popping it.
>  	 */
>  	while (attr_stack->origin) {
>  		int namelen = strlen(attr_stack->origin);
> @@ -586,6 +589,13 @@ static void prepare_attr_stack(const char *path, int dirlen)
>  	 * Read from parent directories and push them down
>  	 */
>  	if (!is_bare_repository() || direction == GIT_ATTR_INDEX) {
> +		/*
> +		 * bootstrap_attr_stack() should have added, and the
> +		 * above loop should have stopped before popping, the
> +		 * root element whose attr_stack->origin is set to an
> +		 * empty string.
> +		 */ 
> +		assert(attr_stack->origin);
>  		while (1) {
>  			char *cp;

Yeah, this version looks good to me (though I thought we usually spelled
assert as die("BUG: ...")).

-Peff
