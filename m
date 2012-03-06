From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: Re: [PATCH v3 4/4] http: handle proxy authentication failure (error
 407)
Date: Tue, 06 Mar 2012 12:10:12 +0100
Message-ID: <4F55F094.6010606@seap.minhap.es>
References: <4F54D9F8.2010401@seap.minhap.es> <20120306085445.GE21199@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, sam@vilain.net
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 06 11:12:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4rNw-0005mn-HK
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 11:12:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758730Ab2CFKMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 05:12:43 -0500
Received: from luthien1.mpt.es ([213.9.211.102]:53553 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756807Ab2CFKMm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 05:12:42 -0500
Received: from correo.map.es (unknown [10.1.24.31])
	by luthien2.map.es (Postfix) with ESMTP id 8BE1624E84;
	Tue,  6 Mar 2012 11:11:40 +0100 (CET)
Received: from [10.47.128.147] (unknown [10.1.29.79])
	by correo.map.es (Postfix) with ESMTP id A944BD4C47;
	Tue,  6 Mar 2012 11:11:33 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
In-Reply-To: <20120306085445.GE21199@sigill.intra.peff.net>
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: 8BE1624E84.A8F83
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1331633501.75018@jYXP8THH4Qq+y5eoBJJygw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192329>

On 03/06/2012 09:54 AM, Jeff King wrote:
> On Mon, Mar 05, 2012 at 04:21:28PM +0100, Nelson Benitez Leon wrote:
> 
>> Handle http 407 error code by asking for credentials and
>> retrying request in case credentials were not present, or
>> marking credentials as rejected if they were already provided.
>>
>> Signed-off-by: Nelson Benitez Leon <nbenitezl@gmail.com>
>> ---
>>  http.c |   16 ++++++++++++++++
>>  1 files changed, 16 insertions(+), 0 deletions(-)
> 
> No tests. I wonder how hard it would be to set up an apache proxy for
> automated testing, just as we set one up as a git server in
> t/lib-httpd.sh. It should be basically the same process, but with a
> different config file, I would think.

I cannot help with this, I didn't even know you could setup a proxy
with solely apache, I thought you needed special software like Squid..
anyway I'm testing all these patches with my employers proxy which uses
NTLM autentication and they're performing well..

> [snip]
> 
> We need to actually loop, retrying if we get reauth (and arguably REAUTH
> should simply be called RETRY). Like this:
> 
> diff --git a/http.c b/http.c
> index e4afbe5..c325b00 100644
> --- a/http.c
> +++ b/http.c
> @@ -810,10 +810,13 @@ static int http_request(const char *url, curl_write_callback cb, void *result,
>  static int http_request_reauth(const char *url, curl_write_callback cb,
>  			       void *result, unsigned long offset, int options)
>  {
> -	int ret = http_request(url, cb, result, offset, options);
> -	if (ret != HTTP_REAUTH)
> -		return ret;
> -	return http_request(url, cb, result, offset, options);
> +	int ret;
> +
> +	do {
> +		ret = http_request(url, cb, result, offset, options);
> +	} while (ret == HTTP_REAUTH);
> +
> +	return ret;
>  }
>  
>  int http_get_strbuf(const char *url, struct strbuf *result, int options)

Yes, giving the case you mention (proxy auth + http auth) your patch does
the right thing.
