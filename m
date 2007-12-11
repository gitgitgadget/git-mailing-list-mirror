From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Invert numbers and names in the git-shortlog summary mode.
Date: Tue, 11 Dec 2007 10:09:04 -0800
Message-ID: <7vr6htdry7.fsf@gitster.siamese.dyndns.org>
References: <20071207093439.GA21896@elte.hu>
	<200712080636.12982.chriscool@tuxfamily.org>
	<20071211092446.GA4703@elte.hu>
	<20071211092916.GF30948@artemis.madism.org>
	<m3ve75sfn3.fsf@roke.D-201>
	<20071211115914.GJ30948@artemis.madism.org>
	<20071211122539.GA13945@sigill.intra.peff.net>
	<20071211140508.GA12204@elte.hu>
	<20071211144351.GA15448@artemis.madism.org>
	<20071211145709.GB19427@elte.hu>
	<20071211152412.GB15448@artemis.madism.org>
	<alpine.LFD.0.99999.0712111032530.555@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>, Ingo Molnar <mingo@elte.hu>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 19:10:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J29YH-0003Zs-0O
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 19:09:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754262AbXLKSJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 13:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754239AbXLKSJ1
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 13:09:27 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48917 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602AbXLKSJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 13:09:26 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F974549F;
	Tue, 11 Dec 2007 13:09:15 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 96D355496;
	Tue, 11 Dec 2007 13:09:06 -0500 (EST)
In-Reply-To: <alpine.LFD.0.99999.0712111032530.555@xanadu.home> (Nicolas
	Pitre's message of "Tue, 11 Dec 2007 10:34:01 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67896>

Nicolas Pitre <nico@cam.org> writes:

> On Tue, 11 Dec 2007, Pierre Habouzit wrote:
> ...
>> Sometimes history hurts :) I don't think there is much we can do on a
>> short timescale. Maybe the old way can be slowly deprecated, and then
>> git-shortlog will be able to act like git-log.
>
> At least, HEAD could be assumed by default when stdin is a tty.

I'd say I agree.

-- >8 --
shortlog: default ot HEAD when standard input is a tty

Instead of warning the user that it is expecting git log output from the
standard input (and instructing to type the log from the keyboard),
default to traverse from HEAD when there is no rev parameter given.

This factors out a useful helper "add_head()" from builtin-diff.c to a
more appropriate place revision.c while renaming it to more descriptive
name add_head_to_pending(), as that is what the function is about.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 builtin-shortlog.c |    5 +++--
 builtin-diff.c     |   14 +-------------
 builtin-log.c      |    5 +----
 revision.c         |   12 ++++++++++++
 revision.h         |    2 ++
 5 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index 90666cb..3d8d709 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -249,9 +249,10 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 
 	read_mailmap(&mailmap, ".mailmap", &common_repo_prefix);
 
+	/* assume HEAD if from a tty */
+	if (!rev.pending.nr && isatty(0))
+		add_head_to_pending(&rev);
 	if (rev.pending.nr == 0) {
-		if (isatty(0))
-			fprintf(stderr, "(reading log to summarize from standard input)\n");
 		read_from_stdin(&list);
 	}
 	else
diff --git a/builtin-diff.c b/builtin-diff.c
index 1b61599..55fb84c 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -176,18 +176,6 @@ static int builtin_diff_combined(struct rev_info *revs,
 	return 0;
 }
 
-void add_head(struct rev_info *revs)
-{
-	unsigned char sha1[20];
-	struct object *obj;
-	if (get_sha1("HEAD", sha1))
-		return;
-	obj = parse_object(sha1);
-	if (!obj)
-		return;
-	add_pending_object(revs, obj, "HEAD");
-}
-
 static void refresh_index_quietly(void)
 {
 	struct lock_file *lock_file;
@@ -272,7 +260,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 			if (!strcmp(arg, "--"))
 				break;
 			else if (!strcmp(arg, "--cached")) {
-				add_head(&rev);
+				add_head_to_pending(&rev);
 				if (!rev.pending.nr)
 					die("No HEAD commit to compare with (yet)");
 				break;
diff --git a/builtin-log.c b/builtin-log.c
index e1f1cf6..d375c9d 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -18,9 +18,6 @@
 static int default_show_root = 1;
 static const char *fmt_patch_subject_prefix = "PATCH";
 
-/* this is in builtin-diff.c */
-void add_head(struct rev_info *revs);
-
 static void add_name_decoration(const char *prefix, const char *name, struct object *obj)
 {
 	int plen = strlen(prefix);
@@ -746,7 +743,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			 * does not have.
 			 */
 			rev.pending.objects[0].item->flags |= UNINTERESTING;
-			add_head(&rev);
+			add_head_to_pending(&rev);
 		}
 		/*
 		 * Otherwise, it is "format-patch -22 HEAD", and/or
diff --git a/revision.c b/revision.c
index 2a59035..7e2f4f1 100644
--- a/revision.c
+++ b/revision.c
@@ -139,6 +139,18 @@ void add_pending_object(struct rev_info *revs, struct object *obj, const char *n
 	add_pending_object_with_mode(revs, obj, name, S_IFINVALID);
 }
 
+void add_head_to_pending(struct rev_info *revs)
+{
+	unsigned char sha1[20];
+	struct object *obj;
+	if (get_sha1("HEAD", sha1))
+		return;
+	obj = parse_object(sha1);
+	if (!obj)
+		return;
+	add_pending_object(revs, obj, "HEAD");
+}
+
 static struct object *get_reference(struct rev_info *revs, const char *name, const unsigned char *sha1, unsigned int flags)
 {
 	struct object *object;
diff --git a/revision.h b/revision.h
index 992e1e9..8572315 100644
--- a/revision.h
+++ b/revision.h
@@ -130,6 +130,8 @@ extern void add_object(struct object *obj,
 
 extern void add_pending_object(struct rev_info *revs, struct object *obj, const char *name);
 
+extern void add_head_to_pending(struct rev_info *);
+
 enum commit_action {
 	commit_ignore,
 	commit_show,
