From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH/RFC] upload-pack: stop "ack continue" when we know common commits for wanted refs
Date: Fri, 26 May 2006 19:20:54 -0700
Message-ID: <7vfyiwi4xl.fsf@assigned-by-dhcp.cox.net>
References: <20060524131022.GA11449@linux-mips.org>
	<Pine.LNX.4.64.0605240931480.5623@g5.osdl.org>
	<Pine.LNX.4.64.0605240947580.5623@g5.osdl.org>
	<7v64jv8fdx.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605241200110.5623@g5.osdl.org>
	<Pine.LNX.4.64.0605241641250.5623@g5.osdl.org>
	<7vd5e23n5a.fsf@assigned-by-dhcp.cox.net>
	<7vd5e21zh9.fsf@assigned-by-dhcp.cox.net>
	<20060526154239.GA20839@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sat May 27 04:21:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjoQF-00035S-2H
	for gcvg-git@gmane.org; Sat, 27 May 2006 04:20:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964895AbWE0CU4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 May 2006 22:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964897AbWE0CU4
	(ORCPT <rfc822;git-outgoing>); Fri, 26 May 2006 22:20:56 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:54516 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S964895AbWE0CUz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 May 2006 22:20:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060527022055.CVZT19284.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 26 May 2006 22:20:55 -0400
To: Ralf Baechle <ralf@linux-mips.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20827>

When the downloader's repository has more roots than the server
side has, the "have" exchange to figure out recent common
commits ends up traversing the whole history of branches that
only exist on the downloader's side.  When the downloader is
asking for newer commits on the branch that exists on both ends,
this is totally unnecessary.

This adds logic to the server side to see if the wanted refs can
reach the "have" commits received so far, and stop issuing "ack
continue" once all of them can be reached from "have" commits.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

  Ralf Baechle <ralf@linux-mips.org> writes:

    >> [PATCH] fetch-pack: give up after getting too many "ack continue"
    >
    > So I did test your patch.  In the big, slow repository it cuts down the
    > time for a
    >
    >   git fetch git://www./.../linux-2.6.16.y.git master:v2.6.16-stable
    >
    > from like 6min to about 7s.
    >
    > Thanks!

  This patch is still rough, but it passes my test of asking for
  "master" from git.git repository into a repository that is a
  merge between linux-2.6.git and a slightly older git.git.

  Without this change, and without the client-side hack Ralf
  tested, it ends up walking down the entire kernel history.

  The code to walk back from wanted ref is unnecessarily ugly and
  inefficient -- if we only support a handful want's (say 25) at a
  time, we could make the traversal go as we receive "have" by
  using something similar to what show-branches does.  I am
  reworking on that part.

 upload-pack.c |  182 ++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 167 insertions(+), 15 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 47560c9..e57733b 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -11,12 +11,18 @@ static const char upload_pack_usage[] = 
 #define THEY_HAVE (1U << 0)
 #define OUR_REF (1U << 1)
 #define WANTED (1U << 2)
+#define COMMON_KNOWN (1U << 3)
+
+#define TRACE_SEEN (1U << 4)
+#define TRACE_BASE 5
+#define MAX_TRACE 20 /* should not exceed bits_per_int - TRACE_BASE */
+
 #define MAX_HAS 256
 #define MAX_NEEDS 256
 static int nr_has = 0, nr_needs = 0, multi_ack = 0, nr_our_refs = 0;
 static int use_thin_pack = 0;
-static unsigned char has_sha1[MAX_HAS][20];
-static unsigned char needs_sha1[MAX_NEEDS][20];
+static struct object *has_sha1[MAX_HAS];
+static struct object *needs_sha1[MAX_NEEDS];
 static unsigned int timeout = 0;
 
 static void reset_timeout(void)
@@ -69,19 +75,22 @@ static void create_pack_file(void)
 		if (create_full_pack || MAX_NEEDS <= nr_needs)
 			*p++ = "--all";
 		else {
+			struct object **o = needs_sha1;
 			for (i = 0; i < nr_needs; i++) {
 				*p++ = buf;
-				memcpy(buf, sha1_to_hex(needs_sha1[i]), 41);
+				memcpy(buf, sha1_to_hex((*o++)->sha1), 41);
 				buf += 41;
 			}
 		}
