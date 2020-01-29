Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD6BC33CB7
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 11:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04642214D8
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 11:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=diamand.org header.i=@diamand.org header.b="DLZpelr1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgA2LMy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 06:12:54 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:51890 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbgA2LMx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 06:12:53 -0500
Received: by mail-wm1-f43.google.com with SMTP id t23so5776251wmi.1
        for <git@vger.kernel.org>; Wed, 29 Jan 2020 03:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wMqHcrcLSPMqZkf5VHMswEGOIFRi+eVx1hStwAK4RsI=;
        b=DLZpelr1g60Ky30gFQYqQYF4CT2MQjqk975NyAWeGcik7//o8yiw0LXMao+RQV0OVA
         YYoURQp+0lLoa8egqAtT+ZGf1gz0C3v9yi5rr348FLGMF5zglzEjsBNjxJrmtePQg/Bw
         BnkIKMEAAd/gyOtRn79u/WKrOiy9g9Rt5oEoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wMqHcrcLSPMqZkf5VHMswEGOIFRi+eVx1hStwAK4RsI=;
        b=TCSUog5OxdyYMeYqjDev4CkrsgherG8giFlEUgSM/4PXfmffzVfskwMiIC9jYvwPQm
         t8svDx21lhwsIIsB50YZQ76/c/hBW/VIzwTO1S4DKRrj2itHVKdQu0ClrteGNTYNuQKv
         ZleugEPW16DcG5qWKdyQdmTvlzkWUrd/2wd95oFbdaXwIKVPTEi39YDZhJDE3evpqxnH
         Evrc1u3X6p/rEvWCzs6ixjL2VBP0TnoZzUDMPcTadaveRtII3rjckZv3Lz2Ytx2e/ulQ
         gJbtf1p5wqE5EXuHGDgWnhq0gU4rbK5QCmffxADfhym7FqPO6xnLgKd3syq9gp6/E3zs
         zQ1g==
X-Gm-Message-State: APjAAAVIk57fhfKbl0HsiHOKgOx6gChyVSnbq5sGK9Pu0qn48h2X6rQ8
        hv6PC0xWvHy18nwHWk6KpX8LxDfd5yM=
X-Google-Smtp-Source: APXvYqw5Xbm52vnZTZX8gbTK7909VBbFyVyk4mSEbEHZ0GnJ+ck+X6pTGogj9GntfTD6xGcsUIbJew==
X-Received: by 2002:a05:600c:54d:: with SMTP id k13mr3608525wmc.188.1580296371510;
        Wed, 29 Jan 2020 03:12:51 -0800 (PST)
Received: from ethel.corp.roku ([85.118.3.105])
        by smtp.gmail.com with ESMTPSA id z6sm2226241wrw.36.2020.01.29.03.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 03:12:51 -0800 (PST)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Yang Zhao <yang.zhao@skyboxlabs.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCHv1 1/6] git-p4: make closeStreams() idempotent
Date:   Wed, 29 Jan 2020 11:12:41 +0000
Message-Id: <20200129111246.12196-2-luke@diamand.org>
X-Mailer: git-send-email 2.20.1.390.gb5101f9297
In-Reply-To: <20200129111246.12196-1-luke@diamand.org>
References: <20200129111246.12196-1-luke@diamand.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ensure that we can safely call self.closeStreams() multiple times, and
can also call it even if there is no git fast-import stream at all.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/git-p4.py b/git-p4.py
index 40d9e7c594..23724defe8 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -3549,11 +3549,14 @@ def openStreams(self):
         self.gitError = self.importProcess.stderr
 
     def closeStreams(self):
+        if self.gitStream is None:
+            return
         self.gitStream.close()
         if self.importProcess.wait() != 0:
             die("fast-import failed: %s" % self.gitError.read())
         self.gitOutput.close()
         self.gitError.close()
+        self.gitStream = None
 
     def run(self, args):
         if self.importIntoRemotes:
-- 
2.20.1.390.gb5101f9297

