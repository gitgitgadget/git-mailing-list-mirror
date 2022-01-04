Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5726C433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 19:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236436AbiADTCL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 14:02:11 -0500
Received: from us-smtp-delivery-195.mimecast.com ([170.10.133.195]:45209 "EHLO
        us-smtp-delivery-195.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234390AbiADTCK (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 4 Jan 2022 14:02:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datto.com;
        s=mimecast20190208; t=1641322929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=r/2HcCL8V6fO7IckjnHW0BKSZNvYA6rs2xDqdTvpS9k=;
        b=b3emMmaxnFVn0Oc8XOlqlGPWDt6cc355OjDyAkqjjHRem+IB2vkFzsU7WSdbHQQVqEukq8
        8+ry4JSFsLayS2ZEevBWoSAghUXgA8RStXe/b15onpHPL5PMMAZ5eaRCeQkZhdtAqqxuBS
        WgtQaR8LNUJmuOBP0XJQ+wHxbTos5ic=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-31-CHERq96-PzeG-kAG9ddlXg-1; Tue, 04 Jan 2022 14:00:38 -0500
X-MC-Unique: CHERq96-PzeG-kAG9ddlXg-1
Received: by mail-ot1-f71.google.com with SMTP id q24-20020a9d7c98000000b0056ea09fce20so9836770otn.17
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 11:00:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=r/2HcCL8V6fO7IckjnHW0BKSZNvYA6rs2xDqdTvpS9k=;
        b=ixyGGT4OEKrzYiXaaDd7wd6x39zktUVjHlQJTotohc3XR9kOpRmNbK3CJZLOy2cbO/
         omJKbsBlCvY6Om1AMgphHM0j5sgsJle2tF6MozcmBZg9zdPDdwB/iscq81IT7nBTsUC7
         DwT4+6q8HVBJLrEgXLcxwDXU1OSjG9bRM4PAW4vb6yYYAeF3g817GQQFogP75mQVrltG
         pAdqQjjMMJFq/5cGfrXvHOYJdAFXJAc/0e7RIbTrQWJ6ax+RHOFL+f1698GK0TP+H9Ly
         Exkl/mMOK1NRil8208EzZdl3KG1o6Gd7cVpsyBlkMSK+O/9Br0rBoWJRh5K7wEgNgrSW
         PHkA==
X-Gm-Message-State: AOAM533phn/JGifbPowvkDlPlBOQBbPhjWcBlU8xBaoRTLHREHtbw3OA
        dCfXRfj5rGYPPXwapWGGakdvdy5iYXWGsjwPySYjIMMoXcBvXUhrgPH/+f6PUUFJ/+PQbVFt2Az
        gy2JYuXbkwcWyX8jQCtRzS4DLrKwC
X-Received: by 2002:a9d:d68:: with SMTP id 95mr35439420oti.188.1641322837425;
        Tue, 04 Jan 2022 11:00:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz0hiOGWmpsEajxE0pOPMsoX6B9F5fgZC6BzQMI0waZOQpdQvtys+qBlLkndBmciNQj/eboblE8LQg74AAjlPg=
X-Received: by 2002:a9d:d68:: with SMTP id 95mr35439409oti.188.1641322837162;
 Tue, 04 Jan 2022 11:00:37 -0800 (PST)
MIME-Version: 1.0
From:   AJ Henderson <ahenderson@datto.com>
Date:   Tue, 4 Jan 2022 14:00:26 -0500
Message-ID: <CACEm96jjWALB=iPiBNr0P5HrX9Oo3bXm_k1PpxsHm4Ns9M-vOQ@mail.gmail.com>
Subject: Stash Apply/Pop not restoring added files when conflict occurs on restore
To:     git@vger.kernel.org
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA95A467 smtp.mailfrom=ahenderson@datto.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: datto.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have had two developers have this problem 3 times.  When they are
doing a stash push with newly created files and old files, when they
go to do a stash pop, if there is no conflict, the files show up as
expected, but when there is a conflict, the modified files are
restored (and placed in a conflict state as expected), however, the
new files are not restored.

We are able to work around this issue by grabbing the files directly
out of the log for the stash head, but are unsure why this behavior
isn't working as expected.  It seems to be a new change in behavior as
we had never previously seen this issue, but have seen it 3 times now
in the last few weeks.

We are running 64 bit Windows with Git For Windows version 2.34.1.windows.1

