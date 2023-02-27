Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A46FC64ED8
	for <git@archiver.kernel.org>; Mon, 27 Feb 2023 19:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjB0TaS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 14:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjB0TaQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 14:30:16 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29830234FA
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 11:30:16 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-53865bdc1b1so160182927b3.16
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 11:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xEdEj0XkreXkSFIERfzFCp1235We/gNppzHpAx69y9I=;
        b=kPNHpic4Dbo9tMsl4Qgn6z31yI0wsqsCr3Mw31XCDNLWmuifT8iuA3CncQZuO4k96D
         FwUICb5R3c+Mzc8HoP1daopssXrhD439mJHA51pb+SQzZb3VI/LeqMKp7+M3QcUihstC
         SeLL54CU3AjuSmN8vPxMBHAWXhq5XkGbzAPBj81DQ9SDHZXj+Mv9jukIoaXgux4ZnvFH
         JHoBPqiehJn+bTzIPpDju6XClwCBKVqp6pb8VFFL1CUXti67GD/x+2+YgKJgBlWt4oFM
         3AIiAyYaITsGE2Jpms2677jcOTcYOHszE/8upcHerNAm08kqeDkvuOefG1EryVhTxnl+
         +qWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xEdEj0XkreXkSFIERfzFCp1235We/gNppzHpAx69y9I=;
        b=5rcyText826Mv1/EZbXg9FR9Zlh8eSZ/+xmCdnJKVfGRnpgSbMWHmyM3VVmMi0WmB3
         6TF0441qtgcGNa2ECAOO+b6SUgQvoCIS3p9vUV82Yel2SRO9hhOsML8S/YmWHswwUiRt
         e/g2zLcGGczhC5uKx9dydo7ye9WylEj/yR4YxgR042qHr6uEiscGngPqoIqNQbscRmo5
         vFil1e92VXcngkTfdr7tmxgcivWzDNwJb45a3J1iX7CWM9OZijNrAD4BriddvvrJyQxx
         apx8sNvORerVft52xEcQUVi534HYBTgDfsgVy2rn3VZoOTpzkqEhZJpFITD7I/9UC9e2
         7dsQ==
X-Gm-Message-State: AO0yUKXGFeeaAxvycXzH8r/4D5td+Xij452e7IIm95WtOExN1BW6BKjc
        rmswWK4s35qdvB2oILOJGDgMvsAvMIdBkhz1BFSX
X-Google-Smtp-Source: AK7set9/EF4zbLrNiDIXP0NunQ4xt6nN+L65lndda0TKeqIwK0ffp+fA0M91il0uIYF2ErRAvC1old3WMi1NtmJSWLxD
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:e547:b66a:7a19:4376])
 (user=jonathantanmy job=sendgmr) by 2002:a25:9e89:0:b0:aa9:bd2e:3744 with
 SMTP id p9-20020a259e89000000b00aa9bd2e3744mr252202ybq.9.1677526215377; Mon,
 27 Feb 2023 11:30:15 -0800 (PST)
Date:   Mon, 27 Feb 2023 11:30:12 -0800
In-Reply-To: <4e6aeffe-98ef-b4d7-7c8f-782e0a617653@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230227193012.2410973-1-jonathantanmy@google.com>
Subject: Re: [PATCH v4 1/3] branch: avoid unnecessary worktrees traversals
From:   Jonathan Tan <jonathantanmy@google.com>
To:     "=?UTF-8?q?Rub=C3=A9n=20Justo?=" <rjusto@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rub=C3=A9n Justo <rjusto@gmail.com> writes:
> Reviewing this, I noticed I made a mistake here.  The original code
> doesn't stop iterating whenever refs_create_symref() fails; it continues
> trying to update the remaining worktrees.  When the iteration ends, if
> any of the updates failed, then die().  Also, the error message "HEAD of
> working tree %s is not updated" is lost. =20

Ah yes, I noticed this too.

Besides that, a reviewer, upon reading the commit message, might ask:
why not take the worktrees as a parameter then, if we're so worried
about performance? I think that the real reason for inlining is that the
code being inlined needs to communicate more information to its calling
function in subsequent patches; the performance improvement is only a
beneficial side effect.

