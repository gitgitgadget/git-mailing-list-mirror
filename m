Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBE2C2BA19
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 15:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C495F2064A
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 15:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=booking.com header.i=@booking.com header.b="dhPPkbWn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438974AbgDNPW1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:22:27 -0400
Received: from mailout-201-r1.booking.com ([37.10.30.25]:44602 "EHLO
        mailout-201-r1.booking.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2438826AbgDNPWY (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Apr 2020 11:22:24 -0400
X-Greylist: delayed 441 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Apr 2020 11:22:24 EDT
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:cc:to:date:subject;
        bh=Sh0LWckyGQ4X9mY/P+9xKkbziGp1pRYRcH8iNCCz+GU=;
        b=R4eBiehxP1KwxJqspgd0JUF/sGowklPWEqL3Z22F+hZkfnUBV/cC7KLRCUiWV/bn99
         sQcTWHUeO54FYPg55jq79hSItOrwpJ6/AcS4hvy/U4cyHJYzOq+Ah9GXD8yRpMow8bzk
         w1i20zNZmEHyR/YTrN0llM6eKInixoBIlqaZBf5S+PITVY1u0a1GP15aPEDJgFY2iPoJ
         OHk5RJqZEfz5iFg+KlGayY3uzlkv7tQmUbz1xUgWXv6W/47XKH2r/JvRY/IqCeWFdkdc
         nAsem2j+ycz1paBI8xDJNXLHpycQM970llvzu6gge+AgFB4uvSWzu3+EuqqdiQlBhYqi
         FMKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=booking.com; s=bk;
        t=1586877296; bh=Sh0LWckyGQ4X9mY/P+9xKkbziGp1pRYRcH8iNCCz+GU=;
        h=Message-ID:From:To:Date:Subject:From;
        b=dhPPkbWn+VR8yYK0RWtlYFCZZxbVjoep2Ycdmb2n/cdeWOxcPd9EJu0jdaVsLSFpE
         iJuxKM8E7CuEiblv7A2W/8D8171eqwhdawzDpkVApPyC0iP+vCeKvMf7DAxyV3/as4
         lFxXHOVYp0CrJYOKa+pSJAs8edMCc1v3dSZzq7es=
X-Gm-Message-State: AGi0PuZhF7UqOaOPVTgi4R6VdMWpFnrmjaibb4FLBl8BlRzPgAOwSMvS
        DNBl4dagCEAfNj7iHdMxYtEKteNHGqt0lzCRh39px5a/VO0KnYlztM+Ok5C3JAn+UXqj9ZHYzn2
        tPtGhDzxTdr4e7QyQmtoO4FA=
X-Received: by 2002:adf:8b8e:: with SMTP id o14mr25905960wra.392.1586877295737;
        Tue, 14 Apr 2020 08:14:55 -0700 (PDT)
X-Google-Smtp-Source: APiQypIfBOHoL/kCSO0HU0moIPonrCY1sYdjWEq1TaYEkLBXwmB7f3t801d8BBm73n5c7x+bXSVQqw==
X-Received: by 2002:adf:8b8e:: with SMTP id o14mr25905943wra.392.1586877295520;
        Tue, 14 Apr 2020 08:14:55 -0700 (PDT)
Message-ID: <5e95d36e.1c69fb81.8d920.c2ba@mx.google.com>
From:   luciano.rocha@booking.com
Cc:     Luciano Rocha <luciano.rocha@booking.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com
Date:   Tue, 14 Apr 2020 16:53:52 +0200
Subject: [PATCH 0/1] freshen_file(): use NULL `times' for implicit current-time
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

Currently freshen_file() consists of:
  struct utimbuf t;
  t.actime = t.modtime = time(NULL);
  return !utime(fn, &t);

That, however, is permitted only on files that the user owns (for normal
users).

So on a shared repo with split-index enabled, we end up with the
warning:
  $ git status
  warning: could not freshen shared index '.git/sharedindex.bd736fa10e0519593fefdb2aec253534470865b2'

The following gives the same end result (updated atime and mtime), and
is also allowed for any file the user has permissions to write to:

  return !utime(fn, NULL);

So the following patch changes it to that.

I'm unaware of any system where those two are not equivalent except for
the permisison check.

Luciano Rocha (1):
  freshen_file(): use NULL `times' for implicit current-time

 sha1-file.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

Regards,
Luciano Rocha

-- 
2.26.0

