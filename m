From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/6] Optimize peel_ref for the current ref of a for_each_ref callback
Date: Sun, 24 Feb 2008 03:07:22 -0500
Message-ID: <20080224080722.GB22587@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 09:08:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTBuN-0004Lv-CG
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 09:08:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbYBXIHt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 03:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbYBXIHt
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 03:07:49 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:42952 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065AbYBXIHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 03:07:25 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JTBtL-0001fH-3z; Sun, 24 Feb 2008 03:07:23 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 98DA120FBC9; Sun, 24 Feb 2008 03:07:22 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74908>

Currently the only caller of peel_ref is show-ref, which is using
this function to show the peeled tag information if it is available
from an existing packed-refs file.  The call happens during the
for_each_ref callback function, so we have the proper struct ref_list
already on the call stack but it is not easily available to return
the peeled information to the caller.

We now save the current struct ref_list item before calling back
into the callback function so that future calls to peel_ref from
within the callback function can quickly access the current ref.
Doing so will save us an lstat() per ref processed as we no longer
have to check the filesystem to see if the ref exists as a loose
file or is packed.  This current ref caching also saves a linear
scan of the cached packed refs list.

As a micro-optimization we test the address of the passed ref name
against the current_ref->name before we go into the much more costly
strcmp().  Nearly any caller of peel_ref will be passing us the same
string do_for_each_ref passed them, which is current_ref->name.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 refs.c |   25 ++++++++++++++++++++-----
 1 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index fb33da1..c979fb1 100644
--- a/refs.c
+++ b/refs.c
@@ -157,6 +157,7 @@ static struct cached_refs {
 	struct ref_list *loose;
 	struct ref_list *packed;
 } cached_refs;
+static struct ref_list *current_ref;
 
 static void free_ref_list(struct ref_list *list)
 {
@@ -476,6 +477,7 @@ static int do_one_ref(const char *base, each_ref_fn fn, int trim,
 		error("%s does not point to a valid object!", entry->name);
 		return 0;
 	}
+	current_ref = entry;
 	return fn(entry->name + trim, entry->sha1, entry->flag, cb_data);
 }
 
@@ -485,6 +487,16 @@ int peel_ref(const char *ref, unsigned char *sha1)
 	unsigned char base[20];
 	struct object *o;
 
+	if (current_ref && (current_ref->name == ref
+		|| !strcmp(current_ref->name, ref))) {
+		if (current_ref->flag & REF_KNOWS_PEELED) {
+			hashcpy(sha1, current_ref->peeled);
+			return 0;
+		}
+		hashcpy(base, current_ref->sha1);
+		goto fallback;
+	}
+
 	if (!resolve_ref(ref, base, 1, &flag))
 		return -1;
 
@@ -504,7 +516,7 @@ int peel_ref(const char *ref, unsigned char *sha1)
 		}
 	}
 
-	/* fallback - callers should not call this for unpacked refs */
+fallback:
 	o = parse_object(base);
 	if (o && o->type == OBJ_TAG) {
 		o = deref_tag(o, ref, 0);
@@ -519,7 +531,7 @@ int peel_ref(const char *ref, unsigned char *sha1)
 static int do_for_each_ref(const char *base, each_ref_fn fn, int trim,
 			   void *cb_data)
 {
-	int retval;
+	int retval = 0;
 	struct ref_list *packed = get_packed_refs();
 	struct ref_list *loose = get_loose_refs();
 
@@ -539,15 +551,18 @@ static int do_for_each_ref(const char *base, each_ref_fn fn, int trim,
 		}
 		retval = do_one_ref(base, fn, trim, cb_data, entry);
 		if (retval)
-			return retval;
+			goto end_each;
 	}
 
 	for (packed = packed ? packed : loose; packed; packed = packed->next) {
 		retval = do_one_ref(base, fn, trim, cb_data, packed);
 		if (retval)
-			return retval;
+			goto end_each;
 	}
-	return 0;
+
+end_each:
+	current_ref = NULL;
+	return retval;
 }
 
 int head_ref(each_ref_fn fn, void *cb_data)
-- 
1.5.4.3.295.g6b554
