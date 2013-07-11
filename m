From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/6] remote.c: add command line option parser for "--lockref"
Date: Thu, 11 Jul 2013 15:26:17 -0700
Message-ID: <1373581580-13651-4-git-send-email-gitster@pobox.com>
References: <1373581580-13651-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 12 00:26:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxPJv-0002Hy-28
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 00:26:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756081Ab3GKW0d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 18:26:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37262 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752039Ab3GKW03 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 18:26:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E635D303EC
	for <git@vger.kernel.org>; Thu, 11 Jul 2013 22:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=o8xt
	EAFrBNWQ9W9UlXeikeV4Mjk=; b=xk64/0FmBiIV4KoK1dOPF4ck5HxClSJiUhiz
	aCcabyblZxmve7mI5XrvVN72yN+oVuxqXh3RngE55VQhBUroBwyGA4GVylXmSSpW
	eEFjV0pgN39rkmfcOLSxjgPFY5xrQS5T77hIfBDdpR9940y6031m+vWhLQBbtk2z
	4N5m3eY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=xwYqbZ
	xzjVrrb6TVZPbNopyP5I6uNCNqGZmPzXLOzvQ2QajuGO48lTc0IQx4L9p94mV8y2
	8oXcTkgM44ZvM4sln2Wb7B4XlL2zO90dT3+wZC5xXK2CfqwmnuZnYa2e3+MLn3uQ
	UOfkD/vZCXiBFMK/oo2n2UbHTzl4Ragog5GKI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD69F303EB
	for <git@vger.kernel.org>; Thu, 11 Jul 2013 22:26:28 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B7DF7303E4
	for <git@vger.kernel.org>; Thu, 11 Jul 2013 22:26:27 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.2-911-g2c4daa5
In-Reply-To: <1373581580-13651-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: ED972A5E-EA78-11E2-96C3-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230138>

Update "git push" and "git send-pack" to parse this commnd line
option.

The intended sematics is:

 * "--lockref" alone, without specifying the details, will protect
   _all_ remote refs that are going to be updated by requiring their
   current value to be the same as the remote-tracking branch we
   have for them, unless otherwise specified;

 * "--lockref=refname", without specifying the expected value, will
   protect that refname, if it is going to be updated, by requiring
   its current value to be the same as the remote-tracking branch we
   have for it;

 * "--lockref=refname:value" will protect that refname, if it is
   going to be updated, by requiring its current value to be the
   same as the specified value (which is allowed to be different
   from the remote-tracking branch we have for the refname, or we do
   not even have to have such a remote-tracking branch when this
   form is used); and

 * "--no-lockref" will cancel all the previous --lockref on the
   command line.

In any of the forms, when we try to use a remote-tracking branch for
the remote ref being updated, it is an error if there is no such
remote-tracking branch on our end.

Because the command line options are parsed _before_ we know which
remote we are pushing to, there needs further processing to the
parsed data after we instantiate the transport object to:

 * expand "refname" given by the user to a full refname to be
   matched with the list of "struct ref" used in match_push_refs()
   and set_ref_status_for_push(); and

 * learning the actual local ref that is the remote-tracking branch
   for the specified remote ref.

Further, some processing need to be deferred until we find the set
of remote refs and match_push_refs() returns in order to find the
ones that need to be checked after explicit ones have been processed
for "--lockref" (no specific details).

These post-processing will be the topic of the next patch.

Oh, of course, the option name is still not cast in stone.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 This round makes --lockref simply a weaker form of --force.

 The old version used to allow "--lockref=<refname>:" to say "I want
 this push to create <refname>, any existing old value should make
 it fail", but the normal fast-forward check already implements it,
 so there is no need for such an option.  This round removes it.

 The old version allowed you to express "I want the old value of
 'master' to be at X and also I want the update to fast-forward" by
 giving only "--lockref=master:X" without "--force".  Because you
 already know if the commit you are updating their 'master' with
 fast-forwards from X or not, such a combination is unnecessary to
 support.  This simplifies the UI greatly, as "--force" can again be
 the big red button that overrides all the safety.

 I think the option now should be renamed to "--force-with-???"; you
 are essentially taking a lease on the ref before you start your
 rebase, and making sure the ref hasn't been updated by other
 people, you are safely forcing your push of a rebased history.

 Perhaps "--force-with-lease"?  "--force-leased-ref"?
