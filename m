From: Jeff King <peff@peff.net>
Subject: [PATCH v2 2/4] use parse_object_or_die instead of die("bad object")
Date: Sun, 17 Mar 2013 04:23:31 -0400
Message-ID: <20130317082331.GB29550@sigill.intra.peff.net>
References: <20130317082139.GA29505@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 17 09:24:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UH8ss-0000uG-QI
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 09:24:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756066Ab3CQIXg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Mar 2013 04:23:36 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54175 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756023Ab3CQIXd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Mar 2013 04:23:33 -0400
Received: (qmail 7745 invoked by uid 107); 17 Mar 2013 08:25:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 17 Mar 2013 04:25:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Mar 2013 04:23:31 -0400
Content-Disposition: inline
In-Reply-To: <20130317082139.GA29505@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218347>

Some call-sites do:

  o = parse_object(sha1);
  if (!o)
	  die("bad object %s", some_name);

We can now handle that as a one-liner, and get more
consistent output.

In the third case of this patch, it looks like we are losing
information, as the existing message also outputs the sha1
hex; however, parse_object will already have written a more
specific complaint about the sha1, so there is no point in
repeating it here.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/grep.c  | 4 +---
 builtin/prune.c | 4 +---
 reachable.c     | 4 +---
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 8025964..159e65d 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -820,9 +820,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		unsigned char sha1[20];
 		/* Is it a rev? */
 		if (!get_sha1(arg, sha1)) {
-			struct object *object = parse_object(sha1);
-			if (!object)
-				die(_("bad object %s"), arg);
+			struct object *object = parse_object_or_die(sha1, arg);
 			if (!seen_dashdash)
 				verify_non_filename(prefix, arg);
 			add_object_array(object, arg, &list);
diff --git a/builtin/prune.c b/builtin/prune.c
index 8cb8b91..85843d4 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -149,9 +149,7 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 		const char *name = *argv++;
 
 		if (!get_sha1(name, sha1)) {
-			struct object *object = parse_object(sha1);
-			if (!object)
-				die("bad object: %s", name);
+			struct object *object = parse_object_or_die(sha1, name);
 			add_pending_object(&revs, object, "");
 		}
 		else
diff --git a/reachable.c b/reachable.c
index bf79706..e7e6a1e 100644
--- a/reachable.c
+++ b/reachable.c
@@ -152,11 +152,9 @@ static int add_one_ref(const char *path, const unsigned char *sha1, int flag, vo
 
 static int add_one_ref(const char *path, const unsigned char *sha1, int flag, void *cb_data)
 {
-	struct object *object = parse_object(sha1);
+	struct object *object = parse_object_or_die(sha1, path);
 	struct rev_info *revs = (struct rev_info *)cb_data;
 
-	if (!object)
-		die("bad object ref: %s:%s", path, sha1_to_hex(sha1));
 	add_pending_object(revs, object, "");
 
 	return 0;
-- 
1.8.2.rc2.7.gef06216
