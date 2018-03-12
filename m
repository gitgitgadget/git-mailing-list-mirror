Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D8FE1F404
	for <e@80x24.org>; Mon, 12 Mar 2018 18:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932176AbeCLScM (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Mar 2018 14:32:12 -0400
Received: from mail-vk0-f42.google.com ([209.85.213.42]:41956 "EHLO
        mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751312AbeCLScL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Mar 2018 14:32:11 -0400
Received: by mail-vk0-f42.google.com with SMTP id l123so6854911vke.8
        for <git@vger.kernel.org>; Mon, 12 Mar 2018 11:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=jWa9Hks+zYC/T9xGNn3ao+ODvgxiYGZmxZB1Omk866c=;
        b=ZwFsW5zq5zcX9qOebtCP46mvrunC4e4Fbqhc33ZpHPYN5ahqscDdz25+TuvfSS/rtl
         MK85RhKOliixx3NwhkjPoDwoSrk9MOmAC7Uzh/9vCDJ58RM9+Iz3fP9QVi3Ww3VwtHeN
         JLvXj95DoBjZHoBsaLuIBAa6uCaw+x+8jx+iHb8rw7vdMTfPzaJvkmAv84YSXzk0hCaS
         TDP8K3oiLzK1WLjcLJpJVRjuz1dambj+qVCbd0K0pugMbidnU7ambzgJp3pkpVaLKaXt
         bYy06th2ZpTDyB8hsLBzUDvK1iBjpaeAeZMcvmNz8dKlFwcZjmkSBTQC0CrjcuF8JWMK
         1RKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=jWa9Hks+zYC/T9xGNn3ao+ODvgxiYGZmxZB1Omk866c=;
        b=nJ7E69S4L3wO8da6ZknasxjQ+l8tEKNDDFfag9lQNlMwW93imGImpWabSFWOhWiCsl
         a6J1kVrGHfJsN3F5QC81wc0CAO+kdkA5wDtTMbwpPNVs05CxxJGtyGfAiH/hqBgL8EZ8
         riU1ldfl8zahMNaOpPqWrHNDFiLKK4CBSjS6yPPPgY7TEtwR0E/gUT2O2gkS9Vr/92kS
         5ino00EabYz5R0Jmjh2M9nAruLxykeUQ3tGWa+0khJFuJoKAp58aFMvJty+FI7SLzMLc
         Y7pzg91hcmCUgdNu3K5wbVj5NrVy92W3fSVTlVHWxayjxav5Q73UoamCZ0mhK8kK4TT5
         gi1Q==
X-Gm-Message-State: AElRT7FztR6F+2Bi8UhSOga1g7xxwfeOh9fdXZYp8PyQkk5cAHkAOx/z
        TZYDa6baEFyhSWfk1fut4OBVm8aaFt1z2mZuBP4=
X-Google-Smtp-Source: AG47ELsmjicN+FX5Hj/VaAYLux8RnyHtNk/4DPxl+cJx7afkF00kBkzp6W07GFK9EJIR+gWdPn+fHRSp1wHANSMEsCg=
X-Received: by 10.31.182.130 with SMTP id g124mr5685928vkf.187.1520879530353;
 Mon, 12 Mar 2018 11:32:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.1.49 with HTTP; Mon, 12 Mar 2018 11:32:09 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 12 Mar 2018 11:32:09 -0700
Message-ID: <CABPp-BEXcvgxcn4-OrDhjUpuOsGCJwE_XT+0eYOK4Ad_O5maOg@mail.gmail.com>
Subject: Opinions on changing add/add conflict resolution?
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

I'd like to change add/add conflict resolution.  Currently when such a
conflict occurs (say at ${path}), git unconditionally does a two-way
merge of the two files and sticks the result in the working tree at
${path}.

I would like to make it instead first check whether the two files are
similar; if they are, then do the two-way merge, but if they're not,
then instead write the two files out to separate paths (${path}~HEAD
and ${path}~$MERGE, while making sure that ${path} is removed from the
working copy).

Thoughts?

I have a patch series[1] with more details and other changes, but
wanted to especially get feedback on this issue even from folks that
didn't have enough time to read the patches or even the cover letter.

Thanks,
Elijah


[1] https://public-inbox.org/git/20180305171125.22331-1-newren@gmail.com/
