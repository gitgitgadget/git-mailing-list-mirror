From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 03/10] update-index: add untracked cache notifications
Date: Tue, 15 Dec 2015 17:28:20 +0100
Message-ID: <1450196907-17805-4-git-send-email-chriscool@tuxfamily.org>
References: <1450196907-17805-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 15 17:29:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8sTS-00041v-ED
	for gcvg-git-2@plane.gmane.org; Tue, 15 Dec 2015 17:29:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754108AbbLOQ3F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 11:29:05 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36081 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754098AbbLOQ3D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 11:29:03 -0500
Received: by mail-wm0-f48.google.com with SMTP id n186so172969955wmn.1
        for <git@vger.kernel.org>; Tue, 15 Dec 2015 08:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hE6TqINiA6FgAYFtW8O6krcNAtwx3z1ExPigsB7TN3E=;
        b=b3vOTYlXmaM10HNN7wU09IUncsz2OpH5ka2LSkxwojf5CoBL+hfPjSnbNO7lfsxk+D
         epS+zXxixek9dvSdKK55a2x9yZnSqrZyPoN/IA6OlhsAHxsYIAICEtseROvOjwE0UDHV
         +4a7TnNF/OZchPgeKCBD8WBsWG+gFgwfTxFZxu992A+E1KJQ6JvccPaJrkiU6ey/3Ovs
         11JSNEWjux1HRglAJmfMGxAyTRii3Z4tCJqTut5mywTQAD47NYRs3sQQRpPDN9PBNA34
         hUooTFFNnxMsnopwg5Z5Nx0uPyPusOKHFtuCl+gEq9WgX9hc9BMfpr786VSrotHOGjUd
         ap1Q==
X-Received: by 10.28.9.138 with SMTP id 132mr5903896wmj.19.1450196941908;
        Tue, 15 Dec 2015 08:29:01 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id s11sm3513817wmb.14.2015.12.15.08.28.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Dec 2015 08:29:01 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.6.3.479.g8eb29d4
In-Reply-To: <1450196907-17805-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282486>

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

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/update-index.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index e747a6c..e84674f 100644
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
@@ -1135,9 +1135,13 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		}
 		add_untracked_ident(the_index.untracked);
 		the_index.cache_changed |= UNTRACKED_CHANGED;
+		if (verbose)
+			printf(_("Untracked cache enabled\n"));
 	} else if (untracked_cache == UC_DISABLE && the_index.untracked) {
 		the_index.untracked = NULL;
 		the_index.cache_changed |= UNTRACKED_CHANGED;
+		if (verbose)
+			printf(_("Untracked cache disabled\n"));
 	}
 
 	if (active_cache_changed) {
-- 
2.6.3.479.g8eb29d4
