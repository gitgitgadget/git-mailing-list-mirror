Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7DEC4332F
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 09:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiJUJ1A (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 05:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiJUJ0x (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 05:26:53 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4776C17F9BC
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 02:26:48 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id y4so1845870plb.2
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 02:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eSFwhQPVp3U9lKRofFKgJxsYrwworyl0As94JB3UGH0=;
        b=ZDH43O2t0VFurx/Ey6JkLNVXJtoIfPcNbY7X2vfVHqrNcrNNTu1uivwmNkdq/H3u5A
         zbSUJd0pKzf1dABYLx1dyezS5x/UYt3F1wTlCp3aPede/uz2Eac1h4t6qh6ySoBk6+eF
         Z50eAu4LK4+wpdKMRBYypp+nBV5GhyRxsP89OH9PGgagGKe9Z+AH/acgTdHtr0/9yumg
         usUitHAJxMCyMplC6x4oYNluZCq5FGXF34VxMgTUkn2Y8RDbr/B4JDUORqSRM1XKgCic
         dd41Nvk2Vfl6AHqdSFU1B1p/IfDFU+BOFRlRkBOPlXBsmLbx/eJt1hjjZutv24jAQNG+
         TNrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eSFwhQPVp3U9lKRofFKgJxsYrwworyl0As94JB3UGH0=;
        b=s8g0LaPpJhUhI4niHi+vW9kADIDMp3lAbxQQR2Fi379XorJreb5iOINh/hJz1FGQmV
         aUkMH3+GLUWHyG6Iir56Kl/SsYwqoSzPN6ghQkX74rJuhkKo7dqGdNoj/V4vQNPyGyyF
         nH2RDOABeQSKZsz+aRFPAh6Q+Z8wN90N1GW8xWNbXzoPZKUOT79vc8/o86XhsA/dabk6
         9j28kgmkCaPgz9m5fj966BWXQd2zEq0PxMMgCOGIfFWwOht2p0OfeTFibzTgEl/A/oYB
         vs3L204a3rfWp9PCiO8sgwqk0Qhse943fDGj/w6kUygTpmKjkZlZ3rQi/AYBtz2G01DC
         cSLQ==
X-Gm-Message-State: ACrzQf2s+0gfO33lA57DoiOIbfJyhD+syTSBoDwVXc3Fdg+29vDl8fiA
        Ls/9gVPnLsnMQ70C+HM0+RZlfQ8p/tURF/KuVo4NisPEnfM=
X-Google-Smtp-Source: AMsMyM7xX0T+mTCPyDjaWT+Gbx3XReCdXJ073BQYaWOSqEoRvuKkLR3aMg05igneIobWASVDP4/oABIE40maPOak0rg=
X-Received: by 2002:a17:90a:f016:b0:20b:a65f:af42 with SMTP id
 bt22-20020a17090af01600b0020ba65faf42mr21250302pjb.79.1666344407291; Fri, 21
 Oct 2022 02:26:47 -0700 (PDT)
MIME-Version: 1.0
From:   shubham sharma <shubhamsharma4060@gmail.com>
Date:   Fri, 21 Oct 2022 14:56:11 +0530
Message-ID: <CADUYy5vwfOJOFBQ+zUmkrsxGO=E9N5vUbsVRgjBn_MMY2X6H=A@mail.gmail.com>
Subject: waitpid errors with shell aliases
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I am using git shell aliases in config and was facing some weird
error. The error is not reproducible in all runs and occurs randomly
between runs...consider the minimal config(alias section) below for
usage idea:

[alias]
    A = "!f(){ \
        ( \
              // implementation
              git \"$1\"; \
        ) 250<dir/tmp; \
    }; f"
    B = "!f(){ \
        ssh <server> <command>; \
    }; f"
    C= "!f(){ \
        git A B; \
    }; f"

when firing "git C" from shell,in some cases(not deterministically reproducible)
i observed weird waitpid errors of the type :

error: waitpid for f(){         ssh <server> <command>;    }; f
failed: No child processes
fatal: while expanding alias 'B': 'f(){       ssh <server> <command>;
     }; f': No child processes
error: waitpid for f(){     (//implementation; git "$1"; )250<dir/tmp;
   }; f failed: No child processes
fatal: while expanding alias 'A': 'f(){        (//implementation; git
"$1"; )250<dir/tmp;      }; f': No child processes
error: waitpid for f(){    git A B;    }; f failed: No child processes
fatal: while expanding alias 'C': 'f(){       git A B;      }; f': No
child processes

can anyone please help as to what could possibly be the reason for this?

Thanks,
Shubham
