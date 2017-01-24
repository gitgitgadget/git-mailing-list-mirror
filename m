Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2A391F89C
	for <e@80x24.org>; Tue, 24 Jan 2017 17:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750772AbdAXRwl (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jan 2017 12:52:41 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:27656 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750732AbdAXRwk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2017 12:52:40 -0500
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id W5Goc3wtM0KuvW5GocUwqK; Tue, 24 Jan 2017 17:52:38 +0000
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=RZjSMBlv c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=8nJEP1OIZ-IA:10 a=A1X0JdhQAAAA:8
 a=3db9Uf9sAAAA:8 a=lLq7OiBHP0uVz7SDoTsA:9 a=wPNLvfGTeEIA:10 a=-FEs8UIgK8oA:10
 a=NWVoK91CQyQA:10 a=Df3jFdWbhGDLdZNm0fyq:22 a=zgEGGwQugW41mEcxgvBZ:22
Message-ID: <5BF60E6DF2C04DF081466BC3BD3F954F@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Patrick Steinhardt" <patrick.steinhardt@elego.de>,
        <git@vger.kernel.org>
Cc:     "Patrick Steinhardt" <ps@pks.im>,
        "Junio C Hamano" <gitster@pobox.com>,
        "Patrick Steinhardt" <patrick.steinhardt@elego.de>
References: <20170124170031.18069-1-patrick.steinhardt@elego.de> <20170124170031.18069-5-patrick.steinhardt@elego.de>
Subject: Re: [PATCH v2 4/4] urlmatch: allow globbing for the URL host part
Date:   Tue, 24 Jan 2017 17:52:39 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfEekQmu+pyJR2WwzpWNxUOlbGiFUx6gLCZdLLRbcjKo3JvdzLE4gcS6rkb/jRVt1uuFEE3gKABb41tColf33e3dy/LJWhJBzGiYv9PkBxsojxGnPoaTN
 ufqROiF+1grRMWUuLdXp3U9dWE8FNiOzM+Hh3aiB3dItNceDtDr+tsX9gVLm8uTtT1Q1NawpZap1ztWpIN5XmofPSwKDya+j0bxZ4ZQZ8VAXO1Y99gf62CRd
 uJbO+mg2TiLpFYQSgjo70zlzI1k2QrhnA5dHDNqsd3CafzvSXrI2hQXSWQCchbH0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Patrick Steinhardt" <patrick.steinhardt@elego.de>

a quick comment on the documentation part ..

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
>
> Signed-off-by: Patrick Steinhardt <patrick.steinhardt@elego.de>
> ---
> Documentation/config.txt |  5 ++++-
> t/t1300-repo-config.sh   | 36 ++++++++++++++++++++++++++++++++++++
> urlmatch.c               | 38 ++++++++++++++++++++++++++++++++++----
> 3 files changed, 74 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 506431267..a78921c2b 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1914,7 +1914,10 @@ http.<url>.*::
>   must match exactly between the config key and the URL.
>
> . Host/domain name (e.g., `example.com` in `https://example.com/`).
> -  This field must match exactly between the config key and the URL.
> +  This field must match between the config key and the URL. It is
> +  possible to use globs in the config key to match all subdomains, e.g.
> +  `https://*.example.com/` to match all subdomains of `example.com`. Note
> +  that a glob only every matches a single part of the hostname.

[s/every/ever/ ?]

the "match all subdomains" appears to contradict the "a glob only ever 
matches a single part ".

Maybe borrow the example from the 0/4 cover letter
"so for example `https://foo.bar.example.com` would not match in the case of 
`http.https://*.example.com` " (If I understood it correctly.

A simple example often clarifies much better than more words.
--
Philip

>
> . Port number (e.g., `8080` in `http://example.com:8080/`).
>   This field must match exactly between the config key and the URL.
> diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
> index 923bfc5a2..ec545e092 100755
> --- a/t/t1300-repo-config.sh
> +++ b/t/t1300-repo-config.sh
> @@ -1177,6 +1177,42 @@ test_expect_success 'urlmatch' '
>  test_cmp expect actual
> '
>
> +test_expect_success 'glob-based urlmatch' '
> + cat >.git/config <<-\EOF &&
> + [http]
> + sslVerify
> + [http "https://*.example.com"]
> + sslVerify = false
> + cookieFile = /tmp/cookie.txt
> + EOF
> +
> + test_expect_code 1 git config --bool --get-urlmatch doesnt.exist 
> https://good.example.com >actual &&
> + test_must_be_empty actual &&
> +
> + echo true >expect &&
> + git config --bool --get-urlmatch http.SSLverify https://example.com 
>  >actual &&
> + test_cmp expect actual &&
> +
> + echo true >expect &&
> + git config --bool --get-urlmatch http.SSLverify https://good-example.com 
>  >actual &&
> + test_cmp expect actual &&
> +
> + echo true >expect &&
> + git config --bool --get-urlmatch http.sslverify 
> https://deep.nested.example.com >actual &&
> + test_cmp expect actual &&
> +
> + echo false >expect &&
> + git config --bool --get-urlmatch http.sslverify https://good.example.com 
>  >actual &&
> + test_cmp expect actual &&
> +
> + {
> + echo http.cookiefile /tmp/cookie.txt &&
> + echo http.sslverify false
> + } >expect &&
> + git config --get-urlmatch HTTP https://good.example.com >actual &&
> + test_cmp expect actual
> +'
> +
> # good section hygiene
> test_expect_failure 'unsetting the last key in a section removes header' '
>  cat >.git/config <<-\EOF &&
> diff --git a/urlmatch.c b/urlmatch.c
> index e328905eb..53ff972a6 100644
> --- a/urlmatch.c
> +++ b/urlmatch.c
> @@ -63,6 +63,38 @@ static int append_normalized_escapes(struct strbuf 
> *buf,
>  return 1;
> }
>
> +static int match_host(const struct url_info *url_info,
> +       const struct url_info *pattern_info)
> +{
> + char *url = xmemdupz(url_info->url + url_info->host_off, 
> url_info->host_len);
> + char *pat = xmemdupz(pattern_info->url + pattern_info->host_off, 
> pattern_info->host_len);
> + char *url_tok, *pat_tok, *url_save, *pat_save;
> + int matching;
> +
> + url_tok = strtok_r(url, ".", &url_save);
> + pat_tok = strtok_r(pat, ".", &pat_save);
> +
> + for (; url_tok && pat_tok; url_tok = strtok_r(NULL, ".", &url_save),
> +    pat_tok = strtok_r(NULL, ".", &pat_save)) {
> + if (!strcmp(pat_tok, "*"))
> + continue; /* a simple glob matches everything */
> +
> + if (strcmp(url_tok, pat_tok)) {
> + /* subdomains do not match */
> + matching = 0;
> + break;
> + }
> + }
> +
> + /* matching if both URL and pattern are at their ends */
> + matching = (url_tok == NULL && pat_tok == NULL);
> +
> + free(url);
> + free(pat);
> +
> + return matching;
> +}
> +
> static char *url_normalize_1(const char *url, struct url_info *out_info, 
> char allow_globs)
> {
>  /*
> @@ -467,9 +499,7 @@ static int match_urls(const struct url_info *url,
>  }
>
>  /* check the host */
> - if (url_prefix->host_len != url->host_len ||
> -     strncmp(url->url + url->host_off,
> -     url_prefix->url + url_prefix->host_off, url->host_len))
> + if (!match_host(url, url_prefix))
>  return 0; /* host names do not match */
>
>  /* check the port */
> @@ -512,7 +542,7 @@ int urlmatch_config_entry(const char *var, const char 
> *value, void *cb)
>  struct url_info norm_info;
>
>  config_url = xmemdupz(key, dot - key);
> - norm_url = url_normalize(config_url, &norm_info);
> + norm_url = url_normalize_1(config_url, &norm_info, 1);
>  free(config_url);
>  if (!norm_url)
>  return 0;
> -- 
> 2.11.0
>
> 

