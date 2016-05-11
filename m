From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 67/94] builtin/apply: change die_on_unsafe_path() to check_unsafe_path()
Date: Wed, 11 May 2016 15:17:18 +0200
Message-ID: <20160511131745.2914-68-chriscool@tuxfamily.org>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 15:22:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U6D-00069s-Vj
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:22:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbcEKNWr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:22:47 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32780 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932315AbcEKNUq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:20:46 -0400
Received: by mail-wm0-f68.google.com with SMTP id r12so9416039wme.0
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hNw9QI27cdOseJfL7R3auJqg5BeUe2/jd8hF+ujLBAg=;
        b=M4Z0cdyH8c5rVmv4ql6eFT7ycqHE4S1ZOfWbnu9y2kU7B3dr+h3iUevKWWKNCsqBv+
         cUwg+twQedQGnh2Mtsgxrh5QDAgn7cl+myRxawa+/Knd75SSLLC/yqHb0649UxZUOvvZ
         vIUGG3t6UzUDq2u9OaXBhyXx0m/KKopM2pjw5ugPKVi5AbNfYXKJlJ+eEUOGsmY5I3J3
         sjui3Hc3Om7ObOBfuokTH0huznV1CCkt9v/EhmOLuLuksgHBfzg0mTSy4ESAG82Y0zdm
         jbLzexJDRfMlwdah7dY1d3qYKlGsTAxnNBGv8lTg5h+Wf6gk5/bBN4JTlOQPxU/GsEZn
         Luwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hNw9QI27cdOseJfL7R3auJqg5BeUe2/jd8hF+ujLBAg=;
        b=YBofqHCtpleOxVfyZyCK5oD/RCkUYullFHwOolbrg9CNxWvgrW11Gp+R/ss7NWxdGW
         y+xFJfJG6hDmwqsDQ5m1RfRiP8lJPzZsHy5YtRz79Ptxhmjcbx+lSX/0pyxF4Lqx96QS
         ImqZd50hXUiJRWEFwXTyHbP7uPzC/2t7YDUQx/FDOsyYaCrIKQiOLInKnY4TRVW/OZ1u
         9uss5EB3zojI0PgIVWyKjcM292i0r5HFRACrCvSFEB4xE3cU06dOQHGcJcoPfQRL1MC5
         iQ+F0sNnaPg1009hWP3t7WajBXGiNWmn3X9R0fmjFtoV/qBjztvhsGPCFYJz9kTmw21A
         PW/w==
X-Gm-Message-State: AOPr4FVqtBaxGlYgQCklv5ux12Dy8NwQJlbM38lYIP+3R+apZ0qCxBWJjLpJSXXmYhMiEw==
X-Received: by 10.28.125.138 with SMTP id y132mr4373881wmc.90.1462972844891;
        Wed, 11 May 2016 06:20:44 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.20.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:20:43 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294318>

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing.

To do that in a compatible manner with the rest of the error handling
in "builtin/apply.c", die_on_unsafe_path() should return -1 using
error() instead of calling die(), so while doing that let's change
its name to check_unsafe_path().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 42b0a24..06c1c16 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3698,7 +3698,7 @@ static int path_is_beyond_symlink(struct apply_state *state, const char *name_)
 	return ret;
 }
 
-static void die_on_unsafe_path(struct patch *patch)
+static int check_unsafe_path(struct patch *patch)
 {
 	const char *old_name = NULL;
 	const char *new_name = NULL;
@@ -3710,9 +3710,10 @@ static void die_on_unsafe_path(struct patch *patch)
 		new_name = patch->new_name;
 
 	if (old_name && !verify_path(old_name))
-		die(_("invalid path '%s'"), old_name);
+		return error(_("invalid path '%s'"), old_name);
 	if (new_name && !verify_path(new_name))
-		die(_("invalid path '%s'"), new_name);
+		return error(_("invalid path '%s'"), new_name);
+	return 0;
 }
 
 /*
@@ -3802,8 +3803,8 @@ static int check_patch(struct apply_state *state, struct patch *patch)
 		}
 	}
 
-	if (!state->unsafe_paths)
-		die_on_unsafe_path(patch);
+	if (!state->unsafe_paths && check_unsafe_path(patch))
+		return -1;
 
 	/*
 	 * An attempt to read from or delete a path that is beyond a
-- 
2.8.2.490.g3dabe57
