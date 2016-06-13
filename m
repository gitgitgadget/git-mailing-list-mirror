From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v7 17/40] builtin/apply: change die_on_unsafe_path() to check_unsafe_path()
Date: Mon, 13 Jun 2016 18:09:19 +0200
Message-ID: <20160613160942.1806-18-chriscool@tuxfamily.org>
References: <20160613160942.1806-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 18:10:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCURd-0003g0-Mo
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 18:10:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424924AbcFMQKY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 12:10:24 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35928 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424915AbcFMQKV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 12:10:21 -0400
Received: by mail-wm0-f66.google.com with SMTP id m124so15998840wme.3
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 09:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CStfutIOavWORWpPxHdf8pSHTTHyEcjOEjAvV5/++pg=;
        b=a6qiQfpopgueSH0C8ZEUdsRh1M+Waj4WbPOYVRuyQZAfsckBWcVR655ECLoO3g8Eqg
         TXQScfMirbm+dbhhskSMQDmaRuLLQVeQ+Rw5l7vkdaOAb+Qacd6SxDjfSXbGxRwVjwXp
         KtgzAVsm8GQ1NDExGvllYmMpb1XOUoUEY/QMZCoK6MCPge3pNGIK1kvd7z5lNTffxEZ3
         8Zl4KyBFeVSZXn1F7Rx94g3AlD5TdQGsapw6sZ8tTEGSTLk1tM0fj1KYjrhf8s3cf877
         TZ4FC+wETm8S3rrGYBnN/nCtYOVKhd1EztvSnrLdoXiQn7hOAVqppGND0666D7Ab/7BY
         gqAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CStfutIOavWORWpPxHdf8pSHTTHyEcjOEjAvV5/++pg=;
        b=P64EuMJUKs9o06Av5y9ww7dWVpo+e/QF9LYPexNIN3rvPegYuMGGLzHqSYJmOwnpXM
         fQ8pU5P7lY4Fw8FvM1LWGhVLJ7lU2qGGECzpEQpt2Vs+Mx+iWJ0jL4yKkHevj8xfz8+n
         8sdj8qw75pWVZyWmGpACH3eFDsP8paV8xSebdoB4wrgSGmKKx8w3tS9GDRot85HLiYnk
         MwsE5UWxzBqTIsDMlPN16paiZMb7KRoEtVM2d4xfX3QD6pZ9lL+Hv9bXeTF+duPvfGX3
         gAZrUdVnaN0c3HQKD6jkBqpWfY+B/LI9PhF8lshybOmS6YZ3B3HolaFB99mymLOuAA8t
         vOiA==
X-Gm-Message-State: ALyK8tJm7XA1K+FVhHX1NM5hE+11Z3fbXH8GePLeL9dzfhKZ72/qqzURX66uHps0OroSsg==
X-Received: by 10.194.76.33 with SMTP id h1mr1887372wjw.43.1465834220153;
        Mon, 13 Jun 2016 09:10:20 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id g10sm6445369wjl.25.2016.06.13.09.10.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 09:10:19 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.411.gcd7457d
In-Reply-To: <20160613160942.1806-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297200>

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
index b506369..429fddd 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3697,7 +3697,7 @@ static int path_is_beyond_symlink(struct apply_state *state, const char *name_)
 	return ret;
 }
 
-static void die_on_unsafe_path(struct patch *patch)
+static int check_unsafe_path(struct patch *patch)
 {
 	const char *old_name = NULL;
 	const char *new_name = NULL;
@@ -3709,9 +3709,10 @@ static void die_on_unsafe_path(struct patch *patch)
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
@@ -3801,8 +3802,8 @@ static int check_patch(struct apply_state *state, struct patch *patch)
 		}
 	}
 
-	if (!state->unsafe_paths)
-		die_on_unsafe_path(patch);
+	if (!state->unsafe_paths && check_unsafe_path(patch))
+		return -1;
 
 	/*
 	 * An attempt to read from or delete a path that is beyond a
-- 
2.9.0.rc2.411.g3e2ca28