-		if (!create_full_pack)
+		if (!create_full_pack) {
+			struct object **o = has_sha1;
 			for (i = 0; i < nr_has; i++) {
 				*p++ = buf;
 				*buf++ = '^';
-				memcpy(buf, sha1_to_hex(has_sha1[i]), 41);
+				memcpy(buf, sha1_to_hex((*o++)->sha1), 41);
 				buf += 41;
 			}
+		}
 		*p++ = NULL;
 		execv_git_cmd(argv);
 		die("git-upload-pack: unable to exec git-rev-list");
@@ -93,6 +102,125 @@ static void create_pack_file(void)
 	die("git-upload-pack: unable to exec git-pack-objects");
 }
 
+static int trace_want(struct object **trace, int cnt)
+{
+	/* start from these cnt objects, traverse the reachability
+	 * chain, without parsing new objects, to see if we can
+	 * reach objects they have.
+	 */
+	int i, j;
+	unsigned trace_flags = 0;
+	struct object_list *list = NULL;
+
+	for (i = 0; i < cnt; i++)
+		trace_flags |= (1U << (TRACE_BASE + i));
+
+	for (i = 0; i < obj_allocs; i++)
+		if (objs[i])
+			objs[i]->flags &= ~trace_flags;
+
+	for (i = 0; i < cnt; i++) {
+		trace[i]->flags |= 1U << (TRACE_BASE + i);
+		object_list_insert(trace[i], &list);
+	}
+
+	while (list) {
+		struct object_list *next = list->next;
+		struct object *o = list->item;
+		unsigned flags = o->flags & trace_flags;
+
+		free(list);
+		list = next;
+		if (o->flags & TRACE_SEEN)
+			continue;
+		o->flags |= TRACE_SEEN;
+		if (!strcmp(o->type, tag_type)) {
+			o = deref_tag(o, NULL, 0);
+			if (o && (o->flags & trace_flags) != flags) {
+				o->flags |= flags;
+				object_list_insert(o, &list);
+			}
+			continue;
+		}
+		if (!strcmp(o->type, commit_type)) {
+			struct commit *c = (struct commit *)o;
+			struct commit_list *l = c->parents;
+			while (l) {
+				struct commit *p = l->item;
+				l = l->next;
+				if ((p->object.flags & trace_flags) != flags) {
+					p->object.flags |= flags;
+					object_list_insert(&p->object, &list);
+				}
+			}
+		}
+	}
+
+	/* Now scan the objects they have, and see if the wanted one
+	 * reach which ones.
+	 */
+	for (j = 0; j < nr_needs; j++) {
+		for (i = 0;
+		     (i < nr_has &&
+		      !(needs_sha1[j]->flags & COMMON_KNOWN));
+		     i++) {
+			if (has_sha1[i]->flags & (1U << (TRACE_BASE + j)))
+				needs_sha1[j]->flags |= COMMON_KNOWN;
+		}
+	}
+
+	for (j = 0; j < nr_needs; j++) {
+		if (!(needs_sha1[j]->flags & COMMON_KNOWN))
+			return 1;
+	}
+	return 0;
+}
+
+static void check_want_heads(void)
+{
+	/* Do not keep saying "ack continue" if we already know
+	 * common ancestor for all the "want"ed heads.  This is
+	 * particularly important if some of the "have" heads does
+	 * not share any root commit with us.  Otherwise we would
+	 * keep asking for that branch, hoping we might get a better
+	 * common ancestor than we already have.
+	 */
+	int i, still_missing;
+	struct object *trace[MAX_TRACE];
+	int trace_bit;
+
+	if (!multi_ack)
+		return;
+
+	still_missing = 0;
+	trace_bit = 0;
+	for (i = 0; still_missing && i < nr_needs; i++) {
+		struct object *o = needs_sha1[i];
+		if (o->flags & COMMON_KNOWN)
+			continue;
+		if (strcmp(o->type, tag_type) &&
+		    strcmp(o->type, commit_type))
+			/* Asking for non traceable types - there
+			 * is not much we can do to optimize it here.
+			 * We will let rev-list deal with it.
+			 */
+			continue;
+		if (trace_bit < MAX_TRACE) {
+			trace[trace_bit] = o;
+			trace_bit++;
+		}
+		else {
+			still_missing = trace_want(trace, trace_bit);
+			trace_bit = 0;
+		}
+	}
+	if (trace_bit && !still_missing)
+		still_missing = trace_want(trace, trace_bit);
+
+	if (!still_missing)
+		multi_ack = 0;
+}
+
 static int got_sha1(char *hex, unsigned char *sha1)
 {
 	if (get_sha1_hex(hex, sha1))
@@ -107,15 +235,39 @@ static int got_sha1(char *hex, unsigned 
 			die("oops (%s)", sha1_to_hex(sha1));
 		if (o->type == commit_type) {
 			struct commit_list *parents;
+			int we_knew_they_have = 0;
+
+			/* Because we deliberately stay behind by one
+			 * window in order to make the protocol
+			 * stream, many commits can already be in
+			 * flight when we notice that the latest one
+			 * in the series is already what we have.  Do
+			 * not waste the has_sha1[] slot for extra commits
+			 * sent that way.
+			 *
+			 * This relies on fetch-pack sending the "have"
+			 * lines without skipping.
+			 */
 			if (o->flags & THEY_HAVE)
-				return 0;
-			o->flags |= THEY_HAVE;
+				we_knew_they_have = 1;
+			else
+				o->flags |= THEY_HAVE;
 			for (parents = ((struct commit*)o)->parents;
 			     parents;
 			     parents = parents->next)
 				parents->item->object.flags |= THEY_HAVE;
+			if (we_knew_they_have)
+				return 0;
 		}
-		memcpy(has_sha1[nr_has++], sha1, 20);
+		has_sha1[nr_has++] = o;
+
+		/* Check to see if we know a common ancestor for
+		 * all the "want" heads, and if so turn multi_ack
+		 * off.  There is nothing more gained by further
+		 * exchange.
+		 */
+		check_want_heads();
+
 	}
 	return 1;
 }
