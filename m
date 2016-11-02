Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78DB420193
	for <e@80x24.org>; Wed,  2 Nov 2016 18:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756418AbcKBSDj (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 14:03:39 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:6017 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755198AbcKBSDi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 14:03:38 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3t8GDl0dDmz5tlW;
        Wed,  2 Nov 2016 19:03:34 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 4FF20148;
        Wed,  2 Nov 2016 19:03:34 +0100 (CET)
Subject: Re: [PATCH v11 13/14] convert: add filter.<driver>.process option
To:     larsxschneider@gmail.com
References: <20161016232038.84951-1-larsxschneider@gmail.com>
 <20161016232038.84951-14-larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jnareb@gmail.com,
        peff@peff.net, ramsay@ramsayjones.plus.com, tboegi@web.de
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <3b09d218-33bd-dc7c-235c-8954a46afc41@kdbg.org>
Date:   Wed, 2 Nov 2016 19:03:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161016232038.84951-14-larsxschneider@gmail.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.10.2016 um 01:20 schrieb larsxschneider@gmail.com:
> +# Compare two files and ensure that `clean` and `smudge` respectively are
> +# called at least once if specified in the `expect` file. The actual
> +# invocation count is not relevant because their number can vary.
> +# c.f. http://public-inbox.org/git/xmqqshv18i8i.fsf@gitster.mtv.corp.google.com/
> +test_cmp_count () {
> +	expect=$1
> +	actual=$2
> +	for FILE in "$expect" "$actual"
> +	do
> +		sort "$FILE" | uniq -c | sed "s/^[ ]*//" |
> +			sed "s/^\([0-9]\) IN: clean/x IN: clean/" |
> +			sed "s/^\([0-9]\) IN: smudge/x IN: smudge/" >"$FILE.tmp" &&

This is not sufficiently portable. Some versions of uniq write the
count left-adjusted, not right-adjusted. How about this on top:

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index a20b9f58e3..f60858c517 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -40,10 +40,9 @@ test_cmp_count () {
 	actual=$2
 	for FILE in "$expect" "$actual"
 	do
-		sort "$FILE" | uniq -c | sed "s/^[ ]*//" |
-			sed "s/^\([0-9]\) IN: clean/x IN: clean/" |
-			sed "s/^\([0-9]\) IN: smudge/x IN: smudge/" >"$FILE.tmp" &&
-		mv "$FILE.tmp" "$FILE"
+		sort "$FILE" | uniq -c |
+		sed -e "s/^ *[0-9][0-9]* *IN: /x IN: /" >"$FILE.tmp" &&
+		mv "$FILE.tmp" "$FILE" || return
 	done &&
 	test_cmp "$expect" "$actual"
 }

-- Hannes

