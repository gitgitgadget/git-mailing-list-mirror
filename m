Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E254E2021E
	for <e@80x24.org>; Wed, 16 Nov 2016 00:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752742AbcKPAVR (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 19:21:17 -0500
Received: from mail-ua0-f169.google.com ([209.85.217.169]:35473 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751741AbcKPAVQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 19:21:16 -0500
Received: by mail-ua0-f169.google.com with SMTP id 12so101561852uas.2
        for <git@vger.kernel.org>; Tue, 15 Nov 2016 16:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=j7oAnSUSF8PF9ccLEOK/FIfJKY5lUf+fMiJKJStlTX8=;
        b=FtdZuJWKc20UBj7XGTsWzbLAprT5dBVibCMwe6ljkwrQqdi/BfzWpQ9IMTcMWhOi81
         /c/7ZhiS8VQTn4qwWKwDolXCpcOMkTUNCJUHfa7zLWj1ZZ0G0wI47UEnieY1ftlTQ+U1
         p6YjzdLeZIEbvODL85bDnBSDgau869GRv58za+xc0i1hklTzqAxnX+ANen9MFlbNhfB6
         SIx9yUJ/1OyNBbmqEBIffj6siP9OAi8qdGMhBaDlvvoYxiBQsp2R3imggikBEaSLkSV1
         P+dMqsja6NYif7KHOLpTu/YYnqNuNyybUC/vrQaHDAW9M5GfAEEIzdPlPGNIKYWG47e3
         jWag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=j7oAnSUSF8PF9ccLEOK/FIfJKY5lUf+fMiJKJStlTX8=;
        b=eUmwTpDtfF2mmMUZjsYR6x2e40fuDCj6WeEeWACkkEiHKLz5np6l7xlONFI4hxc7JA
         +5yF/UAknEp7+RqcCS31XfVOBYKbU5OCJm0hz9Ur57h4+ZG9NdyXOKp1JSzf4BJZgsLo
         ESTg3bIbo3aGEE3rPv+Tr5+XapRQyO+wM5ssyp6QtunpcvFytk5NCEJgLvM0k/A2MKjA
         ZSrn2L7DRNqJteP/k2kXYLbm7+9VP4fuU4rnHGTyW1nbE0XelX3Bn+eUudhJI5GywtIp
         XGWt4RRIf6YBDfQHHC2bPutNY4WiR00cFHSIHEuLhokLw7FrQqF5CeNLPwUjcKEpkWb6
         Pd3g==
X-Gm-Message-State: ABUngvf5rooBZrNCEgmxO1LvIOm7uUQf9u8OJ5XS/0lHw8fxlQhD+B8rdrcqqWFRPTCrGm9gJI06ZYS8auDJ9w==
X-Received: by 10.159.53.107 with SMTP id o98mr58608uao.149.1479255674782;
 Tue, 15 Nov 2016 16:21:14 -0800 (PST)
MIME-Version: 1.0
Received: by 10.103.69.89 with HTTP; Tue, 15 Nov 2016 16:21:14 -0800 (PST)
From:   Douglas Cox <ziflin@gmail.com>
Date:   Tue, 15 Nov 2016 19:21:14 -0500
Message-ID: <CA+i4re65SsxcaLcpGyMDnJygQFmAq4X_x_uxrkqB0yqQkEYPUQ@mail.gmail.com>
Subject: Bug with disabling compression and 'binary' files.
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was doing some experiments today with large-ish (100-200MB) binary
files and was trying to determine the best configuration for Git. Here
are the steps and timings I saw:

git init Test
cp .../largemovie.mp4 .
time git add largemovie.mp4

This took 6.5s for a 200MB file.

This file compressed a little bit, but not enough to matter, so I
wanted to see how much faster the add would be with compression
disabled. So I ran:

git config core.compression = 0

I then completely reran the test above starting with a clean
repository. This time the add took only 2.08s.  I repeated these two
tests about 10 times using the same file each time to verify it wasn't
related to disk caching, etc.

At this point I decided that this was likely a good setting for this
repository, so I also created a .gitattributes file and added a few
entries often seen in suggestions for dealing with binary files:

*.mp4 binary -delta

The goal here was to disable any delta compression done during a
gc/pack and use the other settings 'binary' applies. Unfortunately
when I ran the test again (still using compression = 0), the test was
back to taking 6.5s and the file inside the .git/objects/ folder was
compressed again.

I narrowed this down to the '-text' attribute that is set when
specifying 'binary'.  For some reason this flag is cancelling out the
core.compression = 0 setting and I think this is a bug?

Unfortunately core.compression = 0 is also global. Ideally it would be
great if there was a separate 'compression' attribute that could be
specified in .gitattributes per wildcard similar to how -delta can be
used. This way we would still be able to get compression for
text/source files, while still getting the speed of skipping
compression for binary files that do not compress well.

Has there been any discussion on having an attribute similar to this?

Thanks,
-Doug
