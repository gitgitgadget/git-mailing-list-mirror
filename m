Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C406A1FAEB
	for <e@80x24.org>; Sat, 10 Jun 2017 09:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752043AbdFJJE2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Jun 2017 05:04:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:37576 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751950AbdFJJE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2017 05:04:26 -0400
Received: (qmail 5825 invoked by uid 109); 10 Jun 2017 09:04:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 10 Jun 2017 09:04:26 +0000
Received: (qmail 29785 invoked by uid 111); 10 Jun 2017 09:04:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 10 Jun 2017 05:04:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Jun 2017 05:04:24 -0400
Date:   Sat, 10 Jun 2017 05:04:24 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/8] config: report correct line number upon error
Message-ID: <20170610090424.zibu4sgd2lr7ghfk@sigill.intra.peff.net>
References: <cover.1496951503.git.johannes.schindelin@gmx.de>
 <291e8b643990aee04654b34c6f953387c3c030d4.1496951503.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <291e8b643990aee04654b34c6f953387c3c030d4.1496951503.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 08, 2017 at 09:53:35PM +0200, Johannes Schindelin wrote:

> When get_value() parses a key/value pair, it is possible that the line
> number is decreased (because the \n has been consumed already) before the
> key/value pair is passed to the callback function, to allow for the
> correct line to be attributed in case of an error.
> 
> However, when git_parse_source() asks get_value() to parse the key/value
> pair, the error reporting is performed *after* get_value() returns.
> 
> Which means that we have to be careful not to increase the line number
> in get_value() after the callback function returned an error.

Good catch. Would we want a test here, like:

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 13b7851f7..4cad8366a 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -703,6 +703,12 @@ test_expect_success 'invalid unit' '
 	test_i18ngrep "bad numeric config value .1auto. for .aninvalid.unit. in file .git/config: invalid unit" actual
 '
 
+test_expect_success 'invalid path' '
+	echo "[bool]var" >invalid &&
+	test_must_fail git config -f invalid --path bool.var 2>actual &&
+	test_i18ngrep "line 1" actual
+'
+
 test_expect_success 'invalid stdin config' '
 	echo "[broken" | test_must_fail git config --list --file - >output 2>&1 &&
 	test_i18ngrep "bad config line 1 in standard input" output

which currently reports "line 2" instead of line 1.

I wondered if the same bug could be found earlier (e.g,. from
parse_value() when it sees an unpaired quote), but it looks like we do a
cf->linenr-- rollback there already.

> diff --git a/config.c b/config.c
> index 146cb3452ad..9b88531a70d 100644
> --- a/config.c
> +++ b/config.c
> @@ -604,7 +604,8 @@ static int get_value(config_fn_t fn, void *data, struct strbuf *name)
>  	 */
>  	cf->linenr--;
>  	ret = fn(name->buf, value, data);
> -	cf->linenr++;
> +	if (!ret)
> +		cf->linenr++;
>  	return ret;
>  }

I think this should be "if (ret < 0)". The caller only considers it an
error if get_value() returns a negative number. As you have it here, I
think a config callback which returned a positive number would end up
with nonsense line numbers.

-Peff
