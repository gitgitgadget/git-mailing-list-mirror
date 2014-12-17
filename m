From: Peter Wu <peter@lekensteyn.nl>
Subject: [PATCH v4] remote: add --fetch and --both options to set-url
Date: Wed, 17 Dec 2014 15:18:56 +0100
Message-ID: <1418825936-18575-1-git-send-email-peter@lekensteyn.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 17 15:19:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1FRW-0002C5-FA
	for gcvg-git-2@plane.gmane.org; Wed, 17 Dec 2014 15:19:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbaLQOTF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Dec 2014 09:19:05 -0500
Received: from lekensteyn.nl ([178.21.112.251]:50404 "EHLO lekensteyn.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750790AbaLQOTE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2014 09:19:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lekensteyn.nl; s=s2048-2014-q3;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From; bh=bRfaKfxivz0DBN8KD7GlofDHvuwSD9vX5rAwYOSP4a8=;
	b=ByivjmIN+clszI4XDPH1N6fdV5sugMrr2WdW4ySUXdW/hZPlpb4ms1gw1yV5uQsTxOL5Ho7WE3CorNVClDUTYz6njC9GTCpwASinropH0yjV/B29/t/m/5mwhPOWalndjUB3RByH0twMCEWqMj99ROK5bNWWuNDRdy7ZVDfbvGxGzQiEYzuDJM20/3bOeJejEHTw3/vlgMYRHAAawbxQy6FbpH/lR15JsPPFYR8CQTuPGy6QD5up6sXJZ3/FTfjQWpUknGsHLiryfjjGw5EULjbVKV4MCpExFpRhqlEXeIgemUJ53Vb1iAJEnkJGwOcRkAcpTTUEKcViNyHcjb7ZoQ==;
Received: by lekensteyn.nl with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA256:128)
	(Exim 4.80)
	(envelope-from <peter@lekensteyn.nl>)
	id 1Y1FRL-0005z3-Ol; Wed, 17 Dec 2014 15:19:00 +0100
X-Mailer: git-send-email 2.1.3
X-Spam-Score: 0.0 (/)
X-Spam-Status: No, hits=0.0 required=5.0 tests=NO_RELAYS=-0.001,URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261483>

git remote set-url knew about the '--push' option to update just the
pushurl, but it does not have a similar option for "update fetch URL an=
d
leave whatever was in place for the push URL".

This patch adds support for a '--fetch' option which implements that us=
e
case in a backwards compatible way: if no --both, --push or --fetch
options are given, then the push URL is modified too if it was not set
before. This is the case since the push URL is implicitly based on the
fetch URL.

A '--both' option is added to make the command independent of previous
pushurl settings. For the --add and --delete set operations, it will
always set the push and/ or the fetch URLs. For the primary mode of
operation (without --add or --delete), it will drop pushurl as the
implicit push URL is the (fetch) URL.

While '--both' could be implemented as '--fetch --push', it might also
be mistaken for "--push overrides --fetch". An option such as
"--only=3D{fetch|push|both}" was also considered, but it is longer than
the current options, makes --push redundant and brings the confusing
option "--only=3Dboth". Options such as '--direction=3D...' is too long=
 and
'--dir=3D' is ambiguous ("directory"?). Thus, for brevity three new
options were introduced.

The documentation has also been updated and a missing '--push' option
is added to the 'git remote -h' command.

Tests are also added to verify the documented behavior.

Signed-off-by: Peter Wu <peter@lekensteyn.nl>
---
Hi,

This is the fourth revision of the patch that allows for just setting t=
he fetch
URL. Eric wondered why '--fetch --push' is not used to describe the sta=
te
'--both', so I added this to the commit message.

The t5505-remote.sh test still passes after this change (I was unable t=
o run the
full test suite as it broke due to an unrelated gpg issue).

Kind regards,
Peter

 v2: fixed test case
 v3: added --both option, changed --fetch --push behavior, added more t=
ests for
     --add/--delete cases, refactored to reduce duplication (not specia=
l-casing
     add_mode without oldurl, just skip initially setting oldurl).
 v4: incorporated documentation suggestion from Eric Sunshine;
     Tried to make the code easier to follow by replacing
     (modify_type =3D=3D MODIFY_TYPE_FETCH) by
     (modify_type & MODIFY_TYPE_FETCH && modify_type !=3D MODIFY_TYPE_H=
ISTORIC)
     and added comments explaining why this is special (observed by Jef=
f King);
     Fixed dangling else issue reported by Torsten B=C3=B6gershausen;
     Added considerations for other options to the commit message;
     Rebased on v2.2.0-65-g9abc44b.
