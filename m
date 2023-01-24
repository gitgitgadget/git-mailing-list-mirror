Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9997C54E94
	for <git@archiver.kernel.org>; Tue, 24 Jan 2023 15:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbjAXPJG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Jan 2023 10:09:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233778AbjAXPJF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2023 10:09:05 -0500
X-Greylist: delayed 14854 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 24 Jan 2023 07:09:03 PST
Received: from mail.wijmailenveilig.nl (136-144-226-130.colo.transip.net [136.144.226.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F374671E
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 07:09:03 -0800 (PST)
Received: from mail.wijmailenveilig.nl (localhost [127.0.0.1])
        by mail.wijmailenveilig.nl (Postfix) with ESMTP id 4P1Vjn1F5DzGpJ5
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 16:09:01 +0100 (CET)
Authentication-Results: mail.wijmailenveilig.nl (amavisd-new);
        dkim=pass (1024-bit key) reason="pass (just generated, assumed good)"
        header.d=dulfer.be
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dulfer.be; h=
        content-transfer-encoding:content-type:in-reply-to:from:to
        :references:content-language:subject:user-agent:mime-version
        :date:message-id; s=dkim; t=1674572940; x=1675436941; bh=5uDO8+m
        uzmbRuUcs4c6fZg9DkGyEwTCJoBtfJENieoQ=; b=ufkh/poXIhXLmHHkqeLHkeL
        plifzEnc6meUnusBeAU7dZLXp8Lt33PxkkOtgv/Q+y2/3lfsLL0h8hzvlaYFeEwd
        yEkV+miZpiUv5pmlyJHxjiETj9nIpj93HlFoUYBC3nJqYtXg8xkd/S/cK+U5TlJb
        G3TaAL/D5SdRyZSLv9CY=
X-Virus-Scanned: Debian amavisd-new at mail.wijmailenveilig.nl
Received: from mail.wijmailenveilig.nl ([127.0.0.1])
        by mail.wijmailenveilig.nl (mail.wijmailenveilig.nl [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Irdf91pNitXZ for <git@vger.kernel.org>;
        Tue, 24 Jan 2023 16:09:00 +0100 (CET)
Received: from [130.89.172.17] (mobiel503eaa12060b.roaming.utwente.nl [130.89.172.17])
        by mail.wijmailenveilig.nl (Postfix) with ESMTPSA id 4P1Vjm3VFWzGp5n
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 16:09:00 +0100 (CET)
Message-ID: <9c3428f6-a254-13b4-046d-6e20ef602aef@dulfer.be>
Date:   Tue, 24 Jan 2023 16:09:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Inconsistency between git-log documentation and behavior regarding
 default date format.
Content-Language: en-US
References: <793c8116-f7ea-eef2-6979-231c3e94639a@dulfer.be>
To:     git@vger.kernel.org
From:   Rafael Dulfer <rafael@dulfer.be>
In-Reply-To: <793c8116-f7ea-eef2-6979-231c3e94639a@dulfer.be>
X-Forwarded-Message-Id: <793c8116-f7ea-eef2-6979-231c3e94639a@dulfer.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The Git documentation=20
<https://www.git-scm.com/docs/git-log#Documentation/git-log.txt---dateltf=
ormatgt>=C2=A0states=20
that if no date format is given (or --date=3Ddefault is given), the date=20
format is similar to rfc2822 except of a few exceptions, of which those=20
listed are:

 =C2=A0 * There is no comma after the day-of-week
 =C2=A0 * The time zone is omitted when the local time zone is used

However, if we were to compare the two date formats, you can see another=20
difference:

git log --default=C2=A0 ->=C2=A0 Tue Jan 24 11:03:47 2023 +0100
git log --rfc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ->=C2=
=A0 Tue, 24 Jan 2023 11:03:47 +0100

With the default, the month and day-of-month are switched around. From=20
my own quick investigation, this behavior occurs because of the=20
statement found at date.c#L266=20
<https://github.com/git/git/blob/56c8fb1e95377900ec9d53c07886022af0a5d3c2=
/date.c#L266>=20
wherein the month is inserted before the day-of-month. I am unsure which=20
behavior is exactly intended and whether this discrepancy was known, but=20
it would probably be a good idea to have a note of it in the documentatio=
n.
