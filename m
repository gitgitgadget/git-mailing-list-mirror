From: Anders Kaseorg <andersk@MIT.EDU>
Subject: [PATCH 1/2] for-each-ref: Do not lookup objects when they will not
 be used
Date: Wed, 27 May 2009 15:23:12 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.0905271518540.24169@vinegar-pot.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed May 27 21:23:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9Oik-0006ri-2G
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 21:23:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757335AbZE0TXR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 15:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757062AbZE0TXR
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 15:23:17 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:57103 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756320AbZE0TXQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 May 2009 15:23:16 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id n4RJNDK7014870;
	Wed, 27 May 2009 15:23:13 -0400 (EDT)
Received: from localhost (VINEGAR-POT.MIT.EDU [18.181.0.51])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id n4RJNCDJ007330;
	Wed, 27 May 2009 15:23:12 -0400 (EDT)
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120096>

This makes commands such as `git for-each-ref --format='%(refname)'`, 
which are used heavily by the bash_completion code, run about 6 times 
faster on an uncached repository (3 s intead of 18 s on my linux-2.6 
repository with several remotes).

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---
 builtin-for-each-ref.c |   26 +++++++++++++++++---------
 1 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index d091e04..1911cda 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -561,14 +561,6 @@ static void populate_value(struct refinfo *ref)
 
 	ref->value = xcalloc(sizeof(struct atom_value), used_atom_cnt);
 
-	buf = get_obj(ref->objectname, &obj, &size, &eaten);
-	if (!buf)
-		die("missing object %s for %s",
-		    sha1_to_hex(ref->objectname), ref->refname);
-	if (!obj)
-		die("parse_object_buffer failed on %s for %s",
-		    sha1_to_hex(ref->objectname), ref->refname);
-
 	/* Fill in specials first */
 	for (i = 0; i < used_atom_cnt; i++) {
 		const char *name = used_atom[i];
@@ -621,6 +613,22 @@ static void populate_value(struct refinfo *ref)
 		}
 	}
 
+	for (i = 0; i < used_atom_cnt; i++) {
+		struct atom_value *v = &ref->value[i];
+		if (v->s == NULL)
+			goto need_obj;
+	}
+	return;
+
+ need_obj:
+	buf = get_obj(ref->objectname, &obj, &size, &eaten);
+	if (!buf)
+		die("missing object %s for %s",
+		    sha1_to_hex(ref->objectname), ref->refname);
+	if (!obj)
+		die("parse_object_buffer failed on %s for %s",
+		    sha1_to_hex(ref->objectname), ref->refname);
+
 	grab_values(ref->value, 0, obj, buf, size);
 	if (!eaten)
 		free(buf);
@@ -926,7 +934,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 
 	memset(&cbdata, 0, sizeof(cbdata));
 	cbdata.grab_pattern = argv;
-	for_each_ref(grab_single_ref, &cbdata);
+	for_each_rawref(grab_single_ref, &cbdata);
 	refs = cbdata.grab_array;
 	num_refs = cbdata.grab_cnt;
 
-- 
1.6.3.1