---

 Documentation/git-remote.txt |  16 +++--
 builtin/remote.c             | 146 ++++++++++++++++++++++++++++-------=
--------
 t/t5505-remote.sh            | 125 +++++++++++++++++++++++++++++++++++=
+
 3 files changed, 234 insertions(+), 53 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.tx=
t
index cb103c8..09a4670 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -15,9 +15,9 @@ SYNOPSIS
 'git remote remove' <name>
 'git remote set-head' <name> (-a | --auto | -d | --delete | <branch>)
 'git remote set-branches' [--add] <name> <branch>...
-'git remote set-url' [--push] <name> <newurl> [<oldurl>]
-'git remote set-url --add' [--push] <name> <newurl>
-'git remote set-url --delete' [--push] <name> <url>
+'git remote set-url' [--both | --fetch | --push] <name> <newurl> [<old=
url>]
+'git remote set-url' [--both | --fetch | --push] '--add' <name> <newur=
l>
+'git remote set-url' [--both | --fetch | --push] '--delete' <name> <ur=
l>
 'git remote' [-v | --verbose] 'show' [-n] <name>...
 'git remote prune' [-n | --dry-run] <name>...
 'git remote' [-v | --verbose] 'update' [-p | --prune] [(<group> | <rem=
ote>)...]
@@ -134,7 +134,15 @@ Changes URL remote points to. Sets first URL remot=
e points to matching
 regex <oldurl> (first URL if no <oldurl> is given) to <newurl>. If
 <oldurl> doesn't match any URL, error occurs and nothing is changed.
 +
-With '--push', push URLs are manipulated instead of fetch URLs.
+With '--both', both the fetch and push URLs are manipulated.
++
+With '--fetch', only fetch URLs are manipulated.
++
+With '--push', only push URLs are manipulated.
++
+For historical reasons, if neither --fetch nor --push is specified the=
n the
+fetch URL is changed, as well as the push URL if this was not already =
set. This
+behavior may change in the future.
 +
 With '--add', instead of changing some URL, new URL is added.
 +
diff --git a/builtin/remote.c b/builtin/remote.c
index 7f28f92..1fa2fd7 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -18,9 +18,9 @@ static const char * const builtin_remote_usage[] =3D =
{
 	N_("git remote prune [-n | --dry-run] <name>"),
 	N_("git remote [-v | --verbose] update [-p | --prune] [(<group> | <re=
mote>)...]"),
 	N_("git remote set-branches [--add] <name> <branch>..."),
