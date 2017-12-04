Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9426820954
	for <e@80x24.org>; Mon,  4 Dec 2017 21:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752127AbdLDVXD (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 16:23:03 -0500
Received: from mail-yw0-f193.google.com ([209.85.161.193]:37779 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbdLDVW6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 16:22:58 -0500
Received: by mail-yw0-f193.google.com with SMTP id v190so188167ywg.4
        for <git@vger.kernel.org>; Mon, 04 Dec 2017 13:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kitware.com; s=google;
        h=date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-disposition:user-agent;
        bh=l8M+T76sPcYbOCaci5GeTbmEIWp5/OxAo0QtbO0Vyyo=;
        b=jiCton3hcLaCmK7TXu7FU0C9MGHgdx3IGfIubHkIem03zjsS5HLyegNXU/+J/2rbSq
         +d6mtD6zlC4Jz5TPJIcrRGr276GL69TM2uZ5vauO71+blel8pas4uiIjSw8YaWWTidfq
         g2F0ruPrENiJH+XdBFd0psXimtBS+Hs07vxF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mime-version:content-disposition:user-agent;
        bh=l8M+T76sPcYbOCaci5GeTbmEIWp5/OxAo0QtbO0Vyyo=;
        b=f+PyhO2dP4pb6TSZ7abkqF2QxUC6e/cls++1dNN6utn8Gv1EHI2qdGFP4U2ou7idCk
         bCaGt8v+m13mICibBYkkkrAMIygynjtciXh6q5dZqMg0G+T9HvBMCpn0YY8K0LRjZqXr
         057DgDu7rrBfxPtOmhgBcEdFAFT/ONkuTd+aTpiywVYn7SAkuYrkCx6boGHAxVYzKjLo
         +8z7wioGXroZIhA1B6/lEhiRRzIgdpHlgLrKXsx+Az+k84Zso1FRyKLn6Sfpx0eJfZJE
         UOPGYGRdOVaJ0PpH/9BHlvNCcPSYwn1qNI+Dk++F/4T22IZqdL2B/wEvv0DmaR1Hs4lM
         z6ZQ==
X-Gm-Message-State: AJaThX7/OluikTE2a+Q2fJhGBuhjBMqJCxqy33fL9gcdqnPZRFgAxMFs
        7v1m4zYJg3tn46QVBTcx5UOOJlLcOSM=
X-Google-Smtp-Source: AGs4zMbOmK+x1Y9cvasl8/hz1rqRIdKTXcVxka81cM2fLBIDuDVxTrMI06NJtqT7iZ2gI3UaMTsRHA==
X-Received: by 10.129.196.77 with SMTP id s13mr11426796ywj.393.1512422577176;
        Mon, 04 Dec 2017 13:22:57 -0800 (PST)
Received: from localhost (tripoint.kitware.com. [66.194.253.20])
        by smtp.gmail.com with ESMTPSA id 21sm6340874ywe.13.2017.12.04.13.22.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Dec 2017 13:22:56 -0800 (PST)
Date:   Mon, 4 Dec 2017 16:22:55 -0500
From:   Ben Boeckel <ben.boeckel@kitware.com>
To:     git@vger.kernel.org
Cc:     bmwill@google.com, brad.king@kitware.com
Subject: gitattributes not read for diff-tree anymore in 2.15?
Message-ID: <20171204212255.GA19059@megas.kitware.com>
Reply-To: ben.boeckel@kitware.com
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I've bisected a failure in our test suite to this commit:

    commit 557a5998df19faf8641acfc5b6b1c3c2ba64dca9 (HEAD, refs/bisect/bad)
    Author: Brandon Williams <bmwill@google.com>
    Date:   Thu Aug 3 11:20:00 2017 -0700

        submodule: remove gitmodules_config

        Now that the submodule-config subsystem can lazily read the gitmodules
        file we no longer need to explicitly pre-read the gitmodules by calling
        'gitmodules_config()' so let's remove it.

        Signed-off-by: Brandon Williams <bmwill@google.com>
        Signed-off-by: Junio C Hamano <gitster@pobox.com>

Which is tags/v2.15.0-rc0~120^2.

Our test suite is in a Rust project here:

    https://gitlab.kitware.com/utils/rust-git-checks

and the failing test(s) can be run using:

    cargo test whitespace_all_ignored

The test checks that when `.gitattributes` says that whitespace errors
should be ignored, they aren't reported as errors. My guess is that not
reading the gitmodules configuration also skips reading attributes
files. Is this reasoning correct?

Thanks,

--Ben
