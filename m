Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 889EE1F576
	for <e@80x24.org>; Sun, 21 Jan 2018 14:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750891AbeAUOWZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Jan 2018 09:22:25 -0500
Received: from zucker2.schokokeks.org ([178.63.68.90]:52773 "EHLO
        zucker2.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750817AbeAUOWY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Jan 2018 09:22:24 -0500
Received: from localhost ([::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
  by zucker.schokokeks.org with ESMTPSA; Sun, 21 Jan 2018 15:22:30 +0100
  id 0000000000000036.000000005A64A226.00006B27
Date:   Sun, 21 Jan 2018 15:22:22 +0100
From:   Simon Ruderich <simon@ruderich.org>
To:     lars.schneider@autodesk.com
Cc:     git@vger.kernel.org, gitster@pobox.com, tboegi@web.de,
        j6t@kdbg.org, sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v4 5/6] convert: add 'working-tree-encoding' attribute
Message-ID: <20180121142222.GA10248@ruderich.org>
References: <20180120152418.52859-1-lars.schneider@autodesk.com>
 <20180120152418.52859-6-lars.schneider@autodesk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20180120152418.52859-6-lars.schneider@autodesk.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 20, 2018 at 04:24:17PM +0100, lars.schneider@autodesk.com wrote:
> +static struct encoding *git_path_check_encoding(struct attr_check_item *check)
> +{
> +	const char *value = check->value;
> +	struct encoding *enc;
> +
> +	if (ATTR_TRUE(value) || ATTR_FALSE(value) || ATTR_UNSET(value) ||
> +	    !strlen(value))
> +		return NULL;
> +
> +	for (enc = encoding; enc; enc = enc->next)
> +		if (!strcasecmp(value, enc->name))
> +			return enc;
> +
> +	/* Don't encode to the default encoding */
> +	if (!strcasecmp(value, default_encoding))
> +		return NULL;
> +
> +	enc = xcalloc(1, sizeof(struct convert_driver));

I think this should be "sizeof(struct encoding)" but I prefer
"sizeof(*enc)" which prevents these kind of mistakes.

> +	enc->name = xstrdup_toupper(value);  /* aways use upper case names! */

"aways" -> "always" and I think the comment should say why
uppercase is important.

> +test_expect_success 'ensure UTF-8 is stored in Git' '
> +	git cat-file -p :test.utf16 >test.utf16.git &&
> +	test_cmp_bin test.utf8.raw test.utf16.git &&
> +	rm test.utf8.raw test.utf16.git
> +'
> +
> +test_expect_success 're-encode to UTF-16 on checkout' '
> +	rm test.utf16 &&
> +	git checkout test.utf16 &&
> +	test_cmp_bin test.utf16.raw test.utf16 &&
> +
> +	# cleanup
> +	rm test.utf16.raw

Micro-nit: For consistency with the previous test, remove the
empty line and comment (or just keep the files generated from the
"setup test repo" phase and don't explicitly delete them)?

Regards
Simon
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
