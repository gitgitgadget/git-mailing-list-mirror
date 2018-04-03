Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 825321F404
	for <e@80x24.org>; Tue,  3 Apr 2018 19:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752525AbeDCTdN (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 15:33:13 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:35913 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751749AbeDCTdM (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 3 Apr 2018 15:33:12 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id B815D20FDE
        for <git@vger.kernel.org>; Tue,  3 Apr 2018 15:33:10 -0400 (EDT)
Received: from web2 ([10.202.2.212])
  by compute6.internal (MEProxy); Tue, 03 Apr 2018 15:33:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        content-transfer-encoding:content-type:date:from:message-id
        :mime-version:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=0pr7n1hQTmCo7hwSfpSBzbeffr2BtX7iAvar5VXPsyY=; b=X/V2IcKR
        15qVn6ZJvSMheBz2jp/wO7Ogmd1WXxv+zXT3fY9+txDgM4cAj66dNIIL9odsvlEb
        r8LNgbnzO4VzpGUv/aLFB75fOY+Jt7kMscFk5bpVJ9mJPTjpP2yE+YyQpwMtTQFl
        q5HJ7MGtWcCaMXidp91BX9W3uosQdj0Ci5315nbusMnrehm+HP0qaDiL2wRjqsid
        bCm3DSSmR06mkSlr1h3BxlGseXoMax7NzNqJQhswUg0Zd1HFpvSnb2Zjp4VQkg+/
        C6GMHd5vmlxAuNLs4tBGM6bHbZXnAqczYdHyD8FzUJs48yE8t6ZvVjLxhM9mnC4m
        dLEElsnPQWp6Fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=0pr7n1hQTmCo7hwSfpSBzbeffr2Bt
        X7iAvar5VXPsyY=; b=KOLLP1GbxQkAnKt9kqxOrfBjTa2R+L/9dBDGj8P4m0FSH
        GNdLiFb7ZuRpil41X2886bqE0Kbjc28OHcmdIuIqpvZobF0nObKbnZGpHV6uxvhA
        Yhd7p/YT7yMsPdIcLros5c285VULP5ZocaTbX7qMkXCRxZONYdEGF7RIcGr0drf6
        WUFous06IqkflgTbn4IbKtebzHwXh/GUDWiqsUce+7QjogFFWa5nl/sRtGK6lJcX
        flldaF1ILU7egwsmrjdtC/Iwx9kiJC2QuijoQzfd9CVqIiHFaX9nujSrOGNaVRMg
        JYO3JHgAjhTN/FCPtqgdf7WaPL4qLa4mY2R/EuOSQ==
X-ME-Sender: <xms:9tbDWhtQHMbN7tFON6o2vQs9UMq97KIwbpM739NIny-3cFN9tWzoyA>
Received: by mailuser.nyi.internal (Postfix, from userid 99)
        id 96A2D621B8; Tue,  3 Apr 2018 15:33:10 -0400 (EDT)
Message-Id: <1522783990.964448.1325338528.0D49CC15@webmail.messagingengine.com>
From:   Jan Palus <jpalus@fastmail.com>
To:     git@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Mailer: MessagingEngine.com Webmail Interface - ajax-bb419338
Date:   Tue, 03 Apr 2018 21:33:10 +0200
Subject: Timing issue in t5570 "daemon log records all attributes"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My understanding of test "daemon log records all attributes" is that daemon
process is started in background, some git command is executed and daemon's
output (saved to daemon.log) is compared against expected value. However
daemon.log is not a straight redirect to file -- it is being piped through fifo,
read by a loop in test-git-daemon.sh, additional processing is performed and
finally it makes it to daemon.log. All of this performed concurrently with test
execution. My question is how do you exactly avoid timing issues here? grep on
daemon.log is performed immediately after git invocation:

        >daemon.log &&
        GIT_OVERRIDE_VIRTUAL_HOST=localhost \
                git -c protocol.version=1 \
                        ls-remote "$GIT_DAEMON_URL/interp.git" &&
        grep -i extended.attribute daemon.log | cut -d" " -f2- >actual &&

how can you be sure grep operates on daemon.log that already includes all output
and not on intermediate state that is just being processed by while loop? Same
question applies to ">daemon.log" since shell might still be processing output
of previous test and its content might possibly land in the file after zeroing.

The reason I'm asking is because /bin/sh in my distribution (mksh) actually
manifests the issue -- test fails because at the time of grep output was not
processed yet (fixed by sleep 1 before grep). Also there is an issue with output
of previous test landing in daemon.log despite ">daemon.log".


Regards
Jan
