Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1AE920179
	for <e@80x24.org>; Mon,  4 Jul 2016 13:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753809AbcGDNul (ORCPT <rfc822;e@80x24.org>);
	Mon, 4 Jul 2016 09:50:41 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38070 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753752AbcGDNul (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jul 2016 09:50:41 -0400
Received: by mail-wm0-f52.google.com with SMTP id r201so116527944wme.1
        for <git@vger.kernel.org>; Mon, 04 Jul 2016 06:50:40 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=jnC+ar79HuS6khte0jB5xX9Om7f6c3zdrPUuFFUjUpg=;
        b=MEeuyIVhyApG5mk4M3zgDdTjeqqpK3tmnlxcLSk5BByy5X81RUe0b2RaGH7kqU2seJ
         RjAA3ZAtndOGNIjZhxAXy/Q5s+Le3uk/AM3j9PzW3637Sr94Vjw2xrbIQI+vZB4xeoK5
         wSP7JdupX3scf/BPY2Te2l/M8hBGbk9s6e9MngKO8CRXKkJG9PCvHpKVBs7PddV7K9X+
         +0dSKHsfdl8Y+gbdfbFA2kez3RwqaykbRME7mqUlurzTQko9F0BZun5QCm5HVwU7EchA
         6E64viIxMRM11GrotoWBDojOHrT7vmO+eiuAdL0XLpTttZKGEvsrH6kCTHcWv27rnZ8n
         WKqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=jnC+ar79HuS6khte0jB5xX9Om7f6c3zdrPUuFFUjUpg=;
        b=TWR7RwWrEAB7TmB4SG48O5tcbiQ97LoIbGD/YjQlG9TBOj/TkGmCuXxZ/8m3GpbgvX
         dqI4EE1WhHZV2BTvyg+a8AOGaJO+mlmi2NoBv0jO+zFXYvvV2vlLNXJUl9zUENORByCS
         DzBI8ZTBb1TdvJjK7c2aknPl01kNM24nLLAThFfX3vQBF0/p0TQ8R3ZhJGzgBwHZJbmH
         uwW4svEq9iY8XFKJXrb2RFVPuhWjNYnbJyrw+PkYCbVZe8alE6ZaqYpnFovhf1YZZlHv
         JyaGcdQBxvWi4gUkMr8gq5BSGcbw0Q3w1IR7t7CP5traj9SO2DiJdS8XRJukYlJ1a81R
         L03w==
X-Gm-Message-State: ALyK8tKhwdjSOn0C7cZnozx3yJ3QCGeyXfKX4aXr6AhT6iSCiFtnoc+L+K/o8KmJqqARCFjG6iYcaK40IM58Lg==
X-Received: by 10.28.73.86 with SMTP id w83mr10446213wma.83.1467640239496;
 Mon, 04 Jul 2016 06:50:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.164.69 with HTTP; Mon, 4 Jul 2016 06:50:38 -0700 (PDT)
From:	Yuri Kanivetsky <yuri.kanivetsky@gmail.com>
Date:	Mon, 4 Jul 2016 16:50:38 +0300
Message-ID: <CAMhVC3Y9iT9X=JbB5tguXm8MRX4v2fDEqMwrMuDR6TD2+2+HLQ@mail.gmail.com>
Subject: Git doesn't always add files to a commit (amend)
To:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

When intent to add a directory is made (`git add -N`), and then
contents of any but the first file is staged, `git commit -v --amend`
doesn't add it to the commit, see for yourself:

    #!/usr/bin/env bash
    set -eu
    rm -rf 1
    mkdir 1
    cd 1
    git init
    echo 1 > 1 && git add 1 && git commit -m 1
    mkdir 2
    echo 2/1 > 2/1
    echo 2/2 > 2/2
    git add -N 2
    # git add 2/1   # this file is added
    git add 2/2   # as opposed to this one
    git commit --amend -m 1
    git --no-pager log -p
    git reset
    git --no-pager status

I'm running git-2.9.0.

Regards,
Yuri
