From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v8 04/11] update-index: add untracked cache notifications
Date: Wed, 27 Jan 2016 07:58:00 +0100
Message-ID: <1453877887-11586-5-git-send-email-chriscool@tuxfamily.org>
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
	id 1aOK9C-0002ie-3L
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 08:04:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753974AbcA0HED (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 02:04:03 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:34272 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753956AbcA0HDr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 02:03:47 -0500
Received: by mail-wm0-f46.google.com with SMTP id n5so13135701wmn.1
        for <git@vger.kernel.org>; Tue, 26 Jan 2016 23:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3G79p/ToQrvKtm/2SpUHrS/ze+BB6xJVY6I1TwXosS8=;
        b=0x7omLTbTc4rRQmKLJO5DqW/4DIS7hN25mKrfEKzle2gAtkebdMhs6qOyu0cfMgEwl
         NVyFpwCk2wP3YKPe0vwCbtBvIHlJ2o3y3rGI88XDL5PiLakXA7nB/LG9RDcOnsJswtMh
         u3MibGjxmvFYk+GcB02uOPYf1k2J4glPPPHOeDGN9elb5n2PW4vPKH6Mrfuz8cTMUvAF
         4/3MfMwvGzoWIGPLxwpHDb8Kvzv1oAW/x5/irHusWOiS9dMowIebHRVa+vwDHnhEE6kM
         b75Pbmw8KHbSbg5qQ1W3bx9gunuPuiezZJBmJhbUomr+gwotB+aOrFP+B6/VuUVqY4rP
         XqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3G79p/ToQrvKtm/2SpUHrS/ze+BB6xJVY6I1TwXosS8=;
        b=l8LWLSDKMq8JoeUVHwXG3ysWpVDAlLg0pgzHbONcZuETqfwEmYyEm7GyjDlOYpm7Je
         weLX9dla5tMit152mgucLy3+mevE0POQL5DBXUJWTfhV26ITSjI+9vvLX2w2xkdFw5o8
         ytP1ZMiWJ5Wh/obEN6zeL+0Izck1pTEk6XHtsnHoJVG71xDZiDTFB5/2nfcgG2EysW/2
         y4l2s61zYVle/IUVo71lV5lBKb6dDjtCFbjkekQRQpnQjg4se9Og7wNXfXL45VNyKttE
         GpQanuH2dKRcWxGTcyDEKOeCr6ipyTtrDB+3PZuTQFd+3iei12xiASPg/9JSxqICzJtA
         GoGA==
X-Gm-Message-State: AG10YORxtBOl00UzvH1XDvfvYgat7ZdL/JXVUimlDeJiBrJGhJKkCLQDOtVGcF0apLlUjg==
X-Received: by 10.194.111.232 with SMTP id il8mr31516778wjb.150.1453878226074;
        Tue, 26 Jan 2016 23:03:46 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 75sm6737569wmo.22.2016.01.26.23.03.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Jan 2016 23:03:45 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.181.g07d31f8
In-Reply-To: <1453877887-11586-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284879>

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
2.7.0.181.g07d31f8
