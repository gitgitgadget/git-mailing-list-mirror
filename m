Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B58620248
	for <e@80x24.org>; Fri, 19 Apr 2019 21:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfDSVrZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Apr 2019 17:47:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55950 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfDSVrZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Apr 2019 17:47:25 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BC5A161528; Fri, 19 Apr 2019 21:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555710443;
        bh=KlEzeW1YFRpBRBzDHzCkX2MWavcZ7bEegUl5g9BW+7k=;
        h=From:To:Subject:Date:From;
        b=UGj9IvlQYuECkQpJjXL50LL5YYLGH2CXR1EKZwEVSQZpvVNi/kfaMsTzhj0DL33fJ
         dMu0SDd6560oIl1/3rpteGBbvLyTevpwsfTdBZo1v3hymrdk+KmELC1aguNwm9Vtr3
         MAsXpQvZ5TF4LAf3XRSYRpSBtlDYRotkyZaaRMmI=
Received: from mfick-lnx.localnet (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mfick@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 55722613A3
        for <git@vger.kernel.org>; Fri, 19 Apr 2019 21:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555710443;
        bh=KlEzeW1YFRpBRBzDHzCkX2MWavcZ7bEegUl5g9BW+7k=;
        h=From:To:Subject:Date:From;
        b=UGj9IvlQYuECkQpJjXL50LL5YYLGH2CXR1EKZwEVSQZpvVNi/kfaMsTzhj0DL33fJ
         dMu0SDd6560oIl1/3rpteGBbvLyTevpwsfTdBZo1v3hymrdk+KmELC1aguNwm9Vtr3
         MAsXpQvZ5TF4LAf3XRSYRpSBtlDYRotkyZaaRMmI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 55722613A3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mfick@codeaurora.org
From:   Martin Fick <mfick@codeaurora.org>
To:     Git Mailing List <git@vger.kernel.org>
Subject: Resolving deltas dominates clone time
Date:   Fri, 19 Apr 2019 15:47:22 -0600
Message-ID: <259296914.jpyqiltySj@mfick-lnx>
User-Agent: KMail/5.1.3 (Linux/4.4.0-137-generic; KDE/5.18.0; x86_64; ; )
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have a serious performance problem with one of our large repos. The repo is 
our internal version of the android platform/manifest project. Our repo after 
running a clean "repack -A -d -F" is close to 8G in size, has over 700K refs, 
and it has over 8M objects. The repo takes around 40min to clone locally (same 
disk to same disk) using git 1.8.2.1 on a high end machine (56 processors, 
128GB RAM)! It takes around 10mins before getting to the resolving deltas 
phase which then takes most of the rest of the time.

While this is a fairly large repo, a straight cp -r of the repo takes less 
than 2mins, so I would expect a clone to be on the same order of magnitude in 
time. For perspective, I have a kernel/msm repo with a third of the ref count 
and double the object count which takes only around 20mins to clone on the 
same machine (still slower than I would like).

I mention 1.8.2.1 because we have many old machines which need this. However, 
I also tested this with git v2.18 and it actually is much slower even 
(~140mins).

Reading the advice on the net, people seem to think that repacking with 
shorter delta-chains would help improve this. I have not had any success with 
this yet.

I have been thinking about this problem, and I suspect that this compute time 
is actually spent doing SHA1 calculations, is that possible? Some basic back 
of the envelope math and scripting seems to show that the repo may actually 
contain about 2TB of data if you add up the size of all the objects in the 
repo. Some quick research on the net seems to indicate that we might be able 
to expect something around 500MB/s throughput on computing SHA1s, does that 
seem reasonable? If I really have 2TB of data, should it then take around 
66mins to get the SHA1s for all that data? Could my repo clone time really be 
dominated by SHA1 math?

Any advice on how to speed up cloning this repo, or what to pursue more 
in my investigation?

Thanks,

-Martin


-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation

