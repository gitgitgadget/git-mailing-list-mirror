From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v2 6/6] bisect--helper: `bisect_write` shell function in C
Date: Wed, 15 Jun 2016 19:30:26 +0530
Message-ID: <20160615140026.10519-7-pranit.bauva@gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com>
 <20160615140026.10519-1-pranit.bauva@gmail.com>
Cc: Pranit Bauva <pranit.bauva@gmail.com>, christian.couder@gmail.com,
	chriscool@tuxfamily.org, larsxschneider@gmail.com,
	sunshine@sunshineco.com, tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 15 16:02:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bDBP9-0007Z8-BQ
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 16:02:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161097AbcFOOCS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2016 10:02:18 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34368 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161083AbcFOOCP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2016 10:02:15 -0400
Received: by mail-pa0-f65.google.com with SMTP id us13so1637566pab.1
        for <git@vger.kernel.org>; Wed, 15 Jun 2016 07:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k4d94QgGR3UI3jowlIcPk7y3iF3D8lx3yW4rzj5tM7s=;
        b=ffqzOvIpK8kpfyRIGUzvkoaFz1IFKjaB856N+1eGVAw1a2eBQ6VYxcwpV9x1yNK7mh
         ALYHDrLj10SJJoNwUdG34YeBr/p05r1AxqCn5HPByUMkECDOJx51UOL7uaIDPC9g9/dc
         hyFoddwQ4uyLh0T7Jv4Io68wMkLFMUPXciltQRugZ4VDOBf8VEnikNKzTXK9BlqPfjYE
         hls9iFe/yaF7Iryp8Y1TV3pLliaoEdU0WPTNQWxY52dNz4mq07RlRlaJ1Y13AWZXFqK7
         wIC/0WU3tK77C74EI6xnt1Mg7lZG75nJUFC1295KxJId1nOBph+xJU6HQ2KlnbAi32+Y
         2anQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k4d94QgGR3UI3jowlIcPk7y3iF3D8lx3yW4rzj5tM7s=;
        b=bdvJiqjwFfnIA+JPilfvKyHo0rO2UdLSeQsN6VTlTxl/mAOHUAHisiCCFCgCJBeYIz
         JsP7lt5FduMaXjPQKcITp3Tds70dw+GwA/3e3CJQCiP5yKsraxBdtpIArBIHVhNQ+Nue
         2R8SM4epUsbxR18jsbUT5/k3C5y9BReept1zvuL9Fbr87JO9ZS/5xyfk2C7BNQfxJ1hp
         cC/Sx7iW1axHiw0rUpj3CQCOGBz5OV6NwQYU4zTR9wC8NVR4L1MRLHsd0Hf6el3IS9YR
         /j6/O/b8w6v76zg6HJSQPmMUHgwdwRzxXr+tRfkA0iV7UctbFtLdTIWtmbTGbCxP9Px0
         t8hg==
X-Gm-Message-State: ALyK8tLWjF1RE9tMh/xzNpNx/trR7KLFdxlNm1kXjbSUj2zyq1SB4zIb7O1/0zsod8aMbw==
X-Received: by 10.66.27.80 with SMTP id r16mr4055568pag.102.1465999334132;
        Wed, 15 Jun 2016 07:02:14 -0700 (PDT)
Received: from localhost.localdomain ([27.106.54.188])
        by smtp.gmail.com with ESMTPSA id i5sm37514156pfk.14.2016.06.15.07.02.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 15 Jun 2016 07:02:13 -0700 (PDT)
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160615140026.10519-1-pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297378>

Reimplement the `bisect_write` shell function in C and add a
`bisect-write` subcommand to `git bisect--helper` to call it from
git-bisect.sh

Using `--bisect-write` subcommand is a temporary measure to port shell
function in C so as to use the existing test suite. As more functions
are ported, this subcommand will be retired and will be called by some
other methods.

Note: bisect_write() uses two variables namely TERM_GOOD and TERM_BAD
from the global shell script thus we need to pass it to the subcommand
using the arguments. After the whole conversion, we can remove the extra
arguments and make the method use the two variables from the global scope
within the C code.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/bisect--helper.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh            | 25 ++++----------------
 2 files changed, 64 insertions(+), 22 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index f11c247..eebfcf0 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -22,6 +22,7 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --write-terms <bad_term> <good_term>"),
 	N_("git bisect--helper --bisect-clean-state"),
 	N_("git bisect--helper --bisect-reset [<commit>]"),
+	N_("git bisect--helper --bisect-write <state> <revision> <TERM_GOOD> <TERM_BAD> [<nolog>]"),
 	NULL
 };
 
@@ -192,6 +193,55 @@ static int check_expected_revs(const char **revs, int rev_nr)
 	return 0;
 }
 
