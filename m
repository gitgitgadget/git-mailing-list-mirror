From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 9/9] fetch: allow explicit --refmap to override configuration
Date: Tue,  3 Jun 2014 15:16:32 -0700
Message-ID: <1401833792-2486-10-git-send-email-gitster@pobox.com>
References: <1401833792-2486-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 00:17:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wrx1W-0005Zr-Lj
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 00:17:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965693AbaFCWRZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 18:17:25 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53135 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754217AbaFCWRX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 18:17:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B84EB1DDAC;
	Tue,  3 Jun 2014 18:17:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=18X6
	tkAJfvga9PItwCUhAO244DA=; b=iE7/7P9SirV+WA8NcICvUnr0hM+qP2MX5D1r
	jKPSE3RNQPlRqacmZdP2YPNkcTHOiG9ff+QTDhEDNAj/Xj45+gxU531T1Rp99CG5
	8YS4rcqzHUpWK5ka0yBI9D4XDyNUCDIVTTCw5lggQNXoZiqJ9Xs0PctL53kCVQnA
	OBV4k0g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=RXCz5Y
	GWBVu1Z49gUDBg23xCU4zW8Vq3SUtDQmSyZzAiPGJ8ExF7fPK9ynMvsEK0zwPAK/
	2YWXK+WI8q3xoXvK0sq+lw0kX/8yst1s83ZjGBrfIskQnRlefZEAb547aSpzTfx8
	VweZACI0q6OlUi3G7vti1qwCv/ipBdm5bMs8k=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AEF471DDAA;
	Tue,  3 Jun 2014 18:17:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CE7AB1DDA3;
	Tue,  3 Jun 2014 18:17:18 -0400 (EDT)
X-Mailer: git-send-email 2.0.0-518-g8437b4f
In-Reply-To: <1401833792-2486-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D37ED388-EB6C-11E3-94B9-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250703>

Since the introduction of opportunisitic updates of remote-tracking
branches, started at around f2690487 (fetch: opportunistically
update tracking refs, 2013-05-11) with a few updates in v1.8.4 era,
the remote.*.fetch configuration always kicks in even when a refspec
to specify what to fetch is given on the command line, and there is
no way to disable or override it per-invocation.

Teach the command to pay attention to the --refmap=<lhs>:<rhs>
command-line options that can be used to override the use of
configured remote.*.fetch as the refmap.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
---
 Documentation/fetch-options.txt |  8 ++++++++
 Documentation/git-fetch.txt     |  3 +++
 builtin/fetch.c                 | 35 ++++++++++++++++++++++++++++++++---
 t/t5510-fetch.sh                | 37 +++++++++++++++++++++++++++++++++++++
 4 files changed, 80 insertions(+), 3 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 92c68c3..d5c6289 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -72,6 +72,14 @@ endif::git-pull[]
 	setting. See linkgit:git-config[1].
 
 ifndef::git-pull[]
+--refmap=<refspec>::
+	When fetching refs listed on the command line, use the
+	specified refspec (can be given more than once) to map the
+	refs to remote-tracking branches, instead of values of
+	`remote.*.fetch` configuration variable for the remote
+	repository.  See section on "Configured Remote-tracking
+	Branches" for details.
+
 -t::
 --tags::
 	Fetch all tags from the remote (i.e., fetch remote tags
diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index d09736a..96c44f9 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -93,6 +93,9 @@ This configuration is used in two ways:
   only used to decide _where_ the refs that are fetched are stored
   by acting as a mapping.
 
+The latter use of the configured values can be overridden by giving
+the `--refmap=<refspec>` parameter(s) on the command line.
+
 
 EXAMPLES
 --------
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 55f457c..dd46b61 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -45,6 +45,8 @@ static struct transport *gsecondary;
 static const char *submodule_prefix = "";
 static const char *recurse_submodules_default;
 static int shown_url = 0;
+static int refmap_alloc, refmap_nr;
+static const char **refmap_array;
 
 static int option_parse_recurse_submodules(const struct option *opt,
 				   const char *arg, int unset)
@@ -69,6 +71,19 @@ static int git_fetch_config(const char *k, const char *v, void *cb)
 	return 0;
 }
 
