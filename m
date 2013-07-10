From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [RFC/PATCH 1/4] builtin: add git-check-mailmap command
Date: Wed, 10 Jul 2013 15:03:58 -0400
Message-ID: <1373483041-27901-2-git-send-email-sunshine@sunshineco.com>
References: <1373483041-27901-1-git-send-email-sunshine@sunshineco.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Marius Storm-Olsen <marius@trolltech.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 10 21:05:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwzhF-0006vD-Gx
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jul 2013 21:05:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753758Ab3GJTE5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jul 2013 15:04:57 -0400
Received: from mail-gg0-f169.google.com ([209.85.161.169]:58695 "EHLO
	mail-gg0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752792Ab3GJTE4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jul 2013 15:04:56 -0400
Received: by mail-gg0-f169.google.com with SMTP id b1so2467020ggn.0
        for <git@vger.kernel.org>; Wed, 10 Jul 2013 12:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=Y1xjDlvZLG/4tgCqX46/7L0fSRfUT2AqEeplwXyYkiM=;
        b=W4buhuVQgzbSJ5yyMYVfNdxCKmKrp737CcoLqeUbDyhPisktteA1iZWjOeFHH/TXDt
         3Hn0MnXo1QETw4mPiylsSHQeMEfjE+qDFRKzZ0Cpskyx856pA/0FIlUQ7iKoVsBkrIS1
         aP/V9Ivn6so2ur2sXDgxueSSp63fd8dee3W7IL4Y5k1m2v//tPnKEL8ve7N9PNfVBE3y
         mxV0SECyr0zGoMYLY9Tu/hWDcfo2a0HWDkG+j9MHYo8jjrj6Nn8x3baK38O/iRO0NR4H
         uCCXQyKAkeMOEjPFzs3x8xxWn/zlRjIN+8J4uAOS8rdC5jcsVPZR6C97DcwiqCDTqjyl
         ipAA==
X-Received: by 10.236.199.77 with SMTP id w53mr18818544yhn.126.1373483095670;
        Wed, 10 Jul 2013 12:04:55 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id 66sm54426527yhe.20.2013.07.10.12.04.51
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 10 Jul 2013 12:04:54 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1373483041-27901-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230065>

Introduce command check-mailmap, similar to check-attr and check-ignore,
which allows direct testing of .mailmap configuration.

As plumbing accessible to scripts and other porcelain, check-mailmap
publishes the stable, well-tested .mailmap functionality employed by
built-in Git commands.  Consequently, script authors need not
re-implement .mailmap functionality manually, thus avoiding potential
quirks and behavioral differences.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 .gitignore                             |  1 +
 Makefile                               |  1 +
 builtin.h                              |  1 +
 builtin/check-mailmap.c                | 73 ++++++++++++++++++++++++++++++++++
 command-list.txt                       |  1 +
 contrib/completion/git-completion.bash |  1 +
 git.c                                  |  1 +
 7 files changed, 79 insertions(+)
 create mode 100644 builtin/check-mailmap.c

diff --git a/.gitignore b/.gitignore
index efa8db0..6b1fd1b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -23,6 +23,7 @@
 /git-cat-file
 /git-check-attr
 /git-check-ignore
+/git-check-mailmap
 /git-check-ref-format
 /git-checkout
 /git-checkout-index
diff --git a/Makefile b/Makefile
index 0600eb4..ef442eb 100644
--- a/Makefile
+++ b/Makefile
@@ -912,6 +912,7 @@ BUILTIN_OBJS += builtin/bundle.o
 BUILTIN_OBJS += builtin/cat-file.o
 BUILTIN_OBJS += builtin/check-attr.o
 BUILTIN_OBJS += builtin/check-ignore.o
+BUILTIN_OBJS += builtin/check-mailmap.o
 BUILTIN_OBJS += builtin/check-ref-format.o
 BUILTIN_OBJS += builtin/checkout-index.o
 BUILTIN_OBJS += builtin/checkout.o
diff --git a/builtin.h b/builtin.h
index 1ed8edb..8afa2de 100644
--- a/builtin.h
+++ b/builtin.h
@@ -40,6 +40,7 @@ extern int cmd_checkout(int argc, const char **argv, const char *prefix);
 extern int cmd_checkout_index(int argc, const char **argv, const char *prefix);
 extern int cmd_check_attr(int argc, const char **argv, const char *prefix);
 extern int cmd_check_ignore(int argc, const char **argv, const char *prefix);
+extern int cmd_check_mailmap(int argc, const char **argv, const char *prefix);
 extern int cmd_check_ref_format(int argc, const char **argv, const char *prefix);
 extern int cmd_cherry(int argc, const char **argv, const char *prefix);
 extern int cmd_cherry_pick(int argc, const char **argv, const char *prefix);
diff --git a/builtin/check-mailmap.c b/builtin/check-mailmap.c
new file mode 100644
index 0000000..cbcc6db
--- /dev/null
+++ b/builtin/check-mailmap.c
@@ -0,0 +1,73 @@
+#include "builtin.h"
+#include "mailmap.h"
+#include "parse-options.h"
+#include "string-list.h"
+
+static int use_stdin;
+static int null_out;
+static const char * const check_mailmap_usage[] = {
+N_("git check-mailmap [options] <contact>..."),
+NULL
+};
+
+static const struct option check_mailmap_options[] = {
+	OPT_BOOLEAN(0, "stdin", &use_stdin,
+		    N_("also read contacts from stdin")),
+	OPT_BOOLEAN('z', NULL, &null_out,
+		    N_("null-terminate output lines")),
+	OPT_END()
+};
+
+static void check_mailmap(struct string_list *mailmap, const char *contact)
+{
+	const char *name, *mail;
+	size_t namelen, maillen;
+	struct ident_split ident;
+	char term = null_out ? '\0' : '\n';
+
+	if (split_ident_line(&ident, contact, strlen(contact)))
+		die(_("unable to parse contact: %s"), contact);
+
+	name = ident.name_begin;
+	namelen = ident.name_end - ident.name_begin;
+	mail = ident.mail_begin;
+	maillen = ident.mail_end - ident.mail_begin;
+
+	map_user(mailmap, &mail, &maillen, &name, &namelen);
+
+	if (namelen)
+		printf("%.*s <%.*s>%c",
+			(int)namelen, name, (int)maillen, mail, term);
+	else
+		printf("<%.*s>%c", (int)maillen, mail, term);
+}
+
+int cmd_check_mailmap(int argc, const char **argv, const char *prefix)
+{
+	int i;
+	struct string_list mailmap = STRING_LIST_INIT_NODUP;
+
+	git_config(git_default_config, NULL);
+	argc = parse_options(argc, argv, prefix, check_mailmap_options,
+		check_mailmap_usage, 0);
+	if (argc == 0 && !use_stdin)
+		die(_("no contacts specified"));
+
+	read_mailmap(&mailmap, NULL);
+
+	for (i = 0; i < argc; ++i)
+		check_mailmap(&mailmap, argv[i]);
+	maybe_flush_or_die(stdout, "contact to stdout");
+
+	if (use_stdin) {
+		struct strbuf buf = STRBUF_INIT;
+		while (strbuf_getline(&buf, stdin, '\n') != EOF) {
+			check_mailmap(&mailmap, buf.buf);
+			maybe_flush_or_die(stdout, "contact to stdout");
+		}
+		strbuf_release(&buf);
+	}
+
+	clear_mailmap(&mailmap);
+	return 0;
+}
diff --git a/command-list.txt b/command-list.txt
index bf83303..08b04e2 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -13,6 +13,7 @@ git-bundle                              mainporcelain
 git-cat-file                            plumbinginterrogators
 git-check-attr                          purehelpers
 git-check-ignore                        purehelpers
+git-check-mailmap                       purehelpers
 git-checkout                            mainporcelain common
 git-checkout-index                      plumbingmanipulators
 git-check-ref-format                    purehelpers
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ebc40d4..c118550 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -648,6 +648,7 @@ __git_list_porcelain_commands ()
 		cat-file)         : plumbing;;
 		check-attr)       : plumbing;;
 		check-ignore)     : plumbing;;
+		check-mailmap)    : plumbing;;
 		check-ref-format) : plumbing;;
 		checkout-index)   : plumbing;;
 		commit-tree)      : plumbing;;
diff --git a/git.c b/git.c
index 4359086..02c3035 100644
--- a/git.c
+++ b/git.c
@@ -324,6 +324,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "cat-file", cmd_cat_file, RUN_SETUP },
 		{ "check-attr", cmd_check_attr, RUN_SETUP },
 		{ "check-ignore", cmd_check_ignore, RUN_SETUP | NEED_WORK_TREE },
+		{ "check-mailmap", cmd_check_mailmap, RUN_SETUP },
 		{ "check-ref-format", cmd_check_ref_format },
 		{ "checkout", cmd_checkout, RUN_SETUP | NEED_WORK_TREE },
 		{ "checkout-index", cmd_checkout_index,
-- 
1.8.3.2