-	N_("git remote set-url [--push] <name> <newurl> [<oldurl>]"),
-	N_("git remote set-url --add <name> <newurl>"),
-	N_("git remote set-url --delete <name> <url>"),
+	N_("git remote set-url [--both | --fetch | --push] <name> <newurl> [<=
oldurl>]"),
+	N_("git remote set-url [--both | --fetch | --push] --add <name> <newu=
rl>"),
+	N_("git remote set-url [--both | --fetch | --push] --delete <name> <u=
rl>"),
 	NULL
 };
=20
@@ -66,9 +66,9 @@ static const char * const builtin_remote_update_usage=
[] =3D {
 };
=20
 static const char * const builtin_remote_seturl_usage[] =3D {
-	N_("git remote set-url [--push] <name> <newurl> [<oldurl>]"),
-	N_("git remote set-url --add <name> <newurl>"),
-	N_("git remote set-url --delete <name> <url>"),
+	N_("git remote set-url [--both | --fetch | --push] <name> <newurl> [<=
oldurl>]"),
+	N_("git remote set-url [--both | --fetch | --push] --add <name> <newu=
rl>"),
+	N_("git remote set-url [--both | --fetch | --push] --delete <name> <u=
rl>"),
 	NULL
 };
=20
@@ -1503,21 +1503,39 @@ static int set_branches(int argc, const char **=
argv)
 	return set_remote_branches(argv[0], argv + 1, add_mode);
 }
=20
+#define MODIFY_TYPE_FETCH       (1 << 0)
+#define MODIFY_TYPE_PUSH        (1 << 1)
+#define MODIFY_TYPE_BOTH        (MODIFY_TYPE_FETCH | MODIFY_TYPE_PUSH)
+/* The historic behavior behaves like --fetch, but does not touch the =
push URL
+ * configuration (and thereby may appear to change the push URL too if=
 this was
+ * not set before).
+ */
+#define MODIFY_TYPE_HISTORIC    (MODIFY_TYPE_FETCH | (1 << 2))
+
 static int set_url(int argc, const char **argv)
 {
-	int i, push_mode =3D 0, add_mode =3D 0, delete_mode =3D 0;
+	int i, add_mode =3D 0, delete_mode =3D 0;
+	int modify_type =3D MODIFY_TYPE_HISTORIC;
 	int matches =3D 0, negative_matches =3D 0;
 	const char *remotename =3D NULL;
 	const char *newurl =3D NULL;
 	const char *oldurl =3D NULL;
 	struct remote *remote;
 	regex_t old_regex;
-	const char **urlset;
-	int urlset_nr;
-	struct strbuf name_buf =3D STRBUF_INIT;
+	struct strbuf name_buf_fetch =3D STRBUF_INIT;
+	struct strbuf name_buf_push =3D STRBUF_INIT;
 	struct option options[] =3D {
-		OPT_BOOL('\0', "push", &push_mode,
-			 N_("manipulate push URLs")),
+		OPT_GROUP(""),
+		OPT_SET_INT('\0', "fetch", &modify_type,
+			N_("manipulate just fetch URLs"),
+			MODIFY_TYPE_FETCH),
+		OPT_SET_INT('\0', "push", &modify_type,
+			N_("manipulate just push URLs"),
+			MODIFY_TYPE_PUSH),
+		OPT_SET_INT('\0', "both", &modify_type,
+			N_("manipulate both push and fetch URLs"),
+			MODIFY_TYPE_BOTH),
+		OPT_GROUP(""),
 		OPT_BOOL('\0', "add", &add_mode,
 			 N_("add URL")),
 		OPT_BOOL('\0', "delete", &delete_mode,
@@ -1535,7 +1553,8 @@ static int set_url(int argc, const char **argv)
=20
 	remotename =3D argv[1];
 	newurl =3D argv[2];
-	if (argc > 3)
+	/* The old URL is only meaningful for the primary non-set operation. =
*/
+	if (argc > 3 && !add_mode && !delete_mode)
 		oldurl =3D argv[3];
=20
 	if (delete_mode)
@@ -1545,47 +1564,76 @@ static int set_url(int argc, const char **argv)
 		die(_("No such remote '%s'"), remotename);
 	remote =3D remote_get(remotename);
=20
-	if (push_mode) {
-		strbuf_addf(&name_buf, "remote.%s.pushurl", remotename);
-		urlset =3D remote->pushurl;
-		urlset_nr =3D remote->pushurl_nr;
-	} else {
-		strbuf_addf(&name_buf, "remote.%s.url", remotename);
-		urlset =3D remote->url;
-		urlset_nr =3D remote->url_nr;
-	}
+	strbuf_addf(&name_buf_fetch, "remote.%s.url", remotename);
+	strbuf_addf(&name_buf_push, "remote.%s.pushurl", remotename);
=20
-	/* Special cases that add new entry. */
-	if ((!oldurl && !delete_mode) || add_mode) {
-		if (add_mode)
-			git_config_set_multivar(name_buf.buf, newurl,
-				"^$", 0);
-		else
-			git_config_set(name_buf.buf, newurl);
-		strbuf_release(&name_buf);
-		return 0;
-	}
+	if (oldurl && !add_mode) {
+		/* Old URL specified, or deletion. Demand that one matches. */
+		if (regcomp(&old_regex, oldurl, REG_EXTENDED))
+			die(_("Invalid old URL pattern: %s"), oldurl);
=20
-	/* Old URL specified. Demand that one matches. */
-	if (regcomp(&old_regex, oldurl, REG_EXTENDED))
-		die(_("Invalid old URL pattern: %s"), oldurl);
+		if (modify_type & MODIFY_TYPE_FETCH)
+			for (i =3D 0; i < remote->url_nr; i++) {
+				if (!regexec(&old_regex, remote->url[i], 0, NULL, 0))
+					matches++;
+				else
+					negative_matches++;
+			}
+		if (delete_mode && !negative_matches && modify_type & MODIFY_TYPE_FE=
TCH)
+			die(_("Will not delete all non-push URLs"));
+		if (modify_type & MODIFY_TYPE_PUSH)
+			for (i =3D 0; i < remote->pushurl_nr; i++) {
+				if (!regexec(&old_regex, remote->pushurl[i], 0, NULL, 0))
+					matches++;
+				else
+					negative_matches++;
+			}
+		if (!delete_mode && !matches)
+			die(_("No such URL found: %s"), oldurl);
=20
-	for (i =3D 0; i < urlset_nr; i++)
-		if (!regexec(&old_regex, urlset[i], 0, NULL, 0))
-			matches++;
-		else
-			negative_matches++;
-	if (!delete_mode && !matches)
-		die(_("No such URL found: %s"), oldurl);
-	if (delete_mode && !negative_matches && !push_mode)
-		die(_("Will not delete all non-push URLs"));
+		regfree(&old_regex);
+	}
=20
-	regfree(&old_regex);
+	/* Make the implicit push URL explicit if the fetch URL is modified,
+	 * except when in the historic mode (then the pushurl configuration i=
s
+	 * not changed). */
+	if (modify_type & MODIFY_TYPE_FETCH &&
+			modify_type !=3D MODIFY_TYPE_HISTORIC &&
+			remote->pushurl_nr =3D=3D 0 && remote->url_nr > 0)
+		for (i =3D 0; i < remote->url_nr; i++)
+			git_config_set_multivar(name_buf_push.buf,
+				remote->url[i], "^$", 0);
+
+	/* Set the new entry value (not a --add or --delete operation). */
+	if (!add_mode && !delete_mode && !oldurl) {
+		if (modify_type & MODIFY_TYPE_FETCH)
+			git_config_set(name_buf_fetch.buf, newurl);
+		/* URLs will be the same, so remove pushurl. */
+		if (modify_type =3D=3D MODIFY_TYPE_BOTH)
+			git_config_set(name_buf_push.buf, NULL);
+		else if (modify_type =3D=3D MODIFY_TYPE_PUSH)
+			git_config_set(name_buf_push.buf, newurl);
+
+		goto cleanup_ok;
+	}
=20
-	if (!delete_mode)
-		git_config_set_multivar(name_buf.buf, newurl, oldurl, 0);
-	else
-		git_config_set_multivar(name_buf.buf, NULL, oldurl, 1);
+	/* Set operations (--add, --delete) or change request (oldurl given).=
 */
+	if (delete_mode) {
+		if (modify_type & MODIFY_TYPE_FETCH)
+			git_config_set_multivar(name_buf_fetch.buf, NULL, oldurl, 1);
+		if (modify_type & MODIFY_TYPE_PUSH)
+			git_config_set_multivar(name_buf_push.buf, NULL, oldurl, 1);
+	} else {
+		if (add_mode) /* Do not replace oldurl, but add a new one. */
+			oldurl =3D "^$";
+		if (modify_type & MODIFY_TYPE_FETCH)
+			git_config_set_multivar(name_buf_fetch.buf, newurl, oldurl, 0);
+		if (modify_type & MODIFY_TYPE_PUSH)
+			git_config_set_multivar(name_buf_push.buf, newurl, oldurl, 0);
+	}
+cleanup_ok:
+	strbuf_release(&name_buf_fetch);
+	strbuf_release(&name_buf_push);
 	return 0;
 }
=20
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index ac79dd9..390281a 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -961,6 +961,59 @@ test_expect_success 'remote set-url --push zot' '
 	cmp expect actual
 '
=20
+test_expect_success 'remote set-url --fetch zox' '
+	git remote set-url --fetch someremote zox &&
+	echo zox >expect &&
+	echo "YYY" >>expect &&
+	echo zot >>expect &&
+	git config --get-all remote.someremote.url >actual &&
+	echo "YYY" >>actual &&
+	git config --get-all remote.someremote.pushurl >>actual &&
+	cmp expect actual
+'
+
+test_expect_success 'remote set-url --both foo' '
+	git remote set-url --both someremote foo &&
+	echo "YYY" >expect &&
+	echo foo >>expect &&
+	test_must_fail git config --get-all remote.someremote.pushurl >actual=
 &&
+	echo "YYY" >>actual &&
+	git config --get-all remote.someremote.url >>actual &&
+	cmp expect actual
+'
+
+test_expect_success 'remote set-url --delete --push foo' '
+	git remote set-url --delete --push someremote foo &&
+	echo "YYY" >expect &&
+	echo foo >>expect &&
+	test_must_fail git config --get-all remote.someremote.pushurl >actual=
 &&
+	echo "YYY" >actual &&
+	git config --get-all remote.someremote.url >>actual &&
+	cmp expect actual
+'
+
+test_expect_success 'remote set-url --push zot' '
+	git remote set-url --push someremote zot &&
+	echo zot >expect &&
+	echo "YYY" >>expect &&
+	echo foo >>expect &&
+	git config --get-all remote.someremote.pushurl >actual &&
+	echo "YYY" >>actual &&
+	git config --get-all remote.someremote.url >>actual &&
+	cmp expect actual
+'
+
+test_expect_success 'remote set-url --fetch baz foo' '
+	git remote set-url --fetch someremote baz foo &&
+	echo zot >expect &&
+	echo "YYY" >>expect &&
+	echo baz >>expect &&
+	git config --get-all remote.someremote.pushurl >actual &&
+	echo "YYY" >>actual &&
+	git config --get-all remote.someremote.url >>actual &&
+	cmp expect actual
+'
+
 test_expect_success 'remote set-url --push qux zot' '
 	git remote set-url --push someremote qux zot &&
 	echo qux >expect &&
@@ -1091,6 +1144,78 @@ test_expect_success 'remote set-url --delete baz=
' '
 	cmp expect actual
 '
=20
+test_expect_success 'remote set-url --fetch --add bar' '
+	git remote set-url --fetch --add someremote bar &&
+	echo ccc >expect &&
+	echo "YYY" >>expect &&
+	echo ccc >>expect &&
+	echo bar >>expect &&
+	git config --get-all remote.someremote.pushurl >actual &&
+	echo "YYY" >>actual &&
+	git config --get-all remote.someremote.url >>actual &&
+	cmp expect actual
+'
+
+test_expect_success 'remote set-url --both --add foo' '
+	git remote set-url --both --add someremote foo &&
+	echo ccc >expect &&
+	echo foo >>expect &&
+	echo "YYY" >>expect &&
+	echo ccc >>expect &&
+	echo bar >>expect &&
+	echo foo >>expect &&
+	git config --get-all remote.someremote.pushurl >actual &&
+	echo "YYY" >>actual &&
+	git config --get-all remote.someremote.url >>actual &&
+	cmp expect actual
+'
+
+test_expect_success 'remote set-url --both --delete ccc' '
+	git remote set-url --both --delete someremote ccc &&
+	echo foo >expect &&
+	echo "YYY" >>expect &&
+	echo bar >>expect &&
+	echo foo >>expect &&
+	git config --get-all remote.someremote.pushurl >actual &&
+	echo "YYY" >>actual &&
+	git config --get-all remote.someremote.url >>actual &&
+	cmp expect actual
+'
+
+test_expect_success 'remote set-url --fetch --delete bar' '
+	git remote set-url --fetch --delete someremote bar &&
+	echo foo >expect &&
+	echo "YYY" >>expect &&
+	echo foo >>expect &&
+	git config --get-all remote.someremote.pushurl >actual &&
+	echo "YYY" >>actual &&
+	git config --get-all remote.someremote.url >>actual &&
+	cmp expect actual
+'
+
+test_expect_success 'remote set-url --push --add baz' '
+	git remote set-url --push --add someremote baz &&
+	echo foo >expect &&
+	echo baz >>expect &&
+	echo "YYY" >>expect &&
+	echo foo >>expect &&
+	git config --get-all remote.someremote.pushurl >actual &&
+	echo "YYY" >>actual &&
+	git config --get-all remote.someremote.url >>actual &&
+	cmp expect actual
+'
+
+test_expect_success 'remote set-url --push --delete foo' '
+	git remote set-url --push --delete someremote foo &&
+	echo baz >expect &&
+	echo "YYY" >>expect &&
+	echo foo >>expect &&
+	git config --get-all remote.someremote.pushurl >actual &&
+	echo "YYY" >>actual &&
+	git config --get-all remote.someremote.url >>actual &&
+	cmp expect actual
+'
+
 test_expect_success 'extra args: setup' '
 	# add a dummy origin so that this does not trigger failure
 	git remote add origin .
--=20
2.1.3
