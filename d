Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F204F1F45A
	for <e@80x24.org>; Sat, 17 Aug 2019 09:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbfHQJhG (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Aug 2019 05:37:06 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39390 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfHQJhF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Aug 2019 05:37:05 -0400
Received: by mail-oi1-f196.google.com with SMTP id 16so6561509oiq.6
        for <git@vger.kernel.org>; Sat, 17 Aug 2019 02:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=informer-com.20150623.gappssmtp.com; s=20150623;
        h=sender:date:to:from:reply-to:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=ac3Y7gP8uX4+aeNfk4Xl5TS1u6cKAruZgWqX1O6syaU=;
        b=wfejWEWFukEAvDcrc2sOrbg/xBG285RCJ6pUAleEo7XzCVqsjwdXQtRzdvMqb5vJWa
         OFT3ldlCxbv8zaAMFvfRnGiwh1IryAp7K+qkEUwjwpZL3aKU0CKGtaiQ01iLeChfo264
         +pW/SF2lUg48EIML/KsB6Fp8qxFXv3vNd3smlPYqn1WlfiFa7jQBChpsHGLMww9dBMeM
         mKHufeud7SPBsq1BoqTmq3keG0eZAHhVYMOZYDZmBtzY0hX+TLc9ZSi2FTVD0Z6OU0ZK
         orccIh8Kd7PB5wK69L/Sj8hDai0gK+0f4k2w9FflOgQ0ciSCCnq3OBJpxINeaYw25gzl
         h5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:to:from:reply-to:subject:message-id
         :mime-version:content-transfer-encoding;
        bh=ac3Y7gP8uX4+aeNfk4Xl5TS1u6cKAruZgWqX1O6syaU=;
        b=WMwCyyOKEwf4Tj7tfBlfJIv49on1YiEclL2ULA19mwn7Slzbo2CH8kzLsBrXZ116DP
         +xTLwe0K1o5yt17oQ8GCoN+8GHkZoLSfCQtoisMgkLvHL5wVUL16EUVXtxJZK97QbRbn
         9iyyDGyYaJMe217p59hzpvxj2ixexObpCadO1vNA9ImwKu1qQXRTQe0sQ+aMvph4WdNP
         ncbIrWYKlYTRMIQ3KRj2txvti3S97NZ/fCXare41L2tyJfZ6EZ09rZ9KmSsGYkyYdhvP
         PsJu+lhx0NypAWgWwL0k2YJ3mxX9a4vqax1fXTWL7jThp5b1OhIXK75v7Gw4Icskbj6g
         oudQ==
X-Gm-Message-State: APjAAAVbJjNe75iqRbb6koVw7vV9W4UqG2g/vzQSPxA40nD0i1hz92Sf
        i10b/XGaKfq7OHaQ3CPqOeeghj4FmsQ=
X-Google-Smtp-Source: APXvYqxibDFJOvozOfg3Au2MmO1HVjXaneV7wLh1fi0Tkfmwk96w2cmVVUL/Oxl9jDXVU7uSLakqBQ==
X-Received: by 2002:aca:ec87:: with SMTP id k129mr4167091oih.80.1566034624376;
        Sat, 17 Aug 2019 02:37:04 -0700 (PDT)
Received: from macdownload.informer.com ([208.88.224.100])
        by smtp.gmail.com with ESMTPSA id v1sm3022393ota.60.2019.08.17.02.37.01
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Aug 2019 02:37:02 -0700 (PDT)
Date:   Sat, 17 Aug 2019 05:37:01 -0400
To:     git@vger.kernel.org
From:   Elena Trubaeva <partners@informer.com>
Reply-to: Elena Trubaeva <partners@informer.com>
Subject: Git 2.22.0 is listed on Mac Informer
Message-ID: <207a5908c2798a7911508feef3316737@macdownload.informer.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="iso-8859-1"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Good day!

 would like to inform you that your product Git 2.22.0 is now listed on our web site https://macdownload.informer.com/git3/.

We would be grateful if you place our logo with a link to our review on your website. On our part, we can offer featuring your application in our Today's Highlight block. This block is shown in the rotator at the top of the main page and also on every page of our website in the upper left corner.

You are welcome to order a free video tutorial for your application as well. Once it's finished, you can add it to your website.

We also offer you to take advantage of our free storage by hosting your installation package on our servers and listing us as one of the mirror downloads for your application.

Please let me know if you're interested in any of these offers.

We are on the list of the world's 1000 most visited websites, so this could get your application some extra exposure.

Kind regards,
Elena Trubaeva