@@ -141,7 +293,7 @@ static int get_common_commits(void)
 		len = strip(line, len);
 		if (!strncmp(line, "have ", 5)) {
 			if (got_sha1(line+5, sha1) &&
-					(multi_ack || nr_has == 1)) {
+			    (multi_ack || nr_has == 1)) {
 				if (nr_has >= MAX_HAS)
 					multi_ack = 0;
 				packet_write(1, "ACK %s%s\n",
@@ -156,7 +308,7 @@ static int get_common_commits(void)
 			if (nr_has > 0) {
 				if (multi_ack)
 					packet_write(1, "ACK %s\n",
-							sha1_to_hex(last_sha1));
+						     sha1_to_hex(last_sha1));
 				return 0;
 			}
 			packet_write(1, "NAK\n");
@@ -174,23 +326,21 @@ static int receive_needs(void)
 	needs = 0;
 	for (;;) {
 		struct object *o;
-		unsigned char dummy[20], *sha1_buf;
+		unsigned char sha1_buf[20];
 		len = packet_read_line(0, line, sizeof(line));
 		reset_timeout();
 		if (!len)
 			return needs;
 
-		sha1_buf = dummy;
 		if (needs == MAX_NEEDS) {
 			fprintf(stderr,
 				"warning: supporting only a max of %d requests. "
 				"sending everything instead.\n",
 				MAX_NEEDS);
 		}
-		else if (needs < MAX_NEEDS)
-			sha1_buf = needs_sha1[needs];
 
-		if (strncmp("want ", line, 5) || get_sha1_hex(line+5, sha1_buf))
+		if (strncmp("want ", line, 5) ||
+		    get_sha1_hex(line+5, sha1_buf))
 			die("git-upload-pack: protocol error, "
 			    "expected to get sha, not '%s'", line);
 		if (strstr(line+45, "multi_ack"))
@@ -211,6 +361,8 @@ static int receive_needs(void)
 			die("git-upload-pack: not our ref %s", line+5);
 		if (!(o->flags & WANTED)) {
 			o->flags |= WANTED;
+			if (needs < MAX_NEEDS)
+				needs_sha1[needs] = o;
 			needs++;
 		}
 	}
-- 
1.3.3.g2a0a
