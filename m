From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] log: make --abbrev-commit's ellipsis configurable
Date: Fri, 13 Feb 2009 13:58:40 +0100
Message-ID: <1234529920-9694-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Adeodato=20Sim=C3=B3?= <dato@net.com.org.es>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 13 14:00:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXxeh-0005Bb-9Y
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 14:00:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753201AbZBMM7E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 07:59:04 -0500
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753219AbZBMM7D
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 07:59:03 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:38655 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753090AbZBMM7B (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 07:59:01 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 13 Feb 2009 13:58:57 +0100
Received: from localhost.localdomain ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 13 Feb 2009 13:58:57 +0100
X-Mailer: git-send-email 1.6.2.rc0.274.g97213
X-OriginalArrivalTime: 13 Feb 2009 12:58:57.0227 (UTC) FILETIME=[D4F961B0:01C98DDA]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109745>

'git log --abbrev-commit' adds an ellipsis to all commit names that
were abbreviated.  This is annoying if you want to cut&paste the sha1
from the terminal, since selecting by word will pick up '...' too.
(And this cannot be fixed by making '.' a non-word character; in other
instances, such as the '123457..abcdef0' from git-fetch, it's part of
the expression.)

So we introduce a new variable format.abbrevEllipsis that defaults to
true (previous behaviour).  If disabled, the formatting routines for
log/show/whatchanged do not append an ellipsis.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Asked for by dato (Adeodato Sim=C3=B3) on IRC.  The bad interaction wit=
h
word selection always bothered me, so I jumped at the opportunity.

BTW, how strict is the alphabetic order of Documentation/config.txt
supposed to be?  I noticed several options are in the wrong place,
e.g., format.headers, format.suffix, pack.indexVersion, and
core.autocrlf.


 Documentation/config.txt |    6 ++++++
 builtin-log.c            |    4 ++++
 log-tree.c               |   19 ++++++++++++++-----
 log-tree.h               |    3 +++
 pretty.c                 |    6 ++----
 t/t4202-log.sh           |   23 +++++++++++++++++++++++
 6 files changed, 52 insertions(+), 9 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1806a60..ee5b76f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -656,6 +656,12 @@ fetch.unpackLimit::
 	especially on slow filesystems.  If not set, the value of
 	`transfer.unpackLimit` is used instead.
=20
+format.abbrevEllipsis::
+	Whether --abbrev-commit for log/show/whatchanged should append
+	an ellipsis (...) to the abbreviated SHA-1.  Defaults to true.
+	See linkgit:git-log[1], linkgit:git-show[1],
+	linkgit:git-whatchanged[1].
+
 format.numbered::
 	A boolean which can enable or disable sequence numbers in patch
 	subjects.  It defaults to "auto" which enables it only if there
diff --git a/builtin-log.c b/builtin-log.c
index 2ae39af..f85e469 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -227,6 +227,10 @@ static int git_log_config(const char *var, const c=
har *value, void *cb)
 		default_show_root =3D git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "format.abbrevellipsis")) {
+		log_abbrev_commit_ellipsis =3D git_config_bool(var, value);
+		return 0;
+	}
 	return git_diff_ui_config(var, value, cb);
 }
=20
diff --git a/log-tree.c b/log-tree.c
index 194ddb1..ec7d3e4 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -8,6 +8,7 @@
 #include "refs.h"
=20
 struct decoration name_decoration =3D { "object names" };
+int log_abbrev_commit_ellipsis =3D 1;
=20
 static void add_name_decoration(const char *prefix, const char *name, =
struct object *obj)
 {
@@ -43,12 +44,20 @@ void load_ref_decorations(void)
 	}
 }
=20
+const char *log_unique_abbrev(const unsigned char *sha1, int abbrev)
+{
+	if (log_abbrev_commit_ellipsis)
+		return diff_unique_abbrev(sha1, abbrev);
+	else
+		return find_unique_abbrev(sha1, abbrev);
+}
+
 static void show_parents(struct commit *commit, int abbrev)
 {
 	struct commit_list *p;
 	for (p =3D commit->parents; p ; p =3D p->next) {
 		struct commit *parent =3D p->item;
-		printf(" %s", diff_unique_abbrev(parent->object.sha1, abbrev));
+		printf(" %s", log_unique_abbrev(parent->object.sha1, abbrev));
 	}
 }
