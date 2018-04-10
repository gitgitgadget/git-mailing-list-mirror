Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D63F1F424
	for <e@80x24.org>; Tue, 10 Apr 2018 09:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752539AbeDJJ5E (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 05:57:04 -0400
Received: from mail-yw0-f181.google.com ([209.85.161.181]:45372 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752506AbeDJJ5D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 05:57:03 -0400
Received: by mail-yw0-f181.google.com with SMTP id r29so3795791ywa.12
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 02:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=weka.io; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=GGfVpcd5hifo376ealRurH/yiHrTuzjX5+HuqB6smYo=;
        b=t8szN0H2BPIYWqKqORU1fRcO4N5t10F3w3f7vcZR7L9uKA8/CpPCmmB9cIUHRaldWI
         aipUwjkKXV5zrYUtR+LCkLzXLpU2XWZWp0aQDbf239uHgcamwMkXJQllpaTzkrT5Febh
         3St+So27e/9CabhCmvAcl14euB4WvRkRJQ670=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=GGfVpcd5hifo376ealRurH/yiHrTuzjX5+HuqB6smYo=;
        b=YQ4j8ybl1IpGP/6XdlA8nO8uWnxFeAtHbuCYA0H6VHzhCh45J351MnHggdk/Cscrgt
         e7LPzgmn2Jt2nBRgv8is+TQ+nnPXlfizZUebOdo8VRffHwbB4XgsS+uct3RUDPHbjCF/
         oaZvUnDOeNHjHODhBGIUOozmKHfatLs7PFga+WUr1sBr7JGTetLQed808Li6+v1iBbF2
         rlv7SD4Yg8HT6F2jkgIc6Mison72q+K09/VziiiUsc3nD3LabTPzEwVDA+jk5R0+ZYoI
         c92YdfdCdBgeDf+bS9m1+v4WfQ+V0CFl7BfTon/yZxBtuYMSk0kf/UupS+XWC3qw7p7d
         UWGg==
X-Gm-Message-State: ALQs6tD0O7OaKrsWqcZ2cVixbnRz7RFDWBvWc7lDjPRvzeB3hK5zqVUn
        sl6pDo+vpRXV5XNn6c+0R9RuygQni7d7I5Vbq8IKYGaD
X-Google-Smtp-Source: AIpwx49MEBXrz3X1/GmrO9P+koTBGY0Ho/iStCUp77MzMNh0Qqp7ss8TqcJMujPIx2kSWi0ugOaaUlRkWtv5PuqDsV8=
X-Received: by 10.13.230.146 with SMTP id p140mr12971339ywe.22.1523354223048;
 Tue, 10 Apr 2018 02:57:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:a166:0:0:0:0:0 with HTTP; Tue, 10 Apr 2018 02:57:02
 -0700 (PDT)
From:   Ofer Koren <ofer@weka.io>
Date:   Tue, 10 Apr 2018 12:57:02 +0300
Message-ID: <CAOt29zrv1Wnu8ZWnY9NZS5J36=16r0t=gMCM3_94SFC_fovnfA@mail.gmail.com>
Subject: git log slow - due to fetching ref name prefixes despite format
 string not needing them
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

----------------
Slow:

>> time git log --oneline --no-color --format="%h %ae %at" bd4d00302a^1..bd4d00302a^2
1049ee2882 eyal@weka.io 1518954558
c0e107f167 eyal@weka.io 1518954522

real 0m0.119s
user 0m0.104s
sys 0m0.012s

----------------
Fast:

>> time git log --no-decorate --oneline --no-color --format="%h %ae %at" bd4d00302a^1..bd4d00302a^2
1049ee2882 eyal@weka.io 1518954558
c0e107f167 eyal@weka.io 1518954522

real 0m0.011s
user 0m0.004s
sys 0m0.004s

----------------
As you can see the output is identical, but the first execution is 10
times slower. Using strace I've found the cause of the difference to
be traversal of the '.git/refs/heads/*' folders.

Regards,

- Ofer Koren
