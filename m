Return-Path: <SRS0=gkpi=AN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF40C433DF
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 07:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BF4120936
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 07:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgGBHu5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jul 2020 03:50:57 -0400
Received: from smtp01.domein-it.com ([92.48.232.134]:45217 "EHLO
        smtp01.domein-it.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgGBHu5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jul 2020 03:50:57 -0400
Received: by smtp01.domein-it.com (Postfix, from userid 1000)
        id D536B8086CF5; Thu,  2 Jul 2020 09:50:51 +0200 (CEST)
Received: from ferret.domein-it.nl (ferret.domein-it.nl [84.244.139.72])
        by smtp01.domein-it.com (Postfix) with ESMTP id 695D78086CEC;
        Thu,  2 Jul 2020 09:50:50 +0200 (CEST)
Received: from 80-112-22-40.cable.dynamic.v4.ziggo.nl ([80.112.22.40]:42210 helo=[192.168.1.102])
        by ferret.domein-it.nl with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ben@wijen.net>)
        id 1jqtzb-0006O3-CR; Thu, 02 Jul 2020 09:50:47 +0200
Subject: Re: [PATCH 2/2] git clone: don't clone into non-empty directory
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
References: <20200701093653.3706-1-ben@wijen.net>
 <20200701093653.3706-3-ben@wijen.net>
 <CAPig+cTEpajuD98RH5xepJ+rK2f75SROrTvgjzKnyfjxbuA1AQ@mail.gmail.com>
From:   Ben <ben@wijen.net>
Message-ID: <fe053a22-16a1-a071-520c-9bb5be7dc09f@wijen.net>
Date:   Thu, 2 Jul 2020 09:50:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cTEpajuD98RH5xepJ+rK2f75SROrTvgjzKnyfjxbuA1AQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Domein-IT-MailScanner-Information: Please contact the ISP for more information
X-Domein-IT-MailScanner-ID: 1jqtzb-0006O3-CR
X-Domein-IT-MailScanner: Found to be clean
X-Domein-IT-MailScanner-SpamCheck: 
X-Domein-IT-MailScanner-From: ben@wijen.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01-07-2020 18:10, Eric Sunshine wrote:
> On Wed, Jul 1, 2020 at 5:46 AM Ben Wijen <ben@wijen.net> wrote:
> 
> "git init --separate-git-dir=" checks only whether the path exists,
> and errors out if it does; it doesn't care whether the directory is
> empty or not. I'm wondering, therefore, if this check should be
> tightened to more closely align the behavior of the two commands.
> (Using the tighter semantic now doesn't prohibit loosening it in the
> future, whereas it's harder to tighten behavior which started out
> loose.)
> 

About `git init`, I did take a look at it, but saw 'exist_ok' is always
true when called from 'cmd_init_db' (see builtin/init_db.c:654)
This means `git init` always allows when git_dir/real_git_dir already exists,
which I understand for the worktree, but I doubt if one wants this for the
repository. (when --separate-git-dir is used)

Also, because 'exist_ok' is always true for `git init` and - with this patch -
`git clone` checks the git_dir/real_git_dir before the 'init_db' call I'm wondering if
the code in 'init_db' (builtin/init-db.c:394-400) can be removed. 

Then, even if we do take that route (no 'is_empty_dir', only 'path_exists') we must
also address junk_git_dir_flags, as REMOVE_DIR_KEEP_TOPLEVEL would invalidate
a second git clone.

So, as this patch only fixes the problem at hand, IMHO separate patch-sets should
be created for mentioned issues.

Ben...
