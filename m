From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v7 1/1] http: Add Accept-Language header if possible
Date: Sun, 18 Jan 2015 16:14:04 +0100
Message-ID: <54BBCDBC.1010300@web.de>
References: <1421583806-3563-1-git-send-email-eungjun.yi@navercorp.com> <1421583995-3663-1-git-send-email-eungjun.yi@navercorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Yi EungJun <eungjun.yi@navercorp.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	Peter Krefting <peter@softwolves.pp.se>,
	Michael Blume <blume.mike@gmail.com>
To: Yi EungJun <semtlenori@gmail.com>, Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 18 16:14:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YCrYc-0005I8-At
	for gcvg-git-2@plane.gmane.org; Sun, 18 Jan 2015 16:14:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752139AbbARPOZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2015 10:14:25 -0500
Received: from mout.web.de ([212.227.15.4]:64747 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751646AbbARPOZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2015 10:14:25 -0500
Received: from birne.local ([78.68.171.36]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0MWuiC-1YILCA16Ye-00VyoB; Sun, 18 Jan 2015 16:14:10
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <1421583995-3663-1-git-send-email-eungjun.yi@navercorp.com>
X-Provags-ID: V03:K0:SSz0zTsoQ2L8oeYA9X0hj2KHgT4hf2LzPQT9RC8n3OK5vPdcG9z
 K9nFqlO8YRnNKxWqc+aKj6UKOtCxqU9cbxuBIHpbI7U2Yib3Ad1Jh8hUDsnVM5Te0xKYJs8
 ELBaQC0V8h3zwCSmDoIMOgcVBQR/LWtYR7HTixK6yCbynohIuZ4+d3gagrFzXhEXwSDPEKe
 /2FUjTeqX67trHGdxU9aQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262602>

On 18.01.15 13:26, Yi EungJun wrote:
> From: Yi EungJun <eungjun.yi@navercorp.com>

> diff --git a/http.c b/http.c
> index 040f362..349b033 100644
> --- a/http.c
> +++ b/http.c
> @@ -68,6 +68,8 @@ static struct curl_slist *no_pragma_header;
>  
>  static struct active_request_slot *active_queue_head;
>  
> +static char *cached_accept_language;
> +
>  size_t fread_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
>  {
>  	size_t size = eltsize * nmemb;
> @@ -515,6 +517,11 @@ void http_cleanup(void)
>  		cert_auth.password = NULL;
>  	}
>  	ssl_cert_password_required = 0;
> +
> +	if (cached_accept_language) {
> +		free(cached_accept_language);
> +		cached_accept_language = NULL;
> +	}

Minor remark:
free(NULL) is legal and does nothing.
We can simplify the code somewhat:

  	ssl_cert_password_required = 0;
 
 	free(cached_accept_language);
 	cached_accept_language = NULL;




>  }
>  
>  struct active_request_slot *get_active_slot(void)
> @@ -986,6 +993,145 @@ static void extract_content_type(struct strbuf *raw, struct strbuf *type,
>  		strbuf_addstr(charset, "ISO-8859-1");
>  }
>  
> +/*
> + * Guess the user's preferred languages from the value in LANGUAGE environment
> + * variable and LC_MESSAGES locale category if NO_GETTEXT is not defined.
> + *
> + * The result can be a colon-separated list like "ko:ja:en".
> + */
> +static const char *get_preferred_languages(void)
> +{
> +	const char *retval;
> +
> +	retval = getenv("LANGUAGE");
> +	if (retval && *retval)
> +		return retval;
> +
> +#ifndef NO_GETTEXT
> +	retval = setlocale(LC_MESSAGES, NULL);
> +	if (retval && *retval &&
> +		strcmp(retval, "C") &&
> +		strcmp(retval, "POSIX"))
> +		return retval;
> +#endif
> +
> +	return NULL;
> +}
> +
> +static void write_accept_language(struct strbuf *buf)
> +{
> +	/*
> +	 * MAX_DECIMAL_PLACES must not be larger than 3. If it is larger than
> +	 * that, q-value will be smaller than 0.001, the minimum q-value the
> +	 * HTTP specification allows. See
> +	 * http://tools.ietf.org/html/rfc7231#section-5.3.1 for q-value.
> +	 */
> +	const int MAX_DECIMAL_PLACES = 3;
> +	const int MAX_LANGUAGE_TAGS = 1000;
> +	const int MAX_ACCEPT_LANGUAGE_HEADER_SIZE = 4000;
> +	struct strbuf *language_tags = NULL;
> +	int num_langs;
> +	const char *s = get_preferred_languages();
> +
> +	/* Don't add Accept-Language header if no language is preferred. */
> +	if (!s)
> +		return;
> +
> +	/*
> +	 * Split the colon-separated string of preferred languages into
> +	 * language_tags array.
> +	 */
> +	do {
> +		/* increase language_tags array to add new language tag */
> +		REALLOC_ARRAY(language_tags, num_langs + 1);
> +		strbuf_init(&language_tags[num_langs], 0);
> +
> +		/* collect language tag */
> +		for (; *s && (isalnum(*s) || *s == '_'); s++)
> +			strbuf_addch(&language_tags[num_langs], *s == '_' ? '-' : *s);
> +
> +		/* skip .codeset, @modifier and any other unnecessary parts */
> +		while (*s && *s != ':')
> +			s++;
> +
> +		if (language_tags[num_langs].len > 0) {
> +			num_langs++;
> +			if (num_langs >= MAX_LANGUAGE_TAGS - 1) /* -1 for '*' */
> +				break;
> +		}
> +	} while (*s++);
> +
> +	/* write Accept-Language header into buf */
> +	if (num_langs >= 1) {
> +		int i;
> +		int last_buf_len;
> +		int max_q;
> +		int decimal_places;
> +		char q_format[32];
> +
> +		/* add '*' */
> +		REALLOC_ARRAY(language_tags, num_langs + 1);
> +		strbuf_init(&language_tags[num_langs], 0);
> +		strbuf_addstr(&language_tags[num_langs++], "*");
> +
> +		/* compute decimal_places */
> +		for (max_q = 1, decimal_places = 0;
> +				max_q < num_langs && decimal_places <= MAX_DECIMAL_PLACES;
> +				decimal_places++, max_q *= 10)
> +			;
> +
> +		sprintf(q_format, ";q=0.%%0%dd", decimal_places);
> +
> +		strbuf_addstr(buf, "Accept-Language: ");
> +
> +		for(i = 0; i < num_langs; i++) {
> +			if (language_tags[i].len == 0)
> +				continue;
> +
> +			if (i > 0)
> +				strbuf_addstr(buf, ", ");
> +
> +			strbuf_addstr(buf, strbuf_detach(&language_tags[i], NULL));
> +
> +			if (i > 0)
> +				strbuf_addf(buf, q_format, max_q - i);
> +
> +			if (buf->len > MAX_ACCEPT_LANGUAGE_HEADER_SIZE) {
> +				strbuf_remove(buf, last_buf_len, buf->len - last_buf_len);
> +				break;
> +			}
> +
> +			last_buf_len = buf->len;
> +		}
> +	}
> +
> +	free(language_tags);
> +}
> +
> +/*
> + * Get an Accept-Language header which indicates user's preferred languages.
> + *
> + * This function always return non-NULL string as strbuf_detach() does.
> + *
> + * Examples:
> + *   LANGUAGE= -> ""
> + *   LANGUAGE=ko:en -> "Accept-Language: ko, en; q=0.9, *; q=0.1"
> + *   LANGUAGE=ko_KR.UTF-8:sr@latin -> "Accept-Language: ko-KR, sr; q=0.9, *; q=0.1"
> + *   LANGUAGE=ko LANG=en_US.UTF-8 -> "Accept-Language: ko, *; q=0.1"
> + *   LANGUAGE= LANG=en_US.UTF-8 -> "Accept-Language: en-US, *; q=0.1"
> + *   LANGUAGE= LANG=C -> ""
> + */
> +static const char *get_accept_language(void)
> +{
> +	if (!cached_accept_language) {
> +		struct strbuf buf = STRBUF_INIT;
> +		write_accept_language(&buf);
> +		cached_accept_language = strbuf_detach(&buf, NULL);
> +	}
> +
> +	return cached_accept_language;
> +}
> +
>  /* http_request() targets */
>  #define HTTP_REQUEST_STRBUF	0
>  #define HTTP_REQUEST_FILE	1
> @@ -998,6 +1144,7 @@ static int http_request(const char *url,
>  	struct slot_results results;
>  	struct curl_slist *headers = NULL;
>  	struct strbuf buf = STRBUF_INIT;
> +	const char *accept_language;
>  	int ret;
>  
>  	slot = get_active_slot();
> @@ -1023,6 +1170,11 @@ static int http_request(const char *url,
>  					 fwrite_buffer);
>  	}
>  
> +	accept_language = get_accept_language();
> +
> +	if (strlen(accept_language) > 0)
> +		headers = curl_slist_append(headers, accept_language);
> +
>  	strbuf_addstr(&buf, "Pragma:");
>  	if (options && options->no_cache)
>  		strbuf_addstr(&buf, " no-cache");
> diff --git a/remote-curl.c b/remote-curl.c
> index dd63bc2..04989e5 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -962,6 +962,8 @@ int main(int argc, const char **argv)
>  	struct strbuf buf = STRBUF_INIT;
>  	int nongit;
>  
> +	git_setup_gettext();
> +
>  	git_extract_argv0_path(argv[0]);
>  	setup_git_directory_gently(&nongit);
>  	if (argc < 2) {
> diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
> index ac71418..e1e2938 100755
> --- a/t/t5550-http-fetch-dumb.sh
> +++ b/t/t5550-http-fetch-dumb.sh
> @@ -196,5 +196,47 @@ test_expect_success 'reencoding is robust to whitespace oddities' '
>  	grep "this is the error message" stderr
>  '
>  
> +check_language () {
> +	case "$2" in
> +	'')
> +		>expect
> +		;;
> +	?*)
> +		echo "Accept-Language: $1" >expect
> +		;;
> +	esac &&
> +	GIT_CURL_VERBOSE=1 \
> +	LANGUAGE=$2 \
> +	git ls-remote "$HTTPD_URL/dumb/repo.git" >output 2>&1 &&
> +	tr -d '\015' <output |
> +	sort -u |
> +	sed -ne '/^Accept-Language:/ p' >actual &&
> +	test_cmp expect actual
> +}
> +
> +test_expect_success 'git client sends Accept-Language based on LANGUAGE' '
> +	check_language "ko-KR, *;q=0.9" ko_KR.UTF-8'
> +
> +test_expect_success 'git client sends Accept-Language correctly with unordinary LANGUAGE' '
> +	check_language "ko-KR, *;q=0.9" "ko_KR:" &&
> +	check_language "ko-KR, en-US;q=0.9, *;q=0.8" "ko_KR::en_US" &&
> +	check_language "ko-KR, *;q=0.9" ":::ko_KR" &&
> +	check_language "ko-KR, en-US;q=0.9, *;q=0.8" "ko_KR!!:en_US" &&
> +	check_language "ko-KR, ja-JP;q=0.9, *;q=0.8" "ko_KR en_US:ja_JP"'
> +
> +test_expect_success 'git client sends Accept-Language with many preferred languages' '
> +	check_language "ko-KR, en-US;q=0.9, fr-CA;q=0.8, de;q=0.7, sr;q=0.6, \
> +ja;q=0.5, zh;q=0.4, sv;q=0.3, pt;q=0.2, *;q=0.1" \
> +		ko_KR.EUC-KR:en_US.UTF-8:fr_CA:de.UTF-8@euro:sr@latin:ja:zh:sv:pt &&
> +	check_language "ko-KR, en-US;q=0.99, fr-CA;q=0.98, de;q=0.97, sr;q=0.96, \
> +ja;q=0.95, zh;q=0.94, sv;q=0.93, pt;q=0.92, nb;q=0.91, *;q=0.90" \
> +		ko_KR.EUC-KR:en_US.UTF-8:fr_CA:de.UTF-8@euro:sr@latin:ja:zh:sv:pt:nb
> +'
> +
> +test_expect_success 'git client does not send an empty Accept-Language' '
> +	GIT_CURL_VERBOSE=1 LANGUAGE= git ls-remote "$HTTPD_URL/dumb/repo.git" 2>stderr &&
> +	! grep "^Accept-Language:" stderr
> +'
> +
>  stop_httpd
>  test_done
> 