+static int parse_refmap_arg(const struct option *opt, const char *arg, int unset)
+{
+	ALLOC_GROW(refmap_array, refmap_nr + 1, refmap_alloc);
+
+	/*
+	 * "git fetch --refmap='' origin foo"
+	 * can be used to tell the command not to store anywhere
+	 */
+	if (*arg)
+		refmap_array[refmap_nr++] = arg;
+	return 0;
+}
+
 static struct option builtin_fetch_options[] = {
 	OPT__VERBOSITY(&verbosity),
 	OPT_BOOL(0, "all", &all,
@@ -107,6 +122,8 @@ static struct option builtin_fetch_options[] = {
 		   N_("default mode for recursion"), PARSE_OPT_HIDDEN },
 	OPT_BOOL(0, "update-shallow", &update_shallow,
 		 N_("accept refs that update .git/shallow")),
+	{ OPTION_CALLBACK, 0, "refmap", NULL, N_("refmap"),
+	  N_("specify fetch refmap"), PARSE_OPT_NONEG, parse_refmap_arg },
 	OPT_END()
 };
 
@@ -278,6 +295,9 @@ static struct ref *get_ref_map(struct transport *transport,
 	const struct ref *remote_refs = transport_get_remote_refs(transport);
 
 	if (refspec_count) {
+		struct refspec *fetch_refspec;
+		int fetch_refspec_nr;
+
 		for (i = 0; i < refspec_count; i++) {
 			get_fetch_map(remote_refs, &refspecs[i], &tail, 0);
 			if (refspecs[i].dst && refspecs[i].dst[0])
@@ -307,12 +327,21 @@ static struct ref *get_ref_map(struct transport *transport,
 		 * by ref_remove_duplicates() in favor of one of these
 		 * opportunistic entries with FETCH_HEAD_IGNORE.
 		 */
-		for (i = 0; i < transport->remote->fetch_refspec_nr; i++)
-			get_fetch_map(ref_map, &transport->remote->fetch[i],
-				      &oref_tail, 1);
+		if (refmap_array) {
+			fetch_refspec = parse_fetch_refspec(refmap_nr, refmap_array);
+			fetch_refspec_nr = refmap_nr;
+		} else {
+			fetch_refspec = transport->remote->fetch;
+			fetch_refspec_nr = transport->remote->fetch_refspec_nr;
+		}
+
+		for (i = 0; i < fetch_refspec_nr; i++)
+			get_fetch_map(ref_map, &fetch_refspec[i], &oref_tail, 1);
 
 		if (tags == TAGS_SET)
 			get_fetch_map(remote_refs, tag_refspec, &tail, 0);
+	} else if (refmap_array) {
+		die("--refmap option is only meaningful with command-line refspec(s).");
 	} else {
 		/* Use the defaults */
 		struct remote *remote = transport->remote;
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 29d59ef..d78f320 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -447,6 +447,43 @@ test_expect_success 'explicit pull should update tracking' '
 	)
 '
 
+test_expect_success 'explicit --refmap is allowed only with command-line refspec' '
+	cd "$D" &&
+	(
+		cd three &&
+		test_must_fail git fetch --refmap="*:refs/remotes/none/*"
+	)
+'
+
+test_expect_success 'explicit --refmap option overrides remote.*.fetch' '
+	cd "$D" &&
+	git branch -f side &&
+	(
+		cd three &&
+		git update-ref refs/remotes/origin/master base-origin-master &&
+		o=$(git rev-parse --verify refs/remotes/origin/master) &&
+		git fetch --refmap="refs/heads/*:refs/remotes/other/*" origin master &&
+		n=$(git rev-parse --verify refs/remotes/origin/master) &&
+		test "$o" = "$n" &&
+		test_must_fail git rev-parse --verify refs/remotes/origin/side &&
+		git rev-parse --verify refs/remotes/other/master
+	)
+'
+
+test_expect_success 'explicitly empty --refmap option disables remote.*.fetch' '
+	cd "$D" &&
+	git branch -f side &&
+	(
+		cd three &&
+		git update-ref refs/remotes/origin/master base-origin-master &&
+		o=$(git rev-parse --verify refs/remotes/origin/master) &&
+		git fetch --refmap="" origin master &&
+		n=$(git rev-parse --verify refs/remotes/origin/master) &&
+		test "$o" = "$n" &&
+		test_must_fail git rev-parse --verify refs/remotes/origin/side
+	)
+'
+
 test_expect_success 'configured fetch updates tracking' '
 
 	cd "$D" &&
-- 
2.0.0-511-g1433423
