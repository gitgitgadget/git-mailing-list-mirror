Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 501D3207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 16:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751477AbdDZQ7a (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 12:59:30 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:39516 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751130AbdDZQ7Z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 12:59:25 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3wCmWs1LzWz5tlB;
        Wed, 26 Apr 2017 18:59:21 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 5F90242BE;
        Wed, 26 Apr 2017 18:59:20 +0200 (CEST)
Subject: Re: [PATCH 07/15] remote.c: report error on failure to fopen()
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <20170420112609.26089-1-pclouds@gmail.com>
 <20170420112609.26089-8-pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <3a2686c2-6766-1235-001f-1b5283b5f408@kdbg.org>
Date:   Wed, 26 Apr 2017 18:59:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170420112609.26089-8-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 20.04.2017 um 13:26 schrieb Nguyễn Thái Ngọc Duy:
> @@ -279,8 +283,12 @@ static void read_branches_file(struct remote *remote)
>  	struct strbuf buf = STRBUF_INIT;
>  	FILE *f = fopen(git_path("branches/%s", remote->name), "r");
>
> -	if (!f)
> +	if (!f) {
> +		if (errno != ENOENT)
> +			warn_on_inaccessible(git_path("branches/%s",
> +						      remote->name));
>  		return;
> +	}
>
>  	strbuf_getline_lf(&buf, f);
>  	fclose(f);

This hunk causes a new failure in t5512.10 'confuses pattern as remote 
when no remote specified' on Windows:

+++ diff -u exp actual
--- exp Wed Apr 26 08:16:10 2017
+++ actual      Wed Apr 26 08:16:10 2017
@@ -1,5 +1,19 @@
+++ case "$1" in
+++ _test_ok=
+++ git ls-remote 'refs*master'
+warning: unable to access '.git/branches/refs*master': Invalid argument
  fatal: 'refs*master' does not appear to be a git repository
  fatal: Could not read from remote repository.

  Please make sure you have the correct access rights
  and the repository exists.
+++ exit_code=128

On Windows, it is not allowed to pass a file name with an asterisk to 
the OS. The test case contains this comment:

# We could just as easily have used "master"; the "*" emphasizes its
# role as a pattern.

So, can we replace the name with a simple "master", our would this miss 
the goal of the test case? Should we make it conditional on the MINGW 
prerequisite?

-- Hannes

