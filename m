Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 403ED2036B
	for <e@80x24.org>; Wed,  4 Oct 2017 01:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751657AbdJDBFZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 21:05:25 -0400
Received: from smtprelay06.ispgateway.de ([80.67.18.29]:53453 "EHLO
        smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751148AbdJDBFZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 21:05:25 -0400
X-Greylist: delayed 9358 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Oct 2017 21:05:24 EDT
Received: from [91.113.179.170] (helo=[192.168.92.24])
        by smtprelay06.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.89)
        (envelope-from <marc.strapetz@syntevo.com>)
        id 1dzVgq-0005V4-E3
        for git@vger.kernel.org; Wed, 04 Oct 2017 00:29:24 +0200
From:   Marc Strapetz <marc.strapetz@syntevo.com>
Subject: Git for Windows: mingw.c's strange usage of creation time as ctime?
To:     GIT Mailing-list <git@vger.kernel.org>
Message-ID: <08983090-07d2-cfe4-dd90-ab4887b83893@syntevo.com>
Date:   Wed, 4 Oct 2017 00:29:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWFyYy5zdHJhcGV0ekBzeW50ZXZvLmNvbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

compat/mingw.c assigns the Windows file creation time [1] to Git's ctime 
fields at line 591 and at line 705:

buf->st_ctime = filetime_to_time_t(&(fdata.ftCreationTime));

ftCreationTime > ftLastWriteTime is actually possible after copying a 
file, so it makes sense to include this timestamp somehow in the Index, 
but I think it would be better to use the maximum of ftLastWriteTime and 
ftCreationTime here which is less confusing and closer to Unix's ctime:

buf->st_ctime = max(buf->st_mtime,
                     filetime_to_time_t(&(fdata.ftCreationTime));

-Marc

[1] 
https://msdn.microsoft.com/en-us/library/windows/desktop/aa365739(v=vs.85).aspx

