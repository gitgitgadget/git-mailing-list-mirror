Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C72001F4DD
	for <e@80x24.org>; Fri, 25 Aug 2017 11:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932330AbdHYLZh (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Aug 2017 07:25:37 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:36687 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932093AbdHYLZg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2017 07:25:36 -0400
Received: by mail-wr0-f172.google.com with SMTP id p14so6458664wrg.3
        for <git@vger.kernel.org>; Fri, 25 Aug 2017 04:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=vl+qfha1IAkkEf5PjePyWWWHKuln0cpsjmIBuQ6Urk8=;
        b=lMngTdmTG0me6SbnQO7T+Gad/Z+C8lFYAciK18yOyAvg+Bbh7YMgmIBRF09Bbwo4z7
         1Yk4XVkDOXnToiME7UobBNk9TKVRek4Z1M5Yr1rFIq1C9g0+YGM00XXLKboAe9AlOYIE
         V64y2yCwM5OCgXDJsGLwY4Of5POldZqfE3VyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=vl+qfha1IAkkEf5PjePyWWWHKuln0cpsjmIBuQ6Urk8=;
        b=R6gG7pliwZsXqQiHYJoGWSCeu2rQbT7N/+u9ti/tTK1J91ZRg5DXVoiq287WU5XtDI
         NYFG/zPkeDMadvzwxGedgcc4Jel5Gjo0w7Oap7Okd5it2BvePkZSrLdK8ECZKPMQ6dQ1
         yCpqsP8sHJ3a+ip4VMrYkJ68oCTRs36oBBLvmLf11IaHyOSWYSbEhYdnM9BV6fgPjIxu
         rDEhOQZPkieXZ0apHH+e+Lyly1/f3/M/oTsz4Xk7JHV/1y36Nz2u1l3GrglCJIOOoBLt
         KsNil2ARcqbjyRdKfWLjp6e4E+nJ5hmLnv2l5NtTTe2KAL4MdJWiBCt0RSiyFr9/N0Fp
         mnwQ==
X-Gm-Message-State: AHYfb5hVelKlxteLEOvwyWCX8yo9KYNG5nnzZHMoNSnRdSM+fdGFTZkJ
        P35P/joe0ujEvririKXZ7g==
X-Received: by 10.223.135.157 with SMTP id b29mr5812863wrb.48.1503660335272;
        Fri, 25 Aug 2017 04:25:35 -0700 (PDT)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id 72sm1368576wmh.11.2017.08.25.04.25.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Aug 2017 04:25:34 -0700 (PDT)
Date:   Fri, 25 Aug 2017 12:25:29 +0100
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: cat-file timing window on Cygwin
Message-ID: <20170825112529.GA10378@dinwoodie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As of v2.10.0-rc1-4-g321459439 ("cat-file: support --textconv/--filters
in batch mode"), t8010-cat-file-filters.sh has been failing on Cygwin.
Digging into this, the test looks to expose a timing window: it appears
that if `git cat-file --textconv --batch` receives input on stdin too
quickly, it fails to parse some of that input.

Compare the following output, run from the t8010 trash directory after a
failed test run, where adding a `sleep` between the two lines of input
changes the output:

    $ { echo $sha1 hello.txt ; echo $sha1 hello; } | git -c diff.txt.textconv='tr A-Za-z N-ZA-Mn-za-m <' cat-file --textconv --batch
    ce013625030ba8dba906f756967f9e9ca394464a blob 6
    uryyb

    $ { echo $sha1 hello.txt ; sleep 1; echo $sha1 hello; } | git -c diff.txt.textconv='tr A-Za-z N-ZA-Mn-za-m <' cat-file --textconv --batch
    ce013625030ba8dba906f756967f9e9ca394464a blob 6
    uryyb

    ce013625030ba8dba906f756967f9e9ca394464a blob 6
    hello

Similarly, I can get t8010 to pass with the following patch:

diff --git a/t/t8010-cat-file-filters.sh b/t/t8010-cat-file-filters.sh
index d8242e467..3aa1385ad 100755
--- a/t/t8010-cat-file-filters.sh
+++ b/t/t8010-cat-file-filters.sh
@@ -54,7 +54,7 @@
 test_expect_success 'cat-file --textconv --batch works' '
 	sha1=$(git rev-parse -q --verify HEAD:world.txt) &&
 	test_config diff.txt.textconv "tr A-Za-z N-ZA-Mn-za-m <" &&
-	printf "%s hello.txt\n%s hello\n" $sha1 $sha1 |
+	{ printf "%s hello.txt\n" $sha1 && sleep 1 && printf "%s hello\n" $sha1; } |
 	git cat-file --textconv --batch >actual &&
 	printf "%s blob 6\nuryyb\r\n\n%s blob 6\nhello\n\n" \
 		$sha1 $sha1 >expect &&

I don't think blindly applying the patch is the solution here, however.
The correct solution is presumably to work out what is causing cat-file
to discard some of its input and to get it to stop doing that.

(For reference, to get the output above the test was run on the current
master branch, specifically v2.14.1-326-g3dc57ebfb, while the local
installed Git version was v2.14.0, although this behaviour seems to be
consistent since the originating commit.)
