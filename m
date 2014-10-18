From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] object: make add_object_array_with_mode a static function
Date: Sun, 19 Oct 2014 00:19:07 +0100
Message-ID: <5442F56B.8020205@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 19 01:24:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XfdMV-0003Dd-Sf
	for gcvg-git-2@plane.gmane.org; Sun, 19 Oct 2014 01:24:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbaJRXYg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2014 19:24:36 -0400
Received: from mdfmta010.mxout.tbr.inty.net ([91.221.168.51]:33634 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751542AbaJRXYf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2014 19:24:35 -0400
X-Greylist: delayed 323 seconds by postgrey-1.27 at vger.kernel.org; Sat, 18 Oct 2014 19:24:35 EDT
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id 34C0A6F92FB;
	Sun, 19 Oct 2014 00:18:46 +0100 (BST)
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id E9E726F92FA;
	Sun, 19 Oct 2014 00:18:45 +0100 (BST)
Received: from [10.0.2.15] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP;
	Sun, 19 Oct 2014 00:18:45 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
X-MDF-HostID: 3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Jeff,

I noticed that your 'jk/prune-mtime' branch also removes the only
call to the add_object_array_with_mode() function outside of the
object.c file; specifically commit 75ac69fa ("traverse_commit_list:
support pending blobs/trees with paths", 15-10-2014).

This patch (which was generated using the '--histogram' option to
format-patch), moves the function to before the definition of the
add_object_array() function (to avoid a forward declaration), and
makes it static.

If you need to re-roll this branch, could you please squash this
patch into the above commit. (again, assuming you have no plans
to add new external callers.)

[If new external callers are very likely in the future (i.e. this
function is an essential part of the object-array API), then it may
well not be worth doing this. (with perhaps a note in the commit
message? - dunno). Similar comments apply to the previous 'add_object'
patch as well!]

Thanks!

ATB,
Ramsay Jones


 object.c | 10 +++++-----
 object.h |  1 -
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/object.c b/object.c
index df86bdd..e1ef3f9 100644
--- a/object.c
+++ b/object.c
@@ -339,16 +339,16 @@ void add_object_array_with_path(struct object *obj, const char *name,
 	array->nr = ++nr;
 }
 
+static void add_object_array_with_mode(struct object *obj, const char *name, struct object_array *array, unsigned mode)
+{
+	add_object_array_with_path(obj, name, array, mode, NULL);
+}
+
 void add_object_array(struct object *obj, const char *name, struct object_array *array)
 {
 	add_object_array_with_mode(obj, name, array, S_IFINVALID);
 }
 
-void add_object_array_with_mode(struct object *obj, const char *name, struct object_array *array, unsigned mode)
-{
-	add_object_array_with_path(obj, name, array, mode, NULL);
-}
-
 /*
  * Free all memory associated with an entry; the result is
  * in an unspecified state and should not be examined.
diff --git a/object.h b/object.h
index e5178a5..6416247 100644
--- a/object.h
+++ b/object.h
@@ -114,7 +114,6 @@ int object_list_contains(struct object_list *list, struct object *obj);
 
 /* Object array handling .. */
 void add_object_array(struct object *obj, const char *name, struct object_array *array);
-void add_object_array_with_mode(struct object *obj, const char *name, struct object_array *array, unsigned mode);
 void add_object_array_with_path(struct object *obj, const char *name, struct object_array *array, unsigned mode, const char *path);
 
 typedef int (*object_array_each_func_t)(struct object_array_entry *, void *);
-- 
2.1.0
