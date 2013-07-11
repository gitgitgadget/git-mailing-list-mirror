From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 1/4] builtin: add git-check-mailmap command
Date: Thu, 11 Jul 2013 10:55:25 -0400
Message-ID: <1373554528-15775-2-git-send-email-sunshine@sunshineco.com>
References: <1373554528-15775-1-git-send-email-sunshine@sunshineco.com>
Cc: Duy Nguyen <pclouds@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 11 16:56:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxII8-00006J-JU
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 16:56:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498Ab3GKO4O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 10:56:14 -0400
Received: from mail-gh0-f181.google.com ([209.85.160.181]:51635 "EHLO
	mail-gh0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932193Ab3GKO4N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 10:56:13 -0400
Received: by mail-gh0-f181.google.com with SMTP id z12so2789148ghb.26
        for <git@vger.kernel.org>; Thu, 11 Jul 2013 07:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=TN874CYlRmCqxZLLAIJuxKv0nL7B7Nxa4HNq+wy2n3g=;
        b=gCD9PRRIRPjZIRBlE6mG9o9LsZxpaIBwYcbbswsYf5jantbywB8gzQfT55/D9bEdQk
         Faw+G8lQofyFZGVcwDFbgrD6WUbtvQjKf5X9nFTwJ0psip9mpT4R152hM919jem25CMt
         refdYSuQI2AVnaZuftpq8WazIyHb3MaoCey8eppU2GbC9GDsv6MO4xZl5sMdZPjvBnwN
         3kmFkQLVx8ZZKpWJaotkuEhvmycH3yAErg1RnRhsB5r3VyVcso6hR2Ii+seCvOgj85Ci
         uWC2t93KpTarsWS+w27Ww9qdO2siThKbH19AeKm8nROuMBBvZ4OPT3XP07befQsDI+sO
         skiw==
X-Received: by 10.236.137.15 with SMTP id x15mr20834773yhi.225.1373554571961;
        Thu, 11 Jul 2013 07:56:11 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id s29sm60841065yhf.6.2013.07.11.07.56.09
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 11 Jul 2013 07:56:10 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1373554528-15775-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230102>

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
 Documentation/git-check-mailmap.txt    | 55 +++++++++++++++++++++++++++
 Makefile                               |  1 +
 builtin.h                              |  1 +
 builtin/check-mailmap.c                | 69 ++++++++++++++++++++++++++++++++++
 command-list.txt                       |  1 +
 contrib/completion/git-completion.bash |  1 +
 git.c                                  |  1 +
 8 files changed, 130 insertions(+)
 create mode 100644 Documentation/git-check-mailmap.txt
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
diff --git a/Documentation/git-check-mailmap.txt b/Documentation/git-check-mailmap.txt
new file mode 100644
index 0000000..3040bbc
--- /dev/null
+++ b/Documentation/git-check-mailmap.txt
@@ -0,0 +1,55 @@
+git-check-mailmap(1)
+====================
+
+NAME
+----
+git-check-mailmap - Show canonical mappings of names and email addresses
+
+
+SYNOPSIS
+--------
+[verse]
+'git check-mailmap' [options] <contact>...
+
+
+DESCRIPTION
+-----------
+
+For each ``Name $$<email@address>$$'' or ``$$<email@address>$$'' provided on
+the command-line or standard input (when using `--stdin`), prints a line with
+the canonical contact information for that person according to the 'mailmap'
+(see "Mapping Authors" below). If no mapping exists for the person, echoes the
+provided contact information.
+
+
+OPTIONS
+-------
+--stdin::
+	Read contacts, one per line, from the standard input after exhausting
+	contacts provided on the command-line.
+
+-z::
+--null::
+	Terminate each printed contact line with a null character `\0` rather
+	than a newline.
+
+
+OUTPUT
+------
+
+For each contact, a single line is printed of the form ``Name
+$$<email@address>$$'' if the name is provided or known to the 'mailmap'; or of
+the form ``$$<email@address>$$'' if no name is provided or known. Each line is
+terminated by a newline, or by a null character `\0` when `-z` or `--null` is
+specified.
+
+
+MAPPING AUTHORS
+---------------
+
+include::mailmap.txt[]
+
+
+GIT
+---
+Part of the linkgit:git[1] suite
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
index 0000000..c36a61c
--- /dev/null
+++ b/builtin/check-mailmap.c
@@ -0,0 +1,69 @@
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
+	OPT_BOOL(0, "stdin", &use_stdin, N_("also read contacts from stdin")),
+	OPT_BOOL('z', "null", &null_out, N_("null-terminate output lines")),
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
+		printf("%.*s ", (int)namelen, name);
+	printf("<%.*s>%c", (int)maillen, mail, term);
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
+	maybe_flush_or_die(stdout, "stdout");
+
+	if (use_stdin) {
+		struct strbuf buf = STRBUF_INIT;
+		while (strbuf_getline(&buf, stdin, '\n') != EOF) {
+			check_mailmap(&mailmap, buf.buf);
+			maybe_flush_or_die(stdout, "stdout");
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
