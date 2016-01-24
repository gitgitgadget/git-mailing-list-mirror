From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v7 01/11] dir: free untracked cache when removing it
Date: Sun, 24 Jan 2016 16:28:14 +0100
Message-ID: <1453649304-18121-2-git-send-email-chriscool@tuxfamily.org>
References: <1453649304-18121-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Stefan Beller <sbeller@google.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 24 16:29:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNMbX-0000vY-1H
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 16:29:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752542AbcAXP2r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 10:28:47 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32951 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752230AbcAXP2m (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 10:28:42 -0500
Received: by mail-wm0-f65.google.com with SMTP id u188so6828041wmu.0
        for <git@vger.kernel.org>; Sun, 24 Jan 2016 07:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kCj2K9h4nD1yOJEGo0MATE1Pv6Ue7akqew7ZzmGLD/M=;
        b=vgh1Xj7SVdZrl1h98IfoES4LSAqvsPlAJofa6Sn3kOMlu/t7yq7MsKSLq1AB2BvbvU
         Na8RkmZ2bycgF0axhZUKf6TxVfFjossoDRen0rbJUiC6feV+uvbCfLvLM9wtrAnQ+grz
         QId5YOIhsDaiL1A4SDs/QTT23YsQCqXXoxCFf64u3/5H/zSsfBQ7SKeTvmlryaBzuP6s
         9kwEqXJ5FmnWKXLsO5P2tCq7jqmGylcjUNf5KoQ92hk8tvp2c5XbWCiHGQP9bskzO5z0
         EJN0c/NMhAvLq0K7veOr+KJR06QcRqZ6kyTG2yxA0FhzgYR9uF2lOsp+4UcazoEAbMym
         B0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kCj2K9h4nD1yOJEGo0MATE1Pv6Ue7akqew7ZzmGLD/M=;
        b=TKyKxJvgu5+6iWguoPva/ivTFKtEE7JRDZWL39waeSr8jWmmBK8y9BDneFRFuRZ+U/
         xaLgVUHjGUJhjnvk6lw1QWiIC5oALnC2rY19MQpTtnqnS835GmheWMlfiLCkai3mAhHZ
         6qwKJmYx3AD6jTaHQUmH7SdVuKZ1yFmw+ZQkmdZ1qPRMMujxhI+nJ1aevAVT4o2r4n1L
         OmclajIbypSORZ49VHwIjHaaLLO93tBSxnLC6HNNthf8DaRhfXQX7gKxKip8MBxLVDGb
         5wIhIoKgQ0KnU24LeSEBBXNoz1JTXyZYPhPy5pxfkDfjFSZ8igWeghofmxxAuZhkPVk0
         fmQQ==
X-Gm-Message-State: AG10YOQryF6IZpsXvaDBFgzaSMKt9GcbqDLI2GhDp1nkUmaLduTZvs2wpuwCwYGEsVUxsg==
X-Received: by 10.194.77.235 with SMTP id v11mr13002809wjw.18.1453649321409;
        Sun, 24 Jan 2016 07:28:41 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id y8sm11900231wmg.9.2016.01.24.07.28.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Jan 2016 07:28:40 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.181.gd7ef666.dirty
In-Reply-To: <1453649304-18121-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284654>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/update-index.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 7431938..a6fff87 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1123,6 +1123,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		add_untracked_ident(the_index.untracked);
 		the_index.cache_changed |= UNTRACKED_CHANGED;
 	} else if (!untracked_cache && the_index.untracked) {
+		free_untracked_cache(the_index.untracked);
 		the_index.untracked = NULL;
 		the_index.cache_changed |= UNTRACKED_CHANGED;
 	}
-- 
2.7.0.181.gd7ef666.dirty
