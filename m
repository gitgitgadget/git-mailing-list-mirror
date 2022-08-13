Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2FDC25B08
	for <git@archiver.kernel.org>; Sat, 13 Aug 2022 08:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238560AbiHMIqI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Aug 2022 04:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHMIqH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Aug 2022 04:46:07 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D19231909
        for <git@vger.kernel.org>; Sat, 13 Aug 2022 01:46:06 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id v2so4118891lfi.6
        for <git@vger.kernel.org>; Sat, 13 Aug 2022 01:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=sKGQoJxP4eQMW9r+fvHA7qX4AjTx1pB1WIP3oihbmwg=;
        b=Us1UHUy3sNlpvHr/rVpP0oQwcTQnn8VHV3ODPATFBwJzSlgnho/CWgoFgnVuCVKbdt
         PZEXLKkyp94smYCys9QaF/P4eMLaY6536YPAridvigSdW/XXTy3G+fk4A70EyiOMshSK
         6pi7/pD+NX91Tk0HIX3DIHKimiEgG45JlkUDRq5ekCIHSN6e+LDv1tknhqUe/BlZqmBv
         YGOXEKDZw0DUskLMQE2HZD0qITmWhzCv2QUfTJWKR+5VN98sernWLxLiiDVckeSbE2Q4
         rrjIBFbxeGjG2IAWRPV/VvrESKhqyGyYX/z2ENuS8O6KCm6Y3OX6264F0cwtFsvUbe9H
         46QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=sKGQoJxP4eQMW9r+fvHA7qX4AjTx1pB1WIP3oihbmwg=;
        b=2u1Ng5cajskMhdJ9V1vy8dNzIL3ouI3hsW01U/t+pvjXJqpwoOU/ylSZudhetlgq2P
         ThHUOenX+B3Lf9PG2HS++sXOB3dcbpRwAyVHQXFRAO4XRZNSjqMA1w77q0YrCzYjRXU0
         ILeFlp+H3Ou/5668aVNYxhQjxFQNyP8yabg/R0+je5bcE96LReMENuYJiDJZV6cSn+cG
         XMp5eabqsRAEpkF+H7zekjLcp49y7bHY9ofk2W4XpLhL/rG8F55ztVN9EIDbuOYCpzCS
         ErS9CSKoHm9J8+35RYBw08qELy6MRliIDz/DduXJ5TnQAYJD1BQqYd7mf7mrmlD5D/a5
         D+2Q==
X-Gm-Message-State: ACgBeo3vm3ZdjREGaXfshRQCDiUl54pkR9IyTy0P4RjA4Yfm/1b+bMs/
        py1sXKxrbjptp0NxWO+lcmZpXq778v3yvknMTpHr6AZE
X-Google-Smtp-Source: AA6agR5talqb0jZIDk206QVmxFoWOksXmHonzM3fr28Bvlkvp4oXjWligrM2FQBWBbzCdWTZSZyyOwTthlFmOI7UlL4=
X-Received: by 2002:ac2:5f77:0:b0:48b:38a4:2300 with SMTP id
 c23-20020ac25f77000000b0048b38a42300mr2295469lfc.445.1660380364319; Sat, 13
 Aug 2022 01:46:04 -0700 (PDT)
MIME-Version: 1.0
From:   demerphq <demerphq@gmail.com>
Date:   Sat, 13 Aug 2022 10:45:53 +0200
Message-ID: <CANgJU+VYSuEkU+V0WRpsTPv9iPYeDo52MeMHuD7-Yp4JnA60NA@mail.gmail.com>
Subject: "bubbling up" patches in a commit sequence.
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I keep finding myself using interactive rebase to try to find the
earliest place in a change sequence that a given commit can be placed
without conflicting with any other patch. When I am tired I do this by
repeatedly moving the given commit up by one or two lines manually and
then letting rebase interactive apply the new ordering, when it
conflicts I abort and stop and either leave the patch in its new
position or more likely use the "fixup" option to merge it with the
patch it conflicts with. Sometimes when I am more awake I try to do a
binary search pattern :-), but regardless the process is tedius. I
call this "bubbling up a patch".

In general I do this when I want to find a "fixup" pair that should be
merged together before the PR is pushed, but there are other reasons,
sometimes a PR contains a number of sub topics which are evolving and
using this technique  can help the patches related to different sub
topics be grouped together for easier review.

Anybody created tooling to do something like this? Or suggestions on
how to approach it efficiently?

For instance i would love to have tool that could give me a list of
the patches in my topic branch with information about which commits
they have to be after to not conflict (or some other way to understand
the "conflict properties" of the commit graph), and a way to move a
commit to the earliest position in the patch sequence where it would
not commit.

Please forgive me for not using the correct specialist git jargon for
these concepts, if there is any.

cheers,
Yves
-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
