Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61F69211BC
	for <e@80x24.org>; Thu, 27 Dec 2018 20:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbeL0UQP (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 15:16:15 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51179 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728330AbeL0UQP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 15:16:15 -0500
Received: from carbon-x1.hos.anvin.org (c-24-5-245-234.hsd1.ca.comcast.net [24.5.245.234] (may be forged))
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id wBRKGCLV2532432
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 27 Dec 2018 12:16:14 -0800
To:     git@vger.kernel.org
From:   "H. Peter Anvin" <hpa@zytor.com>
Subject: RFE: version-controlled merge rules
Message-ID: <ad875f1e-54e1-e19f-cd65-95ab503c6de2@zytor.com>
Date:   Thu, 27 Dec 2018 12:16:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Right now, merge rules can get selected in .gitattributes, which is
version-controlled. However, there does not appear to be any way to *define*
custom merge rules which is version controlled.

There are a lot of different files which can benefit from custom merge rules,
especially ones that are in some ways cumulative or version/tree-dependent.
For example, I use this rule to merge version files:

[merge "version"]
        name = Version file merge driver
        driver = sort -V -r %O %A %B | head -1 > %A.tmp.1 && mv -f %A.tmp.1 %A

(Incidentally: the need for an explicit temp file here is frustrating. It
would be better if git could manage the temporary file. Overwriting %A
directly truncates the file too early.  See other email.)

However, I can't even put this in .gitattributes, because doing so would break
any user who *doesn't* have the previous rule defined locally. Even worse, if
this rule needs to change, propagating it to all new users has to be done
manually... never mind if it needs to vary by branch!

The simplest way to address this would presumably be to let the
repository/working directory contain a .gitconfig file that can contain rules
like that.  (Allowing it to be in the repository proper is probably a
requirement for merges to be handled correctly on bare repositories; I'm not
sure how .gitattributes is handled for that.)

	-hpa
