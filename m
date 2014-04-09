From: Diego Lago <diego.lago.gonzalez@gmail.com>
Subject: =?UTF-8?q?=5BPATCH=5D=20Add=20support=20for=20commit=20attributes?=
Date: Wed,  9 Apr 2014 21:38:15 +0200
Message-ID: <1397072295-7670-1-git-send-email-diego.lago.gonzalez@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, Diego Lago <diego.lago.gonzalez@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 09 21:38:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXyKd-0003w5-UE
	for gcvg-git-2@plane.gmane.org; Wed, 09 Apr 2014 21:38:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964970AbaDITin convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Apr 2014 15:38:43 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:43348 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933342AbaDITim (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2014 15:38:42 -0400
Received: by mail-we0-f174.google.com with SMTP id t60so2943805wes.19
        for <git@vger.kernel.org>; Wed, 09 Apr 2014 12:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=hF9dyXDMdZAcxigKse82E1vsEMUU3EGrwbuiOrWBfGY=;
        b=nqADFCHw7UkbPLKcGbqdEX407CDOlhRAGrYyyCmnHP/tbN0QwlrsGdSavP0GFzk9lJ
         VCNTAofwvPsFwLybSc2VAFavw6xu5jGwcFEtx3ednD1dyNGfL1fSVdWvGT9phNjeylH9
         nbHnUkYF3CgocPIqL50HjiRy1tQ8QDTdFk1qeMUpfz03YXqnHAHzIMIK68sCKyGaAHPu
         0O+Z5RAa0F1+Mb8qHATrkUQNmz3cpFGHYB7LT1nJUkntxd6B1+mJXeGsvXeZfKAQEORF
         I5zxxbFpWc3pp5VN/JfOKBGzXxVoUau/glGGxbpwGDKVa06nHN1e3T3bAaTAZNDesimd
         FNbg==
X-Received: by 10.180.14.40 with SMTP id m8mr11458026wic.31.1397072320817;
        Wed, 09 Apr 2014 12:38:40 -0700 (PDT)
Received: from localhost.localdomain (79.109.35.75.dyn.user.ono.com. [79.109.35.75])
        by mx.google.com with ESMTPSA id l12sm3029583wjr.35.2014.04.09.12.38.39
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 09 Apr 2014 12:38:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245995>

Commit attributes are custom commit extra headers the user can
add to the commit object.

The motivation for this patch is that in my company we have a custom
continuous integration software that uses a custom formatted commit
message (currently in YALM format) to show several information into
our CI server front-end.

But this YALM-based commit message pollutes the commit object not being
human readable, so a good form of achieve the YALM's behaviour (without
using YALM nor any other structured language) is to add custom attribut=
es
to the commit object itself.

=46or example, in our CI server we show the risk of the change (that ca=
n
be low, medium or high); we, as said before, add this information by pu=
tting
YALM code inside the commit message, but the problem is that this messa=
ge
is not human readable.

To solve this in Git, we can use this patch to add a commit attribute
indicating the risk of the commit out of the commit message, so that co=
mmit
message can be a normal message (git notes would be a good approach, bu=
t this
information is not inside of the commit object and in my company we nee=
d the
commit carries the whole information).

We could achieve this behaviour using git notes, but this approach impl=
ies
using two operations per commit, and we have found with complaints from=
 users.

=46or example, to do a commit with 'risk' attribute, we would do:

$ edit file.txt
$ git add file.txt
$ git commit -m "Commit message." --attr risk=3Dlow file.txt

Attributes are not shown in normal git log/show. They must be obtained =
in
an explicit way. For example, to show the previous attribute, we would =
do:

$ git log -1 --format=3D"%A(risk)"
low
$ git log -1 --format=3D"%A(not_found)"
%A(not_found)
$ git log -1 --format=3D"%A?(not_found)"

$


Diego Lago (1):
  Add support for commit attributes

 Documentation/git-commit.txt     |   12 ++-
 Documentation/pretty-formats.txt |   17 ++++
 builtin/commit.c                 |  200 ++++++++++++++++++++++++++++++=
++++++++
 pretty.c                         |   41 ++++++++
 t/t2400-commit-attributes.sh     |  187 ++++++++++++++++++++++++++++++=
+++++
 5 files changed, 456 insertions(+), 1 deletion(-)
 create mode 100755 t/t2400-commit-attributes.sh

--=20
1.7.9.5

