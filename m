From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 4/4] Why is "git tag --contains" so slow?
Date: Sat, 11 Jun 2011 19:04:11 +0000
Message-ID: <1307819051-25748-5-git-send-email-avarab@gmail.com>
References: <1307819051-25748-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 11 21:06:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QVTVW-0005wV-Ey
	for gcvg-git-2@lo.gmane.org; Sat, 11 Jun 2011 21:06:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753614Ab1FKTGA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Jun 2011 15:06:00 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:49518 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679Ab1FKTGA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jun 2011 15:06:00 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1232841ewy.19
        for <git@vger.kernel.org>; Sat, 11 Jun 2011 12:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=Txu3szaujhIn+X+M1HzjWyDb29i40AbaTujHMVUBrUU=;
        b=LGVXOPgGAeLrTUTXM3u4gcT4xdIXsIkbFM8XZWV6idlAaznBXRitrz6Jm/sRn5E94y
         Ky7GZ60k53klvhq5+OoVxsts49FHLaBnGxKCiTUZVhqVh3e31/EXJ354fXXylpLrMziJ
         fCvLbxHCADi73uCO8JL+ctbUUi8oDqVDEEJtI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=u/JaEIKdMZP0Nl/Djh9q6r2ITRiN6n/BoaR1J1yN4zMvjHU4ybeFUnAW1UoCq9tpca
         8k5A3/j6vXfFUh+mvM1GUbGuskqohYLRXbvINk9MoRciCY+e6flrAjVHDr4o+3x/UV7Y
         ZunXAbarpZn8Sq30Q5w9p521WEnoE5A/b9f6s=
Received: by 10.213.3.196 with SMTP id 4mr2026608ebo.50.1307819158410;
        Sat, 11 Jun 2011 12:05:58 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id v76sm477161eea.17.2011.06.11.12.05.56
        (version=SSLv3 cipher=OTHER);
        Sat, 11 Jun 2011 12:05:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.3
In-Reply-To: <1307819051-25748-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175647>

=46rom: Jeff King <peff@peff.net>

On Mon, Jul 05, 2010 at 08:27:23AM -0400, Jeff King wrote:

> As you probably guessed from the specificity of the number, I wrote a
> short program to actually traverse and find the worst skew. It takes
> about 5 seconds to run (unsurprisingly, since it is doing the same fu=
ll
> traversal that we end up doing in the above numbers). So we could
> "autoskew" by setting up the configuration on clone, and then
> periodically updating it as part of "git gc".

This patch doesn't implement auto-detection of skew, but is the program
I used to calculate, and would provide the basis for such
auto-detection. It would be interesting to see average skew numbers for
popular repositories. You can run it as "git skew --all".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 .gitignore     |    1 +
 Makefile       |    1 +
 builtin.h      |    1 +
 builtin/skew.c |   50 ++++++++++++++++++++++++++++++++++++++++++++++++=
++
 git.c          |    1 +
 5 files changed, 54 insertions(+), 0 deletions(-)
 create mode 100644 builtin/skew.c

diff --git a/.gitignore b/.gitignore
index acffdfa..503ef8b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -137,6 +137,7 @@
 /git-show-branch
 /git-show-index
 /git-show-ref
+/git-skew
 /git-stage
 /git-stash
 /git-status
diff --git a/Makefile b/Makefile
index e40ac0c..4ba5542 100644
--- a/Makefile
+++ b/Makefile
@@ -763,6 +763,7 @@ BUILTIN_OBJS +=3D builtin/send-pack.o
 BUILTIN_OBJS +=3D builtin/shortlog.o
 BUILTIN_OBJS +=3D builtin/show-branch.o
 BUILTIN_OBJS +=3D builtin/show-ref.o
+BUILTIN_OBJS +=3D builtin/skew.o
 BUILTIN_OBJS +=3D builtin/stripspace.o
 BUILTIN_OBJS +=3D builtin/symbolic-ref.o
 BUILTIN_OBJS +=3D builtin/tag.o
diff --git a/builtin.h b/builtin.h
index 0e9da90..0be47ca 100644
--- a/builtin.h
+++ b/builtin.h
@@ -143,5 +143,6 @@ extern int cmd_verify_pack(int argc, const char **a=
rgv, const char *prefix);
 extern int cmd_show_ref(int argc, const char **argv, const char *prefi=
x);
 extern int cmd_pack_refs(int argc, const char **argv, const char *pref=
ix);
 extern int cmd_replace(int argc, const char **argv, const char *prefix=
);
+extern int cmd_skew(int argc, const char **argv, const char *prefix);
=20
 #endif
diff --git a/builtin/skew.c b/builtin/skew.c
new file mode 100644
index 0000000..1046f5f
--- /dev/null
+++ b/builtin/skew.c
@@ -0,0 +1,50 @@
+#include "cache.h"
+#include "commit.h"
+#include "diff.h"
+#include "revision.h"
+
+unsigned long worst_skew =3D 0;
+
+static void check_skew_recurse(struct commit *c, unsigned long when)
+{
+	struct commit_list *p;
+
+	if (c->object.flags & SEEN)
+		return;
+	c->object.flags |=3D SEEN;
+
+	if (parse_commit(c) < 0)
+		return;
+
+	if (c->date > when) {
+		unsigned long skew =3D c->date - when;
+		if (skew > worst_skew)
+			worst_skew =3D skew;
+	}
+
+	for (p =3D c->parents; p; p =3D p->next)
+		check_skew_recurse(p->item, c->date < when ? c->date : when);
+}
+
+static void check_skew(struct commit *c)
+{
+	check_skew_recurse(c, time(NULL));
+}
+
+int cmd_skew(int argc, const char **argv, const char *prefix) {
+	struct rev_info revs;
+	int i;
+
+	git_config(git_default_config, NULL);
+	init_revisions(&revs, prefix);
+	argc =3D setup_revisions(argc, argv, &revs, NULL);
+
+	for (i =3D 0; i < revs.pending.nr; i++) {
+		struct object *o =3D revs.pending.objects[i].item;
+		if (o->type =3D=3D OBJ_COMMIT)
+			check_skew((struct commit *)o);
+	}
+
+	printf("%lu\n", worst_skew);
+	return 0;
+}
diff --git a/git.c b/git.c
index 89721d4..2404bf3 100644
--- a/git.c
+++ b/git.c
@@ -434,6 +434,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "version", cmd_version },
 		{ "whatchanged", cmd_whatchanged, RUN_SETUP },
 		{ "write-tree", cmd_write_tree, RUN_SETUP },
+		{ "skew", cmd_skew, RUN_SETUP },
 	};
 	int i;
 	static const char ext[] =3D STRIP_EXTENSION;
--=20
1.7.5.3
