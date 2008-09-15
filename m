From: Jeff King <peff@peff.net>
Subject: Re: Diff-tree does not work for initial commit
Date: Mon, 15 Sep 2008 18:34:43 -0400
Message-ID: <20080915223442.GD20677@sigill.intra.peff.net>
References: <3665a1a00809151301p7d8e6387g3cacfb879b45da2f@mail.gmail.com> <48CECA42.1050209@drmicha.warpmail.net> <bd6139dc0809151411p49f5adeaq4beff452574ca980@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Anatol Pomozov <anatol.pomozov@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Tue Sep 16 00:36:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfMfs-0001ea-BT
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 00:36:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757209AbYIOWev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 18:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757196AbYIOWeu
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 18:34:50 -0400
Received: from peff.net ([208.65.91.99]:3156 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757182AbYIOWet (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 18:34:49 -0400
Received: (qmail 18735 invoked by uid 111); 15 Sep 2008 22:34:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 15 Sep 2008 18:34:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Sep 2008 18:34:43 -0400
Content-Disposition: inline
In-Reply-To: <bd6139dc0809151411p49f5adeaq4beff452574ca980@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95949>

On Mon, Sep 15, 2008 at 11:11:30PM +0200, Sverre Rabbelier wrote:

> Some of my code uses "git rev-parse" on "HEAD^" to see if a commit has
> a parent; I wouldn't be surprised if someone else has a script that
> uses "git diff-tree" or such for that purpose, or at least assumes
> that for a root commit it will complain. Anyway, as Junio said, for
> "diff-tree" you can use the "--root" option. A better RFE would
> perhaps be that "--root" be supported in more places.

I posted this a week or so ago, but I am sure it is incomplete. If there
is interest I can clean it up and do a proper submission.

---
diff --git a/builtin-diff.c b/builtin-diff.c
index 76651bd..4151900 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -332,8 +332,11 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 				break;
 			else if (!strcmp(arg, "--cached")) {
 				add_head_to_pending(&rev);
-				if (!rev.pending.nr)
-					die("No HEAD commit to compare with (yet)");
+				if (!rev.pending.nr) {
+					if (!rev.show_root_diff)
+						die("No HEAD commit to compare with (yet)");
+					add_empty_to_pending(&rev);
+				}
 				break;
 			}
 		}
diff --git a/revision.c b/revision.c
index 2f646de..7ec3990 100644
--- a/revision.c
+++ b/revision.c
@@ -145,16 +145,27 @@ void add_pending_object(struct rev_info *revs, struct object *obj, const char *n
 	add_pending_object_with_mode(revs, obj, name, S_IFINVALID);
 }
 
-void add_head_to_pending(struct rev_info *revs)
+static void add_to_pending_by_name(struct rev_info *revs, const char *name)
 {
 	unsigned char sha1[20];
 	struct object *obj;
-	if (get_sha1("HEAD", sha1))
+	if (get_sha1(name, sha1))
 		return;
 	obj = parse_object(sha1);
 	if (!obj)
 		return;
-	add_pending_object(revs, obj, "HEAD");
+	add_pending_object(revs, obj, name);
+}
+
+void add_head_to_pending(struct rev_info *revs)
+{
+	add_to_pending_by_name(revs, "HEAD");
+}
+
+void add_empty_to_pending(struct rev_info *revs)
+{
+	add_to_pending_by_name(revs,
+			"4b825dc642cb6eb9a060e54bf8d69288fbee4904");
 }
 
 static struct object *get_reference(struct rev_info *revs, const char *name, const unsigned char *sha1, unsigned int flags)
diff --git a/revision.h b/revision.h
index 2fdb2dd..8c990d5 100644
--- a/revision.h
+++ b/revision.h
@@ -152,6 +152,7 @@ extern void add_object(struct object *obj,
 extern void add_pending_object(struct rev_info *revs, struct object *obj, const char *name);
 
 extern void add_head_to_pending(struct rev_info *);
+extern void add_empty_to_pending(struct rev_info *);
 
 enum commit_action {
 	commit_ignore,