=46rom 5d63d32fc94c5824e6189092065160eaf075ff5e Mon Sep 17 00:00:00 200=
1
=46rom: Diego Lago <diego.lago.gonzalez@gmail.com>
Date: Tue, 8 Apr 2014 17:29:48 +0200
Subject: [PATCH] Add support for commit attributes

Commit objects support extended attributes using '-A' or '--attr' flag =
to
add them with 'git commit' command. Also, commit attributes are obtaine=
d
using '%A(...)' format in git log and git show command. Examples:

git commit -m "Commit message." --attr name=3Dvalue
git log -1 --format=3D"%A(name)" # Shows 'value'.

In addition, documentation and tests have been added.

Signed-off-by: Diego Lago <diego.lago.gonzalez@gmail.com>
---
 Documentation/git-commit.txt     |   12 ++-
 Documentation/pretty-formats.txt |   17 ++++
 builtin/commit.c                 |  200 ++++++++++++++++++++++++++++++=
++++++++
 pretty.c                         |   41 ++++++++
 t/t2400-commit-attributes.sh     |  187 ++++++++++++++++++++++++++++++=
+++++
 5 files changed, 456 insertions(+), 1 deletion(-)
 create mode 100755 t/t2400-commit-attributes.sh

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.tx=
t
index 429267a..7967eca 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
 	   [--allow-empty-message] [--no-verify] [-e] [--author=3D<author>]
 	   [--date=3D<date>] [--cleanup=3D<mode>] [--[no-]status]
-	   [-i | -o] [-S[<keyid>]] [--] [<file>...]
+	   [(-A | --attr) <key=3Dvalue>] [-i | -o] [-S[<keyid>]] [--] [<file>=
=2E..]
=20
 DESCRIPTION
 -----------
@@ -304,6 +304,16 @@ configuration variable documented in linkgit:git-c=
onfig[1].
 	commit message template when using an editor to prepare the
 	default commit message.
=20
+-A <key=3Dvalue>::
+--attr=3D<key=3Dvalue>::
+	Add an attribute (extra header) to the commit object. The attribute f=
orm
+	is a 'key=3Dvalue' pair and neither the key nor the value cannot be e=
mpty (if
+	the commit is an amend commit, value can be empty). You can add as ma=
ny
+	attributes as you want and these attributes can be shown either by
+	linkgit:git-log[1] or linkgit:git-show[1]. If used with --amend optio=
n,
+	duplicated attributes are replaced and if attributes have an empty va=
lue,
+	they are removed from the commit object.
+
 -S[<keyid>]::
 --gpg-sign[=3D<keyid>]::
 	GPG-sign commit.
diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-fo=
rmats.txt
index 1d174fd..23d54b6 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -134,6 +134,8 @@ The placeholders are:
 - '%b': body
 - '%B': raw body (unwrapped subject and body)
 - '%N': commit notes
+- '%A[?](...)': commit attribute (specifying attribute name inside bra=
ckets).
+  If used with '?', the placeholder is not shown if attribute is not f=
ound.
 - '%GG': raw verification message from GPG for a signed commit
 - '%G?': show "G" for a Good signature, "B" for a Bad signature, "U" f=
or a good,
   untrusted signature and "N" for no signature
@@ -197,6 +199,21 @@ If you add a ` ` (space) after '%' of a placeholde=
r, a space
 is inserted immediately before the expansion if and only if the
 placeholder expands to a non-empty string.
=20
+* 'Commit attributes'
++
+In order to show commit attributes (extra headers), you have to put th=
e name
+of the attribute inside brackets of the %A placeholder. For example:
++
+---------------------
+$ git commit --attr "example_attr=3DThe attribute value." -m "Commit m=
essage."
+$ git show --format=3D"%h %s -- Example attribute: %A(example_attr) [%=
an]"
+4dabe05 Commit message. -- Example attribute: The attribute value. [Jo=
hn Doe]
+$ git show --format=3D"%h %s -- Not found: %A(not_found_attr) [%an]"
+4dbbe05 Commit message. -- Not found: %A(not_found_attr). [John Doe]
+$ git show --format=3D"%h %s -- Not found: %A?(not_found_attr). [%an]"
+4dbbe05 Commit message. -- Not found: . [John Doe]
+---------------------
+
 * 'tformat:'
 +
 The 'tformat:' format works exactly like 'format:', except that it
