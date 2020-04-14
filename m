Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F6BC3815B
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 15:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B048B2063A
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 15:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=booking.com header.i=@booking.com header.b="BNunNQbj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390847AbgDNPXW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:23:22 -0400
Received: from mailout-202-r1.booking.com ([37.10.30.2]:36847 "EHLO
        mailout-202-r1.booking.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390818AbgDNPXD (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Apr 2020 11:23:03 -0400
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:cc:to:date:subject;
        bh=pwhgHFoh/nxd89ybAQ6gkkwzo5Tj6EIH+H3tu7TcZnA=;
        b=KEbvkG7N6JCAUhe0kf4rnEdzQs3llYmTEVHmSlC8S7smBVqB8EK7StJB+bMXGybmP3
         VR09hgrqfN0F6w+RGNxs+Lf1ROpHd9T9RZPldmOVMZSTkdCk98zWJlv3c2rk029R6lg0
         0i7jW6moOiws0DR38TkhSVVMYTjXPnNnPM9v1tT/H8Srb3dZ8FhCEW7egLazSrseak4m
         J2N/mpsN68tHA0RFddTICuHxdUD8tEP1G0ZDroG0uzNgHMq5YRVGVyvasJgdny+jUlQG
         cjPm+oX7Z3RkK9qlTrjo12ACc/sZNUwaMfz445EylRtdUQhlyk/swE1DaBRAVc7DlXYA
         Mk7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=booking.com; s=bk;
        t=1586877311; bh=pwhgHFoh/nxd89ybAQ6gkkwzo5Tj6EIH+H3tu7TcZnA=;
        h=Message-ID:From:To:Date:Subject:From;
        b=BNunNQbjNwq1NFr9B5al5SqKTMhHXMZ+b8R0KXLqfAe7MBhz0y6GncNsxbaqmbdvJ
         zQpT4n+gIvTteGD5Up0n3zUbfZTuqncnw+MEDYgMwnZbJTrNVRQbPJajIt5PSaXAtP
         xgZtRB6tfRwwtbNkbGBOgEr7e5rlwiGBOAO7wJtA=
X-Gm-Message-State: AGi0PuY+nCheOUiaKqJPD2SI53NcLlvFg8Umcl9sXy2goG72CxJ7VwQt
        OQ7ZXpAJd2Qh7LGOWjZVOFh029yjAZ8+GLQO7SfGqyWdbPnwPabO7Y3GLKHBYdL+CyIhIyZIbvl
        BkYXaR0MVPFYYW9VLZdcPf60=
X-Received: by 2002:adf:80ee:: with SMTP id 101mr7806083wrl.156.1586877310161;
        Tue, 14 Apr 2020 08:15:10 -0700 (PDT)
X-Google-Smtp-Source: APiQypLGt/xtk9jOAv6HVp0VXfs2uZ+VvSTw65l73m9gdc604H226IGvO89iPMN+TvzKQqgQOEiqxg==
X-Received: by 2002:adf:80ee:: with SMTP id 101mr7806063wrl.156.1586877309935;
        Tue, 14 Apr 2020 08:15:09 -0700 (PDT)
Message-ID: <5e95d37d.1c69fb81.2b4ec.ce9f@mx.google.com>
From:   luciano.rocha@booking.com
Cc:     Luciano Rocha <luciano.rocha@booking.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com
Date:   Tue, 14 Apr 2020 16:27:26 +0200
Subject: [PATCH 1/1] freshen_file(): use NULL `times' for implicit current-time
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update freshen_file() to use a NULL `times', semantically equivalent to
the currently setup, with an explicit `actime' and `modtime' set to the
"current time", but with the advantage that it works with other files
not owned by the current user.

Fixes an issue on shared repos with a split index, where eventually a
user's operation creates a shared index, and another user will later do
an operation that will try to update its freshness, but will instead
raise a warning:
  $ git status
  warning: could not freshen shared index '.git/sharedindex.bd736fa10e0519593fefdb2aec253534470865b2'

Signed-off-by: Luciano Miguel Ferreira Rocha <luciano.rocha@booking.com>
---
 sha1-file.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sha1-file.c b/sha1-file.c
index 6926851724..ccd34dd9e8 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -881,9 +881,7 @@ void prepare_alt_odb(struct repository *r)
 /* Returns 1 if we have successfully freshened the file, 0 otherwise. */
 static int freshen_file(const char *fn)
 {
-	struct utimbuf t;
-	t.actime = t.modtime = time(NULL);
-	return !utime(fn, &t);
+	return !utime(fn, NULL);
 }
 
 /*
-- 
2.26.0

