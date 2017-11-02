Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89FE520281
	for <e@80x24.org>; Thu,  2 Nov 2017 17:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932392AbdKBRVo (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 13:21:44 -0400
Received: from ikijono.foobar.fi ([193.65.3.99]:51550 "EHLO ikijono.foobar.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932303AbdKBRVn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 13:21:43 -0400
X-Greylist: delayed 498 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Nov 2017 13:21:43 EDT
Received: from localhost (localhost [IPv6:::1])
        by ikijono.foobar.fi (Postfix) with ESMTP id 3ySWrL3Z23zrwdv1
        for <git@vger.kernel.org>; Thu,  2 Nov 2017 19:13:22 +0200 (EET)
X-Virus-Scanned: amavisd-new at ikijono.foobar.fi
Received: from ikijono.foobar.fi ([IPv6:::1])
        by localhost (ikijono.foobar.fi [IPv6:::1]) (amavisd-new, port 10023)
        with ESMTP id SVB_WlR0kHXD for <git@vger.kernel.org>;
        Thu,  2 Nov 2017 19:13:21 +0200 (EET)
Received: from jhs-desktop.uk.solarflarecom.com (uk.solarflare.com [193.34.186.16])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ikijono.foobar.fi (Postfix) with ESMTPSA
        for <git@vger.kernel.org>; Thu,  2 Nov 2017 19:13:21 +0200 (EET)
To:     git@vger.kernel.org
From:   Hermanni Suominen <hermanni@foobar.fi>
Subject: [BUG] git clean -d is too greedy
Message-ID: <d2e823e2-800d-17ba-c9d4-f490cefefd2f@foobar.fi>
Date:   Thu, 2 Nov 2017 17:13:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

Since commit 6b1db4310 it is possible to make git clean -d to remove 
nested git repositories if

   1) .gitignore exists in nested repo (either tracked or untracked)
   2) .gitignore is excluded

Regarding to 2) it doesn't matter if .gitignore is excluded from 
(another) .gitignore or from command-line (but I assume they populate 
same ignore list so that's just stating the obvious).

To demonstrate this I can run the following commands:

# git init -q foo && cd foo
# git init -q bar && cd bar
# touch .gitignore bar
# git add bar && git commit -qm asd && cd ..
# git clean -e .gitignore -dn
Would remove bar/bar

Pre 6b1db4310, and if .gitignore isn't exclued, nested repo is correctly 
skipped:

# git clean -dn
Would skip repository bar/ 


It probably isn't very common use case to exclude .gitignore but 
nevertheless this has been broken for a while, and to make things worse 
it can wipe out lots of uncommitted changes.

-- 
Hermanni
