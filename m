From: Jason McMullan <jason.mcmullan@timesys.com>
Subject: Re: [PATCH] ls-tree matching multiple paths
Date: Thu, 26 May 2005 11:13:29 -0400
Message-ID: <1117120411.11542.16.camel@jmcmullan.timesys>
References: <20050526034756.GA1488@port.evillabs.net>
	 <7vsm0aeguo.fsf@assigned-by-dhcp.cox.net>
	 <1117111843.11542.11.camel@jmcmullan.timesys>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Gq6ZCnO7Z11YZepvroA2"
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 26 17:16:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbK35-0006ME-OI
	for gcvg-git@gmane.org; Thu, 26 May 2005 17:13:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbVEZPOo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 May 2005 11:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbVEZPOi
	(ORCPT <rfc822;git-outgoing>); Thu, 26 May 2005 11:14:38 -0400
Received: from mail.timesys.com ([65.117.135.102]:14015 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261554AbVEZPNc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2005 11:13:32 -0400
Received: from jmcmullan by owa.timesys.com; 26 May 2005 11:13:31 -0400
To: git@vger.kernel.org
In-Reply-To: <1117111843.11542.11.camel@jmcmullan.timesys>
X-Mailer: Evolution 2.0.4-3mdk 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-Gq6ZCnO7Z11YZepvroA2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Same as before, but can now match multiple paths.

Relies upon the name sorted order of the default git-ls-tree -r=20
internals.

Signed-Off-By: Jason McMullan <jason.mcmullan@timesys.com>

diff --git a/Documentation/git-ls-tree.txt
b/Documentation/git-ls-tree.txt
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -9,7 +9,7 @@ git-ls-tree - Displays a tree object in=20
=20
 SYNOPSIS
 --------
-'git-ls-tree' [-r] [-z] <tree-ish>
+'git-ls-tree' [-r] [-z] <tree-ish> [paths...]
=20
 DESCRIPTION
 -----------
@@ -27,6 +27,11 @@ OPTIONS
 -z::
 	\0 line termination on output
=20
+paths::
+	Optionally, restrict the output of git-ls-tree to specific
+	paths. Directories will only list their tree blob ids.
+	Implies -r.
+
 Output Format
 -------------
         <mode>\t	<type>\t	<object>\t	<file>
diff --git a/ls-tree.c b/ls-tree.c
--- a/ls-tree.c
+++ b/ls-tree.c
@@ -13,20 +13,79 @@ struct path_prefix {
 	const char *name;
 };
=20
+#define DEBUG(fmt, ...)=09
+
+static int string_path_prefix(char *buff, size_t blen, struct
path_prefix *prefix)
+{
+	int len =3D 0;
+	if (prefix) {
+		if (prefix->prev) {
+			len =3D string_path_prefix(buff,blen,prefix->prev);
+			buff +=3D len;
+			blen -=3D len;
+			if (blen > 0) {
+				*buff =3D '/';
+				len++;
+				buff++;
+				blen--;
+			}
+		}
+		strncpy(buff,prefix->name,blen);
+		return len + strlen(prefix->name);
+	}
+
+	return 0;
+}
+
 static void print_path_prefix(struct path_prefix *prefix)
 {
 	if (prefix) {
-		if (prefix->prev)
+		if (prefix->prev) {
 			print_path_prefix(prefix->prev);
+			putchar('/');
+		}
 		fputs(prefix->name, stdout);
-		putchar('/');
 	}
 }
=20
+/*
+ * return:
+ * 	-1 if prefix is *not* a subset of path
+ * 	 0 if prefix =3D=3D path
+ * 	 1 if prefix is a subset of path
+ */
+static int pathcmp(const char *path, struct path_prefix *prefix)
+{
+	char buff[PATH_MAX];
+	int len,slen;
+
+	if (prefix =3D=3D NULL)
+		return 1;
+
+	len =3D string_path_prefix(buff, sizeof buff, prefix);
+	slen =3D strlen(path);
+
+	if (slen < len)
+		return -1;
+
+	if (strncmp(path,buff,len) =3D=3D 0) {
+		if (slen =3D=3D len)
+			return 0;
+		else
+			return 1;
+	}
+
+	return -1;
+}=09
+
+/*
+ * match may be NULL, or a *sorted* list of paths
+ */
 static void list_recursive(void *buffer,
 			   const char *type,
 			   unsigned long size,
-			   struct path_prefix *prefix)
+			   struct path_prefix *prefix,
+			   char **match, int matches)
 {
 	struct path_prefix this_prefix;
 	this_prefix.prev =3D prefix;
@@ -34,54 +93,96 @@ static void list_recursive(void *buffer,
 	if (strcmp(type, "tree"))
 		die("expected a 'tree' node");
=20
+	if (matches)
+		recursive =3D 1;
+
 	while (size) {
 		int namelen =3D strlen(buffer)+1;
-		void *eltbuf;
+		void *eltbuf =3D NULL;
 		char elttype[20];
 		unsigned long eltsize;
 		unsigned char *sha1 =3D buffer + namelen;
 		char *path =3D strchr(buffer, ' ') + 1;
 		unsigned int mode;
+		const char *matched =3D NULL;
+		int mtype =3D -1;
+		int mindex;
=20
 		if (size < namelen + 20 || sscanf(buffer, "%o", &mode) !=3D 1)
 			die("corrupt 'tree' file");
 		buffer =3D sha1 + 20;
 		size -=3D namelen + 20;
=20
-		printf("%06o\t%s\t%s\t", mode,
-		       S_ISDIR(mode) ? "tree" : "blob",
-		       sha1_to_hex(sha1));
-		print_path_prefix(prefix);
-		fputs(path, stdout);
-		putchar(line_termination);
+		this_prefix.name =3D path;
+		for ( mindex =3D 0; mindex < matches; mindex++) {
+			mtype =3D pathcmp(match[mindex],&this_prefix);
+			if (mtype >=3D 0) {
+				matched =3D match[mindex];
+				break;
+			}
+		}
+
+		/*
+		 * If we're not matching, or if this is an exact match,
+		 * print out the info
+		 */
+		if (!matches || (matched !=3D NULL && mtype =3D=3D 0)) {
+			printf("%06o\t%s\t%s\t", mode,
+			       S_ISDIR(mode) ? "tree" : "blob",
+			       sha1_to_hex(sha1));
+			print_path_prefix(&this_prefix);
+			putchar(line_termination);
+		}
=20
 		if (! recursive || ! S_ISDIR(mode))
 			continue;
=20
+		if (matches && ! matched)
+			continue;
+
 		if (! (eltbuf =3D read_sha1_file(sha1, elttype, &eltsize)) ) {
 			error("cannot read %s", sha1_to_hex(sha1));
 			continue;
 		}
-		this_prefix.name =3D path;
-		list_recursive(eltbuf, elttype, eltsize, &this_prefix);
+
+		/* If this is an exact directory match, we may have
+		 * directory files following this path. Match on them.
+		 * Otherwise, we're at a pach subcomponent, and we need
+		 * to try to match again.
+		 */
+		if (mtype =3D=3D 0)
+			mindex++;
+
+		list_recursive(eltbuf, elttype, eltsize, &this_prefix,
&match[mindex], matches-mindex);
 		free(eltbuf);
 	}
 }
=20
-static int list(unsigned char *sha1)
+static int qcmp(const void *a, const void *b)
+{
+	return strcmp(*(char **)a, *(char **)b);
+}
+
+static int list(unsigned char *sha1,char **path)
 {
 	void *buffer;
 	unsigned long size;
+	int npaths;
+
+	for (npaths =3D 0; path[npaths] !=3D NULL; npaths++)
+		;
+
+	qsort(path,npaths,sizeof(char *),qcmp);
=20
 	buffer =3D read_object_with_reference(sha1, "tree", &size, NULL);
 	if (!buffer)
 		die("unable to read sha1 file");
-	list_recursive(buffer, "tree", size, NULL);
+	list_recursive(buffer, "tree", size, NULL, path, npaths);
 	free(buffer);
 	return 0;
 }
=20
-static const char *ls_tree_usage =3D "git-ls-tree [-r] [-z] <key>";
+static const char *ls_tree_usage =3D "git-ls-tree [-r] [-z] <key>
[paths...]";
=20
 int main(int argc, char **argv)
 {
@@ -101,11 +202,11 @@ int main(int argc, char **argv)
 		argc--; argv++;
 	}
=20
-	if (argc !=3D 2)
+	if (argc < 2)
 		usage(ls_tree_usage);
 	if (get_sha1(argv[1], sha1) < 0)
 		usage(ls_tree_usage);
-	if (list(sha1) < 0)
+	if (list(sha1, &argv[2]) < 0)
 		die("list failed");
 	return 0;
 }



--=20
Jason McMullan <jason.mcmullan@timesys.com>
TimeSys Corporation


--=-Gq6ZCnO7Z11YZepvroA2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCleeZ8/0vJ5szK6kRAqkqAKCLWFpSAemGFTclBbiwWD7aSrcYAwCg1tAW
G3ry8MD/nPZbhN6Khre9dQU=
=ll4S
-----END PGP SIGNATURE-----

--=-Gq6ZCnO7Z11YZepvroA2--
