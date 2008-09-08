From: Jeff King <peff@peff.net>
Subject: Re: Is "show-ref -h" a good test for an empty repository?
Date: Mon, 8 Sep 2008 10:42:00 -0400
Message-ID: <20080908144159.GA10331@coredump.intra.peff.net>
References: <48C1D2AE.3010001@feds.uwaterloo.ca> <20080906012941.GA2009@coredump.intra.peff.net> <48C3E35C.2050903@feds.uwaterloo.ca> <20080907155033.GA25031@coredump.intra.peff.net> <7vprnfn9pz.fsf@gitster.siamese.dyndns.org> <20080907173434.GA26182@coredump.intra.peff.net> <48C52797.3030500@feds.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eric Gerlach <egerlach@feds.uwaterloo.ca>
X-From: git-owner@vger.kernel.org Mon Sep 08 16:43:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KchxQ-00077d-8h
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 16:43:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752168AbYIHOmF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 10:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752050AbYIHOmE
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 10:42:04 -0400
Received: from peff.net ([208.65.91.99]:2257 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750820AbYIHOmD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 10:42:03 -0400
Received: (qmail 19334 invoked by uid 111); 8 Sep 2008 14:42:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 08 Sep 2008 10:42:01 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Sep 2008 10:42:00 -0400
Content-Disposition: inline
In-Reply-To: <48C52797.3030500@feds.uwaterloo.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95254>

On Mon, Sep 08, 2008 at 09:24:39AM -0400, Eric Gerlach wrote:

> The case I'm looking to protect against is the following:
>
> $ mkdir -p new-repo/debian
> $ cd new-repo
> $ git init
> $ vi debian/changelog (add a few lines)
> $ git add debian/changelog
> $ debcommit
>
> (which runs
> $ git diff --cached debian/changelog)
>
> If I can test before the git-diff, then I can run "diff debian/changelog  
> /dev/null" instead of the git-diff and all is well.

In that case, I would use the "rev-parse --verify HEAD" I mentioned,
since it exactly covers the situation you are trying to avoid.  What you
are saying is something like:

  if there is a previous commit on the current branch
    diff against previous commit on the current branch
  else
    diff against /dev/null

So your "show-ref" attempt could actually say "yes, the repo is
non-empty" but your diff would still fail (because the commits just
weren't on the current branch).


As an aside, it's too bad "--root" isn't more widely supported. Then

  git diff --root --cached

would do what you want without the need for any conditionals. But it
seems that --root only works between trees. Something like the patch
below would help, but I'm sure this is covering only one of many cases.

---

diff --git a/builtin-diff.c b/builtin-diff.c
index 52470c7..43db970 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -317,8 +317,11 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
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
