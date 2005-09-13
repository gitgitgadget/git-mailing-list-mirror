From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Define relative .git/objects/info/alternates semantics.
Date: Tue, 13 Sep 2005 00:05:22 -0700
Message-ID: <7vk6hl4fd9.fsf_-_@assigned-by-dhcp.cox.net>
References: <m3mzmjvbh7.fsf@telia.com>
	<Pine.LNX.4.58.0509110908590.4912@g5.osdl.org>
	<20050911185711.GA22556@mars.ravnborg.org>
	<Pine.LNX.4.58.0509111157360.3242@g5.osdl.org>
	<20050911194630.GB22951@mars.ravnborg.org>
	<Pine.LNX.4.58.0509111251150.3242@g5.osdl.org>
	<52irx7cnw5.fsf@cisco.com>
	<Pine.LNX.4.58.0509111422510.3242@g5.osdl.org>
	<Pine.LNX.4.58.0509111431400.3242@g5.osdl.org>
	<7virx7njxa.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509112038020.3242@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue Sep 13 09:06:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EF4rJ-0005Mg-07
	for gcvg-git@gmane.org; Tue, 13 Sep 2005 09:05:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbVIMHF1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Sep 2005 03:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbVIMHF1
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Sep 2005 03:05:27 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:20706 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932427AbVIMHF0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2005 03:05:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050913070524.NPDW3588.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 13 Sep 2005 03:05:24 -0400
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0509112038020.3242@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 11 Sep 2005 20:39:46 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8461>

Linus Torvalds <torvalds@osdl.org> writes:

> Yes. We should probably have some well-defined meaning for relative paths
> in there regardless (eg just define that they are always relative to the
> main GIT_OBJECT_DIRECTORY or something).
>
> That would also allow mirrors to mirror the git archives in different 
> places, without upsetting the result (as long as they are mirrored 
> together).
>
> 		Linus

This patch is request-for-comments.  I have experimented it and
have a feeling that it may be more intuitive to make it relative
to $project.git/ directory, instead of $project.git/objects as
you originally suggested, in which case a maintainer tree would
have "../../torvalds/linux-2.6.git/objects" instead (one less
dotdot), and if nobody objects that is probably what I'll end up
doing.

------------
An entry in the alternates file can name a directory relative to
the object store it describes.  A typical linux-2.6 maintainer
repository would have "../../../torvalds/linux-2.6.git/objects" there,
because the subsystem maintainer object store would live in

    /pub/scm/linux/kernel/git/$u/$system.git/objects/

and the object store of Linus tree is in

    /pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/

This unfortunately is different from GIT_ALTERNATE_OBJECT_DIRECTORIES
which is relative to the cwd of the running process, but there is no
way to make it consistent with the behaviour of the environment
variable.  The process typically is run in $system.git/ directory for
a naked repository, or one level up for a repository with a working
tree, so we just define it to be relative to the objects/ directory
to be different from either ;-).

Later, the dumb transport could be updated to read from info/alternates
and make requests for the repository the repository borrows from.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 sha1_file.c |   28 ++++++++++++++++++++++------
 1 files changed, 22 insertions(+), 6 deletions(-)

e2e8a0ba5fc80368bf46c615276e406dd373729c
diff --git a/sha1_file.c b/sha1_file.c
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -240,10 +240,12 @@ static struct alternate_object_database 
  * SHA1, an extra slash for the first level indirection, and the
  * terminating NUL.
  */
-static void link_alt_odb_entries(const char *alt, const char *ep, int sep)
+static void link_alt_odb_entries(const char *alt, const char *ep, int sep,
+				 const char *relative_base)
 {
 	const char *cp, *last;
 	struct alternate_object_database *ent;
+	int base_len = -1;
 
 	last = alt;
 	while (last < ep) {
@@ -261,12 +263,25 @@ static void link_alt_odb_entries(const c
 			int pfxlen = cp - last;
 			int entlen = pfxlen + 43;
 
+			if (*last != '/' && relative_base) {
+				/* Relative alt-odb */
+				if (base_len < 0)
+					base_len = strlen(relative_base) + 1;
+				entlen += base_len;
+				pfxlen += base_len;
+			}
 			ent = xmalloc(sizeof(*ent) + entlen);
 			*alt_odb_tail = ent;
 			alt_odb_tail = &(ent->next);
 			ent->next = NULL;
-
-			memcpy(ent->base, last, pfxlen);
+			if (*last != '/' && relative_base) {
+				memcpy(ent->base, relative_base, base_len - 1);
+				ent->base[base_len - 1] = '/';
+				memcpy(ent->base + base_len,
+				       last, cp - last);
+			}
+			else
+				memcpy(ent->base, last, pfxlen);
 			ent->name = ent->base + pfxlen + 1;
 			ent->base[pfxlen] = ent->base[pfxlen + 3] = '/';
 			ent->base[entlen-1] = 0;
@@ -288,12 +303,12 @@ void prepare_alt_odb(void)
 	alt = getenv(ALTERNATE_DB_ENVIRONMENT);
 	if (!alt) alt = "";
 
-	sprintf(path, "%s/info/alternates", get_object_directory());
 	if (alt_odb_tail)
 		return;
 	alt_odb_tail = &alt_odb_list;
-	link_alt_odb_entries(alt, alt + strlen(alt), ':');
+	link_alt_odb_entries(alt, alt + strlen(alt), ':', NULL);
 
+	sprintf(path, "%s/info/alternates", get_object_directory());
 	fd = open(path, O_RDONLY);
 	if (fd < 0)
 		return;
@@ -306,7 +321,8 @@ void prepare_alt_odb(void)
 	if (map == MAP_FAILED)
 		return;
 
-	link_alt_odb_entries(map, map + st.st_size, '\n');
+	link_alt_odb_entries(map, map + st.st_size, '\n',
+			     get_object_directory());
 	munmap(map, st.st_size);
 }
 