---
 Documentation/git-push.txt | 68 ++++++++++++++++++++++++++++++++++++++--------
 builtin/push.c             |  6 ++++
 builtin/send-pack.c        | 17 ++++++++++++
 remote.c                   | 57 ++++++++++++++++++++++++++++++++++++++
 remote.h                   | 22 +++++++++++++++
 5 files changed, 159 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index f7dfe48..b0a793e 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -11,6 +11,7 @@ SYNOPSIS
 [verse]
 'git push' [--all | --mirror | --tags] [--follow-tags] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
 	   [--repo=<repository>] [-f | --force] [--prune] [-v | --verbose] [-u | --set-upstream]
+	   [--lockref[=<refname>[:<expect>]]]
 	   [--no-verify] [<repository> [<refspec>...]]
 
 DESCRIPTION
@@ -130,21 +131,66 @@ already exists on the remote side.
 	repository over ssh, and you do not have the program in
 	a directory on the default $PATH.
 
+--[no-]lockref::
+--lockref=<refname>::
+--lockref=<refname>:<expect>::
+	Usually, the command refuses to update a remote ref that is
+	not an ancestor of the local ref used to overwrite it.
++
+This option bypasses the check, but instead requires that the
+current value of the ref to be the expected value.
++
+Imagine that you have to rebase what you have already published.
+You will have to bypass the "must fast-forward" rule to replace the
+history you originally published with the rebased history.  If
+somebody else built on top of your original history while you are
+rebasing, the tip of the branch at the remote may advance with her
+commit, and blindly pushing with `--force` will lose her work.  By
+using this option to specify that you expect the history you are
+updating is what you rebased and want to replace, you can make sure
+other people's work will not be losed by a forced push. in such a
+case.
++
+`--lockref` alone, without specifying the details, will protect
+all remote refs that are going to be updated by requiring their
+current value to be the same as the remote-tracking branch we have
+for them, unless specified with a `--lockref=<refname>:<expect>`
+option that explicitly states what the expected value is.
++
+`--lockref=<refname>`, without specifying the expected value, will
+protect the named ref (alone), if it is going to be updated, by
+requiring its current value to be the same as the remote-tracking
+branch we have for it.
++
+`--lockref=<refname>:<expect>" will protect the named ref (alone),
+if it is going to be updated, by requiring its current value to be
+the same as the specified value <expect> (which is allowed to be
+different from the remote-tracking branch we have for the refname,
+or we do not even have to have such a remote-tracking branch when
+this form is used).
++
+"--no-lockref" will cancel all the previous --lockref on the
+command line.
+
 -f::
 --force::
 	Usually, the command refuses to update a remote ref that is
 	not an ancestor of the local ref used to overwrite it.
-	This flag disables the check.  This can cause the
-	remote repository to lose commits; use it with care.
-	Note that `--force` applies to all the refs that are pushed,
-	hence using it with `push.default` set to `matching` or with
-	multiple push destinations configured with `remote.*.push`
-	may overwrite refs other than the current branch (including
-	local refs that are strictly behind their remote counterpart).
-	To force a push to only one branch, use a `+` in front of the
-	refspec to push	(e.g `git push origin +master` to force a push
-	to the `master`	branch). See the `<refspec>...` section above
-	for details.
+	Also, when `--lockref` option is used, the command refuses
+	to update a remote ref whose current value does not match
+	what is expected.
++
+This flag disables these checks, and can cause the remote repository
+to lose commits; use it with care.
++
+Note that `--force` applies to all the refs that are pushed, hence
+using it with `push.default` set to `matching` or with multiple push
+destinations configured with `remote.*.push` may overwrite refs
+other than the current branch (including local refs that are
+strictly behind their remote counterpart).  To force a push to only
+one branch, use a `+` in front of the refspec to push (e.g `git push
+origin +master` to force a push to the `master` branch). See the
+`<refspec>...` section above for details.
 
 --repo=<repository>::
 	This option is only relevant if no <repository> argument is
diff --git a/builtin/push.c b/builtin/push.c
index 342d792..31a5ba0 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -21,6 +21,8 @@ static const char *receivepack;
 static int verbosity;
 static int progress = -1;
 
+static struct push_cas_option cas;
+
 static const char **refspec;
 static int refspec_nr;
 static int refspec_alloc;
@@ -432,6 +434,10 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_BIT('n' , "dry-run", &flags, N_("dry run"), TRANSPORT_PUSH_DRY_RUN),
 		OPT_BIT( 0,  "porcelain", &flags, N_("machine-readable output"), TRANSPORT_PUSH_PORCELAIN),
 		OPT_BIT('f', "force", &flags, N_("force updates"), TRANSPORT_PUSH_FORCE),
+		{ OPTION_CALLBACK,
+		  0, CAS_OPT_NAME, &cas, N_("refname>:<expect"),
+		  N_("require old value of ref to be at this value"),
+		  PARSE_OPT_OPTARG, parseopt_push_cas_option },
 		{ OPTION_CALLBACK, 0, "recurse-submodules", &flags, N_("check"),
 			N_("control recursive pushing of submodules"),
 			PARSE_OPT_OPTARG, option_parse_recurse_submodules },
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index e86d3b5..a23b26d 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -103,6 +103,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	int flags;
 	unsigned int reject_reasons;
 	int progress = -1;
+	struct push_cas_option cas = {0};
 
 	argv++;
 	for (i = 1; i < argc; i++, argv++) {
@@ -165,6 +166,22 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 				helper_status = 1;
 				continue;
 			}
+			if (!strcmp(arg, "--" CAS_OPT_NAME)) {
+				if (parse_push_cas_option(&cas, NULL, 0) < 0)
+					exit(1);
+				continue;
+			}
+			if (!strcmp(arg, "--no-" CAS_OPT_NAME)) {
+				if (parse_push_cas_option(&cas, NULL, 1) < 0)
+					exit(1);
+				continue;
+			}
+			if (!prefixcmp(arg, "--" CAS_OPT_NAME "=")) {
+				if (parse_push_cas_option(&cas,
+							  strchr(arg, '=') + 1, 1) < 0)
+					exit(1);
+				continue;
+			}
 			usage(send_pack_usage);
 		}
 		if (!dest) {
diff --git a/remote.c b/remote.c
index b1ff7a2..6014acd 100644
--- a/remote.c
+++ b/remote.c
@@ -1921,3 +1921,60 @@ struct ref *get_stale_heads(struct refspec *refs, int ref_count, struct ref *fet
 	string_list_clear(&ref_names, 0);
 	return stale_refs;
 }
+
+/*
+ * Lockref aka CAS
+ */
+void clear_cas_option(struct push_cas_option *cas)
+{
+	int i;
+
+	for (i = 0; i < cas->nr; i++)
+		free(cas->entry->refname);
+	free(cas->entry);
+	memset(cas, 0, sizeof(*cas));
+}
+
+static struct push_cas *add_cas_entry(struct push_cas_option *cas,
+				      const char *refname,
+				      size_t refnamelen)
+{
+	struct push_cas *entry;
+	ALLOC_GROW(cas->entry, cas->nr + 1, cas->alloc);
+	entry = &cas->entry[cas->nr++];
+	memset(entry, 0, sizeof(*entry));
+	entry->refname = xmemdupz(refname, refnamelen);
+	return entry;
+}
+
+int parse_push_cas_option(struct push_cas_option *cas, const char *arg, int unset)
+{
+	const char *colon;
+	struct push_cas *entry;
+
+	if (unset) {
+		/* "--no-lockref" */
+		clear_cas_option(cas);
+		return 0;
+	}
+
+	if (!arg) {
+		/* just "--lockref" */
+		cas->use_tracking_for_rest = 1;
+		return 0;
+	}
+
+	/* "--lockref=refname" or "--lockref=refname:value" */
+	colon = strchrnul(arg, ':');
+	entry = add_cas_entry(cas, arg, colon - arg);
+	if (!*colon)
+		entry->use_tracking = 1;
+	else if (get_sha1(colon + 1, entry->expect))
+		return error("cannot parse expected object name '%s'", colon + 1);
+	return 0;
+}
+
+int parseopt_push_cas_option(const struct option *opt, const char *arg, int unset)
+{
+	return parse_push_cas_option(opt->value, arg, unset);
+}
diff --git a/remote.h b/remote.h
index a850059..8070303 100644
--- a/remote.h
+++ b/remote.h
@@ -1,6 +1,8 @@
 #ifndef REMOTE_H
 #define REMOTE_H
 
+#include "parse-options.h"
+
 enum {
 	REMOTE_CONFIG,
 	REMOTE_REMOTES,
@@ -226,4 +228,24 @@ struct ref *guess_remote_head(const struct ref *head,
 /* Return refs which no longer exist on remote */
 struct ref *get_stale_heads(struct refspec *refs, int ref_count, struct ref *fetch_map);
 
+/*
+ * Lockref aka CAS
+ */
+#define CAS_OPT_NAME "lockref"
+
+struct push_cas_option {
+	unsigned use_tracking_for_rest:1;
+	struct push_cas {
+		unsigned char expect[20];
+		unsigned use_tracking:1;
+		char *refname;
+	} *entry;
+	int nr;
+	int alloc;
+};
+
+extern int parseopt_push_cas_option(const struct option *, const char *arg, int unset);
+extern int parse_push_cas_option(struct push_cas_option *, const char *arg, int unset);
+extern void clear_cas_option(struct push_cas_option *);
+
 #endif
-- 
1.8.3.2-912-g65cf5cf
