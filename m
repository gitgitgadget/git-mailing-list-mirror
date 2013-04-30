From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] http.c: Add config options/parsing for SSL engine vars
Date: Tue, 30 Apr 2013 14:27:33 -0400
Message-ID: <20130430182732.GB1972@sigill.intra.peff.net>
References: <1366758207-7724-1-git-send-email-jqassar@gmail.com>
 <7v61z4ezlz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jerry Qassar <jqassar@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 20:27:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXFHQ-0007um-0q
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 20:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761283Ab3D3S1k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 14:27:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:40255 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761235Ab3D3S1g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 14:27:36 -0400
Received: (qmail 16412 invoked by uid 102); 30 Apr 2013 18:27:50 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 30 Apr 2013 13:27:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Apr 2013 14:27:33 -0400
Content-Disposition: inline
In-Reply-To: <7v61z4ezlz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222983>

On Tue, Apr 30, 2013 at 09:45:44AM -0700, Junio C Hamano wrote:

> The authoritative source
> 
> https://github.com/bagder/curl/blob/master/docs/libcurl/symbols-in-versions
> 
> tells me that the CURLOPT_* used in this patch are available since
> cURL 7.9.3, but I see a #if LIBCURL_VERSION_NUM < 0x070704 in http.h
> so these may have to be protected in a similar way.

Yeah, I think we'd want to protect it with an #if. More on the exact
version below.

> [the entire message unsnipped for reference]
> Jerry Qassar <jqassar@gmail.com> writes:
> 
> > curl provides many options for configuring the way it negotiates an SSL
> > connection (with its default OpenSSL support), including ways to define
> > the SSL engine used, and parameters to set the format of the key and
> > certificate used.  Unfortunately, git does not parse some of the
> > critical ones needed by curl to support PKCS#11.

I don't know anything about curl's PKCS#11 support, so I can't comment
too much on how these options work. But from my reading of the
curl_easy_setopt(3), these look right, and I can comment on the http.c
bits.

> > * http.sslkeytype
> >   A string variable, either PEM/DER/ENG, that sets CURLOPT_SSLKEYTYPE.
> >   Can be set from environment using GIT_SSL_KEYTYPE.
> > * http.sslcerttype
> >   A string variable, either PEM/DER/ENG, that sets CURLOPT_SSLCERTTYPE.
> >   Can be set from environment using GIT_SSL_CERTTYPE.
> >
> > Parsing these new variables combined with related patches to curl
> > will allow git to support native authentication with smart cards.

Current curl seems to take ENG only for the key, and assumes you have
the certificate on disk (which should be fine, as it is not a secret). I
can imagine that the user experience with a smartcard is better, though,
if it can use ENG to just pull the cert straight from the card. Is that
what your curl patches are for (my comments below are all predicated on
that assumption)?

Since these options are selected from a finite set, we need to consider
who is responsible for complaining to the user when they set
"http.sslkeytype" to "foobar". It probably makes sense to pass that
responsibility along to curl, so that as it grows in capabilities, we do
not have to keep adjusting our list (and it would already catch passing
sslcerttype=ENG to versions of curl without your patches).

Would we need the #if for the libcurl version to reference the new
release of curl that has your patches? I think we don't, as existing
versions would just complain when getting sslcerttype=ENG. IOW, it is
not a build-time problem, but a run-time problem.

> > Note: It's difficult to test this without the related curl patches,
> > which I will be submitting soon.  At the very least, leaving these new
> > options unset doesn't break anything, and setting them has little
> > effect without the back-end curl changes needed to 'turn on' PKCS#11.
> > Any suggestions would be greatly appreciated.

I think you'd be able to set the types to DER and test that, though the
curl_easy_setopt manpage notes that a bug in OpenSSL prevents this from
working.

The ENG method, even with the right curl support, is probably going to
be hard to test (unless there is some mock engine we can plug into
OpenSSL for testing).

I don't think we currently test even the basics of client certs in the
test suite. A good first step might be to check that the existing sslkey
and sslcert options work, followed by this patch and checking whether
sslkeytype=DER works.

