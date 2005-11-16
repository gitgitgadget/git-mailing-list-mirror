From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Fix git_config_set() for mean cases
Date: Wed, 16 Nov 2005 10:47:37 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511161045310.16596@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-400859853-1132134457=:16596"
X-From: git-owner@vger.kernel.org Wed Nov 16 10:49:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcJtH-0000uf-59
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 10:47:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932592AbVKPJrk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 04:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932593AbVKPJrk
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 04:47:40 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:15247 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932592AbVKPJrj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2005 04:47:39 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 541EB13F9C4; Wed, 16 Nov 2005 10:47:38 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 380B69F32F; Wed, 16 Nov 2005 10:47:38 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7D6A99F313; Wed, 16 Nov 2005 10:47:37 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5705D13F9C4; Wed, 16 Nov 2005 10:47:37 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12018>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-400859853-1132134457=:16596
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable


There were problems when the keys=B4 case didn=B4t match, and also when t=
he
section was in the same line as the key.

This patch also adds a test case, so you see that it works now.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	I shoulda started by writing those tests. This patch is on top
	of my earlier patch, which worked only in the nice cases. It=20
	now needs git-config-set, though.

 config.c              |   42 ++++++++++++++----
 t/t1300-config-set.sh |  112 +++++++++++++++++++++++++++++++++++++++++++=
++++++
 2 files changed, 144 insertions(+), 10 deletions(-)
 create mode 100644 t/t1300-config-set.sh

