From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] multi_ack protocol v2
Date: Thu, 27 Oct 2005 10:45:18 -0700
Message-ID: <7vwtjy3lch.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0510270149590.12163@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vzmov4elu.fsf@assigned-by-dhcp.cox.net>
	<20051027141619.0e8029f2.vsu@altlinux.ru>
	<Pine.LNX.4.63.0510271227490.2724@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sergey Vlasov <vsu@altlinux.ru>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 27 19:46:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVBoi-0007o1-6J
	for gcvg-git@gmane.org; Thu, 27 Oct 2005 19:45:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbVJ0RpW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 13:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbVJ0RpV
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 13:45:21 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:54468 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751334AbVJ0RpU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2005 13:45:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051027174457.QLAG4169.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 27 Oct 2005 13:44:57 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0510271227490.2724@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 27 Oct 2005 12:47:24 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10719>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 27 Oct 2005, Sergey Vlasov wrote:
>
>> Actually, there is another way to pass some data from the server
>> which would be ignored by older clients - at the first stage,
>> when upload-pack sends the list of refs to the client:
>> 
>> 	packet_write(1, "%s %s%c%s\n", sha1_to_hex(sha1), refname, '\0',
>> 		     server_capabilities);
>
> That exploits that packet_write() uses vnsprintf() to find out the length,
> not strlen(). Sweet.

OK.

> get_remote_heads() would need to store the server_capabilities, maybe with 
> a function "server_supports(const char *extension_string)" 

Another thing that would probably be helpful is to redo
get_remote_heads() slightly differently, so that it can return
information on *all* refs the other end has.  We need to extend
"struct ref" to mark which one was actually matched/ignored by
path_match() and ignore_funny.  An completely untested patch is
attached, based on fetch-pack that still runs rev-list as an
external process, to outline the idea.

---
diff --git a/cache.h b/cache.h
index 2e36cc5..d39a006 100644
--- a/cache.h
+++ b/cache.h
@@ -329,6 +329,7 @@ struct ref {
 	unsigned char old_sha1[20];
 	unsigned char new_sha1[20];
 	unsigned char force;
+	unsigned char matched; /* when using REPORT_ALL */
 	struct ref *peer_ref; /* when renaming */
 	char name[0];
 };
@@ -339,7 +340,9 @@ extern int path_match(const char *path, 
 extern int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
 		      int nr_refspec, char **refspec, int all);
 extern int get_ack(int fd, unsigned char *result_sha1);