> >  http.sslKey::
> >  	File containing the SSL private key when fetching or pushing
> >  	over HTTPS. Can be overridden by the 'GIT_SSL_KEY' environment
> >  	variable.
> >  
> > +http.sslKeyType::
> > +	Specifies the format of the private key to curl as one of (PEM|DER|ENG).
> > +	Can be overridden by the 'GIT_SSL_KEYTYPE' environment variable.
> > +

Setting this to ENG impacts how http.sslKey is interpreted (and of
course whether http.sslEngine is used at all). We might want to mention
that here.

> > @@ -211,6 +215,17 @@ static int http_options(const char *var, const char *value, void *cb)
> >  	if (!strcmp("http.useragent", var))
> >  		return git_config_string(&user_agent, var, value);
> >  
> > +	/* Adding parsing for curl options relating to engines and */
> > +	/* key/cert types.  This is necessary if attempting to     */
> > +	/* specify an external engine (e.g. for smartcards.)       */

  /*
   * Style nit: our multi-line comments usually look
   * like this. No right-hand border, and no text on
   * the top or bottom lines.
   */

> > +	if (!strcmp("http.sslkeytype", var))
> > +		return git_config_string(&ssl_keytype, var, value);
> > +	if (!strcmp("http.sslcerttype", var))
> > +		return git_config_string(&ssl_certtype, var, value);
> > +	if (!strcmp("http.sslengine", var))
> > +		return git_config_string(&ssl_engine, var, value);

We aren't checking the validity of the "type" fields here, which I
think is OK. But then later, we do:

> > +	if (ssl_keytype != NULL)
> > +		curl_easy_setopt(result, CURLOPT_SSLKEYTYPE, ssl_keytype);
> > +	if (ssl_certtype != NULL)
> > +		curl_easy_setopt(result, CURLOPT_SSLCERTTYPE, ssl_certtype);

Shouldn't we be checking the result of curl_easy_setopt for errors here
(and when the engine cannot be loaded)?  I think we should probably die
if the engine can't be loaded, but at the very least we'd want to warn
the user that their settings are being ignored.

> > @@ -321,6 +336,22 @@ static CURL *get_curl_handle(void)
> [...ssl handle setup...]

Good, this is the right function in which to do that setup (I mention it
mostly because some of the setup happens in get_active_slot, and we just
fixed a bug the other day where some setup was in the wrong spot).

> > +	/* Adding setting of engine-related curl SSL options. */
> > +	if (ssl_engine != NULL) {
> > +		curl_easy_setopt(result, CURLOPT_SSLENGINE, ssl_engine);

This comment does not seem to say anything that is not already obvious,
and seems more for the reader of the diff than a reader of the code in
general. Such comments should stay in the commit message; I think you
have already explained yourself well there, so we can just drop it here.

> > +		/* Within the lifetime of a single git execution, setting
> > +		 * the default does nothing interesting.  When curl properly
> > +		 * duplicates handles, the engine choice will propagate.
> > +		 */
> > +		/* curl_easy_setopt(result, CURLOPT_SSLENGINE_DEFAULT, 1L); */

If it is not doing anything, we can just drop this whole block, can't
we?

I am unclear from reading the curl docs whether one would need to call
SSLENGINE_DEFAULT or not, though. Maybe your patches have some impact on
that.

> > @@ -405,6 +436,11 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
> >  			ssl_cert_password_required = 1;
> >  	}
> >  
> > +	/* Added environment variables for expanded engine-related options. */
> > +	set_from_env(&ssl_keytype, "GIT_SSL_KEYTYPE");
> > +	set_from_env(&ssl_certtype, "GIT_SSL_CERTTYPE");
> > +	set_from_env(&ssl_engine, "GIT_SSL_ENGINE");

These come after the config but before we have used the values in
get_curl_handle, so they should properly take precedence. Good.


Overall, I think it is looking good. Aside from a few style/cleanup
issues, my only real complaint is the lack of error-checking from
curl_easy_setopt.

And of course adding some tests while you are working in the area would
be very nice. :)

-Peff
