Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB79D1F803
	for <e@80x24.org>; Mon,  7 Jan 2019 17:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbfAGRlE (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 12:41:04 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:6746 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727133AbfAGRlE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 12:41:04 -0500
Received: from [192.168.1.12] ([92.29.14.220])
        by smtp.talktalk.net with SMTP
        id gYtZgZ0HUVlGZgYtZg4DTs; Mon, 07 Jan 2019 17:41:01 +0000
X-Originating-IP: [92.29.14.220]
X-Spam: 0
X-OAuthority: v=2.3 cv=JcuSU3CV c=1 sm=1 tr=0 a=iGBlNkCVnKJDjRvOkgwXUw==:117
 a=iGBlNkCVnKJDjRvOkgwXUw==:17 a=IkcTkHD0fZMA:10 a=uPZiAMpXAAAA:8
 a=RwT2eVkGvIoyyPjaLZQA:9 a=QEXdDO2ut3YA:10
Subject: Re: gitk shows local uncommit changes after touch file + reload
To:     Jacob Kroon <jacob.kroon@gmail.com>, git@vger.kernel.org
References: <CAPbeDCm5hjq06fbs=SUPR1rm3bD3GJvifZovP1d-Xd=01JfpYQ@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <2666a093-f9a5-782e-40b3-0cfbce8fe2a3@iee.org>
Date:   Mon, 7 Jan 2019 17:41:02 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAPbeDCm5hjq06fbs=SUPR1rm3bD3GJvifZovP1d-Xd=01JfpYQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfL5NkoyRiW7VeqgRZr7xoT+gaU3f5iGnFgVpy3+NnqnmBCOQI+el7Of0DJ5J//6/uNkEYxz+5tO5bbonv63A2Y6tg24Xa1JRsmwocWE9mlzkPsigeqXk
 4vhZlqWnlaRRiffS5Y3URY4XWgrcEvk+hJVoAlRWLBDX6/56m9QeeFlQkV5JdRDC0Vffy73NUz+2kZNaXuxQBDguaKzwtmqm3po=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/01/2019 22:51, Jacob Kroon wrote:
> Hi,
>
> Not sure if this has already been reported, but I observe this odd
> behaviour in gitk from master:
>
> git status
> gitk # everything looks good
> touch <file-under-version-control>
> gitk # gitk shows "local uncomitted changes" on the file I touched
> git status
> gitk # gitk is back to normal again, showing no local uncommitted changes
>
> The issue has been discussed on stackoverflow here:
> https://stackoverflow.com/questions/49990403/after-tar-untar-of-git-repo-gitk-shows-local-uncommitted-changes-not-checked
>
> Any chance gitk could be changed to so that it doesn't display the
> "local uncommitted changes" blob in this case ?
>
> Regards Jacob

I believe this is doing the right thing (TM) at the level of 
investigation that gitk uses to determine the status of the files. In 
particular, Git uses the modified time stamp as a surrogate indication 
for detecting that the user has probably edited the file (it's been 
modified at time hhmmss, right?).

Now as I understand it, the full (without limiting options) git status 
command does go and check the content of anything that's potentially 
changed (but it can be costly), and at that point the status command 
simply updates its 'Index' record with the new mtime after noticing that 
nothing had really changed. Meanwhile, gitk, being a continuously 
running GUI avoids the overhead of the git status (though you can force 
it) and does report the mtime change as being a potential file modification.

There is a separate discussion on the git users forum regarding the 
compatibility with other tools that has a similar root cause in the use 
and abuse of mtime as a canary for modification, given that the Git repo 
storage does not record any file times, so will get a (moderately) 
arbitrary mtime & ctime when checked out.

-- 

Philip

