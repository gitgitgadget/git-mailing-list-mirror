Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE0AC33CAD
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 13:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD8CF214AF
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 13:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgAMNl4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 08:41:56 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40480 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgAMNl4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jan 2020 08:41:56 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so8604497wrn.7
        for <git@vger.kernel.org>; Mon, 13 Jan 2020 05:41:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xgRmmq8CDVOD9TKvGj1CaR+G0uvVSpW/VyaTNHx2DS8=;
        b=YRkYP2WJhSvvqpVEkTYXH7/ZPUmK2MwVwF8YofcVM10pLrSwJ56/E6NoSvXvJmE90N
         ufj8sZWgOFufjU+dq5QH3OV6UF3OBm8KDS71S5v2Rb9gUz9eS3Eub0MlKnlUUvpPqMXc
         qUT70OD0uYAh4WUJ3r2DZiTwKlryfpXV6xECIUxUSLH7dMfSYv+uXwZzh96ia4Z+7Nnt
         XTtnVmW0XnasdxfyUgygPMLD2T3XkHIIS3ij8cbW0yg332AHlA7SGnLL6c9cQzenbRzz
         QdEwAr3E9tST6GCT6g9Tuei8W82Z9oM+oeR2o0g15Vxe7gUXpGv2WIsVO8vVcPov5GS4
         n8iQ==
X-Gm-Message-State: APjAAAVqMCyzKxUusDyj2sY2X8cknqheD58moTRviVo8DiuwFwDdrybb
        pFuvGC3BgsBhAOUbUlVLCnOGh0CckYmMUQnS27U=
X-Google-Smtp-Source: APXvYqxP38b30pg8aAKH15MssTOoKfnC+2bujKUJXt1n17nKvsiyQWEcwpZV05P6SR8dGRfKJRCpwKeu+kjFJDbAggg=
X-Received: by 2002:adf:db84:: with SMTP id u4mr19118764wri.317.1578922915040;
 Mon, 13 Jan 2020 05:41:55 -0800 (PST)
MIME-Version: 1.0
References: <20200113123857.3684632-1-sandals@crustytoothpaste.net>
In-Reply-To: <20200113123857.3684632-1-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 13 Jan 2020 08:41:44 -0500
Message-ID: <CAPig+cReDPs8D1L3+Z4sMn__JuU-Ezs+fOSF00=_tNxa0DotFQ@mail.gmail.com>
Subject: Re: [PATCH 00/24] SHA-256 test fixes, part 8
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 13, 2020 at 7:40 AM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> I suspect that t3404 also has a bug, since the object IDs that are
> supposed to collide do not, according to my instrumentation of the test.
> I'm unsure what the intended collision was and consequently haven't
> fixed it.  However, it does work with SHA-256 as it stands and is no
> more or less functional than with SHA-1, so I've removed the
> prerequisite.

The test itself is fine, but it is one of those unfortunate cases of
checking for absence of something (which is a wide net). As explained
by the commit message[1] of the patch which added the test, the
collision occurred only between short OID's. The patch[2] which fixed
the problem did so by avoiding short OID's in the scripted
implementation of `git rebase -i` (and also flipped the test from
`text_expect_failure` to `test_expect_success`).

The test, as currently implemented, is very much specific to SHA-1
since the FAKE_COMMIT_MESSAGE="collide2 ac4f2ee" it uses only produces
a collision with short OID's when SHA-1 is the hashing function, so
the prerequisite is correct and serves as documentation (even if it
doesn't affect the outcome of the test). Removing that prerequisite
should only be done if the test is updated with a different
FAKE_COMMIT_MESSAGE which causes a short OID collision when SHA-256 is
used.

[1]: 66ae9a57b8 (t3404: rebase -i: demonstrate short SHA-1 collision,
2013-08-23)
[2]: 75c6976655 (rebase -i: fix short SHA-1 collision, 2013-08-23)
