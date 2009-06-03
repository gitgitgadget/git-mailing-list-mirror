From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Patch] Prevent cloning over http from spewing
Date: Wed, 03 Jun 2009 11:28:40 -0700
Message-ID: <7vmy8p8947.fsf@alter.siamese.dyndns.org>
References: <20090602174229.GA14455@infidigm.net>
	<m3vdnda9f7.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sparse@infidigm.net, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 20:28:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBvCk-0002x9-JO
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 20:28:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752163AbZFCS2l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 14:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751595AbZFCS2k
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 14:28:40 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:58896 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751536AbZFCS2j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 14:28:39 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090603182841.YPUG20430.fed1rmmtao105.cox.net@fed1rmimpo03.cox.net>;
          Wed, 3 Jun 2009 14:28:41 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id zWUh1b0084aMwMQ04WUhau; Wed, 03 Jun 2009 14:28:41 -0400
X-VR-Score: -320.00
X-Authority-Analysis: v=1.0 c=1 a=ZkhMCfy6vnwA:10 a=_RqQhl_5OWQA:10
 a=pGLkceISAAAA:8 a=FK0TcsC6EXWazwQs7VAA:9 a=jrkC2ufegprgsJ-fu4AA:7
 a=gl0PuV29PsCIYXjmmUuG4gCmD_YA:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120626>

Jakub Narebski <jnareb@gmail.com> writes:

> Finally a question: if we turn off verbose output, do we have any kind
> of progress info fot git-clone over http?

This was discussed before.

For example, Shawn wrote in September 2007 in $gmane/59433

    ... Few people really grok the pack-objects/index-pack output, nor do they
    care.  They just want to know two things:

      - Is git working or frozen in limbo?
      - Is git frozen because my network sucks, or git sucks?
      - When will this be done?  Please $DIETY, I want to go home!
        Make the fetch finish!

    The C based git-fetch made the http protocol almost totally silent.
    (No more got/walk messages.)  But that's actually also bad as it
    now doesn't even let you know its transferring anything at all.

You _could_ do something like this patch.  Instead of showing "walk %s"
and "got %s" lines, with occasional "Getting pack %s\n which contains %s",
it shows and recycles a single line that shows the number of packs, walk
actions and got actions.

This is a toy patch; it hiccups for too long while getting each pack, and
it does not cleanly restore the display after it finishes, but I'll leave
it to interested readers as an exercise to properly do this using the
progress API.

Currently many http related patches are in flight, so it may not be the
best time to do so, though.

 http-walker.c |   11 +++--------
 walker.c      |   21 +++++++++++++++++----
 walker.h      |   10 +++++++++-
 3 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/http-walker.c b/http-walker.c
index 7321ccc..3303bc1 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -256,7 +256,7 @@ static void finish_object_request(struct object_request *obj_req)
 		move_temp_to_file(obj_req->tmpfile, obj_req->filename);
 
 	if (obj_req->rename == 0)
-		walker_say(obj_req->walker, "got %s\n", sha1_to_hex(obj_req->sha1));
+		walker_progress(obj_req->walker, WALKER_GOT);
 }
 
 static void process_object_response(void *callback_data)
@@ -733,12 +733,7 @@ static int fetch_pack(struct walker *walker, struct alt_base *repo, unsigned cha
 	if (!target)
 		return -1;
 
-	if (walker->get_verbosely) {
-		fprintf(stderr, "Getting pack %s\n",
-			sha1_to_hex(target->sha1));
-		fprintf(stderr, " which contains %s\n",
-			sha1_to_hex(sha1));
-	}
+	walker_progress(walker, WALKER_PACK);
 
 	url = xmalloc(strlen(repo->base) + 65);
 	sprintf(url, "%s/objects/pack/pack-%s.pack",
@@ -907,7 +902,7 @@ struct walker *get_http_walker(const char *url, struct remote *remote)
 {
 	char *s;
 	struct walker_data *data = xmalloc(sizeof(struct walker_data));
-	struct walker *walker = xmalloc(sizeof(struct walker));
+	struct walker *walker = xcalloc(1, sizeof(struct walker));
 
 	http_init(remote);
 
diff --git a/walker.c b/walker.c
index e57630e..aaf3e2c 100644
--- a/walker.c
+++ b/walker.c
@@ -9,10 +9,23 @@
 
 static unsigned char current_commit_sha1[20];
 
-void walker_say(struct walker *walker, const char *fmt, const char *hex)
+void walker_progress(struct walker *walker, enum walker_action action)
 {
-	if (walker->get_verbosely)
-		fprintf(stderr, fmt, hex);
+	switch (action) {
+	default:
+		break;
+	case WALKER_GOT:
+		walker->got++;
+		break;
+	case WALKER_WALK:
+		walker->walked++;
+		break;
+	case WALKER_PACK:
+		walker->got_pack++;
+		break;
+	}
+	fprintf(stderr, "pack %-5u walk %-10lu got %-10lu\r",
+		walker->got_pack, walker->walked, walker->got);
 }
 
 static void report_missing(const struct object *obj)
@@ -83,7 +96,7 @@ static int process_commit(struct walker *walker, struct commit *commit)
 
 	hashcpy(current_commit_sha1, commit->object.sha1);
 
-	walker_say(walker, "walk %s\n", sha1_to_hex(commit->object.sha1));
+	walker_progress(walker, WALKER_WALK);
 
 	if (walker->get_tree) {
 		if (process(walker, &commit->tree->object))
diff --git a/walker.h b/walker.h
index 8a149e1..5e7c1f6 100644
--- a/walker.h
+++ b/walker.h
@@ -9,6 +9,9 @@ struct walker {
 	void (*prefetch)(struct walker *, unsigned char *sha1);
 	int (*fetch)(struct walker *, unsigned char *sha1);
 	void (*cleanup)(struct walker *);
+	unsigned long walked;
+	unsigned long got;
+	unsigned got_pack;
 	int get_tree;
 	int get_history;
 	int get_all;
@@ -19,7 +22,12 @@ struct walker {
 };
 
 /* Report what we got under get_verbosely */
-void walker_say(struct walker *walker, const char *, const char *);
+enum walker_action {
+	WALKER_GOT,
+	WALKER_WALK,
+	WALKER_PACK,
+};
+void walker_progress(struct walker *, enum walker_action);
 
 /* Load pull targets from stdin */
 int walker_targets_stdin(char ***target, const char ***write_ref);
