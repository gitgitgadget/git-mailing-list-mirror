From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v7 04/11] update-index: add untracked cache notifications
Date: Sun, 24 Jan 2016 16:28:17 +0100
Message-ID: <1453649304-18121-5-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sun Jan 24 16:29:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNMbf-0000zo-Ei
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 16:29:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753274AbcAXP33 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 10:29:29 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36293 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752544AbcAXP2r (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 10:28:47 -0500
Received: by mail-wm0-f65.google.com with SMTP id l65so6785502wmf.3
        for <git@vger.kernel.org>; Sun, 24 Jan 2016 07:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cHtmbWjRakCrQBP9ZTSQr534LMv7Cc2EhVxtRaJJVzY=;
        b=Uhs+w1S2hrNdwgmF5a/txcrc3fKP9zH+q6Rpt/UhBgmdoAJWlMbXvtkIc0BCbLCQ4P
         diJHcbsiGqRh6Jllglb3lnAEnUCVKd8fj6/SQK6uIzkTrs1CikIm8yzb+c/ubuMRSegZ
         uxoQMpk6jnHaw6iyustHz8QYXsKSY2WYduMXBgf46pd6F+8YDuCxYiKDWrekGLqukIB4
         9iQYsc1kIPRus9JepuoKFS0gG8tyWvjRdJweNMP0Z0QX8AR4aBtqD7An3s8d/BGo8SM8
         ps+1EgCaOcFJnebT+bGfrceIMC3Xx3OV1X+gTrxp0Gq4RErDArCYmMvbUcAtQB4WbXIz
         iOiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cHtmbWjRakCrQBP9ZTSQr534LMv7Cc2EhVxtRaJJVzY=;
        b=gMsbAN0LvQNv+Vg+LbcdxtYNtxSP1WKXgS3plFQ+3LPm2xISX7t3dSIsehR7yGHXL1
         z2TlYRBCvXX3PxrO3rmlXj6hBA5Eo+lfJvjh5cCnHVu74m9PKkokcHthGtm0PCQ4J9Ng
         nYi5/z7t+lDunJiQ35qXR9ydOzHlcMVeUlSPOefNLNe1PQuVAbsxCHAmK6BoDDi+INC9
         G9S2fkr71DAjD8Ge7b5cMirk7W2j+/BXXXCGGnD6SbrdT35p+oHO3q2Xq8CI6UimUVAh
         S2Ze/pZeLYqSo6nNJ7VnnIEmyrX/iDQGY3Q/lcvJLOG7C8ESs6MKqcWfHF4EhaEk5HVI
         m+3A==
X-Gm-Message-State: AG10YOQbGp+Vu7/Qr4G1YK6twNewFU7h8i8KeNCyJh9EiRlSBGuv1DO3fv0erOw8/M/oMQ==
X-Received: by 10.28.21.19 with SMTP id 19mr12874537wmv.43.1453649326590;
        Sun, 24 Jan 2016 07:28:46 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id y8sm11900231wmg.9.2016.01.24.07.28.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Jan 2016 07:28:45 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.181.gd7ef666.dirty
In-Reply-To: <1453649304-18121-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284661>

Attempting to flip the untracked-cache feature on for a random index
file with

    cd /random/unrelated/place
    git --git-dir=/somewhere/else/.git update-index --untracked-cache

would not work as you might expect. Because flipping the feature on
in the index also records the location of the corresponding working
tree (/random/unrelated/place in the above example), when the index
is subsequently used to keep track of files in the working tree in
/somewhere/else, the feature is disabled.

With this patch "git update-index --[test-]untracked-cache" tells the
user in which directory tests are performed. This makes it easy to
spot any problem.

Also in verbose mode, let's tell the user when the cache is enabled
or disabled.

Helped-by: Duy Nguyen <pclouds@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/update-index.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 62222dd..369c207 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -130,7 +130,7 @@ static int test_if_untracked_cache_is_supported(void)
 	if (!mkdtemp(mtime_dir.buf))
 		die_errno("Could not make temporary directory");
 
-	fprintf(stderr, _("Testing "));
+	fprintf(stderr, _("Testing mtime in '%s' "), xgetcwd());
 	atexit(remove_test_directory);
 	xstat_mtime_dir(&st);
 	fill_stat_data(&base, &st);
@@ -1135,10 +1135,14 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		}
 		add_untracked_ident(the_index.untracked);
 		the_index.cache_changed |= UNTRACKED_CHANGED;
-	} else if (untracked_cache == UC_DISABLE && the_index.untracked) {
-		free_untracked_cache(the_index.untracked);
-		the_index.untracked = NULL;
-		the_index.cache_changed |= UNTRACKED_CHANGED;
+		report(_("Untracked cache enabled for '%s'"), get_git_work_tree());
+	} else if (untracked_cache == UC_DISABLE) {
+		if (the_index.untracked) {
+			free_untracked_cache(the_index.untracked);
+			the_index.untracked = NULL;
+			the_index.cache_changed |= UNTRACKED_CHANGED;
+		}
+		report(_("Untracked cache disabled"));
 	}
 
 	if (active_cache_changed) {
-- 
2.7.0.181.gd7ef666.dirty
