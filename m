Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27C521F858
	for <e@80x24.org>; Thu, 28 Jul 2016 23:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752461AbcG1XgA (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 19:36:00 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34568 "EHLO
	mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375AbcG1XgA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 19:36:00 -0400
Received: by mail-oi0-f67.google.com with SMTP id c199so5962777oig.1
        for <git@vger.kernel.org>; Thu, 28 Jul 2016 16:35:59 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:message-id:subject:to:cc;
        bh=3knJROoo49harEh22a2hIf6b4/Hg7KoA1fO0PvpzExY=;
        b=HSa5egdMcfV/M26ldYEJYfycTLtpiYyHAgltqqNaLkDqEhrwvB9n9bD3ofHEPfiQHu
         bgHjgklpEclhLE72yoCLDd6MEAYYAWoWGWKixTJYE7rVYgkdt3Vw732cL4gJGMM4ZouX
         Y7l0We+lwhZWPCTUvwGl/dqvVrXWeTYrbudg05utTuHCEqMpzYlva986RErDrCxl6ZDP
         XHgVTjeyK5yveBawpVwf2kGfguqdEMfv/YnYBR2gC3l8fF9x0IUuSIyih5lvaMtwBm9N
         E36baQQ7/S62+/GOP+E+3tFi9DPi00fDU4595Nr6aEE181gOzCbpDG7+/3A28E3YDjP0
         uCDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:cc;
        bh=3knJROoo49harEh22a2hIf6b4/Hg7KoA1fO0PvpzExY=;
        b=CnglVGdZSE48fR/k1vxtqB5bv9Jkbazq03HEXiNxl3Kr0jrUHAqnP1nSQ253BjBo8I
         D0d1swWbWauGUkR/NPGnb4AVbbBs+syBNJJPnWKk0WxxoOsrxnHKuCQ35+siWFe3nvyM
         ofemltQe1VSa50a8+aa0uSxiBH1+ydIt/kDjTfltwSDNrenbY1GYlzvCBip3MkjbxaCN
         Cxc94luhMZXEJR6cSwoupHmwY8JM9AEauGJLyIajfikNr8wcS/iSgMczgijuDSyajE/e
         uBKONnVP82oplJqH5OdeEmnMRdZbhug8zRfRJF66jV18NLdZkJTSiNSzm6bWQqFcl0zr
         J2tw==
X-Gm-Message-State: AEkoouvSdzXLSigzYr40lQVCMTDeMhv+oGmAajM5f2Q388S2Gp+aMAqMo6J3qqRL6e+9GzApQIGG41yF1p/NdQ==
X-Received: by 10.202.223.132 with SMTP id w126mr22563051oig.20.1469748959260;
 Thu, 28 Jul 2016 16:35:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.204.35 with HTTP; Thu, 28 Jul 2016 16:35:58 -0700 (PDT)
From:	Linus Torvalds <torvalds@linux-foundation.org>
Date:	Thu, 28 Jul 2016 16:35:58 -0700
X-Google-Sender-Auth: YHolwNlADklHVQUHf2LCA56SMHk
Message-ID: <CA+55aFxaia7_VkKKF3JiQt76+z5goz3vCpmWi-wTyBH=iaw5ew@mail.gmail.com>
Subject: Small trivial annoyance with the nice new builtin "git am"
To:	Junio C Hamano <gitster@pobox.com>, Paul Tan <pyokagan@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Ok, it's no longer *that* new, but I only now noticed..

So I noticed that when I applied the last patch-bomb series from
Andrew, all the commit date-stamps are idential.

Now, it would be lovely if the new builtin git-am really was *so* fast
that it applies a 100+-patch series in under a second, but no, that's
not it. It's just that it only looks up the current time once.

That seems entirely accidental, I think that what happened is that
"ident_default_date()" just ends up initializing the default date
string once, and then the date is cached there, because it's now run
as a single process for the whole series.

I think I'd rather get the "real" commit dates, even if they show that
git only does a handful of commits a second rather than hundreds of
commits..

Something that just clears git_default_date in between "git am"
iterations, perhaps?

                  Linus
