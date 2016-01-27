From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v8 01/11] dir: free untracked cache when removing it
Date: Wed, 27 Jan 2016 07:57:57 +0100
Message-ID: <1453877887-11586-2-git-send-email-chriscool@tuxfamily.org>
References: <1453877887-11586-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Stefan Beller <sbeller@google.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 27 08:04:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOK9B-0002ie-Hc
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 08:04:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753930AbcA0HDo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 02:03:44 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35802 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753854AbcA0HDm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 02:03:42 -0500
Received: by mail-wm0-f44.google.com with SMTP id r129so132999416wmr.0
        for <git@vger.kernel.org>; Tue, 26 Jan 2016 23:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ul8CqBzkMQ00/5sR82+JrXnDKo/2Foza5dSaHxEj6q4=;
        b=Sy45tqUvoDq7TtBOt/Auwe5y8EA+IfA8AVwlr/gJ/ZKD05a3NnEFCuCnv4VNNfbu8k
         XZiAs1PhE0EKDybjz2Jojr3jIJ9ccV9KSR19GQQ/qfZhiHvxcgOLyknXo1hW0ZNl0csQ
         CHAHPJUlnYOUXY2WXH/WNlnCK28LjFOmLzQJgKKCEcKw8zAltU3oDEVcVXg04J7MoVJ+
         O3AaKDChEIB0t+rOEst41QY2s0Jg7yP2oUGlxWkCVhtd6TkRDOnyhQsrg8y2VmpCOJvW
         BeOnWcWUPjHgb3cVx+W/nwenr+pO1V+O88wP/5OAqRpA8lidBt8X6gfPCVgXlpXS+PbG
         zUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ul8CqBzkMQ00/5sR82+JrXnDKo/2Foza5dSaHxEj6q4=;
        b=kOAD/sHPD5WwRe2bCyLQbIrwE7u2C/TkSj1ylwAD10H+x7cpit/jqmsX/u2jMbkSS5
         O0TsEDp02p3SXcrrKNyKmA7VO/YOGMv/HPQq8GWKMk/MxCp747jTIIMk9iP6BsYSTnqJ
         Xvqmcr6Z2gYGTwS5JTBySNA4nGX8QRl8Xvpq1yA1gN0yRKNIMSpCh2Hf17WeQ80DH3ii
         qxveUShpJXMq1i1tZ97iAre8D4EsrhZfPaaAS7UFC/wUJGPdq4WWuwO5ZQf1tdyzrEk1
         Op09HPhFtpe2P3j59DS4oZlIBOqo+pdMIiBGd4Qe9I51Lw+xZgl9B8f431X2kO+50kJn
         vdHA==
X-Gm-Message-State: AG10YOR39SeVwXteRjKXmibzpWLyqdzAjmpjJ8AAIpOBTn7oAMdkdKw192tZo/gL3VoW9A==
X-Received: by 10.28.57.69 with SMTP id g66mr29965756wma.63.1453878221311;
        Tue, 26 Jan 2016 23:03:41 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 75sm6737569wmo.22.2016.01.26.23.03.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Jan 2016 23:03:40 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.181.g07d31f8
In-Reply-To: <1453877887-11586-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284876>

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
2.7.0.181.g07d31f8
