From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Teach diff-tree to honor grafts
Date: Mon, 21 Nov 2005 19:02:41 -0800
Message-ID: <7v3blpjsfi.fsf_-_@assigned-by-dhcp.cox.net>
References: <87lkzi1aio.fsf@gmail.com>
	<7v4q65odkg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 22 04:03:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeOQh-00064g-A1
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 04:02:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbVKVDCo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 21 Nov 2005 22:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964886AbVKVDCn
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 22:02:43 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:17873 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S964785AbVKVDCn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Nov 2005 22:02:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051122030206.SBFG6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 21 Nov 2005 22:02:06 -0500
To: Santi =?iso-8859-1?Q?B=E9jar?= <sbejar@gmail.com>
In-Reply-To: <7v4q65odkg.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 21 Nov 2005 14:12:31 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12516>

Junio C Hamano <junkio@cox.net> writes:

> Santi B=E9jar <sbejar@gmail.com> writes:
>
>>         diff-tree decode directly the commit, so it does not take in=
to
>>         account the graft file. Is this the expected behaviour?
>
> Expected?  Yes, only because I happen to know diff-tree was
> written way before grafts are invented and nobody bothered to
> change that behaviour.  Desireable?  Probably not.

Something like this (only lightly tested) should make it work in
one-tree case.  The --stdin form does not necessarily need this
if you tell rev-list to show the parents, but that case should
be covered as well with this patch.

-- >8 --

"git-rev-list --parent" piped to "git-diff-tree --stdin" honors
grafts because rev-list will explicitly tell diff-tree what base
commit to compare each commit against, but a single parameter
"git-diff-tree oneEnt" form did its own thing to extract parent
information from the commit object by hand, without honoring the
grafts the user has.  Rewrite that part to use parse_commit()
API.

---

diff --git a/diff-tree.c b/diff-tree.c
index 09d16ad..e79a134 100644
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -69,52 +69,50 @@ static int diff_root_tree(const unsigned
 	return retval;
 }
=20
-static const char *generate_header(const char *commit, const char *par=
ent, const char *msg, unsigned long len)
+static const char *generate_header(const char *commit, const char *par=
ent, const char *msg)
 {
 	static char this_header[16384];
 	int offset;
+	unsigned long len;
=20
 	if (!verbose_header)
 		return commit;
=20
+	len =3D strlen(msg);
 	offset =3D sprintf(this_header, "%s%s (from %s)\n", header_prefix, co=
mmit, parent);
 	offset +=3D pretty_print_commit(commit_format, msg, len, this_header =
+ offset, sizeof(this_header) - offset);
 	return this_header;
 }
=20
-static int diff_tree_commit(const unsigned char *commit, const char *n=
ame)
+static int diff_tree_commit(const unsigned char *commit_sha1)
 {
-	unsigned long size, offset;
-	char *buf =3D read_object_with_reference(commit, "commit", &size, NUL=
L);
+	struct commit *commit;
+	struct commit_list *parents;
+	char name[50];
+	unsigned char sha1[20];
=20
-	if (!buf)
+	sprintf(name, "%s^0", sha1_to_hex(commit_sha1));
+	if (get_sha1(name, sha1))
 		return -1;
-
-	if (!name) {
-		static char commit_name[60];
-		strcpy(commit_name, sha1_to_hex(commit));
-		name =3D commit_name;
-	}
-
+	name[40] =3D 0;
+	commit =3D lookup_commit(sha1);
+=09
 	/* Root commit? */
-	if (show_root_diff && memcmp(buf + 46, "parent ", 7)) {
-		header =3D generate_header(name, "root", buf, size);
-		diff_root_tree(commit, "");
+	if (show_root_diff && !commit->parents) {
+		header =3D generate_header(name, "root", commit->buffer);
+		diff_root_tree(commit_sha1, "");
 	}
=20
 	/* More than one parent? */
-	if (ignore_merges) {
-		if (!memcmp(buf + 46 + 48, "parent ", 7))
+	if (ignore_merges && commit->parents && commit->parents->next)
 			return 0;
-	}
=20
-	offset =3D 46;
-	while (offset + 48 < size && !memcmp(buf + offset, "parent ", 7)) {
-		unsigned char parent[20];
-		if (get_sha1_hex(buf + offset + 7, parent))
-			return -1;
-		header =3D generate_header(name, sha1_to_hex(parent), buf, size);
-		diff_tree_sha1_top(parent, commit, "");
+	for (parents =3D commit->parents; parents; parents =3D parents->next)=
 {
+		struct commit *parent =3D parents->item;
+		header =3D generate_header(name,
+					 sha1_to_hex(parent->object.sha1),
+					 commit->buffer);
+		diff_tree_sha1_top(parent->object.sha1, commit_sha1, "");
 		if (!header && verbose_header) {
 			header_prefix =3D "\ndiff-tree ";
 			/*
@@ -122,9 +120,7 @@ static int diff_tree_commit(const unsign
 			 * don't print the diffs.
 			 */
 		}
-		offset +=3D 48;
 	}
-	free(buf);
 	return 0;
 }
=20
@@ -147,7 +143,7 @@ static int diff_tree_stdin(char *line)
 		return diff_tree_sha1_top(parent, commit, "");
 	}
 	line[40] =3D 0;
-	return diff_tree_commit(commit, line);
+	return diff_tree_commit(commit);
 }
=20
 static const char diff_tree_usage[] =3D
@@ -250,7 +246,7 @@ int main(int argc, const char **argv)
 			usage(diff_tree_usage);
 		break;
 	case 1:
-		diff_tree_commit(sha1[0], NULL);
+		diff_tree_commit(sha1[0]);
 		break;
 	case 2:
 		diff_tree_sha1_top(sha1[0], sha1[1], "");
