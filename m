Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95445E7E644
	for <git@archiver.kernel.org>; Tue, 26 Sep 2023 16:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234990AbjIZQBL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Sep 2023 12:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjIZQBK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2023 12:01:10 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAD6EB
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 09:01:03 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-79fb78e297bso207269439f.0
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 09:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695744063; x=1696348863; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/8vR/lNTilcw7w79etwoiczVpfCrHQGMmnSs8WqyYMw=;
        b=cskmozsX0GUKaETayKYr2Tgcv+ujPV/B5z0PIBqdiLXPaLtnZEmyIfYB9Y8i2esIHC
         Gh53odsPtznlv4wKr/VzINHM1GCMbgDbOFtmwULl26BeBgkLKabMohJM8raN+pNTj6kq
         OW3AOiJT1FIyaU/Bu3gJI4vr7T1C4EVgStOaeCVa39iKVb4yzdQECDKID9dUGYKrMvHn
         4KnHGAxTqzzWMgP1TfqVFONm90GTvKWHzITam72h38kQkbWv5WJpOJuSYNzaK2gbRwgv
         7Mr5aACgaQMBU2VR5F2gba3L+crD0+8yBB2a9MQrLeRBPI0QvBh1UZzm16ZCJnx4Bjv2
         5wig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695744063; x=1696348863;
        h=mime-version:user-agent:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/8vR/lNTilcw7w79etwoiczVpfCrHQGMmnSs8WqyYMw=;
        b=k6MODL9Pd09T0LkBPyuFGqJRxmxrOwD8KP7t0LrnDIcHiGo5cEhK0asK+DBZdQ82+n
         yRL/MShgKQQMh6EdUur+Hta0OpGnce7xvjUYWiUqyQoX+mXkH5bJUgyTMdmnZiOTp/mp
         4M7jBexngDzmQKaCeUUs1zNyYMRO8KoQum71jBwtuGP5tJTh81I5TYrbWe6/HE9uhcDd
         WcpLNAwrwk0l89ELZYZYBXF2vHJXvHByVZ+UrN/xr/2gjaNcaeyT3257g2mvnn68zWjg
         cIK1y/OUi1j+Bid3kenb69bXoLyccHXmj5HBCZjbWTjt5jWxlbWux/3t4rYHW+ClHeQQ
         9iLw==
X-Gm-Message-State: AOJu0YyqfHPQivwerPWqKX8qG300erlFPfh8isWLX3EOEUSs/xHyq+Bb
        O6oabAaXuW6djsWofNfILwPbLAwHIWI=
X-Google-Smtp-Source: AGHT+IEGI2BMmJVJkXSxN5ljahMp8syQ4DT6xcqX2YYKL6OVP7yMY5ih1/YsqBGXNnznf7mZFT4ZRA==
X-Received: by 2002:a5d:9c17:0:b0:798:2415:1189 with SMTP id 23-20020a5d9c17000000b0079824151189mr10087833ioe.12.1695744063004;
        Tue, 26 Sep 2023 09:01:03 -0700 (PDT)
Received: from gmail.froward.int.ebiederm.org.gmail.com (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id f7-20020a6b5107000000b00785cfdd968bsm758905iob.5.2023.09.26.09.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 09:01:02 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH] setup: Only allow extenions.objectFormat to be specified once
Date:   Tue, 26 Sep 2023 11:01:00 -0500
Message-ID: <87h6ngapqb.fsf@gmail.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Today there is no sanity checking of what happens when
extensions.objectFormat is specified multiple times.  Catch confused git
configurations by only allowing this option to be specified once.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 setup.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/setup.c b/setup.c
index 18927a847b86..ef9f79b8885e 100644
--- a/setup.c
+++ b/setup.c
@@ -580,6 +580,7 @@ static enum extension_result handle_extension(const char *var,
 	if (!strcmp(ext, "noop-v1")) {
 		return EXTENSION_OK;
 	} else if (!strcmp(ext, "objectformat")) {
+		struct string_list_item *item;
 		int format;
 
 		if (!value)
@@ -588,6 +589,13 @@ static enum extension_result handle_extension(const char *var,
 		if (format == GIT_HASH_UNKNOWN)
 			return error(_("invalid value for '%s': '%s'"),
 				     "extensions.objectformat", value);
+		/* Only support objectFormat being specified once. */
+		for_each_string_list_item(item, &data->v1_only_extensions) {
+			if (!strcmp(item->string, "objectformat"))
+				return error(_("'%s' already specified as '%s'"),
+					"extensions.objectformat",
+					hash_algos[data->hash_algo].name);
+		}
 		data->hash_algo = format;
 		return EXTENSION_OK;
 	}
-- 
2.41.0

