Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC922C433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 20:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B3CB61153
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 20:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbhIKUdS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 16:33:18 -0400
Received: from mout.web.de ([212.227.15.3]:59167 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233907AbhIKUdR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 16:33:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1631392313;
        bh=xnMDP0xczVCP+WOlBKkOWb0AcCR7wGMZ0eHGplAv5uQ=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=OsKoPU/c4+fxOLq1EippxmFBo7jUPcTfWchKLAP3uOny+lBG9U3USmX4ZMVgtQHKD
         cUHYN1CmZ4ZQEa3C0boQF4MwJF5zukC+XF82cKjvWCPRiqnPxpCPUxbveAHnZUDabL
         s9UurS69utO0vMSq0Lsj6/gU+obB9jV35c+fBZVs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb003 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0MV4hR-1mQ50W1VT3-00YTLM; Sat, 11 Sep 2021 22:31:53 +0200
Subject: [PATCH v2 0/5] packfile: use oidset for bad objects
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <4a702bfe-afd0-669a-c893-0262289c24b8@web.de>
Message-ID: <e50c1465-59de-7fe1-de01-800404c7640e@web.de>
Date:   Sat, 11 Sep 2021 22:31:52 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <4a702bfe-afd0-669a-c893-0262289c24b8@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gUIZhKaOnY0+Qp9lm04zmKtIsCxW5DU0zJ76WGDE3Tq7QCVeV5I
 bRCCof0y9FSpGIMT79KflaKcXVwvOuO0VIjpLU39qFihC+X7n9ZTyjjLPJT2lTjROL/zSIx
 wYh23HqMoLRYoafkWc28lYwfMQEUADeBxnDqsQeWCL9OnhiRJu8HyN0JPcWeamAFeoAKk+2
 /ZxdOpCOesJ+tSjuqqYdA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:He8jZ5gwGiI=:lv7IH97EQFy+GwMhqDgPc0
 dfEBuNP23cg5O8bSmn3cDIrMaFgu22lBcK8ewPkn4Kxm1DNL3eBwlwU1ZjzBxYGTVw69ttVvN
 J3i4X12C4cbYaThs4ln/lMiqiJi+NtUs5/4B/UTH9CWc2AhP+O8i6RgWCZ9dR2VLrIj62533l
 7xBD1LNd2WU/0zDZQFRAZmHG30gPn2i4ZN53hzylX3DXqVuUGDXFVrmH7DUfxhMUxmuKTcroT
 jFmgNwiT2ex0TmBdsIhulqtAnRgJK6kvILo5+syUoVzLK6ijqWDVGtjki5DdhpCvPisj3DuPo
 cTkVo8ab5EwQ32tG1pNd9NmkytXXvdYljCPex9Y+rISHsVsmLxgJbB5Tz93cwsVw4UlDzMPQV
 SjkxBMJXnEorMz0a7DtoPmH3SEeSCNWwkqbhBijP+7ELL4Ko9fVmN28Yvjc/JfSv3lSUzI59M
 deKfLpAg7tEA6dBsj0TuPcePqKQfNvBE4ebmjIvQiti/2KewCfX8tUPgjPQqyRmt7IyUQyq3E
 cTqnrdNiCakgWWmCXKojU9whHCX1di12B7sUQW4sBsUt9S8LUndLOZmQ1pkQEiS/1CSgXvqu7
 D/irPN6ctlcMHCGeFBDWfUJ/GtR90c+oeoisVbMMLfUTiLyto1V+3n9WTzqHmDGdlcrCz01Bl
 xPB9NaX4hpYufHLWs0DHIt1AlnI/lVvKE3KkU+J4FM+mY5uqzcYOcOIqa4HfdkQgdg+3OAp3v
 W7D6z5hdPSyQrhbWmevQFXrZ1M79gWjVaHOJAA0vEYgi45kGYRilLGGAr8IQrXfbwuJg9QJpL
 DoRCtK4jUkcrZcaxuRe5nMk7fT2yL8YF7ycpnfqOPmhpedMZ0Du7pdB3TfBySURhUk2/hp0pg
 ZOiv850rsYgVKHewCe1z5zbcvI0sk0JQX4Lz7o1G4DsAOkNbS/KP3RjeMlMJ8WcVQnA9aEbP/
 jY33TTR8y0af0WgCm05ysk+Le4C+F8ul2jC7095x5FlJLi52Dj54VbY0hmHKRzS32dhpZPN8k
 +JU70Jl5Vud1w7DN1oXwtmSYjn3CT/LyzqGMKWnHr0PFL8WXJP9x+xlqjG7bskf5FyFvsBcNd
 nuT6aLGzIWpE+U=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace the custom hash array for remembering corrupt pack entries with
an oidset.  This shortens and simplifies the code.

Changes since v1:
- inline oidset_size()
- inline nth_midxed_pack_entry() early
- use oidset_size() to avoid a function call if no bad objects exist

  oidset: make oidset_size() an inline function
  midx: inline nth_midxed_pack_entry()
  packfile: convert mark_bad_packed_object() to object_id
  packfile: convert has_packed_and_bad() to object_id
  packfile: use oidset for bad objects

 midx.c         | 37 +++++++++++--------------------------
 object-file.c  |  4 ++--
 object-store.h |  4 ++--
 oidset.c       |  5 -----
 oidset.h       |  5 ++++-
 packfile.c     | 38 +++++++++++---------------------------
 packfile.h     |  4 ++--
 7 files changed, 32 insertions(+), 65 deletions(-)

=2D-
2.33.0
