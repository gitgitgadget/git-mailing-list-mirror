Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27BE51FCA9
	for <e@80x24.org>; Wed, 14 Sep 2016 14:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1763232AbcINODY (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Sep 2016 10:03:24 -0400
Received: from washoe.dartmouth.edu ([129.170.30.229]:39629 "EHLO
        smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763193AbcINODU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2016 10:03:20 -0400
Received: from smtp.onerussian.com ([192.168.100.6] helo=washoe.onerussian.com)
        by smtp.onerussian.com with esmtps (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <yoh@onerussian.com>)
        id 1bkAmU-0001pA-OL
        for git@vger.kernel.org; Wed, 14 Sep 2016 10:03:18 -0400
Received: from yoh by washoe.onerussian.com with local (Exim 4.84)
        (envelope-from <yoh@onerussian.com>)
        id 1bkAmU-0001p5-F2
        for git@vger.kernel.org; Wed, 14 Sep 2016 10:03:18 -0400
Date:   Wed, 14 Sep 2016 10:03:18 -0400
From:   Yaroslav Halchenko <yoh@onerussian.com>
To:     git@vger.kernel.org
Subject: git submodule add  spits unrelated to actual problem error msg about
 .gitignore
Message-ID: <20160914140318.GB9833@onerussian.com>
References: <20160909221942.GS9830@onerussian.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160909221942.GS9830@onerussian.com>
X-URL:  http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: 192.168.100.6
X-SA-Exim-Rcpt-To: git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
X-SA-Exim-Scanned: No (on smtp.onerussian.com); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have spent some time chasing the wild goose (well - the .gitignore
file) after getting:

    $> git-submodule add --name fcx-1 ./fcx-1/ ./fcx-1/
    The following path is ignored by one of your .gitignore files:
    fcx-1
    Use -f if you really want to add it.

long story short -- the culprit is this piece of code in git-submodule:

    if test -z "$force" && ! git add --dry-run --ignore-missing "$sm_path" > /dev/null 2>&1
    then
        eval_gettextln "The following path is ignored by one of your .gitignore files:
\$sm_path
Use -f if you really want to add it." >&2
        exit 1
    fi


so if anything goes wrong in git add, it just reports  this error
message.

FTR -- actual problem in my case was:

    $> git add --dry-run --ignore-missing fcx-1
    fatal: Unable to create '/mnt/datasets/datalad/crawl/crcns/.git/index.lock': File exists.

    Another git process seems to be running in this repository, e.g.
    an editor opened by 'git commit'. Please make sure all processes
    are terminated then try again. If it still fails, a git process
    may have crashed in this repository earlier:
    remove the file manually to continue.

;-)

Cheers!
P.S. Please CC me in replies
-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        
