From: Elijah Newren <newren@gmail.com>
Subject: [RFC/PATCH 02/18] Avoid checking working copy when creating a virtual merge base
Date: Thu,  7 Apr 2016 23:58:30 -0700
Message-ID: <1460098726-5958-3-git-send-email-newren@gmail.com>
References: <1460098726-5958-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 08 08:59:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoQO7-0002VL-JC
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 08:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757862AbcDHG7J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 02:59:09 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35967 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932590AbcDHG7B (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 02:59:01 -0400
Received: by mail-pf0-f195.google.com with SMTP id q129so8827919pfb.3
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 23:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Anjrje2/zp+b1I7hOuoSV5meBD4MWBtHEvosuPI5M3g=;
        b=ao+I/vElxXm6AJUVpVTJHaOBc7xJPju2tRsdslI2bUcec7tLVPbwtLwD7ubp0WdsER
         +s3c4eRFQgTElj6qeR6fMrSoyrBIutnZ7G30Ut1QpiEv3iG2uuKHK4FRhPngKaLnQayP
         MrLa5gB5PNLZDDKCgI4ErVZKeNQqAPDTimV6wC2Sscr37Myptws/s6nOiLO593BkvCJ9
         bzQwTZW01YDqFqMjb5C/gghmNEeoQHBLhlQKTnwhrbYQ39aHwIhz2axKAcvn56DyrsaO
         aakU3bLlStpvSRkmYnpihs/IerCKYOfBXgegXtexGxhS5jJyyHLEoY9g3oW1Uct8AX4/
         PxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Anjrje2/zp+b1I7hOuoSV5meBD4MWBtHEvosuPI5M3g=;
        b=N9RSxq/sSTyHdtYvRJNoN/2/LkH2EeLkk+qHwrRF8Qi54F6WXxgI+wHFMMSGxurOj4
         H4paZ8ohvXVI2cPf4CxHupP5t9GO0XGiqql74YnI3Zu0ZOR3U3LooxDGxno1s23RAmbN
         5MhnxF5gLFOLDE9sovjn/otPcd8NtZMrEyXMl92LkITq+MUGYwRhCPcXG22LvJ64zH2A
         CHlhAx09wo48RQJbcqluWPCUeviN9aDfbcOJxUIadNg7voVVH797vhtX9MOdMuJPYc2Q
         KLtHCIZs6hjn9B4v8jzZ3W+RENb+SgFrI7HT81tOS0GESDaLekR69O4Fdibjm/La1BsZ
         725Q==
X-Gm-Message-State: AD7BkJLataGLu1Z50o+AT8AH3uGpbx9T2SUgbNPQC3BKc/7Kt4QrxYhcbi2P5++d41h2MA==
X-Received: by 10.98.86.28 with SMTP id k28mr10504152pfb.43.1460098740399;
        Thu, 07 Apr 2016 23:59:00 -0700 (PDT)
Received: from unknownB8F6B118D3EB.attlocal.net ([2602:30a:2c28:20f0:baf6:b1ff:fe18:d3eb])
        by smtp.gmail.com with ESMTPSA id w62sm16371973pfa.79.2016.04.07.23.58.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Apr 2016 23:58:59 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.18.gc685494
In-Reply-To: <1460098726-5958-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291003>

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
2.8.0.18.gc685494
