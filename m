From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 07/10] replace: die early if replace ref already exists
Date: Sat, 17 May 2014 08:41:29 +0200
Message-ID: <20140517064133.18932.92343.chriscool@tuxfamily.org>
References: <20140517062418.18932.21200.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 17 08:43:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlYLR-0006FL-Dy
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 08:43:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757085AbaEQGnj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2014 02:43:39 -0400
Received: from [194.158.98.15] ([194.158.98.15]:51219 "EHLO mail-2y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756821AbaEQGne (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2014 02:43:34 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 8DDE751;
	Sat, 17 May 2014 08:43:13 +0200 (CEST)
X-git-sha1: f83b0912ea8d664d3649c47722362238dab176c7 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140517062418.18932.21200.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249444>

If a replace ref already exists for an object, it is
much better for the user if we error out before we
let the user edit the object, rather than after.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replace.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 3d6edaf..4ee3d92 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -268,7 +268,8 @@ static int edit_and_replace(const char *object_ref, int force)
 {
 	char *tmpfile = git_pathdup("REPLACE_EDITOBJ");
 	enum object_type type;
-	unsigned char old[20], new[20];
+	unsigned char old[20], new[20], prev[20];
+	char ref[PATH_MAX];
 
 	if (get_sha1(object_ref, old) < 0)
 		die("Not a valid object name: '%s'", object_ref);
@@ -277,6 +278,8 @@ static int edit_and_replace(const char *object_ref, int force)
 	if (type < 0)
 		die("unable to get object type for %s", sha1_to_hex(old));
 
+	check_ref_valid(old, prev, ref, sizeof(ref), force);
+
 	export_object(old, tmpfile);
 	if (launch_editor(tmpfile, NULL, NULL) < 0)
 		die("editing object file failed");
-- 
1.9.rc0.17.g651113e
