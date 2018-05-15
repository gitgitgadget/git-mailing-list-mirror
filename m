Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02D6B1F42D
	for <e@80x24.org>; Tue, 15 May 2018 10:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752606AbeEOKBi (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 06:01:38 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:51232 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752454AbeEOKBh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 06:01:37 -0400
Received: by mail-wm0-f53.google.com with SMTP id j4-v6so18329874wme.1
        for <git@vger.kernel.org>; Tue, 15 May 2018 03:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=mQwhoGk++h9Ov6ivgla/80NRO9dCVtENIPVPSoQ0dhs=;
        b=DCbNqOa+CZOItA6XKj3AwtJoD/8uNc0ZXfXV53BGK38HX4J8yLzaaGOfREexdGCOiv
         F9xqPgIoiYW8eh70RZEUZYsyx0Yk+WdqaViemMx1nmM1JY+Ozs4iYzXHfHEzQTJePat8
         6gJAyhmyOMFaQ5XPEZXkuMEmGAn1+WiP4sh1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mQwhoGk++h9Ov6ivgla/80NRO9dCVtENIPVPSoQ0dhs=;
        b=hqoDgjnb/bAG3F++hrXE+flzhV4DBxqibKtZoQEkHsW1PCYfe6mK2ioYJFje7G82mL
         omCpQBLmbQzufTnPdXG8Yw4aBU7+R80r9z4yDr+YwWHF+0yCl3Iq0bKUOJW31Bc6reLo
         MYXO/SxjIPRY/kOwmMnE2IYd0u5/01HceyUJLx7ZuBydPbkVse1bNnPeD+vnKZAocrbe
         5gJL1h72nUWmADeMNZ/+TCT3MhjDbYR9iVHiGLVgjerWK3UQEs7cr1xa8/f4bRVzv/CI
         FpmAiueAU6zNRKxpUu5WsmlcLD2ymVCSiuIftoKGqejTJrfuwClm3GTjMV4c5mB/TrAk
         z6sQ==
X-Gm-Message-State: ALKqPwf0ZN8ohuxDQVOPAo7XxJPemKzqt5dFos0r6zFsY6zg5ld+TsXw
        /4J+XmlogzMqrER4QAOuMYZc57I9
X-Google-Smtp-Source: AB8JxZqXKI8fOrqPJKnPE5QdZpnqEe95qrDShvRCh5B+8amHMemza6jQeoXEuxxMDEPyHDPbW/QDsA==
X-Received: by 2002:a1c:4a0d:: with SMTP id x13-v6mr7060402wma.150.1526378496399;
        Tue, 15 May 2018 03:01:36 -0700 (PDT)
Received: from ethel.corp.roku (cpc92728-cmbg20-2-0-cust351.5-4.cable.virginm.net. [82.29.15.96])
        by smtp.gmail.com with ESMTPSA id v18-v6sm13643418wrf.76.2018.05.15.03.01.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 May 2018 03:01:35 -0700 (PDT)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        Merland Romain <merlorom@yahoo.fr>,
        George Vanburgh <gvanburgh@bloomberg.net>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCHv3 0/1] git-p4 unshelve
Date:   Tue, 15 May 2018 11:01:28 +0100
Message-Id: <20180515100129.1454-1-luke@diamand.org>
X-Mailer: git-send-email 2.17.0.392.gdeb1a6e9b7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a git-p4 unshelve command which detects when extra
changes are going to be included, and refuses to unhshelve.

As in my earlier unshelve change, this uses git fast-import
to do the actual delta generation, but now checks to see
if the files unshelved are based on the same revisions that
fast-import will be using, using the revision numbers in
the "p4 describe -S" command output. If they're different,
it refuses to unshelve.

That makes it safe to use, rather than potentially generating
deltas that contain bits from other changes.

I have added a test for this case.

Luke Diamand (1):
  git-p4: add unshelve command

 Documentation/git-p4.txt |  32 ++++++
 git-p4.py                | 207 ++++++++++++++++++++++++++++++++-------
 t/t9832-unshelve.sh      | 153 +++++++++++++++++++++++++++++
 3 files changed, 356 insertions(+), 36 deletions(-)
 create mode 100755 t/t9832-unshelve.sh

-- 
2.17.0.392.gdeb1a6e9b7

