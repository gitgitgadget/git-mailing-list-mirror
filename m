Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA3FC1F803
	for <e@80x24.org>; Tue,  8 Jan 2019 22:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728790AbfAHWQS (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 17:16:18 -0500
Received: from mail-pl1-f175.google.com ([209.85.214.175]:41116 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbfAHWQS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 17:16:18 -0500
Received: by mail-pl1-f175.google.com with SMTP id u6so2538200plm.8
        for <git@vger.kernel.org>; Tue, 08 Jan 2019 14:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vewd-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=L+QwxWXDgbvQZVBFXNeP3rX104CaMPmktUU7BUs6Oog=;
        b=QvFRdJONY1UFj6Bsh5gbhPod3g9cmAyAIrCsxpHFOBHZwZF65EnMNMY1JH3xctlmFu
         lFIWBbrxeFU60PsMzSfL7PT434RcGPpyQ8gNDR6DnUyaBX78PnMPkZD5r1l3+Lnu6UI9
         gnAVkagyx2G8c2k4E0fUajhnnYXKbf6EnGLGv+gcFHwmz0r+YPz3KdldOr7WQStkvavd
         gNaPMcavwPaish16eEZ68UF9Yr8hr/ayBVggf8KGqmBtznUlGaxGAVbN7BeCukk5QEYr
         A7vOm0S/nVeoGLd1ZlqTjxA4aAXhW6EVsFjkDO+2vqx/2b2fdn2B0cB8MXGwAkKmd0Nk
         MhAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=L+QwxWXDgbvQZVBFXNeP3rX104CaMPmktUU7BUs6Oog=;
        b=GFWoaL7EoJzKHoozYk48uwgoFCYygwA5w5Ed45WZEiV6+ZZKAMTf1QZ0svqJFSr7AS
         XIvhIzx/yPAw4Nl/9wX6b1ZtifWqE6jM4xNVw2y+LcJjtmXoHJ8mj9wDfu6j4s8+xLGE
         6ncoBfiSq9/GO3WpQgADL71/fdDB2TEM7mqEfBaoKfOh/SIFYl+3U697DxQuDL0P84NT
         RY12EdKIuFf3ZtAz9S0Wacy7794gBkVGCU2j3ceoQ4jVvrcPWCes2Tr31imkg3ehd3iN
         IS4NaJDj5+vco5GVxXxnuwnmvRX3IIr30HByv++dYoUkQDPMXvusl4VkRorU9U5lnz8o
         RUJg==
X-Gm-Message-State: AJcUukd87PBHCU7V6IwH5e5Vq9S0APrI6uhRiGSup4h8Ei3pvdngm37Y
        KikI7qoM19Von5WaVpntWTzYD50+1q/ckPbPwZQR3kcG0os=
X-Google-Smtp-Source: ALg8bN48PspL49QJtYtIW1wzZ6jJT9Vo9iKj9/sOfN/eobh1mJDSIzxjOozxhDIeQOBYG1BGhUH8lqsSpMtzlg+swLw=
X-Received: by 2002:a17:902:7402:: with SMTP id g2mr3442549pll.198.1546985777458;
 Tue, 08 Jan 2019 14:16:17 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?Q?Tomasz_=C5=9Aniatowski?= <tsniatowski@vewd.com>
Date:   Tue, 8 Jan 2019 23:16:06 +0100
Message-ID: <CAG0vfyQeA3Hm7AsYgYtP4v-Yg0=rKXW0YYfg_emAwEscZha4VA@mail.gmail.com>
Subject: Regression: submodule worktrees can clobber core.worktree config
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After upgrading to 2.20.1 I noticed in some submodule+worktree scenarios gi=
t
will break the submodule configuration. Reproducible with:
    git init a && (cd a; touch a; git add a; git commit -ma)
    git init b && (cd b; git submodule add ../a; git commit -mb)
    git -C b worktree add ../b2
    git -C b/a worktree add ../../b2/a
    git -C b status
    git -C b2 submodule update
    git -C b status

The submodule update in the _worktree_ puts an invalid core.worktree value =
in
the _original_ repository submodule config (b/.git/modules/a/config), causi=
ng
the last git status to error out with:
    fatal: cannot chdir to '../../../../../../b2/a': No such file or direct=
ory
    fatal: 'git status --porcelain=3D2' failed in submodule a

Looking at the config file itself, the submodule update operation applies t=
he
following change (the new path is invalid):
    -       worktree =3D ../../../a
    +       worktree =3D ../../../../../../b2/a

This worked fine on 2.19.2 (no config change, no error), and was useful to =
have
a worktree with (large) submodules that are also worktrees.

Bisects down to:
74d4731da1 submodule--helper: replace connect-gitdir-workingtree by
ensure-core-worktree

--
Tomasz =C5=9Aniatowski
