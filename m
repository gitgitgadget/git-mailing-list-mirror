Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C00820248
	for <e@80x24.org>; Tue,  5 Mar 2019 00:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfCEAEr (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 19:04:47 -0500
Received: from mail-qk1-f169.google.com ([209.85.222.169]:36532 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfCEAEq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 19:04:46 -0500
Received: by mail-qk1-f169.google.com with SMTP id c2so3860987qkb.3
        for <git@vger.kernel.org>; Mon, 04 Mar 2019 16:04:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=NdUwXIqkkru7Wl/rTVp0+slKl1ERzZ6sW6nOrTe+Hxc=;
        b=caAq3ETibt9jlsWgFCOok03kWbJU7fj9Mno7OhGeH6/ZP+DdWmsx5Z8zY89stioZsI
         vluwQFvEnGOOM+Gpv55uDyY1OLEB1LfoVTGnTweCVd3lrmPpX/blLagV9RWccMxEBQMx
         TcMgl7X2iT3oeSDWEsuw5/JZaqupSbkPFWSmahSt3tknFYK5s0chSAWbir6jquZZ/7/W
         j+oOz/qwzYV7y+UjqxGMVkhvvm19yqrGRQ83oqbxkF4ssD3eU1Biw3t1UU3NHneIP4Tn
         n02SQJbCLqVVKX63MMf6V5vVnDmiB0T8FCw2zZyK2osYJO7YH1UZ1bBgbzYbXRNu4coR
         iOrw==
X-Gm-Message-State: APjAAAVDv7g8/+t+FXPZDALfaO2ybtS11wdtlhmgmaeeQEJqp7dzBxOM
        JY+7oXvwQYXRy+Vl//KR2omX9UYC4Q==
X-Google-Smtp-Source: APXvYqwwcrwl++Tx/2vILubhY8s2pSdRL1VwiKrf9WFNxHdJCDOpHOKLhw6XdzhIBfwRfDznFPqbLw==
X-Received: by 2002:a37:de0b:: with SMTP id h11mr15448614qkj.238.1551744285472;
        Mon, 04 Mar 2019 16:04:45 -0800 (PST)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com. [209.85.160.182])
        by smtp.gmail.com with ESMTPSA id v80sm4927870qkv.34.2019.03.04.16.04.44
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 16:04:45 -0800 (PST)
Received: by mail-qt1-f182.google.com with SMTP id o6so7184895qtk.6
        for <git@vger.kernel.org>; Mon, 04 Mar 2019 16:04:44 -0800 (PST)
X-Received: by 2002:aed:3ef9:: with SMTP id o54mr16824645qtf.149.1551744284615;
 Mon, 04 Mar 2019 16:04:44 -0800 (PST)
MIME-Version: 1.0
From:   Patrick Hogg <phogg@novamoon.net>
Date:   Mon, 4 Mar 2019 19:04:02 -0500
X-Gmail-Original-Message-ID: <CAFOcBz=+XZtcxPxeE3j6dpHXA79R_BOyDCtNbwSu+nbBpPzGrw@mail.gmail.com>
Message-ID: <CAFOcBz=+XZtcxPxeE3j6dpHXA79R_BOyDCtNbwSu+nbBpPzGrw@mail.gmail.com>
Subject: Large object issue (Windows)
To:     git-for-windows@googlegroups.com,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

While investigating the last issue I reported (and fixed) I was trying
to come up with a good test case for repos with large objects. In the
process I found an issue on Windows with objects at least 4g large:

git init test
cd test
echo "*.exe binary" > .gitattributes
truncate -s 4g nullbytes.exe
git stage .
git commit -m "Test"
# This will break, complaining that the object is corrupt.
git fsck --full
# This will also break, complaining that the object is corrupt.
#git gc

I did some investigation and I think that this is a porting issue.
unpack_object_header_buffer in packfile.c uses an unsigned long for the
size. On Linux this will be 64 bits (at least on the Linux systems I've
tried) but on Windows it's 32 bits. The code then decides that the
object header is bad and bombs. However, if I move the repo to a Linux
machine it can handle the data just fine. (And ironically git generated
the object header when storing the object!)

Is there any reason not to switch the unsigned longs in
unpack_object_header_buffer (and its callers, wherever that may lead)
to uint64_t? (Or any potential pitfalls in doing so that I would need
to look out for?)

Thanks,
-Patrick
