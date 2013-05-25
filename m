From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 12/25] fsck: don't put a void*-shaped peg in a char*-shaped hole
Date: Sat, 25 May 2013 11:08:11 +0200
Message-ID: <1369472904-12875-13-git-send-email-mhagger@alum.mit.edu>
References: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johan Herland <johan@herland.net>, Thomas Rast <trast@inf.ethz.ch>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 25 11:09:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgATe-0005B0-C9
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 11:09:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752167Ab3EYJJR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 May 2013 05:09:17 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:59674 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752678Ab3EYJJN (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 May 2013 05:09:13 -0400
X-AuditID: 12074413-b7f226d000000902-ac-51a07fb8d9d3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 96.35.02306.8BF70A15; Sat, 25 May 2013 05:09:12 -0400 (EDT)
Received: from michael.fritz.box (p4FDD49F3.dip0.t-ipconnect.de [79.221.73.243])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4P98gum000489
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 25 May 2013 05:09:11 -0400
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsUixO6iqLujfkGgwZrPOhZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYLe5eXsXuwObx9/0HJo9LL7+zedx+PZ/Z41nvHkaPi5eUPT5vkgtg
	i+K2SUosKQvOTM/Tt0vgznjb3chUsIqzomnlf9YGxl3sXYycHBICJhIbDr5mgrDFJC7cW8/W
	xcjFISRwmVHi5Ko2sCIhgQtMErv2g9lsAroSi3qawRpEBBwlTjy4zgrSwCzQyyjx8NF3sISw
	QLDE0cabjCA2i4CqxMNLk1lAbF4BV4mLR65AbVOQuDxrDXMXIwcHJ1D87QlOiF0uEs8/nWOd
	wMi7gJFhFaNcYk5prm5uYmZOcWqybnFyYl5eapGuuV5uZoleakrpJkZImAnvYNx1Uu4QowAH
	oxIPr0D5/EAh1sSy4srcQ4ySHExKorz8tQsChfiS8lMqMxKLM+KLSnNSiw8xSnAwK4nwMqQA
	5XhTEiurUovyYVLSHCxK4rxqS9T9hATSE0tSs1NTC1KLYLIyHBxKErwedUCNgkWp6akVaZk5
	JQhpJg5OEMEFsoEHaEMgSCFvcUFibnFmOkTRKUZFKXHeiSAJAZBERmke3ABYQnjFKA70jzDv
	ApAqHmAyget+BTSYCWjwzdz5IINLEhFSUg2MOjEzijJz7ZmXPpy08POm3x73H3zdJ+1zvPXf
	Xf+mhI/VLN+kD5/duOB/wTcv/k1r6s5O6V+T9mDOyaOviq9/+legVbp4ntPEHAnFII8JzXm7
	Shbeqd1UWNGu6aWuXxl8qDRK3JkjNHZdHauP6/rQMzsPHtkn6zs7rlDK7BCTVGxv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225499>

The source of this nonsense was

    04d3975937 fsck: reduce stack footprint

, which wedged a pointer to parent into the object_array_entry's name
field.  The parent pointer was passed to traverse_one_object(), even
though that function *didn't use it*.

The useless code has been deleted over time.  Commit

    a1cdc25172 fsck: drop unused parameter from traverse_one_object()

removed the parent pointer from traverse_one_object()'s
signature. Commit

    c0aa335c95 Remove unused variables

removed the code that read the parent pointer back out of the name
field.

This commit takes the last step: don't write the parent pointer into
the name field in the first place.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fsck.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index bb9a2cd..9909b6d 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -112,7 +112,7 @@ static int mark_object(struct object *obj, int type, void *data)
 		return 1;
 	}
 
-	add_object_array(obj, (void *) parent, &pending);
+	add_object_array(obj, NULL, &pending);
 	return 0;
 }
 
-- 
1.8.2.3
