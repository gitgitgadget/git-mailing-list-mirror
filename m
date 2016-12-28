Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,URI_HEX shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F16462092F
	for <e@80x24.org>; Wed, 28 Dec 2016 17:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751936AbcL1RR4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Dec 2016 12:17:56 -0500
Received: from mail-pg0-f44.google.com ([74.125.83.44]:36630 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbcL1RRz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2016 12:17:55 -0500
Received: by mail-pg0-f44.google.com with SMTP id f188so157526798pgc.3
        for <git@vger.kernel.org>; Wed, 28 Dec 2016 09:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XhEad4r0tLTu3FnO+Q/3mtiZQ3XtjiYpGyyM6KFI+Hw=;
        b=r/JpDPgaJ6j3PCI4qF8ZFk1Bqeyz/i3jUdZMvZFQyU29zFOw68PTu8hi8dofJJm0/o
         Q+OUNGeYYA+nCnw7Eq2Urgdarayw0GF3DsULAC1PXdsRf5HeaZCjwM98qeEicmwWrIzF
         HUEZmsoKLHfsmA7j1OQyEZqUpKwjPt1y5kX3CkHldf41eiEoFx+oXfVyysUQsy9iZpr9
         Do+f3urxIV9f7Xb552qjQ6TYwJcDKVYygx2kMnGHpF9IdQ1vEbAbXy5ZUw6c391B7258
         FSgepXIWRED0nsE4WsyQFBcwdgfbRV8b5CpgGm+SpqZ2agZsehiluNPyz95Jz2+uyCxt
         ct0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XhEad4r0tLTu3FnO+Q/3mtiZQ3XtjiYpGyyM6KFI+Hw=;
        b=lmTx3RCVVfc9lMQ2UKEYnRYPxbJK8nyGiOmn/z+fWb3/n464HWD222snXh5XF+JmTP
         Rh9PtsJ9nQLd6M4OVyXg9Ntl/dbWPK/BL3luNnsGNyUEa4t6DJ3jjPBoRXJ3/0h5/5FY
         CkW55hogzvvcQd3rCWJ6nOD6DUXju4kS45IjQlJEuOtkw3xZwrLEitfqZlp3YVvSNCXo
         z8gJmBDZBk3Ds7F62D347xr9cFsgFNTWFWqDcKq9ObOggLq/BbdvBL028jMrNQ3VhDDc
         2A2Qn53q+4y0vsyrJKcedE21RbdjhVGsgi6rVbMH1sw2dqWE2XQwEcpezbZDB+lHUBwg
         p3kw==
X-Gm-Message-State: AIkVDXLdiGxa0zhKvN4qGnbv8KoDJNQJGS2JDV6soIO/rBHwEqHHKjEUWo22sAT3GhF8u3Bf
X-Received: by 10.98.52.71 with SMTP id b68mr35868559pfa.18.1482945474337;
        Wed, 28 Dec 2016 09:17:54 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:d4d5:954a:76bf:2d18])
        by smtp.gmail.com with ESMTPSA id q5sm23170461pgf.45.2016.12.28.09.17.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 28 Dec 2016 09:17:53 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     peff@peff.net
Cc:     git@vger.kernel.org, bmwill@google.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2] pathspec: give better message for submodule related pathspec error
Date:   Wed, 28 Dec 2016 09:17:46 -0800
Message-Id: <20161228171746.22859-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.259.ga95e92af08
In-Reply-To: <20161228055826.xu2gclwkvisbft6o@sigill.intra.peff.net>
References: <20161228055826.xu2gclwkvisbft6o@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Every once in a while someone complains to the mailing list to have
run into this weird assertion[1].

The usual response from the mailing list is link to old discussions[2],
and acknowledging the problem stating it is known.

For now just improve the user visible error message.

[1] https://www.google.com/search?q=item-%3Enowildcard_len
[2] http://git.661346.n2.nabble.com/assert-failed-in-submodule-edge-case-td7628687.html
    https://www.spinics.net/lists/git/msg249473.html

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Peff wrote:
> Don't you need to flip the logic here? An assert() triggers when the
> condition is not true, but an "if" does the opposite. So "assert(X)"
> should always become "if (!X) die(...)".

Duh! and it should compile as well. 

Thanks,
Stefan

 pathspec.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index 22ca74a126..4724d522f2 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -313,8 +313,11 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
 	}
 
 	/* sanity checks, pathspec matchers assume these are sane */
-	assert(item->nowildcard_len <= item->len &&
-	       item->prefix         <= item->len);
+	if (item->nowildcard_len > item->len ||
+	    item->prefix         > item->len)
+		die (_("Path leads inside submodule '%s', but the submodule "
+		       "was not recognized, i.e. not initialized or deleted"),
+		       item->original);
 	return magic;
 }
 
-- 
2.11.0.196.gee862f456e.dirty