=20
@@ -280,7 +289,7 @@ void show_log(struct rev_info *opt)
 					putchar('>');
 			}
 		}
-		fputs(diff_unique_abbrev(commit->object.sha1, abbrev_commit), stdout=
);
+		fputs(log_unique_abbrev(commit->object.sha1, abbrev_commit), stdout)=
;
 		if (opt->print_parents)
 			show_parents(commit, abbrev_commit);
 		show_decorations(opt, commit);
@@ -348,14 +357,14 @@ void show_log(struct rev_info *opt)
 					putchar('>');
 			}
 		}
-		fputs(diff_unique_abbrev(commit->object.sha1, abbrev_commit),
+		fputs(log_unique_abbrev(commit->object.sha1, abbrev_commit),
 		      stdout);
 		if (opt->print_parents)
 			show_parents(commit, abbrev_commit);
 		if (parent)
 			printf(" (from %s)",
-			       diff_unique_abbrev(parent->object.sha1,
-						  abbrev_commit));
+			       log_unique_abbrev(parent->object.sha1,
+						 abbrev_commit));
 		show_decorations(opt, commit);
 		printf("%s", diff_get_color_opt(&opt->diffopt, DIFF_RESET));
 		if (opt->commit_format =3D=3D CMIT_FMT_ONELINE) {
diff --git a/log-tree.h b/log-tree.h
index f2a9008..af99c69 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -3,6 +3,8 @@
=20
 #include "revision.h"
=20
+extern int log_abbrev_commit_ellipsis;
+
 struct log_info {
 	struct commit *commit, *parent;
 };
@@ -18,5 +20,6 @@ void log_write_email_headers(struct rev_info *opt, co=
nst char *name,
 			     const char **extra_headers_p,
 			     int *need_8bit_cte_p);
 void load_ref_decorations(void);
+const char *log_unique_abbrev(const unsigned char *sha1, int abbrev);
=20
 #endif
diff --git a/pretty.c b/pretty.c
index cc460b5..c64ad23 100644
--- a/pretty.c
+++ b/pretty.c
@@ -210,15 +210,13 @@ static void add_merge_info(enum cmit_fmt fmt, str=
uct strbuf *sb,
 	while (parent) {
 		struct commit *p =3D parent->item;
 		const char *hex =3D NULL;
-		const char *dots;
 		if (abbrev)
-			hex =3D find_unique_abbrev(p->object.sha1, abbrev);
+			hex =3D log_unique_abbrev(p->object.sha1, abbrev);
 		if (!hex)
 			hex =3D sha1_to_hex(p->object.sha1);
-		dots =3D (abbrev && strlen(hex) !=3D 40) ?  "..." : "";
 		parent =3D parent->next;
=20
-		strbuf_addf(sb, " %s%s", hex, dots);
+		strbuf_addf(sb, " %s", hex);
 	}
 	strbuf_addch(sb, '\n');
 }
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 7b976ee..730036e 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -134,5 +134,28 @@ test_expect_success 'log --grep -i' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'git log --abbrev-commit (default: ellipsis enable=
d)' '
+	git log --pretty=3Doneline --abbrev-commit -1 |
+	grep "^$(git log --pretty=3Dformat:%h -1)\\.\\.\\."
+'
+
+test_expect_success 'enable format.abbrevEllipsis' '
+	git config format.abbrevEllipsis true
+'
+
+test_expect_success 'git log --abbrev-commit (ellipsis enabled)' '
+	git log --pretty=3Doneline --abbrev-commit -1 |
+	grep "^$(git log --pretty=3Dformat:%h -1)\\.\\.\\."
+'
+
+test_expect_success 'disable format.abbrevEllipsis' '
+	git config format.abbrevEllipsis false
+'
+
+test_expect_success 'git log --abbrev-commit (ellipsis disabled)' '
+	git log --pretty=3Doneline --abbrev-commit -1 |
+	grep "^$(git log --pretty=3Dformat:%h -1) "
+'
+
 test_done
=20
--=20
1.6.2.rc0.274.g97213
