Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8A6C54FD0
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 15:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5A8620656
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 15:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbgD0Pjg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 11:39:36 -0400
Received: from relay.secumail.de ([212.11.240.80]:46109 "EHLO
        relay.secumail.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgD0Pjg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 11:39:36 -0400
Received: from sprizz4-2953.local (p2E542407.dip0.t-ipconnect.de [46.84.36.7])
        (authenticated bits=0)
        by relay.secumail.de (8.15.2/8.15.2/Debian-10) with ESMTPSA id 03RFdKEA014108
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 27 Apr 2020 17:39:21 +0200
From:   Dirk <dirk@ed4u.de>
Subject: Re: [PATCH v3] git-credential-store: skip empty lines and comments
 from store
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        git@vger.kernel.org
Cc:     sunshine@sunshineco.us, peff@peff.net
References: <20200427084235.60798-1-carenas@gmail.com>
 <20200427125915.88667-1-carenas@gmail.com>
Message-ID: <9db4fc9c-94df-076d-0fe4-61bcfb73506e@ed4u.de>
Date:   Mon, 27 Apr 2020 17:39:19 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060111
 Thunderbird/1.5 Mnenhy/0.6.0.104
MIME-Version: 1.0
In-Reply-To: <20200427125915.88667-1-carenas@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you very much. That's correct and ideal in my eyes.

Regarding the comments, this is a new feature, of course. I think it's a worthless discussion about the question if the correct handling of empty lines are a bugfix or a new feature. In fact empty lines were handled correcty (ignored). So this might be considered a feature. But it wasn't documented, so it's a bugfix...

Anyway. Thank you all.

Dirk


Am 27.04.20 um 14:59 schrieb Carlo Marcelo Arenas Belón:
> with the added checks for invalid URLs in credentials, any locally
> modified store files which might have empty lines or even comments
> were reported[1] failing to parse as valid credentials.
>
> using the store file in this manner wasn't intended by the original
> code and it had latent issues which the new code dutifully prevented
> but since the strings used wouldn't had been valid credentials anyway
> we could instead detect them and skip the matching logic and therefore
> formalize this "feature".
>
> trim all lines as they are being read from the store file and skip the
> ones that will be otherwise empty or that start with "#" (therefore
> assuming them to be comments)
>
> [1] https://stackoverflow.com/a/61420852/5005936
>
> Reported-by: Dirk <dirk@ed4u.de>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
> v3:
> * avoid using q_to_cr as suggested by Peff
> * a more verbose commit message and slightly more complete documentation 
> v2:
> * use a here-doc for clarity as suggested by Eric
> * improve commit message and include documentation
>
>  Documentation/git-credential-store.txt |  7 +++++++
>  credential-store.c                     |  3 +++
>  t/t0302-credential-store.sh            | 15 +++++++++++++++
>  3 files changed, 25 insertions(+)
>
> diff --git a/Documentation/git-credential-store.txt b/Documentation/git-credential-store.txt
> index 693dd9d9d7..48ab4b13e5 100644
> --- a/Documentation/git-credential-store.txt
> +++ b/Documentation/git-credential-store.txt
> @@ -101,6 +101,13 @@ username (if we already have one) match, then the password is returned
>  to Git. See the discussion of configuration in linkgit:gitcredentials[7]
>  for more information.
>  
> +Note that the file used is not a configuration file and should be ideally
> +managed only through git, as any manually introduced typos will compromise
> +the validation of credentials.
> +
> +The parser will ignore any lines starting with the '#' character during
> +the processing of credentials for read, though.
> +
>  GIT
>  ---
>  Part of the linkgit:git[1] suite
> diff --git a/credential-store.c b/credential-store.c
> index c010497cb2..b2f160890d 100644
> --- a/credential-store.c
> +++ b/credential-store.c
> @@ -24,6 +24,9 @@ static int parse_credential_file(const char *fn,
>  	}
>  
>  	while (strbuf_getline_lf(&line, fh) != EOF) {
> +		strbuf_trim(&line);
> +		if (line.len == 0 || *line.buf == '#')
> +			continue;
>  		credential_from_url(&entry, line.buf);
>  		if (entry.username && entry.password &&
>  		    credential_match(c, &entry)) {
> diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
> index d6b54e8c65..5e6ace3a06 100755
> --- a/t/t0302-credential-store.sh
> +++ b/t/t0302-credential-store.sh
> @@ -120,4 +120,19 @@ test_expect_success 'erase: erase matching credentials from both xdg and home fi
>  	test_must_be_empty "$HOME/.config/git/credentials"
>  '
>  
> +test_expect_success 'get: allow for empty lines or comments in store file' '
> +	test_write_lines "#comment" " " "" \
> +		 https://user:pass@example.com >"$HOME/.git-credentials" &&
> +	check fill store <<-\EOF
> +	protocol=https
> +	host=example.com
> +	--
> +	protocol=https
> +	host=example.com
> +	username=user
> +	password=pass
> +	--
> +	EOF
> +'
> +
>  test_done
