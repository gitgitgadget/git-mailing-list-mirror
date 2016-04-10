From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 2/6] Avoid checking working copy when creating a virtual merge base
Date: Sat,  9 Apr 2016 23:13:36 -0700
Message-ID: <1460268820-8308-3-git-send-email-newren@gmail.com>
References: <1460268820-8308-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 10 08:14:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ap8dV-0004GU-Rf
	for gcvg-git-2@plane.gmane.org; Sun, 10 Apr 2016 08:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbcDJGNw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2016 02:13:52 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:36675 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbcDJGNv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2016 02:13:51 -0400
Received: by mail-pa0-f66.google.com with SMTP id k3so8290520pav.3
        for <git@vger.kernel.org>; Sat, 09 Apr 2016 23:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vms4goWxg11V70/KhvcpWnkREzLbpiExP2rtUUHpsNw=;
        b=0P54vhiQLIz8L8tePRmgJxVuVN5+Ins77+zm/mCbjXGoJr9Mw05iDHMGpsiQOc5G3g
         rL9YvQZQfUzxZSG5QAz1WgygqoVsOqxYbR7HMBH/TZ60LBOiLrTRSJwmdwLt+3Lx308R
         W+4RZsWutPrjpovsraAtVtK3kIlTo6+nKrz6Sb/Mi5tOW5MERebGG4wg9BBc8WXaDATz
         erW75fZLxpymrIJL6O3epObFugwKBAVHUX6paZcG48zJzZRLrzI2VGavOH/YxwyMDoWm
         6oiXo+mjqdounByH8pFfAytwcsnEcErjRcqmw58XF4q7g9vIYlS4Q3bYrwEiA+bhobat
         bjmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vms4goWxg11V70/KhvcpWnkREzLbpiExP2rtUUHpsNw=;
        b=UX7fgS2897woQOxCRohsFx/d7o4K0S5KxGXvd4ru674xYVHO4brjNYykbMuP3StCfX
         yRsjfHxd9JnAeO7xTD0uIxFu1q3t5G8/AbjV8TcL/0sqlzieI/yTH+3Smw0BBMwHyydb
         BfaEYeOr6hVR+vdT8BDmb5KEnJDmq1bOBtvwuElSKJShlBoF0ho5wqQKwP7I5FOtLw+y
         UUHe4i2/MfDHC134Z5Cwq4zYPzjZLRzUxFJIlVu+2l2vz2BQf6WBKcAjnz/zijgyDUDW
         VkCcGTr2EXkhjWzUcbCAQpVfjxP3/1p8B9wbS6IxlFUFOBOWXJWW+d5E3IdpE0jNWxVL
         Dk6w==
X-Gm-Message-State: AD7BkJJ7NEWAx1KZtVKVlOqMMFuOgGx2Mvf9uY8zLxGEi2r3aEnr+Cwe7v1gkEdYbJ+fUg==
X-Received: by 10.66.251.132 with SMTP id zk4mr24226601pac.50.1460268830723;
        Sat, 09 Apr 2016 23:13:50 -0700 (PDT)
Received: from unknownB8F6B118D3EB.attlocal.net ([2602:30a:2c28:20f0:baf6:b1ff:fe18:d3eb])
        by smtp.gmail.com with ESMTPSA id p26sm28228711pfi.84.2016.04.09.23.13.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Apr 2016 23:13:50 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.6.g5833b2a
In-Reply-To: <1460268820-8308-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291146>

There were a few cases in merge-recursive that could result in a check for
the presence of files in the working copy while trying to create a virtual
merge base.  These were rare and innocuous, but somewhat illogical.  The
two cases were:

  * When there was naming conflicts (e.g. a D/F conflict) and we had to
    pick a new unique name for a file.  Since the new name is somewhat
    arbitrary, it didn't matter that we consulted the working copy to
    avoid picking a filename it has, but since the virtual merge base is
    never checked out, it's a waste of time and slightly odd to do so.

  * When two different files get renamed to the same name (on opposite
    sides of the merge), we needed to delete the original filenames from
    the cache and possibly also the working directory.  The caller's check
    for determining whether to delete from the working directory was a
    call to would_lose_untracked().  It turns out this didn't matter
    because remove_file() had logic to avoid modifying the working
    directory when creating a virtual merge base, but there is no reason
    for the caller to check the working directory in such circumstances.
    It's a waste of time, if not also a bit weird.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index d4292de..06d31ed 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -622,7 +622,7 @@ static char *unique_path(struct merge_options *o, const char *path, const char *
 	base_len = newpath.len;
 	while (string_list_has_string(&o->current_file_set, newpath.buf) ||
 	       string_list_has_string(&o->current_directory_set, newpath.buf) ||
-	       file_exists(newpath.buf)) {
+	       (!o->call_depth && file_exists(newpath.buf))) {
 		strbuf_setlen(&newpath, base_len);
 		strbuf_addf(&newpath, "_%d", suffix++);
 	}
@@ -1234,8 +1234,8 @@ static void conflict_rename_rename_2to1(struct merge_options *o,
 	       a->path, c1->path, ci->branch1,
 	       b->path, c2->path, ci->branch2);
 
-	remove_file(o, 1, a->path, would_lose_untracked(a->path));
-	remove_file(o, 1, b->path, would_lose_untracked(b->path));
+	remove_file(o, 1, a->path, o->call_depth || would_lose_untracked(a->path));
+	remove_file(o, 1, b->path, o->call_depth || would_lose_untracked(b->path));
 
 	mfi_c1 = merge_file_special_markers(o, a, c1, &ci->ren1_other,
 					    o->branch1, c1->path,
-- 
2.8.0.21.g229f62a
