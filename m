From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 07/10] checkout: add -S to update sparse checkout
Date: Mon, 15 Nov 2010 17:36:47 +0700
Message-ID: <1289817410-32470-8-git-send-email-pclouds@gmail.com>
References: <1289817410-32470-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 15 11:40:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHwTt-0002OJ-7D
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 11:40:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104Ab0KOKkE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Nov 2010 05:40:04 -0500
Received: from mail-px0-f174.google.com ([209.85.212.174]:36066 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932093Ab0KOKkC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Nov 2010 05:40:02 -0500
Received: by pxi15 with SMTP id 15so923789pxi.19
        for <git@vger.kernel.org>; Mon, 15 Nov 2010 02:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=oaW6RIozBhEPcOXHpz1funmMmg3sVZ4azViDo/N7BNk=;
        b=JyzAmWF298FVMDAqAzUeXGfExtetj94wHh3td2AvvIVmcpS2TRpeIm2p+T09RTzu4K
         HTlL/6XLHFD0IMv6+nMgph8F3mCBzpy85Mhechc5NlMGO63lwfAIjRecj1i9Oon7cBZx
         9loYCuqRn/Sg+gyFG8banZIHOdtpd8gEyt+D4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=LfpqpZhNTciCLybK8JQzkVC6MBrzkY3AgL4CL3xUOMfWiKAOKodQWcHhEpJ2NvBfj5
         EfegAU3NRCyZmlgkwl2EcF3cXbcN4gwdjhVO7nd+GwMPLsOf+KxI+ZT34gnogtt1RuhL
         3xXD/ra3mkepR9CvcfB3NTNjRavoQONaC/BOc=
Received: by 10.142.169.17 with SMTP id r17mr61793wfe.112.1289817601383;
        Mon, 15 Nov 2010 02:40:01 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.247.75])
        by mx.google.com with ESMTPS id x18sm8580191wfa.23.2010.11.15.02.39.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Nov 2010 02:40:00 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 15 Nov 2010 17:38:43 +0700
X-Mailer: git-send-email 1.7.3.2.210.g045198
In-Reply-To: <1289817410-32470-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161484>

The traditional way of updating sparse checkout is to open
$GIT_DIR/info/sparse-checkout manually, edit it, save, then run "git
checkout" or "git read-tree -m -u HEAD". That's not convenient.

"git checkout -S" is introduced to combine those steps in one. It also
provides some additional checks:

 - warn users if core.sparseCheckout is off
 - refuse to update sparse checkout if there is no valid sparse
   patterns (faulty sparse-checkout file for example)

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-checkout.txt       |   16 +++++++++++++
 builtin/checkout.c                   |   42 ++++++++++++++++++++++++++=
+++++++-
 t/t1011-read-tree-sparse-checkout.sh |   18 ++++++++++++++
 templates/info--sparse-checkout      |    1 +
 4 files changed, 76 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkou=
t.txt
index 22d3611..478bfe7 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -12,6 +12,7 @@ SYNOPSIS
 'git checkout' [-q] [-f] [-m] [[-b|-B|--orphan] <new_branch>] [<start_=
point>]
 'git checkout' [-f|--ours|--theirs|-m|--conflict=3D<style>] [<tree-ish=
>] [--] <paths>...
 'git checkout' --patch [<tree-ish>] [--] [<paths>...]
+'git checkout' -S
=20
 DESCRIPTION
 -----------
@@ -176,6 +177,13 @@ the conflicted merge in the specified paths.
 This means that you can use `git checkout -p` to selectively discard
 edits from your current working tree.
=20
+-S::
+--update-sparse-checkout::
+	An editor is invoked to let you update your sparse checkout
+	patterns. The updated patterns will be saved in
+	$GIT_DIR/info/sparse-checkout. The working directory is also
+	updated. An empty file will abort the process.
+
 <branch>::
 	Branch to checkout; if it refers to a branch (i.e., a name that,
 	when prepended with "refs/heads/", is a valid ref), then that
@@ -316,6 +324,14 @@ $ git add frotz
 ------------
=20
=20
+ENVIRONMENT AND CONFIGURATION VARIABLES
+---------------------------------------
+The editor used to edit the commit log message will be chosen from the
+GIT_EDITOR environment variable, the core.editor configuration variabl=
e, the
+VISUAL environment variable, or the EDITOR environment variable (in th=
at
+order).  See linkgit:git-var[1] for details.
+
+
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 9240faf..47847b3 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -675,6 +675,31 @@ static const char *unique_tracking_name(const char=
 *name)
 	return NULL;
 }
