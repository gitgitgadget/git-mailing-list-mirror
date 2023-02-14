Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4310C05027
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 10:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbjBNKvB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 05:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbjBNKuz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 05:50:55 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146004EC1
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 02:50:35 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id n10so12056890ejc.4
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 02:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LQZmbj6WX+vviKlhcjpqOXcA/YrFoNVhK3DyV9/iZAE=;
        b=ITl7KcuKzJl4DE25voJ/gW/kepH1GLBBUWw0ctfsjCKh3pbknKSg1FtkYxrX+9iMYy
         fDVKbUcpnHgsVfnJ/XOr6WVx5LeUFwooIsN5aTwmuRJJbBNATkmK6+Bkfz17norcagj6
         ZMiWUl1/CXE+YlHzAS7dx4ytiMJ6xJoolg8ig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LQZmbj6WX+vviKlhcjpqOXcA/YrFoNVhK3DyV9/iZAE=;
        b=lwW7P7af+CubJ/xNUPOyib+CrirzjotbssZnqvPv4tptduwV8NikkdGxfxbaDqihGR
         rrJrR6glI837TsjMrViGlHGxB14cEFaGeMuiV1w6wQExy8mMLohwMPJIAqNqJZ/QSAre
         oACvDcPE5yAAUzOH1APYoSjFl8ebQbW+YVTmHD/wOUJqeD/eIyuLCZtSDqmCnXPbQjlg
         5dwQiio92mtoudEp6Mn8B/ZjWCOnG8QZKbTlwHB7Nam5j86kg/VKV/ThEnu/zAkOTLtR
         PWHGQrSAVq03IiKqU96Xu3o4+IgOYDORMVg0Kd8+V2S5xuF9BBIB5wWDlNAbDn6v2lhz
         9ymQ==
X-Gm-Message-State: AO0yUKUczZUoE36vcuQTWnSWQTydrnOqPU2yESmu04hQa9ERyxtg+OAM
        VcX9Qp36uwNk4L0/zY8fg+sp/LpIGBlwtG4qoy62aLQ2fg9xw4PtrXo=
X-Google-Smtp-Source: AK7set89D2RFAyaP/YqiY8f4b/1y+T5yFBAlFgkplowMPtx6WH5BM/GaINKrEj6TG6Udi/TPkjLWtFRcqMVoI0WJhJc=
X-Received: by 2002:a17:906:3455:b0:8ae:b14b:4b9e with SMTP id
 d21-20020a170906345500b008aeb14b4b9emr1046841ejb.9.1676371833163; Tue, 14 Feb
 2023 02:50:33 -0800 (PST)
MIME-Version: 1.0
From:   Tao Klerks <tao@klerks.biz>
Date:   Tue, 14 Feb 2023 11:50:22 +0100
Message-ID: <CAPMMpohJ1gajTYOA9ZJjq=hASA9ry9fKP02TYH2dDF+VBeek8w@mail.gmail.com>
Subject: "git maintenance" - detect status?
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

I'm trying to understand how to expose "git maintenance" state to
users, and suspect I'm missing something:

I see in the doc (https://git-scm.com/docs/git-maintenance) that "git
maintenance start" does three things:
 * sets maintenance.auto = false in the current repo
 * registers the current repo into a --global maintenance.repo entry
 * starts the global schedule

Also see there that "undoing" this requires three separate steps:
 * "git maintenance stop" for the schedule
 * "git maintenance unregister" for the maintenance.repo entry
 * "git config --unset maintenance.auto to resume legacy maintenance

However, I can't figure out how to test the current state of
scheduling, from within git:
 * There's no config value representing "scheduling is enabled" (as
far as I can tell)
 * There's no "git maintenance" subcommand for "check on the
scheduling tasks" (as far as I can tell)

In principle I guess it's possible to check for the Task Scheduler
entries and their status in Windows, for example, but that sounds...
like relying on implementation details.

Is there any correct cross-platform way to detect the scheduling state?

Thanks,
Tao