-extern struct ref **get_remote_heads(int in, struct ref **list, int nr_match, char **match, int ignore_funny);
+#define GET_REMOTE_HEADS_IGNORE_FUNNY	1
+#define GET_REMOTE_HEADS_REPORT_ALL	2
+extern struct ref **get_remote_heads(int in, struct ref **list, int nr_match, char **match, int match_options);
 
 extern struct packed_git *parse_pack_index(unsigned char *sha1);
 extern struct packed_git *parse_pack_index_file(const unsigned char *sha1,
diff --git a/clone-pack.c b/clone-pack.c
index 9609219..8b63183 100644
--- a/clone-pack.c
+++ b/clone-pack.c
@@ -250,7 +250,7 @@ static int clone_pack(int fd[2], int nr_
 	struct ref *refs;
 	int status;
 
-	get_remote_heads(fd[0], &refs, nr_match, match, 1);
+	get_remote_heads(fd[0], &refs, nr_match, match, GET_REMOTE_HEADS_IGNORE_FUNNY);
 	if (!refs) {
 		packet_flush(fd[1]);
 		die("no matching remote head");
diff --git a/connect.c b/connect.c
index b171c5d..f7a3550 100644
--- a/connect.c
+++ b/connect.c
@@ -12,8 +12,11 @@
  * Read all the refs from the other end
  */
 struct ref **get_remote_heads(int in, struct ref **list,
-			      int nr_match, char **match, int ignore_funny)
+			      int nr_match, char **match, int match_options)
 {
+	int ignore_funny = match_options & GET_REMOTE_HEADS_IGNORE_FUNNY;
+	int report_all = match_options & GET_REMOTE_HEADS_REPORT_ALL;
+
 	*list = NULL;
 	for (;;) {
 		struct ref *ref;
@@ -21,6 +24,7 @@ struct ref **get_remote_heads(int in, st
 		static char buffer[1000];
 		char *name;
 		int len;
+		int matched = 1;
 
 		len = packet_read_line(in, buffer, sizeof(buffer));
 		if (!len)
@@ -28,17 +32,22 @@ struct ref **get_remote_heads(int in, st
 		if (buffer[len-1] == '\n')
 			buffer[--len] = 0;
 
-		if (len < 42 || get_sha1_hex(buffer, old_sha1) || buffer[40] != ' ')
-			die("protocol error: expected sha/ref, got '%s'", buffer);
+		if (len < 42 || get_sha1_hex(buffer, old_sha1) ||
+		    buffer[40] != ' ')
+			die("protocol error: expected sha/ref, got '%s'",
+			    buffer);
 		name = buffer + 41;
 
-		if (ignore_funny && 45 < len && !memcmp(name, "refs/", 5) &&
-		    check_ref_format(name + 5))
-			continue;
+		if ((ignore_funny && 45 < len && !memcmp(name, "refs/", 5) &&
+		     check_ref_format(name + 5)) ||
+		    (nr_match && !path_match(name, nr_match, match))) {
+			if (!report_all)
+				continue;
+			matched = 0;
+		}
 
-		if (nr_match && !path_match(name, nr_match, match))
-			continue;
 		ref = xcalloc(1, sizeof(*ref) + len - 40);
+		ref->matched = matched;
 		memcpy(ref->old_sha1, old_sha1, 20);
 		memcpy(ref->name, buffer + 41, len - 40);
 		*list = ref;
diff --git a/fetch-pack.c b/fetch-pack.c
index 8566ab1..11fb1c1 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -13,6 +13,7 @@ static const char fetch_pack_usage[] =
 static const char *exec = "git-upload-pack";
 
 #define COMPLETE	(1U << 0)
+#define EXCLUDE		(1U << 1)
 
 static int find_common(int fd[2], unsigned char *result_sha1,
 		       struct ref *refs)
@@ -52,17 +53,24 @@ static int find_common(int fd[2], unsign
 			p = commit->parents;
 			while (p &&
 			       rev_command_len + 44 < sizeof(rev_command)) {
-				snprintf(rev_command + rev_command_len, 44,
-					 " ^%s",
-					 sha1_to_hex(p->item->object.sha1));
-				rev_command_len += 43;
+				struct object *pobj = &(p->item->object);
+				if (!pobj->flags & EXCLUDE) {
+					snprintf(rev_command +
+						 rev_command_len, 44,
+						 " ^%s",
+						 sha1_to_hex(pobj->sha1));
+					rev_command_len += 43;
+				}
+				pobj->flags |= EXCLUDE;
 				p = p->next;
 			}
 			continue;
 		}
 	repair:
-		packet_write(fd[1], "want %s\n", sha1_to_hex(remote));
-		fetching++;
+		if (refs->matched) {
+			packet_write(fd[1], "want %s\n", sha1_to_hex(remote));
+			fetching = 1;
+		}
 	}
 	packet_flush(fd[1]);
 	if (!fetching)
@@ -183,6 +191,8 @@ static int everything_local(struct ref *
 		unsigned char local[20];
 		struct object *o;
 
+		if (!refs->matched)
+			continue;
 		o = parse_object(remote);
 		if (!o || !(o->flags & COMPLETE)) {
 			retval = 0;
@@ -204,6 +214,16 @@ static int everything_local(struct ref *
 	return retval;
 }
 
+static int no_matching_remote(struct ref *ref)
+{
+	while (ref)
+		if (ref->matched)
+			return 0;
+		else
+			ref = ref->next;
+	return 1;
+}
+
 static int fetch_pack(int fd[2], int nr_match, char **match)
 {
 	struct ref *ref;
@@ -211,8 +231,10 @@ static int fetch_pack(int fd[2], int nr_
 	int status;
 	pid_t pid;
 
-	get_remote_heads(fd[0], &ref, nr_match, match, 1);
-	if (!ref) {
+	get_remote_heads(fd[0], &ref, nr_match, match,
+			 GET_REMOTE_HEADS_IGNORE_FUNNY |
+			 GET_REMOTE_HEADS_REPORT_ALL);
+	if (no_matching_remote(ref)) {
 		packet_flush(fd[1]);
 		die("no matching remote head");
 	}
@@ -245,8 +267,9 @@ static int fetch_pack(int fd[2], int nr_
 			die("git-unpack-objects died with error code %d", code);
 all_done:
 		while (ref) {
-			printf("%s %s\n",
-			       sha1_to_hex(ref->old_sha1), ref->name);
+			if (ref->matched)
+				printf("%s %s\n",
+				       sha1_to_hex(ref->old_sha1), ref->name);
 			ref = ref->next;
 		}
 		return 0;
diff --git a/send-pack.c b/send-pack.c
index 9f9a6e7..d7bb6c1 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -181,7 +181,8 @@ static int send_pack(int in, int out, in
 	int new_refs;
 
 	/* No funny business with the matcher */
-	remote_tail = get_remote_heads(in, &remote_refs, 0, NULL, 1);
+	remote_tail = get_remote_heads(in, &remote_refs, 0, NULL,
+				       GET_REMOTE_HEADS_IGNORE_FUNNY);
 	get_local_heads();
 
 	/* match them up */
