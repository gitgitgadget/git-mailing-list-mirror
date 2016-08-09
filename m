Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC78F2018E
	for <e@80x24.org>; Tue,  9 Aug 2016 05:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbcHIFrV (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 01:47:21 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:36250 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745AbcHIFrU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Aug 2016 01:47:20 -0400
Received: by mail-io0-f172.google.com with SMTP id b62so2568711iod.3
        for <git@vger.kernel.org>; Mon, 08 Aug 2016 22:47:20 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammant-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=NpW7a/q5mADeMqHszba8/nTgglF5Ikjryf1exRsi9rE=;
        b=i2a+nNcBKZlEuIBytKqZPIpxEh0RanSpi+G8oGWcTMIw/a+7TVVoN/dd42WEZWVu77
         PqQb1YrbltrFbXtZ1sXDiP9RCdeq3KV8vM6ZUa2Y8HMvN0A2c1Ek4B70S5Xioq/QWimq
         6Kxfd0EtdlqqLHbFyEHJ5djBf7RxZz+LRuLzMoRwpD0GUkdAS6zrSTTc5EtJcWhXLbKp
         bBxP3XmewfFwjeqQaeQMCLueHCK9mFI19ZFyNloeG6Zsr7ueuw/e7yy7gY4CCFlL0s3h
         hKq71TQ84khWeXyP9ZSiHXQomxXG9n/nn+EMzAnIQy0+0Xq33H/AChXVIWfZY3EEq2xh
         QzAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=NpW7a/q5mADeMqHszba8/nTgglF5Ikjryf1exRsi9rE=;
        b=N2A0s+URJXX3NGOXuk87lKnFLaA5+sJtIJ1Ljfi7gIpbsuVEfGiSqCjB7AnNEKil7G
         /qt6ktMWwIHyfq4UJV6U82ynjDCns98mBQiJ3VhvhHIhpPiuiJFRPwwXAT6M56aRCDN7
         ZLjvHgUuEeHmpDSlQIyA8HWJQUlHSG2HfEwrPhB5KWeoKBkWPlGCLpAIcr+Sk9UdF7VJ
         RYx/6nhYR53R2ICIODRwesPD7rv3q3ZtgtNzYy7KGaDxVOSK5repMPq3AkcujhDYm8ow
         5P0e0/QZl3p5WoQNIwpMeOPAJkcUOFP4c8uUWbEBvX/oe24pS3X2VieDcVgbdEoQQyVJ
         U9Pw==
X-Gm-Message-State: AEkooutE6BZsgRZEpeDCZLIP2UQSOThsbgh6yJIi060a++O5+S4S+9UyFoV7aqnM9Dku/rwgLmlxhRY1+llkBQ==
X-Received: by 10.107.20.206 with SMTP id 197mr109942610iou.103.1470721639326;
 Mon, 08 Aug 2016 22:47:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.51.18 with HTTP; Mon, 8 Aug 2016 22:47:18 -0700 (PDT)
X-Originating-IP: [65.78.25.171]
From:	Paul Hammant <paul@hammant.org>
Date:	Tue, 9 Aug 2016 01:47:18 -0400
Message-ID: <CA+298UiKf6heNPy-NZSfdx47jyS_aK+C8UX3vh6OB3_XE+pn=g@mail.gmail.com>
Subject: [bug] git-check-ignore and file names with unicode chars in name -
 sys-out filename is corrupted
To:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Reproduction:

  $ echo "*.ignoreme" >> .gitignore
  # (and commit)
  $ touch "fooo-€.ignoreme"
  $ find . -print | grep fooo | xargs git check-ignore
  "./fooo-\342\202\254.ignoreme"

You could view that git-check-ignore isn't corrupting anything, it is
just outputting another form for the file name (octal escaped), but it
doesn't need to change it at all, and its causing downstream problems
in bash scripting.

Of course this may get munged by gmail or a list manager. In the text
above, you should see unicode char "euro sign" to the right of a dash,
and the left of .ignoreme

Git version is 2.9.2

-ph