=20
+static void edit_info_sparse_checkout()
+{
+	char *tmpfile =3D xstrdup(git_path("sparse-checkout"));
+	struct exclude_list el;
+	int i;
+
+	copy_file(tmpfile, git_path("info/sparse-checkout"), 0666);
+
+	if (launch_editor(tmpfile, NULL, NULL))
+		exit(1);
+
+	memset(&el, 0, sizeof(el));
+	if (add_excludes_from_file_to_list(tmpfile, "", 0, NULL, &el, 0) < 0 =
||
+	    el.nr =3D=3D 0)
+		die("No valid sparse patterns. Abort.");
+	for (i =3D 0; i < el.nr; i++)
+		free(el.excludes[i]);
+	free(el.excludes);
+
+	if (rename(tmpfile, git_path("info/sparse-checkout")) < 0)
+		die_errno("Can't update %s", git_path("info/sparse-checkout"));
+
+	free(tmpfile);
+}
+
 int cmd_checkout(int argc, const char **argv, const char *prefix)
 {
 	struct checkout_opts opts;
@@ -685,6 +710,7 @@ int cmd_checkout(int argc, const char **argv, const=
 char *prefix)
 	char *conflict_style =3D NULL;
 	int patch_mode =3D 0;
 	int dwim_new_local_branch =3D 1;
+	int update_sparse_checkout =3D 0;
 	struct option options[] =3D {
 		OPT__QUIET(&opts.quiet),
 		OPT_STRING('b', NULL, &opts.new_branch, "branch",
@@ -704,6 +730,8 @@ int cmd_checkout(int argc, const char **argv, const=
 char *prefix)
 		OPT_STRING(0, "conflict", &conflict_style, "style",
 			   "conflict style (merge or diff3)"),
 		OPT_BOOLEAN('p', "patch", &patch_mode, "select hunks interactively")=
,
+		OPT_BOOLEAN('S', "update-sparse-checkout", &update_sparse_checkout,
+			    "open up editor to edit $GIT_DIR/info/sparse-checkout" ),
 		{ OPTION_BOOLEAN, 0, "guess", &dwim_new_local_branch, NULL,
 		  "second guess 'git checkout no-such-branch'",
 		  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN },
@@ -722,6 +750,9 @@ int cmd_checkout(int argc, const char **argv, const=
 char *prefix)
 	argc =3D parse_options(argc, argv, prefix, options, checkout_usage,
 			     PARSE_OPT_KEEP_DASHDASH);
=20
+	if (update_sparse_checkout && !core_apply_sparse_checkout)
+		die("core.sparseCheckout needs to be turned on");
+
 	/* we can assume from now on new_branch =3D !new_branch_force */
 	if (opts.new_branch && opts.new_branch_force)
 		die("-B cannot be used with -b");
@@ -874,6 +905,9 @@ no_reference:
 		if (!pathspec)
 			die("invalid path specification");
=20
+		if (update_sparse_checkout)
+			die("git checkout: update paths is incompatible with updating spars=
e checkout.");
+
 		if (patch_mode)
 			return interactive_checkout(new.name, pathspec, &opts);
=20
@@ -892,8 +926,11 @@ no_reference:
 		return checkout_paths(source_tree, pathspec, &opts);
 	}
=20
-	if (patch_mode)
+	if (patch_mode) {
+		if (update_sparse_checkout)
+			die("git checkout: interactive checkout is incompatible with updati=
ng sparse checkout.");
 		return interactive_checkout(new.name, NULL, &opts);
+	}
=20
 	if (opts.new_branch) {
 		struct strbuf buf =3D STRBUF_INIT;
@@ -915,5 +952,8 @@ no_reference:
 	if (opts.writeout_stage)
 		die("--ours/--theirs is incompatible with switching branches.");
=20
+	if (update_sparse_checkout)
+		edit_info_sparse_checkout();
+
 	return switch_branches(&opts, &new);
 }
diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-s=
parse-checkout.sh
index 50f7dfe..fe4716c 100755
--- a/t/t1011-read-tree-sparse-checkout.sh
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -184,4 +184,22 @@ test_expect_success 'read-tree --reset removes out=
side worktree' '
 	test_cmp empty result
 '
=20
+test_expect_success 'git checkout -S fails to launch editor' '
+	GIT_EDITOR=3D/non-existent test_must_fail git checkout -S &&
+	grep init.t .git/info/sparse-checkout
+'
+
+test_expect_success 'git checkout -S' '
+	git checkout -f top &&
+	cat >editor.sh <<\EOF &&
+#!/bin/sh
+echo sub > "$1"
+EOF
+	chmod 755 editor.sh &&
+	GIT_EDITOR=3D"./editor.sh" git checkout -S &&
+	grep sub .git/info/sparse-checkout &&
+	test -f sub/added &&
+	test ! -f init.t
+'
+
 test_done
diff --git a/templates/info--sparse-checkout b/templates/info--sparse-c=
heckout
index 7426475..588008b 100644
--- a/templates/info--sparse-checkout
+++ b/templates/info--sparse-checkout
@@ -1,3 +1,4 @@
 # Specify what files are checked out in working directory
 # Run "git checkout" after updating this file to update working direct=
ory
+# If this is opened by "git checkout -S", empty this file will abort i=
t.
 *
--=20
1.7.3.2.210.g045198
