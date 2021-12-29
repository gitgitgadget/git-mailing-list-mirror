Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8081AC433EF
	for <git@archiver.kernel.org>; Wed, 29 Dec 2021 14:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236904AbhL2OV7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Dec 2021 09:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233907AbhL2OV7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Dec 2021 09:21:59 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0771DC061574
        for <git@vger.kernel.org>; Wed, 29 Dec 2021 06:21:59 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id b186-20020a1c1bc3000000b00345734afe78so11841952wmb.0
        for <git@vger.kernel.org>; Wed, 29 Dec 2021 06:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google;
        h=mime-version:content-transfer-encoding:date:message-id:subject:from
         :to:cc:references:in-reply-to;
        bh=q8UZ6arbycHE2CpKfOtq3yBPUu7dFT+MHraGDQp/KL0=;
        b=KOo4+1bIF+A/8kWDWP/6IXxMMf2mNVGLBYTLw4yIhMvm1kM0vhYmoUTqUQD9PBE2tW
         5MCTPgb7A2oXemp0RcfgN5gM/TAFRvG0rmBKmvBX6U3rmE5N1uoA1zoHAq08xGP2hMyJ
         Q1PuiEc1GivJRW1Eg7+qsxcagCk4cBnYG4pJe9LAsIin4M7hqosHG21YUKFbPSDQ67qr
         EPEXxMA0isnaYgNpX3M2saUMihn5h6vTrWIAYtEkqjaGdr4EeXw6iZidVV2uhnu6ddLC
         G2XZLDerriy7wQdykq3Qwm1zmssU0dzfYGh/7cI5lXHr7+eB8kveNkCX/PfRQytl4hdP
         jgtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:subject:from:to:cc:references:in-reply-to;
        bh=q8UZ6arbycHE2CpKfOtq3yBPUu7dFT+MHraGDQp/KL0=;
        b=sb1HK4u7JwnD4BEKELS+ZHq9LFDbQNkuu4eQaRIicO4tQ61oXRc66hNI8omVQ68Dlm
         Fz8JQo14LgukNNp9KeBe2O2gQEEvpcMH9YdNW2jS7a8BImul0BIf4WmALaGZ7XJY3rU/
         aN+Nop7nJLwIuxPbOAlIRQ6IpMotqMJ/DYxr/oWcyIIOaVE9a+szIecwwFpEgwms0Y6+
         YM2un6XEcjf8emFzhzwi7C8gK+F7Fo5wV4Ia7xQiAAJnViIx0Uo7FqVDlHq8UM9WzzP9
         tHfcQ9kp1LF4whAqwNKPVYF+cO+hEgPQyQvi8V5z7KliMDJbNxnEoP8dW0d6pDhEcTtp
         2SDQ==
X-Gm-Message-State: AOAM531dzGoBRDC7fZ3gYvvIJfH1YSgXLlpDeHrXTDIcsJXq9gBeGPhG
        odk38oJaAGvkGdJOLcB7aG+iMA==
X-Google-Smtp-Source: ABdhPJwqJYuDbGgeExE6uJjo2irj9A65mDHBMBh94TYL5GDvrIzvc4/eecCPjbmiaavxciOo3KCSag==
X-Received: by 2002:a05:600c:219a:: with SMTP id e26mr22502273wme.136.1640787717631;
        Wed, 29 Dec 2021 06:21:57 -0800 (PST)
Received: from localhost ([2a01:cb1d:312:bc00:141e:cf13:f68c:6ab6])
        by smtp.gmail.com with ESMTPSA id p11sm23579285wru.99.2021.12.29.06.21.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Dec 2021 06:21:57 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 29 Dec 2021 15:21:57 +0100
Message-Id: <CGRUPBBYR6GK.3FR53MJK5K0NT@diabtop>
Subject: Re: [RFC PATCH] receive-pack: interrupt pre-receive when client
 disconnects
From:   "Robin Jarry" <robin.jarry@6wind.com>
To:     "Robin Jarry" <robin.jarry@6wind.com>,
        "Junio C Hamano" <gitster@pobox.com>
Cc:     =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, <git@vger.kernel.org>,
        "Nicolas Dichtel" <nicolas.dichtel@6wind.com>,
        "Jan Smets" <jan.smets@nokia.com>,
        "Stephen Morton" <stephen.morton@nokia.com>,
        "Jeff King" <peff@peff.net>
References: <xmqqzgqd11dp.fsf@gitster.g>
 <20211110103525.171066-1-robin.jarry@6wind.com>
In-Reply-To: <20211110103525.171066-1-robin.jarry@6wind.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

do you have any remarks on this patch? Is it going in the right
direction? Should I send a non-RFC?

Happy holidays all.

Thanks!
