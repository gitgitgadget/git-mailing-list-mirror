Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA6761F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 20:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753652AbdAZUr0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 15:47:26 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58754 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752933AbdAZUrX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 15:47:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 482B46463E;
        Thu, 26 Jan 2017 15:43:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=6yEZaHhbItsjeBgzWOODCXQubrM=; b=N98oLBG7AJEP357N9y5i
        grDjBitwfJb26tNdYAlRryBoz5IJgaazhbqSbKUdlIbISPxHvPlX5JahrErm7K42
        eD9ybMi+miID/LAgYt8QxvJ73YJDdy8doKZx4EaGrmc1xaaGMq6p59JN349/sNZL
        Oe9heotcoQH6BEuXzH8i+ns=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=bmtOHxeOVA/MDiszOVERw32hZ25CODV7IDmmqJuxhYBOGe
        bAKXGiq9RCyF2M7fXJFzP13Y46zkH+gQlJamTXoAzmScMrzUeOdsj7bcj9Bt4BBT
        HOg+d244p07gCxmdC3BvaQ6huqM56VrYX4sKAUa0ZdNNUxnWCLzi1nC36eeHk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3E41E6463D;
        Thu, 26 Jan 2017 15:43:33 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 833526463B;
        Thu, 26 Jan 2017 15:43:32 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <patrick.steinhardt@elego.de>
Cc:     git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH v3 4/4] urlmatch: allow globbing for the URL host part
References: <20170125095648.4116-1-patrick.steinhardt@elego.de>
        <20170123130635.29577-1-patrick.steinhardt@elego.de>
        <20170125095648.4116-5-patrick.steinhardt@elego.de>
Date:   Thu, 26 Jan 2017 12:43:31 -0800
Message-ID: <xmqq7f5h4kng.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 19D36128-E408-11E6-AEAD-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <patrick.steinhardt@elego.de> writes:

> The URL matching function computes for two URLs whether they match not.
> The match is performed by splitting up the URL into different parts and
> then doing an exact comparison with the to-be-matched URL.
>
> The main user of `urlmatch` is the configuration subsystem. It allows to
> set certain configurations based on the URL which is being connected to
> via keys like `http.<url>.*`. A common use case for this is to set
> proxies for only some remotes which match the given URL. Unfortunately,
> having exact matches for all parts of the URL can become quite tedious
> in some setups. Imagine for example a corporate network where there are
> dozens or even hundreds of subdomains, which would have to be configured
> individually.
>
> This commit introduces the ability to use globbing in the host-part of
> the URLs. A user can simply specify a `*` as part of the host name to
> match all subdomains at this level. For example adding a configuration
> key `http.https://*.example.com.proxy` will match all subdomains of
> `https://example.com`.

This is probably a useful improvement.

Having said that, when I mentioned "glob", I meant to also support
something like this:

	https://www[1-4].ibm.com/

And when people read "glob", that is what they expect.

So calling this "the ability to use globbing" is misleading.
The last paragraph in the log message above needs a bit of
tweaking, perhaps like this:

	Allow users to write an asterisk '*' in place of any 'host'
	or 'subdomain' label as part of the host name.  For example,
	"http.https://*.example.com.proxy" sets "http.proxy" for all
	direct subdomains of "https://example.com",
	e.g. "https://foo.example.com", but not
	"https://foo.bar.example.com".

Fortunately, your update to config.txt, which is facing the end
users, does not misuse the word and instead is explicit that the
only thing the matcher does is to match '*' to a single hierarchy.
It is clear that even http://www*.ibm.com/ is not supported from
the description, which is good.

>  . Host/domain name (e.g., `example.com` in `https://example.com/`).
> -  This field must match exactly between the config key and the URL.
> +  This field must match between the config key and the URL. It is
> +  possible to specify a `*` as part of the host name to match all subdomains
> +  at this level. `https://*.example.com/` for example would match
> +  `https://foo.example.com/`, but not `https://foo.bar.example.com/`.

This is good as-is.

>  . Port number (e.g., `8080` in `http://example.com:8080/`).
>    This field must match exactly between the config key and the URL.
> diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
> index 923bfc5a2..ec545e092 100755
> --- a/t/t1300-repo-config.sh
> +++ b/t/t1300-repo-config.sh
> @@ -1177,6 +1177,42 @@ test_expect_success 'urlmatch' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'glob-based urlmatch' '

