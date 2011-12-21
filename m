From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 2/4] Fix a bitwise negation assignment issue spotted by Sun Studio
Date: Wed, 21 Dec 2011 01:18:20 +0000
Message-ID: <1324430302-22441-3-git-send-email-avarab@gmail.com>
References: <1324430302-22441-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Jason Evans <jasone@canonware.com>,
	David Barr <david.barr@cordelta.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 21 02:18:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdApN-0001Uu-8N
	for gcvg-git-2@lo.gmane.org; Wed, 21 Dec 2011 02:18:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753555Ab1LUBSh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Dec 2011 20:18:37 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:52700 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753674Ab1LUBSf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Dec 2011 20:18:35 -0500
Received: by mail-ee0-f46.google.com with SMTP id c4so7119243eek.19
        for <git@vger.kernel.org>; Tue, 20 Dec 2011 17:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=tAGbykwi4ww9RaIn2e/Ef0B7dBLnMvp37V86iBv5Gc0=;
        b=miO5VTXRf78UJU5WdPIbmku6sm1JNWMeGpYY06svCUAA+argD6sAcuw/fiOb24V3II
         3igmy4/w+YAFwBI4tPCTEHCsjw7lUsSF9yu8Ba3ru4uCxASfzeDh9Hn/1MmViIJN2ifz
         MHWUM4mTEGcOlH3KQAf0M6cgajRNIWVa719PU=
Received: by 10.213.15.76 with SMTP id j12mr959823eba.120.1324430315237;
        Tue, 20 Dec 2011 17:18:35 -0800 (PST)
Received: from w.nix.is (w.nix.is. [188.40.98.140])
        by mx.google.com with ESMTPS id z43sm14054237eef.7.2011.12.20.17.18.34
        (version=SSLv3 cipher=OTHER);
        Tue, 20 Dec 2011 17:18:34 -0800 (PST)
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1324430302-22441-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187542>

Change direct and indirect assignments of the bitwise negation of 0 to
uint32_t variables to have a "U" suffix. I.e. ~0U instead of ~0. This
eliminates warnings under Sun Studio 12 Update 1:

    "vcs-svn/string_pool.c", line 11: warning: initializer will be sign=
-extended: -1 (E_INIT_SIGN_EXTEND)
    "vcs-svn/string_pool.c", line 81: warning: initializer will be sign=
-extended: -1 (E_INIT_SIGN_EXTEND)
    "vcs-svn/repo_tree.c", line 112: warning: initializer will be sign-=
extended: -1 (E_INIT_SIGN_EXTEND)
    "vcs-svn/repo_tree.c", line 112: warning: initializer will be sign-=
extended: -1 (E_INIT_SIGN_EXTEND)
    "test-treap.c", line 34: warning: initializer will be sign-extended=
: -1 (E_INIT_SIGN_EXTEND)

The semantics are still the same as demonstrated by this program:

    $ cat test.c && make test && ./test
    #include <stdio.h>
    #include <stdint.h>

    int main(void)
    {
        uint32_t foo =3D ~0;
        uint32_t bar =3D ~0U;

        printf("foo =3D <%u> bar =3D <%u>\n", foo, bar);

        return 0;
    }
    cc     test.c   -o test
    "test.c", line 5: warning: initializer will be sign-extended: -1
    foo =3D <4294967295> bar =3D <4294967295>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 test-treap.c          |    2 +-
 vcs-svn/repo_tree.c   |    2 +-
 vcs-svn/string_pool.c |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/test-treap.c b/test-treap.c
index ab8c951..294d7ee 100644
--- a/test-treap.c
+++ b/test-treap.c
@@ -31,7 +31,7 @@ static void strtonode(struct int_node *item, const ch=
ar *s)
 int main(int argc, char *argv[])
 {
 	struct strbuf sb =3D STRBUF_INIT;
-	struct trp_root root =3D { ~0 };
+	struct trp_root root =3D { ~0U };
 	uint32_t item;
=20
 	if (argc !=3D 1)
diff --git a/vcs-svn/repo_tree.c b/vcs-svn/repo_tree.c
index a21d89d..c3f198d 100644
--- a/vcs-svn/repo_tree.c
+++ b/vcs-svn/repo_tree.c
@@ -109,7 +109,7 @@ static struct repo_dirent *repo_read_dirent(uint32_=
t revision,
 static void repo_write_dirent(const uint32_t *path, uint32_t mode,
 			      uint32_t content_offset, uint32_t del)
 {
-	uint32_t name, revision, dir_o =3D ~0, parent_dir_o =3D ~0;
+	uint32_t name, revision, dir_o =3D ~0U, parent_dir_o =3D ~0U;
 	struct repo_dir *dir;
 	struct repo_dirent *key;
 	struct repo_dirent *dent =3D NULL;
diff --git a/vcs-svn/string_pool.c b/vcs-svn/string_pool.c
index 8af8d54..1b63b19 100644
--- a/vcs-svn/string_pool.c
+++ b/vcs-svn/string_pool.c
@@ -8,7 +8,7 @@
 #include "obj_pool.h"
 #include "string_pool.h"
=20
-static struct trp_root tree =3D { ~0 };
+static struct trp_root tree =3D { ~0U };
=20
 struct node {
 	uint32_t offset;
@@ -78,7 +78,7 @@ void pool_print_seq(uint32_t len, uint32_t *seq, char=
 delim, FILE *stream)
 uint32_t pool_tok_seq(uint32_t sz, uint32_t *seq, const char *delim, c=
har *str)
 {
 	char *context =3D NULL;
-	uint32_t token =3D ~0;
+	uint32_t token =3D ~0U;
 	uint32_t length;
=20
 	if (sz =3D=3D 0)
--=20
1.7.7.3
