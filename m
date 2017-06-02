Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4E5C20D0A
	for <e@80x24.org>; Fri,  2 Jun 2017 00:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751159AbdFBAPK (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 20:15:10 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34104 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751122AbdFBAPJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 20:15:09 -0400
Received: by mail-pf0-f181.google.com with SMTP id 9so40772927pfj.1
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 17:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ODgHSDASTu3JNHlwFxoPnxqRpay5FKEYdD2tfNBoJRk=;
        b=VTLVWibQTPRY+bn8gcp/OSCvZJU5GknildDxXgGn1LcOMs3wFJ68xyCPcUFznLjGb0
         XC2d9HOEMhAKGbXORw9/1intvh7Y7DTuajsvLoHiXDfTflk76//Wbxfko5FAhgvWN6ze
         RM6BYTOO7217lzGMYYLMXXuDtjuzVTg+H1VRnkYLeJ8oBprcfbbzGTmcHiOog8/PDPaS
         MZ/m+5nfaRo2f1M3+YOruVt7dW+h1pDrcTCE6H77BnHEUdLJfGsdc9bpGp+kMeg40LeG
         kZyBII8uHuMCUJvKBYZvuzFFQaU8Glbv8icrdvD0Tsdfl9g/nfTHYkEwxKZka5Y3BK8P
         yQ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ODgHSDASTu3JNHlwFxoPnxqRpay5FKEYdD2tfNBoJRk=;
        b=hye5jpgx/Vai2HRD3vWOBtpzScgkvdRHc0cOgpIR4g6jV2HUa9AWw5sM6Q/ZrtKPqM
         eXvC2VmlqW7Qs44SjtnAVsgXBxaq3fusCfSQtqEoOE60ey5ueGY91p+ogwbTuIrD5YgU
         J6hq2Pgz/RC2N1Xt0oQUE1YN062a3PixC67Wnyg5ysc+vvplrmIA85V0FxNSsfXlqJrB
         JVObwtl8vdf2LDmkE5ss3b7gfbvtO6wzEvRBhNdEtHZEUYBhcYZBQnT9Rl4F8Bpgzgrf
         ZazlnVnAggnb9774Nuhc7Bt+wboXx5FUuEAiF1Y6FICFZifaLp0PbF1lAhO2XcJWtsQj
         Fkdg==
X-Gm-Message-State: AODbwcDydZ3wQcqOZTJ9jTN8Kp87MzdPVLtU1SfV+R7ES/EcMvgx+6LU
        acK3TaZvtQUiECF7
X-Received: by 10.84.241.206 with SMTP id t14mr99285010plm.48.1496362509051;
        Thu, 01 Jun 2017 17:15:09 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id s23sm38046377pfg.81.2017.06.01.17.15.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Jun 2017 17:15:07 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@jeffhostetler.com
Subject: [WIP 0/2] Modifying pack-objects to support --blob-size-limit
Date:   Thu,  1 Jun 2017 17:14:53 -0700
Message-Id: <cover.1496361873.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.0.506.g27d5fe0cd-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I took a look at modifying builtin/pack-objects.c to support excluding
oversized blobs and reporting the exclusions that it has performed.
Here's a work in progress - it might be of aid to others who are working
on a similar feature and/or are modifying pack-objects for something
else.

The way I used to obtain a blob's size seems inefficient and redundant
with check_object() - if you have a suggestion to improve this, I'm
interested.

This is similar to [1] except that this reports blobs and their sizes
(after the packfile is printed), and is slightly more comprehensive in
that the read_object_list_from_stdin() codepath is also covered in
addition to the get_object_list() codepath. (Although, to be clear,
upload-pack always passes "--revs" and thus only needs the
get_object_list() codepath).

[1] https://public-inbox.org/git/1488994685-37403-3-git-send-email-jeffhost@microsoft.com/

Jonathan Tan (2):
  pack-objects: rename want_.* to ignore_.*
  pack-objects: support --blob-size-limit

 Documentation/git-pack-objects.txt |  19 ++++-
 builtin/pack-objects.c             | 163 ++++++++++++++++++++++++++++++-------
 t/t5300-pack-object.sh             |  71 ++++++++++++++++
 3 files changed, 223 insertions(+), 30 deletions(-)

-- 
2.13.0.506.g27d5fe0cd-goog