applies-to: ae3c1e28a1df80086033825ac68fdf4c6c835eee
e326b690c85a648ffcbbc63e69333a7100a07892
diff --git a/config.c b/config.c
index 3b883b2..9315351 100644
--- a/config.c
+++ b/config.c
@@ -255,7 +255,7 @@ int git_config(config_fn_t fn)
=20
 static struct {
 	int baselen;
-	const char* key;
+	char* key;
 	const char* value;
 	off_t offset;
 	enum { START, SECTION_SEEN, SECTION_END_SEEN, KEY_SEEN } state;
@@ -270,10 +270,10 @@ static int store_aux(const char* key, co
 			break;
 		case SECTION_SEEN:
 			if (strncmp(key, store.key, store.baselen+1)) {
-				store.offset =3D ftell(config_file);
 				store.state =3D SECTION_END_SEEN;
 				break;
-			}
+			} else
+				store.offset =3D ftell(config_file);
 		case SECTION_END_SEEN:
 		case START:
 			if (!strcmp(key, store.key)) {
@@ -326,18 +326,21 @@ int git_config_set(const char* key, cons
 		return 2;
 	}
=20
+	store.key =3D strdup(key);
 	for (i =3D 0; key[i]; i++)
 		if (i !=3D store.baselen && !isalpha(key[i])) {
 			fprintf(stderr, "invalid key: %s\n", key);
+			free(store.key);
 			return 1;
-		}
+		} else
+			store.key[i] =3D tolower(key[i]);
=20
-	store.key =3D key;
 	store.value =3D value;
=20
 	fd =3D open(lock_file, O_WRONLY | O_CREAT | O_EXCL, 0666);
 	if (fd < 0) {
 		fprintf(stderr, "could not lock config file\n");
+		free(store.key);
 		return -1;
 	}
=20
@@ -349,6 +352,9 @@ int git_config_set(const char* key, cons
 			"#\n"
 			"\n";
=20
+		free(store.key);
+		store.key =3D (char*)key;
+
 		write(fd, contents, sizeof(contents)-1);
 		store_write_section(fd);
 		store_write_pair(fd);
@@ -362,25 +368,41 @@ int git_config_set(const char* key, cons
=20
 		if (git_config(store_aux)) {
 			fprintf(stderr, "invalid config file\n");
+			free(store.key);
 			return 3;
 		}
=20
+		free(store.key);
+		store.key =3D (char*)key;
+
 		in_fd =3D open(config_file, O_RDONLY, 0666);
 		contents =3D mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, in_fd, 0);
 		close(in_fd);
=20
 		if (store.offset =3D=3D 0)
-			offset =3D st.st_size;
-		else {
+			store.offset =3D offset =3D st.st_size;
+		else if (store.state !=3D KEY_SEEN) {
+			offset =3D store.offset;
+		} else {
+			int equal_offset =3D st.st_size,
+				bracket_offset =3D st.st_size;
 			for (offset =3D store.offset-2; offset > 0=20
-					&& contents[offset] !=3D '\n'; offset--);
-			offset++;
+					&& contents[offset] !=3D '\n'; offset--)
+				switch (contents[offset]) {
+					case '=3D': equal_offset =3D offset; break;
+					case ']': bracket_offset =3D offset; break;
+				}
+			if (bracket_offset < equal_offset) {
+				contents[bracket_offset+1] =3D '\n';
+				offset =3D bracket_offset+2;
+			} else
+				offset++;
 		}
 		write(fd, contents, offset);
 		if (store.state =3D=3D START)
 			store_write_section(fd);
 		store_write_pair(fd);
-		if (store.offset > offset)
+		if (store.offset < st.st_size)
 			write(fd, contents + store.offset,
 				st.st_size - store.offset);
 	=09
diff --git a/t/t1300-config-set.sh b/t/t1300-config-set.sh
new file mode 100644
index 0000000..48d4ff1
--- /dev/null
+++ b/t/t1300-config-set.sh
@@ -0,0 +1,112 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Johannes Schindelin
+#
+
+test_description=3D'Test git-config-set in different settings'
+
+. ./test-lib.sh
+
+test -f .git/config && rm .git/config
+
+git-config-set core.penguin "little blue"
+
+cat > expect.1 << EOF
+#
+# This is the config file
+#
+
+[core]
+	penguin =3D little blue
+EOF
+
+test_expect_success 'initial' 'cmp .git/config expect.1'
+
+git-config-set Core.Movie BadPhysics
+
+cat > expect.2 << EOF
+#
+# This is the config file
+#
+
+[core]
+	penguin =3D little blue
+	Movie =3D BadPhysics
+EOF
+
+test_expect_success 'mixed case' 'cmp .git/config expect.2'
+
+git-config-set Cores.WhatEver Second
+
+cat > expect.3 << EOF
+#
+# This is the config file
+#
+
+[core]
+	penguin =3D little blue
+	Movie =3D BadPhysics
+[Cores]
+	WhatEver =3D Second
+EOF
+
+test_expect_success 'similar section' 'cmp .git/config expect.3'
+
+git-config-set CORE.UPPERCASE true
+
+cat > expect.4 << EOF
+#
+# This is the config file
+#
+
+[core]
+	penguin =3D little blue
+	Movie =3D BadPhysics
+	UPPERCASE =3D true
+[Cores]
+	WhatEver =3D Second
+EOF
+
+test_expect_success 'similar section' 'cmp .git/config expect.4'
+
+cat > .git/config << EOF
+[beta] ; silly comment # another comment
+noIndent=3D sillyValue ; =B4nother silly comment
+
+# empty line
+		; comment
+		haha   =3D"beta" # last silly comment
+[nextSection] noNewline =3D ouch
+EOF
+
+git-config-set beta.haha alpha
+
+cat > expect.5 << EOF
+[beta] ; silly comment # another comment
+noIndent=3D sillyValue ; =B4nother silly comment
+
+# empty line
+		; comment
+	haha =3D alpha
+[nextSection] noNewline =3D ouch
+EOF
+
+test_expect_success 'really mean test' 'cmp .git/config expect.5'
+
+git-config-set nextsection.nonewline wow
+
+cat > expect.6 << EOF
+[beta] ; silly comment # another comment
+noIndent=3D sillyValue ; =B4nother silly comment
+
+# empty line
+		; comment
+	haha =3D alpha
+[nextSection]
+	nonewline =3D wow
+EOF
+
+test_expect_success 'really really mean test' 'cmp .git/config expect.6'
+
+test_done
+
---
0.99.9.GIT
---1148973799-400859853-1132134457=:16596--
