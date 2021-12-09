Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47A8C433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 19:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbhLITkf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 14:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhLITke (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 14:40:34 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254A1C061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 11:37:00 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id u17so11553910wrt.3
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 11:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=8PDdw2LaXEZSdT7Zpl4gByEcsD40q5e9LT1FqEXfmuo=;
        b=RiS5YuSyS4UThWSVJ9LzVXgc/HPvfm1/qnPia7LiVbCOrMn7nTEeuDprTJEOgD6Sid
         YX/t4J88goXGX4jO8KaL2WWR0uCl5FQKBB4NDR8s/t0kR452QOWp5Fq0/sk2fD/T7PCg
         qWC5KH83Pb6Z81fJdtRHpy3W0NFmvMdtL+O8RMrHF1vKM6HVkH6HWs9a5lNBY/1juwz6
         3PzhnhndfXfdWzAQx9GguX0ZrE0UcYmtZWsLek4LayVoFZViSckV/SNpn401L8/VfDDU
         6gZIG9ZdO6iCVNm/4SjX0sap0fOTpeZvStqsLgW9t8yj0fg/flUnyx6wwpB2/uTxXkH7
         SbwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=8PDdw2LaXEZSdT7Zpl4gByEcsD40q5e9LT1FqEXfmuo=;
        b=D8FQHRFOA6iFOy+uSeOVYDN0uoGNcgTm/HSxPrZCF3CKIHpnn7HDPrpUkPqImMADdb
         5nA5sLzeRfl+1eLqIeWQB+aA3lLY2vOLJjPFM8ilw0y4u/enT36JGYKdo1BNcuGP2owc
         C5fRgSrf4PArdnlfOHwmVu6fspuTiFhaJ2deoM7JLf48e6h0FIvMJTkqWR1sRbuynCQZ
         BJSKH7CuDCBkaTeZBKCp0jpX1EmM1NElPeMeJMd45gDtLGD2j7G2Xi53vAShDg+lH0XH
         VmOg1BeziDS1ycny/h4+WNndLMN6QhM+a8PFbPgYykOOvc6p6TRz1rh2pW5xDQRQLEco
         d9Qg==
X-Gm-Message-State: AOAM531QlRW9p+1yz+M7vBL8TgdMsPthlyS63u/qkO8DVDX8LUkSlP+v
        4yPztpznIiNMpZCXafw1hE4ZuhHLLSI=
X-Google-Smtp-Source: ABdhPJyh9svAhzxX6srWRM1XM78jpGAF8nBne4cmxhIP39h1X0YndyrL8hyDtSvtgP+kATPzzTzGaw==
X-Received: by 2002:adf:d1e2:: with SMTP id g2mr8933936wrd.179.1639078618756;
        Thu, 09 Dec 2021 11:36:58 -0800 (PST)
Received: from szeder.dev (94-21-58-127.pool.digikabel.hu. [94.21.58.127])
        by smtp.gmail.com with ESMTPSA id l1sm559391wrn.15.2021.12.09.11.36.57
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 11:36:58 -0800 (PST)
Date:   Thu, 9 Dec 2021 20:36:25 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Subject: builtin add interactive regression
Message-ID: <20211209193625.GA3294@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

This morning 'git add --patch' told me "Sorry, cannot split this hunk"
even though that hunk in question was definitely splittable.  Then I
spent my lunch break trying to reproduce the issue, and it turned out
to be a regression in the builtin add interactive (I have
'add.interactive.useBuiltin=true' in my config).  The following test
demonstrates this issue:

  ---  >8  ---

#!/bin/sh

test_description='test'
. ./test-lib.sh

test_expect_success 'builtin interactive add cannot split hunk?!' '
	printf "%s\n" 1 2 >file &&
	echo a >zzzz &&
	git add file zzzz &&
	git commit -m initial &&
	cat >file <<-\EOF &&
	1
	add a line
	2
	add a line at the end (this is important!)
	EOF
	echo "modify one more file (this, too, is important!)" >zzzz &&

	git diff file &&

	git -c add.interactive.useBuiltin=false add -u -p >expect &&
	git -c add.interactive.useBuiltin=true add -u -p >actual &&
	# Uh-oh, "s" (for splitting the hunk) is missing!
	test_cmp expect actual
'

test_done

  ---  8<  ---

This fails with:

  + git -c add.interactive.useBuiltin=false add -u -p
  + git -c add.interactive.useBuiltin=true add -u -p
  + test_cmp expect actual
  --- expect	2021-12-09 19:21:23.354461170 +0000
  +++ actual	2021-12-09 19:21:23.358461215 +0000
  @@ -7,7 +7,7 @@
   +add a line
    2
   +add a line at the end (this is important!)
  -(1/1) Stage this hunk [y,n,q,a,d,s,e,?]? 
  +(1/1) Stage this hunk [y,n,q,a,d,e,?]? 
   diff --git a/zzzz b/zzzz
   index 7898192..84e1b35 100644
   --- a/zzzz
  error: last command exited with $?=1
  not ok 1 - builtin interactive add cannot split hunk?!

So the builtin add interactive doesn't even offer the 's - split the
current hunk into smaller hunks' option, but my finger memory pressed
's' anyway, and then it told me that "Sorry..." message.  The scripted
version can split the hunk just fine.

