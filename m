Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3A6D20899
	for <e@80x24.org>; Wed,  2 Aug 2017 15:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752100AbdHBP4I (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 11:56:08 -0400
Received: from mail-qt0-f169.google.com ([209.85.216.169]:35305 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751773AbdHBP4H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 11:56:07 -0400
Received: by mail-qt0-f169.google.com with SMTP id p3so29337424qtg.2
        for <git@vger.kernel.org>; Wed, 02 Aug 2017 08:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:reply-to:mime-version
         :content-disposition:user-agent;
        bh=g1YbtWN2BjeerTaJxy/Szvp3dmNV9CIVLiYiEW+/GCc=;
        b=Qto3h1BHTNgdqdFmNAYvsUwAsdTSoaqYcZXp6/fAblx8EearRNFaGGlHYBgT+wCpSi
         +X1OKptf67087epwmy82gFVthQsM/+s2WCaHTM+Pu2oYJiVskknkHmM3DdR9E53PVoHx
         iEYMAwL5h/YuJJg5UVxV4jJn7HDikEVoaG1/d3EuXiTTd+vOB//Obd9436On2H7cAwrH
         dU6m49IHeCxJVLjlE4vvV2SFB/WwwTxghygFXBxiAvH8tYmgMukeZq0NNOimkIUg8AkH
         chs9SzehA1c1FzCFoB4zNlP1nVs2fgqwWEYCT/ohbmLLl0giVhz7dSVQi28m95brUQat
         QfxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:reply-to
         :mime-version:content-disposition:user-agent;
        bh=g1YbtWN2BjeerTaJxy/Szvp3dmNV9CIVLiYiEW+/GCc=;
        b=V0Dwfu0qXweICUFI2AXvtIOlE6Z9+kz+j5MpwySRYODtstNKVpQPN0erFUebKPOgiX
         0gPsX0RqPF744zZsTzUC+WjprrCFxTv9pAqTdJaoRkow8d5JxZ1fZI4meeoRrkmEiyTL
         tW+cmqAfxI9Q6dhnvYb2rVJrlKD7UV4nbmENVE0e+cMelqi2iOXeBfe1Cktv5Dy/ed4Y
         igVB0OR9mQZtqA2H+dSNbDxLdJFli0CZ+JCzP3EcW9g6eznN8gMBOANUY1kAuK2Kx2G1
         dvOIysvmjrdqL7n4eKUgD+p5b3qcfsC2vF/wK3PPI+pIPyXfEeXS8H1K5eOisWK9Yp31
         ehhQ==
X-Gm-Message-State: AIVw111WMc6uf9L/yZvLuH2R4u2N89VhbVxfCwN+p0tjrJ4LhJ9c5FkW
        mrRos05EsLF4gqibs8Q=
X-Received: by 10.237.32.68 with SMTP id 62mr6705519qta.164.1501689366661;
        Wed, 02 Aug 2017 08:56:06 -0700 (PDT)
Received: from localhost (tripoint.kitware.com. [66.194.253.20])
        by smtp.gmail.com with ESMTPSA id m123sm23512471qke.12.2017.08.02.08.56.06
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Aug 2017 08:56:06 -0700 (PDT)
Date:   Wed, 2 Aug 2017 11:56:05 -0400
From:   Ben Boeckel <mathstuf@gmail.com>
To:     git@vger.kernel.org
Subject: git bisect "commits left" miscount
Message-ID: <20170802155605.GA31021@megas.kitware.com>
Reply-To: mathstuf@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

When bisecting given a set of paths, git counts the number of remaining
commits improperly. Here's example output (based in the git.git
repository):

    % git bisect start -- sha1_file.c
    % git bisect good v2.10.0
    % git bisect bad v2.10.3
    Bisecting: 1 revision left to test after this (roughly 1 step)
    [f7f0a87e0a27a1baaf782af7cec18fd23fdf35de] Merge branch 'jc/verify-loose-object-header' into maint
    % git bisect good
    Bisecting: 0 revisions left to test after this (roughly 0 steps)
    [5827a03545663f6d6b491a35edb313900608568b] fetch: use "quick" has_sha1_file for tag following
    % git bisect good
    Bisecting: -1 revisions left to test after this (roughly 0 steps)
    [39000e849970a554a257577dcb2fb844a523a1d1] Merge branch 'jk/fetch-quick-tag-following' into maint
    % git bisect good
    No testable commit found.
    Maybe you started with bad path parameters?

Note that it ends up with -1 revisions left and it doesn't end up with a
"this commit is the first bad commit" message.

Should git find the newest ancestors(s) of the given bad commit which
modifies the given paths and start counting from there?

I haven't bisected to find out when this was introduced yet (first seen
with 2.9.4; confirmed with 2.14.0-rc1).

Thanks,

--Ben
