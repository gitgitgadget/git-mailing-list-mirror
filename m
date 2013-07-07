From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/4] describe/name-rev: tell name-rev to peel the incoming object to commit first
Date: Sun,  7 Jul 2013 15:33:44 -0700
Message-ID: <1373236424-25617-5-git-send-email-gitster@pobox.com>
References: <1373236424-25617-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 08 00:34:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvxWx-00050T-Gg
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 00:34:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753274Ab3GGWeC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 18:34:02 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32900 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753268Ab3GGWdy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 18:33:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A1B52EAB1
	for <git@vger.kernel.org>; Sun,  7 Jul 2013 22:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=aMp2
	ldFcM94XqrHw2/f4Hced8p8=; b=RIOqNNXzQOiDVuZ5mQ7kCN2Vl8zQx0SXzz12
	3IIVD78Ze4JWyhxfls9PvapT9QdE6nAyWhst9MArE2s9pFWENO3a9QCkKGtdHXFW
	58HrcxvrAVZMA26jRU3H1dliOYCz5VmxgLPSmeAaHaw1LhUzJ7tQOHff+z34bwKH
	BcjJEEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=gIDiV/
	852jDPgB3i0c84UzR0SkmKRQapgPhTno0/LyBKB0k6VwKZs1DwP7tZ3fvP17NV75
	35vPfrwXDQG0i0NWvl++rIRW3qfJbEzZgF9nteani8TYxqKqQWu6aSYf4EpYmopd
	Wx2X+uQfetLGvEciAjOizrTAGtQ2XvVQhQolM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 412A82EAAE
	for <git@vger.kernel.org>; Sun,  7 Jul 2013 22:33:54 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 86FEE2EA90
	for <git@vger.kernel.org>; Sun,  7 Jul 2013 22:33:53 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.2-853-ga8cbcc9
In-Reply-To: <1373236424-25617-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 4DA780C8-E755-11E2-A77D-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229815>

With this on top of the other patches in this series, you would get:

    $ git describe --contains $(git rev-parse v1.8.3 v1.8.3^0)
    v1.8.3
    v1.8.3

while you can still differentiate tags and the commits they point at
with:

    $ git name-rev --refs=tags/\* --name-only $(git rev-parse v1.8.3 v1.8.3^0)
    v1.8.3
    v1.8.3^0

The difference in these two behaviours is achieved by adding --peel-to-commit
option to "name-rev" and using it when "describe" internally calls it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/describe.c |  1 +
 builtin/name-rev.c | 35 +++++++++++++++++++++++++----------
 2 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index b5434e4..f7adda6 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -447,6 +447,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 
 		argv_array_init(&args);
 		argv_array_push(&args, "name-rev");
+		argv_array_push(&args, "--peel-to-commit");
 		argv_array_push(&args, "--name-only");
 		argv_array_push(&args, "--no-undefined");
 		if (always)
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 29a6f56..fa37731 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -15,6 +15,7 @@ typedef struct rev_name {
 } rev_name;
 
 static long cutoff = LONG_MAX;
+static int peel_to_commit;
 
 /* How many generations are maximally preferred over _one_ merge traversal? */
 #define MERGE_TRAVERSAL_WEIGHT 65535
@@ -33,7 +34,7 @@ static void name_rev(struct commit *commit,
 	if (commit->date < cutoff)
 		return;
 
-	if (deref) {
+	if (deref && !peel_to_commit) {
 		char *new_name = xmalloc(strlen(tip_name)+3);
 		strcpy(new_name, tip_name);
 		strcat(new_name, "^0");
@@ -320,6 +321,8 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN(0, "undefined", &allow_undefined, N_("allow to print `undefined` names")),
 		OPT_BOOLEAN(0, "always",     &always,
 			   N_("show abbreviated commit object as fallback")),
+		OPT_BOOLEAN(0, "peel-to-commit", &peel_to_commit,
+			    N_("peel tag object names in the input to a commmit")),
 		OPT_END(),
 	};
 
@@ -334,7 +337,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 
 	for (; argc; argc--, argv++) {
 		unsigned char sha1[20];
-		struct object *o;
+		struct object *object;
 		struct commit *commit;
 
 		if (get_sha1(*argv, sha1)) {
@@ -343,17 +346,29 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
-		o = deref_tag(parse_object(sha1), *argv, 0);
-		if (!o || o->type != OBJ_COMMIT) {
+		commit = NULL;
+		object = parse_object(sha1);
+		if (object) {
+			struct object *peeled = deref_tag(object, *argv, 0);
+			if (peeled && peeled->type == OBJ_COMMIT)
+				commit = (struct commit *) peeled;
+		}
+
+		if (!object) {
+			fprintf(stderr, "Could not get object for %s. Skipping.\n",
+				*argv);
+			continue;
+		}
+		if (peel_to_commit && !commit) {
 			fprintf(stderr, "Could not get commit for %s. Skipping.\n",
-					*argv);
+				*argv);
 			continue;
 		}
-
-		commit = (struct commit *)o;
-		if (cutoff > commit->date)
-			cutoff = commit->date;
-		add_object_array((struct object *)commit, *argv, &revs);
+		if (commit) {
+			if (cutoff > commit->date)
+				cutoff = commit->date;
+		}
+		add_object_array(object, *argv, &revs);
 	}
 
 	if (cutoff)
-- 
1.8.3.2-853-ga8cbcc9