This is not "glob".  A more generic term "wildcard" is OK.

> +	cat >.git/config <<-\EOF &&
> +	[http]
> +		sslVerify
> ...
> +static int match_host(const struct url_info *url_info,
> +		      const struct url_info *pattern_info)
> +{
> +	char *url = xmemdupz(url_info->url + url_info->host_off, url_info->host_len);
> +	char *pat = xmemdupz(pattern_info->url + pattern_info->host_off, pattern_info->host_len);
> +	char *url_tok, *pat_tok, *url_save, *pat_save;
> +	int matching;
> +
> +	url_tok = strtok_r(url, ".", &url_save);
> +	pat_tok = strtok_r(pat, ".", &pat_save);

Hmph, this will be the first use of strtok_r() in our codebase.
Does everybody have it?

For a use like this where your delimiter set is a singleton, it may
be simpler to do the usual strchrnul() or memchr() based loop.  The
attached is my attempt to do so on top of this patch.

> +
> +	for (; url_tok && pat_tok; url_tok = strtok_r(NULL, ".", &url_save),
> +				   pat_tok = strtok_r(NULL, ".", &pat_save)) {
> +		if (!strcmp(pat_tok, "*"))
> +			continue; /* a simple glob matches everything */

s/glob/asterisk/

Other than that, the patch looks OK.



diff --git a/urlmatch.c b/urlmatch.c
index 53ff972a60..8dfc7fd28a 100644
--- a/urlmatch.c
+++ b/urlmatch.c
@@ -63,36 +63,47 @@ static int append_normalized_escapes(struct strbuf *buf,
 	return 1;
 }
 
+static const char *end_of_token(const char *s, int c, size_t n)
+{
+	const char *next = memchr(s, c, n);
+	if (!next)
+		next = s + n;
+	return next;
+}
+
 static int match_host(const struct url_info *url_info,
 		      const struct url_info *pattern_info)
 {
-	char *url = xmemdupz(url_info->url + url_info->host_off, url_info->host_len);
-	char *pat = xmemdupz(pattern_info->url + pattern_info->host_off, pattern_info->host_len);
-	char *url_tok, *pat_tok, *url_save, *pat_save;
-	int matching;
-
-	url_tok = strtok_r(url, ".", &url_save);
-	pat_tok = strtok_r(pat, ".", &pat_save);
-
-	for (; url_tok && pat_tok; url_tok = strtok_r(NULL, ".", &url_save),
-				   pat_tok = strtok_r(NULL, ".", &pat_save)) {
-		if (!strcmp(pat_tok, "*"))
-			continue; /* a simple glob matches everything */
-
-		if (strcmp(url_tok, pat_tok)) {
-			/* subdomains do not match */
-			matching = 0;
-			break;
-		}
+	const char *url = url_info->url + url_info->host_off;
+	const char *pat = pattern_info->url + pattern_info->host_off;
+	int url_len = url_info->host_len;
+	int pat_len = pattern_info->host_len;
+
+	while (url_len && pat_len) {
+		const char *url_next = end_of_token(url, '.', url_len);
+		const char *pat_next = end_of_token(pat, '.', pat_len);
+
+		if (pat_next == pat + 1 && pat[0] == '*')
+			/* wildcard matches anything */
+			;
+		else if ((pat_next - pat) == (url_next - url) &&
+			 !memcmp(url, pat, url_next - url))
+			/* the components are the same */
+			;
+		else
+			return 0; /* found an unmatch */
+
+		if (url_next < url + url_len)
+			url_next++;
+		url_len -= url_next - url;
+		url = url_next;
+		if (pat_next < pat + pat_len)
+			pat_next++;
+		pat_len -= pat_next - pat;
+		pat = pat_next;
 	}
 
-	/* matching if both URL and pattern are at their ends */
-	matching = (url_tok == NULL && pat_tok == NULL);
-
-	free(url);
-	free(pat);
-
-	return matching;
+	return 1;
 }
 
 static char *url_normalize_1(const char *url, struct url_info *out_info, char allow_globs)