+static int bisect_write(const char *state, const char *rev,
+			const char *term_good, const char *term_bad,
+			int nolog)
+{
+	struct strbuf tag = STRBUF_INIT;
+	struct strbuf commit_name = STRBUF_INIT;
+	struct object_id oid;
+	struct commit *commit;
+	struct pretty_print_context pp = {0};
+	FILE *fp;
+
+	if (!strcmp(state, term_bad))
+		strbuf_addf(&tag, "refs/bisect/%s", state);
+	else if(one_of(state, term_good, "skip", NULL))
+		strbuf_addf(&tag, "refs/bisect/%s-%s", state, rev);
+	else
+		return error(_("Bad bisect_write argument: %s"), state);
+
+	if (get_oid(rev, &oid)) {
+		strbuf_release(&tag);
+		return error(_("couldn't get the oid of the rev '%s'"), rev);
+	}
+
+	if (update_ref(NULL, tag.buf, oid.hash, NULL, 0,
+		       UPDATE_REFS_MSG_ON_ERR)) {
+		strbuf_release(&tag);
+		return -1;
+	}
+
+	fp = fopen(git_path_bisect_log(), "a");
+	if (!fp) {
+		strbuf_release(&tag);
+		return error_errno(_("couldn't open the file '%s'"), git_path_bisect_log());
+	}
+
+	commit = lookup_commit_reference(oid.hash);
+	format_commit_message(commit, "%s", &commit_name, &pp);
+	fprintf(fp, "# %s: [%s] %s\n", state, sha1_to_hex(oid.hash),
+		commit_name.buf);
+
+	if (!nolog)
+		fprintf(fp, "git bisect %s %s\n", state, rev);
+
+	strbuf_release(&commit_name);
+	strbuf_release(&tag);
+	fclose(fp);
+	return 0;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
@@ -199,7 +249,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		WRITE_TERMS,
 		BISECT_CLEAN_STATE,
 		BISECT_RESET,
-		CHECK_EXPECTED_REVS
+		CHECK_EXPECTED_REVS,
+		BISECT_WRITE
 	} cmdmode = 0;
 	int no_checkout = 0;
 	struct option options[] = {
@@ -213,6 +264,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("reset the bisection state"), BISECT_RESET),
 		OPT_CMDMODE(0, "check-expected-revs", &cmdmode,
 			 N_("check for expected revs"), CHECK_EXPECTED_REVS),
+		OPT_CMDMODE(0, "bisect-write", &cmdmode,
+			 N_("write out the bisection state in BISECT_LOG"), BISECT_WRITE),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
@@ -225,6 +278,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_bisect_helper_usage, options);
 
 	switch (cmdmode) {
+	int nolog;
 	case NEXT_ALL:
 		return bisect_next_all(prefix, no_checkout);
 	case WRITE_TERMS:
@@ -241,6 +295,11 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		return bisect_reset(argc ? argv[0] : NULL);
 	case CHECK_EXPECTED_REVS:
 		return check_expected_revs(argv, argc);
+	case BISECT_WRITE:
+		if (argc != 4 && argc != 5)
+			die(_("--bisect-write requires either 4 or 5 arguments"));
+		nolog = (argc == 5) && !strcmp(argv[4], "nolog");
+		return bisect_write(argv[0], argv[1], argv[2], argv[3], nolog);
 	default:
 		die("BUG: unknown subcommand '%d'", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index 4f6545e..b9896a4 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -145,7 +145,7 @@ bisect_start() {
 		0) state=$TERM_BAD ; bad_seen=1 ;;
 		*) state=$TERM_GOOD ;;
 		esac
-		eval="$eval bisect_write '$state' '$rev' 'nolog' &&"
+		eval="$eval git bisect--helper --bisect-write '$state' '$rev' '$TERM_GOOD' '$TERM_BAD' 'nolog' &&"
 	done
 	#
 	# Verify HEAD.
@@ -221,23 +221,6 @@ bisect_start() {
 	trap '-' 0
 }
 
-bisect_write() {
-	state="$1"
-	rev="$2"
-	nolog="$3"
-	case "$state" in
-		"$TERM_BAD")
-			tag="$state" ;;
-		"$TERM_GOOD"|skip)
-			tag="$state"-"$rev" ;;
-		*)
-			die "$(eval_gettext "Bad bisect_write argument: \$state")" ;;
-	esac
-	git update-ref "refs/bisect/$tag" "$rev" || exit
-	echo "# $state: $(git show-branch $rev)" >>"$GIT_DIR/BISECT_LOG"
-	test -n "$nolog" || echo "git bisect $state $rev" >>"$GIT_DIR/BISECT_LOG"
-}
-
 bisect_skip() {
 	all=''
 	for arg in "$@"
@@ -263,7 +246,7 @@ bisect_state() {
 	1,"$TERM_BAD"|1,"$TERM_GOOD"|1,skip)
 		rev=$(git rev-parse --verify $(bisect_head)) ||
 			die "$(gettext "Bad rev input: $(bisect_head)")"
-		bisect_write "$state" "$rev"
+		git bisect--helper --bisect-write "$state" "$rev" "$TERM_GOOD" "$TERM_BAD" || exit
 		git bisect--helper --check-expected-revs "$rev" ;;
 	2,"$TERM_BAD"|*,"$TERM_GOOD"|*,skip)
 		shift
@@ -276,7 +259,7 @@ bisect_state() {
 		done
 		for rev in $hash_list
 		do
-			bisect_write "$state" "$rev"
+			git bisect--helper --bisect-write "$state" "$rev" "$TERM_GOOD" "$TERM_BAD" || exit
 		done
 		git bisect--helper --check-expected-revs $hash_list ;;
 	*,"$TERM_BAD")
@@ -413,7 +396,7 @@ bisect_replay () {
 			cmd="bisect_start $rev"
 			eval "$cmd" ;;
 		"$TERM_GOOD"|"$TERM_BAD"|skip)
-			bisect_write "$command" "$rev" ;;
+			git bisect--helper --bisect-write "$command" "$rev" "$TERM_GOOD" "$TERM_BAD" || exit;;
 		terms)
 			bisect_terms $rev ;;
 		*)
-- 
2.9.0