diff --git a/builtin/commit.c b/builtin/commit.c
index d9550c5..3ba4995 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -103,6 +103,9 @@ static int no_post_rewrite, allow_empty_message;
 static char *untracked_files_arg, *force_date, *ignore_submodule_arg;
 static char *sign_commit;
=20
+/* Commit attributes (commit extra headers) */
+static struct commit_extra_header *commit_attrs =3D NULL;
+
 /*
  * The default commit message cleanup mode will remove the lines
  * beginning with # (shell comments) and leading and trailing
@@ -1479,6 +1482,192 @@ int run_commit_hook(int editor_is_used, const c=
har *index_file, const char *name
 	return ret;
 }
=20
+/* Removes the given commit extra header returning its parent. */
+static struct commit_extra_header *remove_commit_extra_header(
+	struct commit_extra_header **headers, struct commit_extra_header *to_=
remove)
+{
+	if (!headers || !*headers)
+		return NULL;
+
+	struct commit_extra_header *r =3D *headers, *parent =3D NULL;
+	while(r !=3D NULL) {
+		if (r =3D=3D to_remove) {
+			if (parent =3D=3D NULL) {
+				*headers =3D r->next;
+			} else {
+				parent->next =3D r->next;
+			}
+			free(to_remove->key);
+			free(to_remove->value);
+			free(to_remove);
+			break;
+		}
+		parent =3D r;
+		r =3D r->next;
+	}
+	return parent !=3D NULL ? parent : *headers;
+}
+
+/* Check for duplicated/empty attributes. */
+static void process_commit_attrs(struct commit_extra_header **attrs,
+				struct commit_extra_header **new_attrs, int is_amend)
+{
+	/*
+	 * Check first if there are duplicated attributes from the attributes
+	 * to be appended (new_attrs).
+	 */
+	struct commit_extra_header *r =3D *new_attrs, *r2 =3D *new_attrs;
+	while(r !=3D NULL) {
+		r2 =3D *new_attrs;
+		while(r2 !=3D NULL) {
+			if (r !=3D r2 && strcmp(r->key, r2->key) =3D=3D 0) {
+				die(_("Cannot add duplicated attributes to a commit: %s"),
+					r->key);
+			}
+			r2 =3D r2->next;
+		}
+		r =3D r->next;
+	}
+
+	/*
+	 * Now, check if there are duplicates for amended commits. Then, repl=
ace
+	 * if they have a value or remove if they have an empty value.
+	 */
+	if (is_amend) {
+		r =3D *attrs, r2 =3D *new_attrs;
+		while(r !=3D NULL) {
+			r2 =3D *new_attrs;
+			while(r2 !=3D NULL) {
+				if (r !=3D r2 && strcmp(r->key, r2->key) =3D=3D 0) {
+					struct commit_extra_header *to_remove =3D r2;
+					if (r2->len =3D=3D 0) {
+						/* If attribute is 'key=3D', remove it from main attrs. */
+						r =3D remove_commit_extra_header(attrs, r);
+					} else {
+						free(r->value);
+						r->value =3D xmalloc(r2->len);
+						memcpy(r->value, r2->value, r2->len);
+						r->len =3D r2->len;
+					}
+					r2 =3D r2->next;
+					remove_commit_extra_header(new_attrs, to_remove);
+				} else {
+					r2 =3D r2->next;
+				}
+			}	// while r2
+			if (!r)
+				break;
+			r =3D r->next;
+		}	// while r
+	}
+}
+
+/* Checks if there are any commit extra header with an empty value. */
+static void check_for_empty_attrs(struct commit_extra_header *attrs)
+{
+	struct commit_extra_header *r =3D attrs;
+
+	while(r !=3D NULL) {
+		if (r->len =3D=3D 0)
+			die(_("Cannot add an empty attribute to a commit: %s"), r->key);
+		r =3D r->next;
+	}
+}
+
+/* Append attrs to current_attrs. */
+static void append_commit_attrs(struct commit_extra_header **current_a=
ttrs,
+				struct commit_extra_header *attrs)
+{
+	if(*current_attrs =3D=3D NULL) {
+		*current_attrs =3D attrs;
+		return;
+	}
+
+	struct commit_extra_header *r =3D *current_attrs;
+
+	while(r->next !=3D NULL)
+		r =3D r->next;
+
+	r->next =3D attrs;
+}
+
+static void check_disallowed_attribute_names(const char *attr_name)
+{
+	const char *disallowed_names[] =3D { "author", "committer", "encoding=
",
+		"gpgsig", "mergetag", "parent", "tree" };
+
+	int i;
+	for (i =3D 0; i < ARRAY_SIZE(disallowed_names); i++) {
+		if (strcmp(attr_name, disallowed_names[i]) =3D=3D 0) {
+			die(_("Invalid commit attribute name: %s"), attr_name);
+		}
+	}
+}
+
+/* Parses -A/--attr value of the form 'key=3Dvalue'. */
+static int parse_attr_option_callback(const struct option *option,
+				const char *arg, int unset)
+{
+	unsigned short key_len =3D 0;
+	unsigned short value_len =3D 0;
+	short equal_found =3D 0;
+	short invalid_char_in_name =3D 0;
+	short invalid_char_in_value =3D 0;
+
+	int i;
+	for (i =3D 0; arg[i] !=3D '\0'; i++) {
+		if (arg[i] =3D=3D '=3D') {
+			equal_found =3D 1;
+			if (invalid_char_in_name) {
+				break;
+			}
+		} else if (!equal_found && (arg[i] =3D=3D ' ' || arg[i] =3D=3D '\n')=
) {
+			invalid_char_in_name =3D 1;
+			key_len++;
+		} else if (equal_found && (arg[i] =3D=3D '\n')) {
+			invalid_char_in_value =3D 1;
+			value_len++;
+		} else {
+			if(equal_found) {
+				value_len++;
+			} else {
+				key_len++;
+			}
+		}
+	}
+
+	if(!equal_found || key_len =3D=3D 0) {
+		die(_("Invalid commit attribute format (must be 'key=3Dvalue'): %s")=
, arg);
+	}
+
+	struct commit_extra_header *attr =3D xmalloc(sizeof(*attr));
+	attr->next =3D NULL;
+	attr->key =3D xmalloc(key_len + 1);
+	memcpy(attr->key, arg, key_len);
+	attr->key[key_len] =3D '\0';
+	if (invalid_char_in_name) {
+		die(_("Invalid character in commit attribute name: %s"), attr->key);
+	}
+
+	check_disallowed_attribute_names(attr->key);
+
+	attr->value =3D xmalloc(value_len);
+	memcpy(attr->value, arg + key_len + 1, value_len);
+	attr->len =3D value_len;
+
+	if (invalid_char_in_value) {
+		die(_("Invalid character in commit attribute value: %s"), attr->valu=
e);
+	}
+
+	if (!amend && value_len =3D=3D 0) {
+		die(_("Commit attribute value cannot be empty if not amend."));
+	}
+
+	append_commit_attrs(&commit_attrs, attr);
+
+	return 0;
+}
+
 int cmd_commit(int argc, const char **argv, const char *prefix)
 {
 	static struct wt_status s;
@@ -1526,6 +1715,7 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
 		OPT_BOOL(0, "amend", &amend, N_("amend previous commit")),
 		OPT_BOOL(0, "no-post-rewrite", &no_post_rewrite, N_("bypass post-rew=
rite hook")),
 		{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg, N_("m=
ode"), N_("show untracked files, optional modes: all, normal, no. (Defa=
ult: all)"), PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
+		OPT_CALLBACK('A', "attr", NULL, N_("key=3Dvalue"), N_("add a commit =
attribute"), &parse_attr_option_callback),
 		/* end commit contents options */
=20
 		OPT_HIDDEN_BOOL(0, "allow-empty", &allow_empty,
@@ -1659,6 +1849,16 @@ int cmd_commit(int argc, const char **argv, cons=
t char *prefix)
 		append_merge_tag_headers(parents, &tail);
 	}
=20
+	/* Check for duplicated commit attributes on extra and commit_attrs.
+	   Replace them if we are amending the commit. */
+	process_commit_attrs(&extra, &commit_attrs, amend);
+
+	/* Append extra attributes (supplied with --attr or -A). */
+	append_commit_attrs(&extra, commit_attrs);
+
+	/* Check for empty attributes again (may come from amend). */
+	check_for_empty_attrs(extra);
+
 	if (commit_tree_extended(&sb, active_cache_tree->sha1, parents, sha1,
 				 author_ident.buf, sign_commit, extra)) {
 		rollback_index_files();
diff --git a/pretty.c b/pretty.c
index 3c43db5..8f4dc95 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1081,6 +1081,45 @@ static size_t parse_padding_placeholder(struct s=
trbuf *sb,
 	return 0;
 }
=20
+static size_t parse_commit_attribute(struct strbuf *sb, /* in UTF-8 */
+			  const char *placeholder,
+			  struct format_commit_context *c,
+			  const struct commit *commit)
+{
+	unsigned short offset =3D 1;
+	unsigned short hide_if_not_found =3D 0;
+
+	if (placeholder[offset] =3D=3D '?') {
+		offset++;
+		hide_if_not_found =3D 1;
+	}
+
+	if (placeholder[offset] =3D=3D '(') {
+		const char *start =3D placeholder + offset + 1;
+		const char *end =3D strchr(start, ')');
+
+		if (!end || start =3D=3D end)
+			return 0;
+
+		const size_t len =3D end - start;
+
+		char *attr_name =3D xmalloc(len + 1);
+		memcpy(attr_name, start, len);
+		attr_name[len] =3D '\0';
+
+		const char *msg =3D commit->buffer;
+		char *header =3D get_header(commit, msg, attr_name);
+
+		if (header) {
+			strbuf_addstr(sb, header);
+			return len + offset + 2;
+		} else {
+			return hide_if_not_found ? len + offset + 2 : 0;
+		}
+	} else
+		return 0;
+}
+
 static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 				const char *placeholder,
 				void *context)
@@ -1240,6 +1279,8 @@ static size_t format_commit_one(struct strbuf *sb=
, /* in UTF-8 */
 			return 1;
 		}
 		return 0;
+	case 'A':
+		return parse_commit_attribute(sb, placeholder, c, commit);
 	}
=20
 	if (placeholder[0] =3D=3D 'G') {
diff --git a/t/t2400-commit-attributes.sh b/t/t2400-commit-attributes.s=
h
new file mode 100755
index 0000000..8993322
--- /dev/null
+++ b/t/t2400-commit-attributes.sh
@@ -0,0 +1,187 @@
+#!/bin/sh
+#
+# Copyright (c) 2014 Diego Lago Gonz=C3=A1lez
+# <diego.lago.gonzalez@gmail.com>
+#
+
+test_description=3D'git commit attributes (--attr option)
+
+This script test the commit attributes feature with
+command git commit --attr <key=3Dvalue>.'
+
+. ./test-lib.sh
+
+count=3D1
+
+test_expect_success 'git commit --attr key=3Dvalue' '
+echo test_$count > test &&
+count=3D$(($count+1)) &&
+git add test &&
+git commit --attr key=3Dvalue -m "Commit message."
+'
+
+test_expect_success 'git commit -A key=3Dvalue' '
+echo test_$count > test &&
+count=3D$(($count+1)) &&
+git add test &&
+git commit -A key=3Dvalue -m "Commit message."
+'
+
+test_expect_success 'git commit --attr=3Dkey=3Dvalue' '
+echo test_$count > test &&
+count=3D$(($count+1)) &&
+git add test &&
+git commit --attr=3Dkey=3Dvalue -m "Commit message."
+'
+
+test_expect_success 'git commit --attr with utf8 key' '
+echo test_$count > test &&
+count=3D$(($count+1)) &&
+git add test &&
+git commit --attr key=E2=86=92=3Dvalue -m "Commit message."
+'
+
+test_expect_success 'git commit --attr with utf8 value' '
+echo test_$count > test &&
+count=3D$(($count+1)) &&
+git add test &&
+git commit --attr key=3Dvalu=E2=82=AC -m "Commit message."
+'
+
+test_expect_success 'git commit --attr with a long value' '
+echo test_$count > test &&
+count=3D$(($count+1)) &&
+git add test &&
+git commit --attr "key=3DLong message for an attribute." -m "Commit me=
ssage."
+'
+
+test_expect_success 'git commit --attr with a very long value' '
+echo test_$count > test &&
+count=3D$(($count+1)) &&
+git add test &&
+git commit --attr "key=3DVery long message for a commit attribute. Thi=
s is a very long message to check if commit attributes (extra headers f=
or commit objects) work as expected." -m "Commit message."
+'
+
+test_expect_success 'git commit --attr key=3D (no value)' '
+echo test_$count > test &&
+count=3D$(($count+1)) &&
+git add test &&
+test_must_fail git commit --attr key=3D -m "Commit message."
+'
+
+test_expect_success 'git commit --attr =3D (no key and no value)' '
+echo test_$count > test &&
+count=3D$(($count+1)) &&
+git add test &&
+test_must_fail git commit --attr =3D -m "Commit message."
+'
+
+test_expect_success 'git commit --attr key (no value and no =3D sign)'=
 '
+echo test_$count > test &&
+count=3D$(($count+1)) &&
+git add test &&
+test_must_fail git commit --attr key -m "Commit message."
+'
+
+test_expect_success 'git commit --attr =3Dvalue (no key with value)' '
+echo test_$count > test &&
+count=3D$(($count+1)) &&
+git add test &&
+test_must_fail git commit --attr =3Dvalue -m "Commit message."
+'
+
+test_expect_success 'git commit --attr "key =3Dvalue" (key with space)=
' '
+echo test_$count > test &&
+count=3D$(($count+1)) &&
+git add test &&
+test_must_fail git commit --attr "key =3Dvalue" -m "Commit message."
+'
+
+test_expect_success 'git commit --attr: key with invalid chars' '
+echo test_$count > test &&
+count=3D$(($count+1)) &&
+git add test &&
+test_must_fail git commit --attr "key
+=3Dvalue" -m "Commit message."
+'
+
+test_expect_success 'git commit --attr: value with invalid chars' '
+echo test_$count > test &&
+count=3D$(($count+1)) &&
+git add test &&
+test_must_fail git commit --attr "key=3Dvalue
+with invalid
+chars" -m "Commit message."
+'
+
+test_expect_success 'git commit --amend: new attribute on amend' '
+echo test_$count > test &&
+count=3D$(($count+1)) &&
+git add test &&
+git commit --amend --attr "new_key=3Dnew value" -m "New attribute on a=
mend."
+'
+
+test_expect_success 'git commit --amend: replace attribute on amend' '
+echo test_$count > test &&
+count=3D$(($count+1)) &&
+git add test &&
+git commit --amend --attr "new_key=3Dreplaced value" -m "Replaced on a=
mend."
+'
+
+test_expect_success 'git commit --amend: remove attribute on amend' '
+echo test_$count > test &&
+count=3D$(($count+1)) &&
+git add test &&
+git commit --amend --attr "new_key=3D" -m "Removed on amend."
+'
+
+test_expect_success 'git log -1: get attribute' '
+echo test_$count > test &&
+count=3D$(($count+1)) &&
+git add test &&
+git commit --attr "key=3Dtestthis" -m "Commit message." &&
+test $(git log -1 --format=3D"%A(key)") =3D "testthis"
+'
+
+test_expect_success 'git log -1: get attribute (key not found)' '
+test_must_fail test $(git log -1 --format=3D"%A(key_invalid)") =3D "te=
stthis"
+'
+
+test_expect_success 'git log -1: get attribute (text of key not found)=
' '
+test $(git log -1 --format=3D"%A(key_invalid)") =3D "%A(key_invalid)"
+'
+
+test_expect_success 'git log -1: get attribute (invalid attribute name=
)' '
+test_must_fail test $(git log -1 --format=3D"%A(key)") =3D "testthis_i=
nvalid"
+'
+
+test_expect_success 'git log -1: get attribute (key not found but hidd=
en)' '
+test "$(git log -1 --format=3D"%A?(key_invalid)")" =3D ""
+'
+
+test_expect_success 'git log -1: get attribute (key with space)' '
+test "$(git log -1 --format=3D"% A(key)")" =3D " testthis"
+'
+
+test_expect_success 'git log -1: get attribute (key -hidden- and space=
)' '
+test "$(git log -1 --format=3D"% A?(key)")" =3D " testthis"
+'
+
+test_expect_success 'git log -1: get attribute (key not found but hidd=
en -no space-)' '
+test "$(git log -1 --format=3D"% A?(key_invalid)")" =3D ""
+'
+
+test_expect_success 'git commit --amend: check for replaced attribute'=
 '
+git commit --amend --attr key=3Dtestthat -m "Amend: replace attribute.=
"
+test_must_fail test "$(git log -1 --format=3D"%A(key)")" =3D "testthis=
"
+test "$(git log -1 --format=3D"%A(key)")" =3D "testthat"
+'
+
+test_expect_success 'git commit --amend: check for removed attribute' =
'
+git commit --amend --attr key=3D -m "Amend: replace attribute."
+test_must_fail test "$(git log -1 --format=3D"%A(key)")" =3D "testthis=
"
+test "$(git log -1 --format=3D"%A(key)")" =3D "%A(key)"
+test "$(git log -1 --format=3D"%A?(key)")" =3D ""
+'
+
+test_done
--=20
1.7.9.5
