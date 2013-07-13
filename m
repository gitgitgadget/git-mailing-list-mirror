From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 1/2] builtin: add git-check-mailmap command
Date: Fri, 12 Jul 2013 20:53:10 -0400
Message-ID: <1373676791-42758-2-git-send-email-sunshine@sunshineco.com>
References: <1373676791-42758-1-git-send-email-sunshine@sunshineco.com>
Cc: Duy Nguyen <pclouds@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 13 02:54:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uxo65-00046F-Lm
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jul 2013 02:54:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757976Ab3GMAx4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 20:53:56 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:62020 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757957Ab3GMAxz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 20:53:55 -0400
Received: by mail-ie0-f178.google.com with SMTP id u16so21345794iet.23
        for <git@vger.kernel.org>; Fri, 12 Jul 2013 17:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=JaoSiQ1RBHYHmofls/xXdO6NB2T6OZij5e1rem0Eqbs=;
        b=czjkI33YmW6pbhDZfAqWQmqE5BF/QZE3EZDJ0aYbYg9sZyyDPNF+8AxnMCH/owXUtv
         73IDanjAhC7iAHn4AZlm9gQkeaIbvrWRusgWij7spbEV4Ou1rJZNsTX503soLy0HTNwf
         oUtE3wtjnUyVgMFG44aqug22bafszKp0HnKy2gYMVgR7umG2VSCBip1gGVtRCwSG3E7H
         6XJnWUkU7jSaJ4d0jtHZxX5rV12WgtlZ9I6SLgjiiigP+m/iJftkymMzXLwoRnmfMowX
         d7GdDBp9jT+t5DokdkW66j4wT5y+PRB3rKj1mJ+5d2PGK1JYWvj6FcwhH8MeMtIKiWxw
         4JuA==
X-Received: by 10.50.88.7 with SMTP id bc7mr1737140igb.37.1373676834401;
        Fri, 12 Jul 2013 17:53:54 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id nm17sm2562384igb.5.2013.07.12.17.53.52
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 12 Jul 2013 17:53:53 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.804.g0da7a53
In-Reply-To: <1373676791-42758-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230272>

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
 Documentation/git-check-mailmap.txt    | 47 ++++++++++++++++++++++++
 Makefile                               |  1 +
 builtin.h                              |  1 +
 builtin/check-mailmap.c                | 66 ++++++++++++++++++++++++++++++++++
 command-list.txt                       |  1 +
 contrib/completion/git-completion.bash |  1 +
 git.c                                  |  1 +
 8 files changed, 119 insertions(+)
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
index 0000000..39028ee
--- /dev/null
+++ b/Documentation/git-check-mailmap.txt
@@ -0,0 +1,47 @@
+git-check-mailmap(1)
+====================
+
+NAME
+----
+git-check-mailmap - Show canonical names and email addresses of contacts
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
+For each ``Name $$<user@host>$$'' or ``$$<user@host>$$'' from the command-line
+or standard input (when using `--stdin`), look up the person's canonical name
+and email address (see "Mapping Authors" below). If found, print them;
+otherwise print the input as-is.
+
+
+OPTIONS
+-------
+--stdin::
+	Read contacts, one per line, from the standard input after exhausting
+	contacts provided on the command-line.
+
+
+OUTPUT
+------
+
+For each contact, a single line is output, terminated by a newline.  If the
+name is provided or known to the 'mailmap', ``Name $$<user@host>$$'' is
+printed; otherwise only ``$$<user@host>$$'' is printed.
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
index 0000000..8f4d809
--- /dev/null
+++ b/builtin/check-mailmap.c
@@ -0,0 +1,66 @@
+#include "builtin.h"
+#include "mailmap.h"
+#include "parse-options.h"
+#include "string-list.h"
+
+static int use_stdin;
+static const char * const check_mailmap_usage[] = {
+N_("git check-mailmap [options] <contact>..."),
+NULL
+};
+
+static const struct option check_mailmap_options[] = {
+	OPT_BOOL(0, "stdin", &use_stdin, N_("also read contacts from stdin")),
+	OPT_END()
+};
+
+static void check_mailmap(struct string_list *mailmap, const char *contact)
+{
+	const char *name, *mail;
+	size_t namelen, maillen;
+	struct ident_split ident;
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
+	printf("<%.*s>\n", (int)maillen, mail);
+}
+
+int cmd_check_mailmap(int argc, const char **argv, const char *prefix)
+{
+	int i;
+	struct string_list mailmap = STRING_LIST_INIT_NODUP;
+
+	git_config(git_default_config, NULL);
+	argc = parse_options(argc, argv, prefix, check_mailmap_options,
+			     check_mailmap_usage, 0);
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
index fa3ae1e..cd509a5 100644
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
1.8.3.2.804.g0da7a53
