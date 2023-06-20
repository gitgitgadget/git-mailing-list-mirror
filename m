Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDB9EB64D7
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 11:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjFTL0p (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 07:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjFTL0o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 07:26:44 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0155810C
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 04:26:42 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-519608ddbf7so4758591a12.2
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 04:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google; t=1687260401; x=1689852401;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IQg96VgGmb0k6aWEan+751nZVlW2051HShsbaTDeCh0=;
        b=XKy6g6h/6e1s2na0MPVuF3PS/6TXKlJmVrzCi8y4JlufxXK0xDNU/PxS11UoLn6nmg
         DY5N/3C+8GG7ViIFKOKulUKGavYqPgun2fWaOd35vbLyPbefZ1iZaxKeIEQRZsDXXrPP
         +Vm7JGxcZWHlS9EHYQHBGjot8b+wrgBOLZkFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687260401; x=1689852401;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IQg96VgGmb0k6aWEan+751nZVlW2051HShsbaTDeCh0=;
        b=MK7mNiZxWHKwWMT1MM5NQ8ecn8gK2xG0m+n3EvsdZC3qzvKN8DWdjaMWlIESiPzgAH
         9L2oI7RUunFWUH/bwerwdKHSeUkyJdbHeAhB+NStFDwQ9vDouiHmz7TXEn898GVKKZHJ
         WESZCVJCgI6JuYJW5fb9AjIh4f9hCyyrMmxsvJqCOYMEtShj0xoLhJyK0hjM9unew5cX
         ufz9XvhRrFeU6hLD6nxOx9d11yged5dLXntMRTfbYZtzDJYqZKOq2u3u3vK7x4qXT0Gw
         4WsvWGsdp7V3SHDzVfk14aHDkQ9tjRtzwSjnrUB5k0OEkYt1hSMjSeL7rzaluq8xoonO
         ohLA==
X-Gm-Message-State: AC+VfDzyAnTQ07o+XExJMBNmeT6dPXCqJ4PSqj8UWMZolvfb1qSN5bSd
        HwlFpjtjAKPbNRqswTh0Ae5GD6ZgyEPyZVMCnXu5MX3eYKRiLDw0dBB1HA==
X-Google-Smtp-Source: ACHHUZ64+hreIe56C0PraY7BXou9qbBIZRyyTcC8SZi3UXFtenijOusStd+tOJrN0/TP+Luh5JaTnAI3h31ALfXT4bM=
X-Received: by 2002:a05:6402:481:b0:516:af22:bcc6 with SMTP id
 k1-20020a056402048100b00516af22bcc6mr7022418edv.21.1687260401113; Tue, 20 Jun
 2023 04:26:41 -0700 (PDT)
MIME-Version: 1.0
From:   Tao Klerks <tao@klerks.biz>
Date:   Tue, 20 Jun 2023 13:26:29 +0200
Message-ID: <CAPMMpohiTzANyhzL-mS-gg2kzbOEOiDktNbdwEXBKy9uL0-JgA@mail.gmail.com>
Subject: Determining whether you have a commit locally, in a partial clone?
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

I "discovered" today that when you're in a partial clone, naive tests
to check for whether you have a commit locally no longer work - they
fetch the commit on-demand:

git cat-file -t SOME_HASH_NOT_IN_REFSPEC
git rev-list SOME_HASH_NOT_IN_REFSPEC

I didn't realize this until today: even commits can be "filtered out"
by partial clone, so any reference to a commit that is not found
locally must be resolved transparently via jit-fetch.

I'm optimizing some stuff for users, so I need to know whether a given
commit exists locally or not... but I can't seem to figure out how!

I tried using "git rev-list"'s "--exclude-promisor-objects" option,
but I guess I don't understand what that's supposed to do. In my case
it just made a simple check like "git rev-list
--exclude-promisor-objects SOME_HASH_NOT_IN_REFSPEC" take forever (10
mins and counting).

I confirmed that removing (commenting out) the
"remote.origin.promisor" and "remote.origin.partialclonefilter" config
keys achieves my objective, but I can't figure out how to do it
safely; "-c remote.origin.promisor=false -c
remote.origin.partialclonefilter=" does *not* seem to work. The
existence of a "remote.origin.partialclonefilter" value, even if it is
empty, appears to override the "remote.origin.promisor=false" setting.

As far as I can tell, config values cannot be unset with "-c" - in
fact I see that credential.helper was granted special support for
empty string as a way of signalling "no credential helper" by Jeff
King in 2016.

So I guess I have two questions:
* Is there any way to run a single git command in a "don't use
promisors" context?
* Is the fact that "-c remote.origin.partialclonefilter=" doesn't work
for temporarily unsetting the filter a bug/issue to be resolved?

Thanks,
Tao
