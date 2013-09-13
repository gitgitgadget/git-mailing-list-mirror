From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 3/3] dir: revert work-around for retired dangerous behavior
Date: Fri, 13 Sep 2013 07:15:43 -0400
Message-ID: <1379070943-36595-4-git-send-email-sunshine@sunshineco.com>
References: <1379070943-36595-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 13 13:16:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKRMX-0000sI-Ot
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 13:16:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755535Ab3IMLQ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Sep 2013 07:16:26 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:47324 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753376Ab3IMLQW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Sep 2013 07:16:22 -0400
Received: by mail-ob0-f174.google.com with SMTP id uz6so941391obc.19
        for <git@vger.kernel.org>; Fri, 13 Sep 2013 04:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IReG+M5bIbgGuYQlwO2e+fmdLOjNFptEs8m7ZTyokRY=;
        b=fbkdEygwU2sjYB+hkqT7uw3UCy+lNPJVOiDFaiNAowDqCd+rx1lmmnH4ZBVcX7U5Xt
         SBCXmhvk9u4hSL7TdWGJlhLEgvE5QseOWi6ebXRjIm6UQyab0hCqfd7Q3tvQJl0zA9su
         fx2/QjFX96TPSa9KhJUbHBdONkI+nVtZSA7EIxM5WcVPc0yuomuZ2bVwga+/yJ0WDupw
         PuXEOfcHJECPdKIYvukwd83rnE7om6+cs1YmJSlEpqQYFvSPz4fVuan+4bdJnbaJi1CA
         1BzpwmosvhlvNv3XLKIX8VAKKKIJpzMkr6nZr+UBhTIu6w+HTs7bsytWcHw+b6uoPVzc
         GmfQ==
X-Received: by 10.60.42.168 with SMTP id p8mr1088193oel.73.1379070982144;
        Fri, 13 Sep 2013 04:16:22 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dr8.cable.mindspring.com. [69.81.183.104])
        by mx.google.com with ESMTPSA id it7sm13049040obb.11.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 13 Sep 2013 04:16:21 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.457.g424cb08
In-Reply-To: <1379070943-36595-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234746>

directory_exists_in_index_icase() dangerously assumed that it could
access one character beyond the end of its directory argument, and that
that character would unconditionally be '/'.  2eac2a4c (ls-files -k: a
directory only can be killed if the index has a non-directory,
2013-08-15) added a caller which did not respect this undocumented
assumption, and 680be044 (dir.c::test_one_path(): work around
directory_exists_in_index_icase() breakage, 2013-08-23) added a
work-around which temporarily appends a '/' before invoking
directory_exists_in_index_icase().

Since the dangerous behavior of directory_exists_in_index_icase() has
been eliminated, the work-around is now redundant, so retire it (but not
the tests added by the same commit).

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 dir.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/dir.c b/dir.c
index 69d04a0..ef95160 100644
--- a/dir.c
+++ b/dir.c
@@ -1161,21 +1161,9 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 	 */
 	if ((dir->flags & DIR_COLLECT_KILLED_ONLY) &&
 	    (dtype == DT_DIR) &&
-	    !has_path_in_index) {
-		/*
-		 * NEEDSWORK: directory_exists_in_index_icase()
-		 * assumes that one byte past the given path is
-		 * readable and has '/', which needs to be fixed, but
-		 * until then, work it around in the caller.
-		 */
-		strbuf_addch(path, '/');
-		if (directory_exists_in_index(path->buf, path->len - 1) ==
-		    index_nonexistent) {
-			strbuf_setlen(path, path->len - 1);
-			return path_none;
-		}
-		strbuf_setlen(path, path->len - 1);
-	}
+	    !has_path_in_index &&
+	    (directory_exists_in_index(path->buf, path->len) == index_nonexistent))
+		return path_none;
 
 	exclude = is_excluded(dir, path->buf, &dtype);
 
-- 
1.8.4.457.g424cb08
