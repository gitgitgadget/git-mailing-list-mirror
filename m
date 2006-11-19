X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] do_for_each_ref: perform the same sanity check for leftovers.
Date: Sat, 18 Nov 2006 22:13:33 -0800
Message-ID: <7vr6w07ylu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 19 Nov 2006 06:13:57 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31825>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Glfw5-00076K-La for gcvg-git@gmane.org; Sun, 19 Nov
 2006 07:13:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756469AbWKSGNf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 19 Nov 2006
 01:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756471AbWKSGNf
 (ORCPT <rfc822;git-outgoing>); Sun, 19 Nov 2006 01:13:35 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:50069 "EHLO
 fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP id S1756469AbWKSGNe
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 19 Nov 2006 01:13:34 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061119061334.RDPW5465.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>; Sun, 19
 Nov 2006 01:13:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id oWD51V00Y1kojtg0000000; Sun, 19 Nov 2006
 01:13:06 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

An earlier commit b37a562a added a check to see if the ref
points at a valid object (as a part of 'negative ref' support
which we currently do not use), but did so only while iterating
over both packed and loose refs, and forgot to apply the same
check while iterating over the remaining ones.

We might want to replace the "if null then omit it" check with
"eh --- what business does a 0{40} value have here?" complaint
later since we currently do not use negative refs, but that is
a separate issue.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * "pickaxe -L'/^static int do_for_each_ref/,+40' refs.c" turns
   out to be a very handy way to find out why a line I am
   interested in is in that shape.

   But it might be even better if it allowed us to say
   '-L/^static int do_for_each_ref/+20,+20'.

diff --git a/refs.c b/refs.c
index f003a0b..6abd12f 100644
--- a/refs.c
+++ b/refs.c
@@ -322,6 +322,20 @@ int read_ref(const char *ref, unsigned c
 	return -1;
 }
 
+static inline int do_one_ref(const char *base, each_ref_fn fn, int trim,
+			     void *cb_data, struct ref_list *entry)
+{
+	if (strncmp(base, entry->name, trim))
+		return 0;
+	if (is_null_sha1(entry->sha1))
+		return 0;
+	if (!has_sha1_file(entry->sha1)) {
+		error("%s does not point to a valid object!", entry->name);
+		return 0;
+	}
+	return fn(entry->name + trim, entry->sha1, entry->flag, cb_data);
+}
+
 static int do_for_each_ref(const char *base, each_ref_fn fn, int trim,
 			   void *cb_data)
 {
@@ -343,29 +357,15 @@ static int do_for_each_ref(const char *b
 			entry = packed;
 			packed = packed->next;
 		}
-		if (strncmp(base, entry->name, trim))
-			continue;
-		if (is_null_sha1(entry->sha1))
-			continue;
-		if (!has_sha1_file(entry->sha1)) {
-			error("%s does not point to a valid object!", entry->name);
-			continue;
-		}
-		retval = fn(entry->name + trim, entry->sha1,
-			    entry->flag, cb_data);
+		retval = do_one_ref(base, fn, trim, cb_data, entry);
 		if (retval)
 			return retval;
 	}
 
-	packed = packed ? packed : loose;
-	while (packed) {
-		if (!strncmp(base, packed->name, trim)) {
-			retval = fn(packed->name + trim, packed->sha1,
-				    packed->flag, cb_data);
-			if (retval)
-				return retval;
-		}
-		packed = packed->next;
+	for (packed = packed ? packed : loose; packed; packed = packed->next) {
+		retval = do_one_ref(base, fn, trim, cb_data, packed);
+		if (retval)
+			return retval;
 	}
 	return 0;
 }
