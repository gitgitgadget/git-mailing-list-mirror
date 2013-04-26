From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 03/20] remote-bzr: fix order of locking in CustomTree
Date: Thu, 25 Apr 2013 20:07:51 -0500
Message-ID: <1366938488-25425-4-git-send-email-felipe.contreras@gmail.com>
References: <1366938488-25425-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 03:09:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVXAP-0003R9-0f
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 03:09:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932629Ab3DZBJd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 21:09:33 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:56521 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758382Ab3DZBJc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 21:09:32 -0400
Received: by mail-oa0-f50.google.com with SMTP id j6so3518418oag.9
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 18:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=iGmkXvsj1VDUoyGxlnHYvO7dGyiSlCWyWwqyujmeU2s=;
        b=AJWpoumZAnh5a01dAE7tfJ039j08/u9ledzm6V2RzvilaWoKmjB0FgOY4QbzccohEq
         vweEGPiRh04Ztz+jv82U7ZuPmxr839hZoVvkHVFwgk96QT/qIpixdNYLgYA8xiSjwRsp
         ngwARsng0DQ+KKVXqLHQZJycLJckngJzD42KwT6z0JUzqBFlUwFtBPwONlKwSJi+rgf0
         jgZEOzrlBFIt1uJFyH0VXgqj2Gvp+mSrniI0rCDLnlZOojx8e18B70Q81Xp/Km3seQxg
         z3jbXNsOsOLgZTi7IEngB7IyFKbIxxNOrYqsvgMZ+k2ojoq4AFhPvmu2mSR2AFbO8SGs
         KblA==
X-Received: by 10.60.132.196 with SMTP id ow4mr17093865oeb.75.1366938571965;
        Thu, 25 Apr 2013 18:09:31 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id b2sm5857604oby.5.2013.04.25.18.09.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 18:09:31 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.884.g3532a8d
In-Reply-To: <1366938488-25425-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222483>

It doesn't seem to make any difference, but revision_tree() requires a
lock.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 91b5cda..b428244 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -389,8 +389,8 @@ class CustomTree():
 
         def copy_tree(revid):
             files = files_cache[revid] = {}
-            tree = repo.repository.revision_tree(revid)
             repo.lock_read()
+            tree = repo.repository.revision_tree(revid)
             try:
                 for path, entry in tree.iter_entries_by_dir():
                     files[path] = entry.file_id
-- 
1.8.2.1.884.g3532a8d
