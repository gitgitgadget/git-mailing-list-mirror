From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Verify Content-Type from smart HTTP servers
Date: Wed, 6 Feb 2013 05:39:52 -0500
Message-ID: <20130206103952.GA5267@sigill.intra.peff.net>
References: <7v38xhf1i3.fsf@alter.siamese.dyndns.org>
 <51122F69.9060704@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Michael Schubert <mschub@elegosoft.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 11:40:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U32QW-0001xz-NL
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 11:40:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754686Ab3BFKkF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 05:40:05 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:36495 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751947Ab3BFKkE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 05:40:04 -0500
Received: (qmail 4098 invoked by uid 107); 6 Feb 2013 10:41:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Feb 2013 05:41:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Feb 2013 05:39:52 -0500
Content-Disposition: inline
In-Reply-To: <51122F69.9060704@elegosoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215572>

On Wed, Feb 06, 2013 at 11:24:41AM +0100, Michael Schubert wrote:

> On 01/31/2013 11:09 PM, Junio C Hamano wrote:
> 
> >  
> > -static int http_request_reauth(const char *url, void *result, int target,
> > +static int http_request_reauth(const char *url,
> > +			       struct strbuf *type,
> > +			       void *result, int target,
> >  			       int options)
> >  {
> > -	int ret = http_request(url, result, target, options);
> > +	int ret = http_request(url, type, result, target, options);
> >  	if (ret != HTTP_REAUTH)
> >  		return ret;
> > -	return http_request(url, result, target, options);
> > +	return http_request(url, type, result, target, options);
> >  }
> 
> This needs something like
> 
> diff --git a/http.c b/http.c
> index d868d8b..da43be3 100644
> --- a/http.c
> +++ b/http.c
> @@ -860,6 +860,8 @@ static int http_request_reauth(const char *url,
>         int ret = http_request(url, type, result, target, options);
>         if (ret != HTTP_REAUTH)
>                 return ret;
> +       if (type)
> +               strbuf_reset(type);
>         return http_request(url, type, result, target, options);
>  }
> 
> on top. Otherwise we get
> 
> "text/plainapplication/x-git-receive-pack-advertisement"
> 
> when doing HTTP auth.

Good catch. It probably makes sense to put it in http_request, so that
we also protect against any existing cruft from the callers of
http_get_*, like:

-- >8 --
Subject: [PATCH] http_request: reset "type" strbuf before adding

Callers may pass us a strbuf which we use to record the
content-type of the response. However, we simply appended to
it rather than overwriting its contents, meaning that cruft
in the strbuf gave us a bogus type. E.g., the multiple
requests triggered by http_request could yield a type like
"text/plainapplication/x-git-receive-pack-advertisement".

Reported-by: Michael Schubert <mschub@elegosoft.com>
Signed-off-by: Jeff King <peff@peff.net>
---
Is it worth having a strbuf_set* family of functions to match the
strbuf_add*? We seem to have these sorts of errors with strbuf from time
to time, and I wonder if that would make it easier (and more readable)
to do the right thing.

 http.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/http.c b/http.c
index d868d8b..d9d1aad 100644
--- a/http.c
+++ b/http.c
@@ -841,6 +841,7 @@ static int http_request(const char *url, struct strbuf *type,
 
 	if (type) {
 		char *t;
+		strbuf_reset(type);
 		curl_easy_getinfo(slot->curl, CURLINFO_CONTENT_TYPE, &t);
 		if (t)
 			strbuf_addstr(type, t);
-- 
1.8.1.2.11.g1a2f572
