Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF87C433EF
	for <git@archiver.kernel.org>; Sun,  3 Apr 2022 02:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiDCCD4 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 2 Apr 2022 22:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiDCCDz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Apr 2022 22:03:55 -0400
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480CA6580
        for <git@vger.kernel.org>; Sat,  2 Apr 2022 19:02:00 -0700 (PDT)
Received: by mail-pg1-f177.google.com with SMTP id z128so5450783pgz.2
        for <git@vger.kernel.org>; Sat, 02 Apr 2022 19:02:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VkigTOCAo6+jedWlG9KtkTu3Ve412vb2ctXIvGfHN88=;
        b=vT2HaYy7U7xS/sFsrqTBnqLoCRyCxlTZoTk3uA35i4nmAlV9tkHSkVQEmrJ7QfB+uI
         OIWdrHanc/o2ctGAkPFEcRSqVdt21yU76w+dbZ08KKh+EiwpVPYsvtwgqdVAlBebsFqa
         incM/mVIkBcmW0JiZZtniu323tcFe4X7iVSXWqMkQH1MZY7BmX5Rn3zcksn4D+Wvey/n
         SwbErbo/14zj8ahPoXk/bZiiMhwHZxRbAc3d732KHwri9vNZBjqKA8yVbOvGA6xnN5pJ
         RTntB1LBo+nR2SuDNgIbsFQEQ5iKYK9qs0DsCtOSmC8Nl6jXadDSWZYH+wa1TJZTxeOW
         p/LA==
X-Gm-Message-State: AOAM533JNBoDxoWAFhMma4JC9D3NyPmtDaDxTAztstFJ5H1U4wd7JRX5
        dmmtltUGw2wrq7SQ/sEWkLq0KAXqRBrfGBnbjhY=
X-Google-Smtp-Source: ABdhPJyUOkATyDsS14UGGgR4UJVgFbq/2Or8yFtJijvSbXe+R39CTJ4iOMVeHjzDhz83donXqgfN6pMkMMWzuTgCIq0=
X-Received: by 2002:a05:6a00:3387:b0:4fa:9063:dfed with SMTP id
 cm7-20020a056a00338700b004fa9063dfedmr51417088pfb.15.1648951319563; Sat, 02
 Apr 2022 19:01:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220331091755.385961-4-shaoxuan.yuan02@gmail.com> <220331.86ilruqup6.gmgdl@evledraar.gmail.com>
 <CAJyCBORNQEN4WNfuYbO264qz0W6d-rbT6z=T_-AZF5jY36c1yQ@mail.gmail.com> <220401.867d89p6sp.gmgdl@evledraar.gmail.com>
In-Reply-To: <220401.867d89p6sp.gmgdl@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 2 Apr 2022 22:01:48 -0400
Message-ID: <CAPig+cRg09zG+mRKXE+EKgX-quP85yBi+RZcW=xiqfVs9Z=yAQ@mail.gmail.com>
Subject: Re: [WIP v1 3/4] mv: add advise_to_reapply hint for moving file into cone
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Git List <git@vger.kernel.org>, Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Tao Klerks <tao@klerks.biz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 2, 2022 at 11:15 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> On Fri, Apr 01 2022, Shaoxuan Yuan wrote:
> > I actually did use advise(), but I noticed that it prints to stderr
> > and ... nevermind,
>
> We've typically used stderr in git not to mean "error", but to
> distinguish "chatty" and non-primary output from non-chatty.
>
> So (leaving aside that we're unlikely to add advice to plumbing) if you
> emitted a warning() or advice from git-ls-tree you should be able to run
> something like:
>
>     git ls-tree -r HEAD >output-for-a-script
>
> And get the advise() on stderr, while the "primary" output is on stdout.
>
> There's a recent-ish (last year or so) thread where I think Jeff King
> explained this better than I'm doing here, but I couldn't find it with a
> quick search.

You're probably thinking of [1] in which Peff referenced an earlier
email[2] in which he stated his thoughts on the subject. The result of
[1] was that git-workree was changed[3] to use stderr rather than
stdout for its chatty messages, and (significant to this discussion)
CodingGuidelines was updated[4] to cover this topic, so we can now
refer people to CodingGuidelines.

[1]: https://lore.kernel.org/git/YaaN0pibKWgjcVk3@coredump.intra.peff.net/
[2]: https://lore.kernel.org/git/20110907215716.GJ13364@sigill.intra.peff.net/
[3]: https://lore.kernel.org/git/20211203034420.47447-2-sunshine@sunshineco.com/
[4]: https://lore.kernel.org/git/20211202223110.22062-1-sunshine@sunshineco.com/
