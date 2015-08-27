From: David Turner <dturner@twopensource.com>
Subject: [PATCH] commit: don't rewrite shared index unnecessarily
Date: Thu, 27 Aug 2015 13:07:54 -0400
Message-ID: <1440695274-12400-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu Aug 27 19:08:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZV0ew-00005z-U6
	for gcvg-git-2@plane.gmane.org; Thu, 27 Aug 2015 19:08:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752345AbbH0RIE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2015 13:08:04 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:36686 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531AbbH0RIC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2015 13:08:02 -0400
Received: by qgeb6 with SMTP id b6so14426884qge.3
        for <git@vger.kernel.org>; Thu, 27 Aug 2015 10:08:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qkKBSlb7quRGUqa53uWAF3gMukAO+zSi7A5y8A8iC3Q=;
        b=TZB/FXbevJRWPDng3MKW+ZGDv7tpqiymJgDqb1tiaPZnIxapvwv1lUMQ98MlYO19n1
         Y5dSKkzKFkJecciRrVLGS3Y8oqz1L4a5QioQZyVJxgTByFr2yf7WTuXr4gWM5brr/Vab
         qVCj219eYq0HgrJo9rkkRLoKb0PELtWp4Eir7qDg8pKbG5o9xWyG2uU4dT9GbISzZ3CN
         YuG+cqLchW3tAG0KVxTLf9ls0SA2rinS7XinG+sNq1J+xgUEmPC9WEtgVw7V05pdQfxe
         q6zdDC2nFbb9N2bmCLhcDr0fY2jPzp72237PEVzfRZqHNCDurP9GRUmhX/ohDNfHLu2i
         s0GA==
X-Gm-Message-State: ALoCoQk+dHIQj02XTR6b248WE0RX9dypQQ4QhmQSTIiRueeOJrrGYWGu9dLqCwNE7Y4/Vt5oAYR7
X-Received: by 10.140.238.3 with SMTP id j3mr9439034qhc.14.1440695281329;
        Thu, 27 Aug 2015 10:08:01 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id y7sm1595517qky.20.2015.08.27.10.07.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Aug 2015 10:08:00 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.622.gac67c30-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276684>

Remove a cache invalidation which would cause the shared index to be
rewritten on as-is commits.

When the cache-tree has changed, we need to update it.  But we don't
necessarily need to update the shared index.  So setting
active_cache_changed to SOMETHING_CHANGED is unnecessary.  Instead, we
let update_main_cache_tree just update the CACHE_TREE_CHANGED bit.

In order to test this, make test-dump-split-index not segfault on
missing replace_bitmap/delete_bitmap.  This new codepath is not called
now that the test passes, but is necessary to avoid a segfault when the
new test is run with the old builtin/commit.c code.

Signed-off-by: David Turner <dturner@twopensource.com>
---

I introduced this bug last year while improving the cache-tree code.
I guess I probably didn't notice that active_cache_changed wasn't a
boolean.

---
 builtin/commit.c        |  4 +---
 t/t0090-cache-tree.sh   | 10 ++++++++++
 test-dump-split-index.c |  6 ++++--
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 254477f..1692620 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -404,10 +404,8 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 		hold_locked_index(&index_lock, 1);
 		refresh_cache_or_die(refresh_flags);
 		if (active_cache_changed
-		    || !cache_tree_fully_valid(active_cache_tree)) {
+		    || !cache_tree_fully_valid(active_cache_tree))
 			update_main_cache_tree(WRITE_TREE_SILENT);
-			active_cache_changed = 1;
-		}
 		if (active_cache_changed) {
 			if (write_locked_index(&the_index, &index_lock,
 					       COMMIT_LOCK))
diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index 601d02d..f92dd1f 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -218,4 +218,14 @@ test_expect_success 'no phantom error when switching trees' '
 	! test -s errors
 '
 
+test_expect_success 'switching trees does not invalidate shared index' '
+	git update-index --split-index &&
+	>split &&
+	git add split &&
+	test-dump-split-index .git/index | grep -v ^own >before &&
+	git commit -m "as-is" &&
+	test-dump-split-index .git/index | grep -v ^own >after &&
+	test_cmp before after
+'
+
 test_done
diff --git a/test-dump-split-index.c b/test-dump-split-index.c
index 9cf3112..861d28c 100644
--- a/test-dump-split-index.c
+++ b/test-dump-split-index.c
@@ -26,9 +26,11 @@ int main(int ac, char **av)
 		       sha1_to_hex(ce->sha1), ce_stage(ce), ce->name);
 	}
 	printf("replacements:");
-	ewah_each_bit(si->replace_bitmap, show_bit, NULL);
+	if (si->replace_bitmap)
+		ewah_each_bit(si->replace_bitmap, show_bit, NULL);
 	printf("\ndeletions:");
-	ewah_each_bit(si->delete_bitmap, show_bit, NULL);
+	if (si->delete_bitmap)
+		ewah_each_bit(si->delete_bitmap, show_bit, NULL);
 	printf("\n");
 	return 0;
 }
-- 
2.4.2.622.gac67c30-twtrsrc
