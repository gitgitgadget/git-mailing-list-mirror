From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] http: Add Accept-Language header if possible
Date: Fri, 11 Jul 2014 13:35:44 -0400
Message-ID: <20140711173544.GB7856@sigill.intra.peff.net>
References: <1405097573-19239-1-git-send-email-eungjun.yi@navercorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Yi EungJun <eungjun.yi@navercorp.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Peter Krefting <peter@softwolves.pp.se>
To: Yi EungJun <semtlenori@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 19:35:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5ejf-0006Qb-VT
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 19:35:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520AbaGKRfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 13:35:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:60260 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751045AbaGKRfr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 13:35:47 -0400
Received: (qmail 13072 invoked by uid 102); 11 Jul 2014 17:35:46 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 11 Jul 2014 12:35:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Jul 2014 13:35:44 -0400
Content-Disposition: inline
In-Reply-To: <1405097573-19239-1-git-send-email-eungjun.yi@navercorp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253300>

On Sat, Jul 12, 2014 at 01:52:53AM +0900, Yi EungJun wrote:

> Add an Accept-Language header which indicates the user's preferred
> languages defined by $LANGUAGE, $LC_ALL, $LC_MESSAGES and $LANG.
> 
> Examples:
>   LANGUAGE= -> ""
>   LANGUAGE=ko:en -> "Accept-Language: ko, en; q=0.9, *; q=0.1"
>   LANGUAGE=ko LANG=en_US.UTF-8 -> "Accept-Language: ko, *; q=0.1"
>   LANGUAGE= LANG=en_US.UTF-8 -> "Accept-Language: en-US, *; q=0.1"
> 
> This gives git servers a chance to display remote error messages in
> the user's preferred language.

Thanks, this is looking much nicer. Most of my comments are on style:

> +static const char* get_preferred_languages() {
> +    const char* retval;

A few style nits:

  1. We usually put a function's opening brace on a new line.

  2. We usually put the asterisk in a pointer declaration with the
     variable name ("const char *retval"). This one appears elsewhere in
     the patch.

  3. This line seems to be indented with spaces instead of tabs.

> +	retval = getenv("LANGUAGE");
> +	if (retval != NULL && retval[0] != '\0')
> +		return retval;
> +
> +	retval = setlocale(LC_MESSAGES, NULL);
> +	if (retval != NULL && retval[0] != '\0'
> +		&& strcmp(retval, "C") != 0
> +		&& strcmp(retval, "POSIX") != 0)
> +		return retval;

More style nits: we usually avoid writing out explicit comparisons with
NULL (and often with zero). So I'd write this as:

  if (retval && *retval &&
      strcmp(retval, "C") &&
      strcmp(retval, "POSIX"))

but I think the NULL one is the only one we usually enforce explicitly.

> +	const char *p1, *p2, *p3;

I had trouble following the logic with these variable names. Is it
possible to give them more descriptive names?

> +	/* Don't add Accept-Language header if no language is preferred. */
> +	if (p1 == NULL || p1[0] == '\0') {
> +		strbuf_release(&buf);
> +		return headers;
> +	}

No need to strbuf_release a buffer that hasn't been used (assigning
STRBUF_INIT does not count as use).

> +	/* Count number of preferred languages to decide precision of q-factor */
> +	for (p3 = p1; *p3 != '\0'; p3++) {
> +		if (*p3 == ':') {
> +			num_langs++;
> +		}
> +	}

Style: we usually omit braces for one-liners. So:

  for (p3 = p1; *p3; p3++)
	if (*p3 == ':')
		num_langs++;

(and elsewhere).

> +	/* Decide the precision for q-factor on number of preferred languages. */
> +	if (num_langs + 1 > 100) { /* +1 is for '*' */
> +		q_precision = 0.001;
> +		q_format = "; q=%.3f";
> +	} else if (num_langs + 1 > 10) { /* +1 is for '*' */
> +		q_precision = 0.01;
> +		q_format = "; q=%.2f";
> +	}

I don't mind this auto-precision too much, but I'm not sure it buys us
anything. We are still setting a hard-limit at 100, and it just means we
write "0.1" instead of "0.001" sometimes.

> +	headers = curl_slist_append(headers, buf.buf);
> +
> +	strbuf_release(&buf);

Do all versions of curl make a copy of buf.buf here?

I seem to recall that older versions want pointers passed to
curl_easy_setopt to stay around for the duration of the request (I do
not know about curl_slist, though).

> @@ -1020,6 +1143,8 @@ static int http_request(const char *url,
>  					 fwrite_buffer);
>  	}
>  
> +	headers = add_accept_language(headers);

This means we do the whole parsing routine for each request we make (for
dumb-http, this can be quite a lot, though I suppose the parsing is not
especially expensive). Should we perhaps just cache the result in a
static strbuf? That would also make the pointer-lifetime issue above go
away.

> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -946,6 +946,8 @@ int main(int argc, const char **argv)
>  	struct strbuf buf = STRBUF_INIT;
>  	int nongit;
>  
> +	git_setup_gettext();

Oops. We probably should have been doing this all along to localize the
messages on our side.

> +test_expect_success 'git client sends Accept-Language based on LANGUAGE, LC_ALL, LC_MESSAGES and LANG' '
> +	test_must_fail env GIT_CURL_VERBOSE=1 LANGUAGE=ko_KR.UTF-8 LC_ALL=de_DE.UTF-8 LC_MESSAGES=ja_JP.UTF-8 LANG=en_US.UTF-8 git clone "$HTTPD_URL/accept/language" 2>stderr &&

We usually try to avoid long lines (you can break them up with "\").

> +	grep "^Accept-Language: ko-KR, \\*; q=0.1" stderr &&

I see you noticed the extra level of quoting necessary between v2 and
v3. :)

I wonder if these test cases might be more readable with a helper
function like:

  check_language () {
	echo "Accept-Language: $1" >expect &&
	test_must_fail env \
		GIT_CURL_VERBOSE=1 \
		LANGUAGE=$2 \
		LC_ALL=$3 \
		LC_MESSAGES=$4 \
		LANG=$5 \
		git clone "$HTTPD_URL/accept/language" 2>stderr &&
	grep -i ^Accept-Language: stderr >actual &&
	test_cmp expect actual
  }

which lets you write:

  check_language "de-DE, *; q=0.1" "" de_DE.UTF-8 ja_JP.UTF-8 en_US.UTF-8

and so on. I dunno if that is more readable or not.

-Peff
