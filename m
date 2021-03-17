Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEC7C433E6
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 21:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6C9564F40
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 21:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbhCQV1Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 17:27:16 -0400
Received: from a0.mail.mailgun.net ([198.61.254.59]:50757 "EHLO
        a0.mail.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbhCQV07 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 17:26:59 -0400
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Mar 2021 17:26:59 EDT
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1616016419; h=Content-Type: Content-Transfer-Encoding:
 MIME-Version: References: In-Reply-To: Message-ID: Date: Subject: Cc:
 To: From: Sender; bh=5FqrWBm7wQN/sVpUphJlRrXqpkXxAI5UYZgIX02u1/E=; b=RUpkx3vbYYCndMOV0adeF9TNpnfn/0S8WlEZYAd06IGdBpWp5NmM9rgDeBj99nRsLBp5/dYY
 eMo4njGWEYMuJ+3Ea5uMA4YnDA7qVcvnyCSqMLYctXEd0seSEXPgEJjdq3mjO7FE3qiawAqS
 cw+25P2IHzlAAwey/cBx0nShw1c=
X-Mailgun-Sending-Ip: 198.61.254.59
X-Mailgun-Sid: WyJjNzk3NCIsICJnaXRAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 605272f221031618f656c28a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 17 Mar 2021 21:21:54
 GMT
Sender: mfick=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 54C2DC433CA; Wed, 17 Mar 2021 21:21:54 +0000 (UTC)
Received: from mfick-lnx.localnet (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mfick)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B98AAC433C6;
        Wed, 17 Mar 2021 21:21:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B98AAC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=mfick@codeaurora.org
From:   Martin Fick <mfick@codeaurora.org>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: Distinguishing FF vs non-FF updates in the reflog?
Date:   Wed, 17 Mar 2021 15:21:52 -0600
Message-ID: <5359503.g8GvsOHjsp@mfick-lnx>
User-Agent: KMail/5.2.3 (Linux/4.4.0-203-generic; KDE/5.36.0; x86_64; ; )
In-Reply-To: <CAFQ2z_MefCwiWdhs0buJv5Zok+nsgaOvUCcsSnfm_PP0WozZKA@mail.gmail.com>
References: <CAFQ2z_MefCwiWdhs0buJv5Zok+nsgaOvUCcsSnfm_PP0WozZKA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday, March 17, 2021 9:06:06 PM MDT Han-Wen Nienhuys wrote:
> I'm working on some extensions to Gerrit for which it would be very
> beneficial if we could tell from the reflog if an update is a
> fast-forward or not: if we find a SHA1 in the reflog, and see there
> were only FF updates since, we can be sure that the SHA1 is reachable
> from the branch, without having to open packfiles and decode commits.

I don't think this would be reliable.

1) Not all updates make it to the reflogs
2) Reflogs can be edited or mucked with
3) On NFS reflogs can outright be wrong even when used properly as their are 
caching issues. We specifically have seen entries that appear to be FFs that 
were not.

I believe that today git can do very fast reachability checks without opening 
pack files by using some of its indexes (bitmap code or https://git-scm.com/
docs/commit-graph ?). It probably makes sense to add this ability to jgit if 
that is what you need?

-Martin 

-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation

