Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9854C433F5
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 01:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C69560F45
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 01:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhJXBx2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Oct 2021 21:53:28 -0400
Received: from mail.archlinux.org ([95.216.189.61]:56234 "EHLO
        mail.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbhJXBx1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Oct 2021 21:53:27 -0400
X-Greylist: delayed 478 seconds by postgrey-1.27 at vger.kernel.org; Sat, 23 Oct 2021 21:53:26 EDT
From:   Eli Schwartz <eschwartz@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1635039786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=WUDyZUIpl3qUdV3NyhzXFNJkMOed+hXsS0vN+uMwupk=;
        b=g6Sbh671oa/cAJrpX62JfXVqPgwoPsZoXNKDNw8+r6hkrsOjCYLSZ0zc6UGkxZut9kJXh3
        kV8KWycbdtR9RzQyTk0woVwsgtZe0lUw7oo/uQWGHHwYfhJ2o7K9IJcheE+qy63toFQu9N
        pFk8MRuuYHwtVjNNY/BuSwcPyLeEN1n3qnlUNSVMUbg0r09M+i7HhVGjNOoJpUIUKl9jNy
        tfjCPsHZIVmOhTL0rGo/CknS1sojPL0/q7pcBph4JabAXgWtrgoD6Uq9aeNn5WfBgZhH7M
        +F1X5VJfcKjV2KjBl2qygwRYjt/o5qFYvHLE7uJjCli0RNKeUIZ31ZnU9eTqo+vFs0aIrN
        Gz4mcMVOetyTRzWsKDOXY9sipcNY2FtZ9Jk4ZiC6oIUGsJAuB8oLIaF07UlXP34PzwrsnE
        tYR7IMdKJttRWfseVDCc4F1z0aeEeb3phDqFOkT7YTa6vH4WRPlIMoZZAsQZ/opHo2P32i
        GHfulu1tGvVUpKY3Y1ZyaI7zayDDC9MXKPSdFAkSQj42a+by/n+G1IzHhE2AQcqH4Ac/Kt
        7SxahVwtL7SKa40hLZ6rdHdbB2hAUAGP44oMs3d9mBjsV7/4YUIoBT9xPXcx6MrOAKoyQx
        OiJ2evvCHVw9hsMKeIN1uI6pgK8v0GSH5coF8TXAiCQkPT2sbfcgI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1635039786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=WUDyZUIpl3qUdV3NyhzXFNJkMOed+hXsS0vN+uMwupk=;
        b=7eyuMrzupRh11xcJ42KhNBJVnF/ntbYeZWBn3ay8lUh9BS6NTjMzXNXlImWaVT9kgxptSc
        KPGrAxEzxo9yDvBw==
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH 0/3] Add some more options to the pretty-formats
Date:   Sat, 23 Oct 2021 21:42:53 -0400
Message-Id: <20211024014256.3569322-1-eschwartz@archlinux.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: mail.archlinux.org;
        auth=pass smtp.auth=eschwartz smtp.mailfrom=eschwartz@archlinux.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While discussing adding git archive support to a software versioning
tool, the issue came up that apparently many people (maybe in the python
community specifically?) use lightweight tags for releases.

While it would be nice if the current describe functionality for
export-subst was sufficient to cover the average reasonable use, this is
apparently not the case; at least --tags support will most likely need
to be added. The alternative is documenting a workflow change and having
the versioning tool raise some kind of error if you use the wrong kind
of tag, which is not an exciting requirement for the project maintainer.

In my initial proposal of the %(describe) feature I gave an example
using --tags, but it never ended up in the initial implementation:

https://public-inbox.org/git/7418f1d8-78c2-61a7-4f03-62360b986a41@archlinux.org/

So I figured I'd take a stab at it myself. While I was at it, I looked
at the options available to git describe and came up with a use case for
adding --abbrev support too.

Eli Schwartz (3):
  pretty.c: rename describe options variable to more descriptive name
  pretty: add tag option to %(describe)
  pretty: add abbrev option to %(describe)

 Documentation/pretty-formats.txt | 15 ++++++++++-----
 pretty.c                         | 31 +++++++++++++++++++++++--------
 t/t4205-log-pretty-formats.sh    | 16 ++++++++++++++++
 3 files changed, 49 insertions(+), 13 deletions(-)

-- 
2.33.1

