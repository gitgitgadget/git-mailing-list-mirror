From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH] git: add optional support for full pattern in fetch refspecs
Date: Tue,  7 Jul 2015 15:57:49 -0700
Message-ID: <1436309869-19609-1-git-send-email-jacob.e.keller@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 08 00:58:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCboQ-0000L0-L3
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 00:58:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757282AbbGGW56 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 18:57:58 -0400
Received: from mga02.intel.com ([134.134.136.20]:65015 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752555AbbGGW54 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 18:57:56 -0400
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP; 07 Jul 2015 15:57:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,426,1432623600"; 
   d="scan'208";a="757890445"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.85])
  by fmsmga002.fm.intel.com with ESMTP; 07 Jul 2015 15:57:55 -0700
X-Mailer: git-send-email 2.4.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273614>

This patch updates the refs.c check_refname_component logic in order to
allow for the possibility of using arbitrary patterns in fetch refspecs.
Specifically, patterns similar to `refs/tags/prefix-*:refs/tags/prefix-*`.

In order to ensure that standard users do not accidentally setup refspecs
which could cause issues, tie this feature to
remote.<name>.arbitrary_pattern boolean configuration option. This ensures
that no user will have this enabled on accident.

The primary reason against this is the ability to pull refs incorrectly
and then later push them again. Ie:

refs/tags/some-prefix-*:/refs/tags/other-prefix-*

This ref will essentially re-name the references locally. This is
generally not what you would want but there is no easy way to validate
this doesn't occur. Note this can already occur to normal pattern refspecs
via `refs/tags/*:refs/tags/namespace/*` refspecs, but these are a bit more
difficult to typo.

However, the additional functionality is useful for specifying to pull
certain patterns of refs, and can be useful if the power user decides to
enable it for a given remote.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
Cc: Daniel Barkalow <barkalow@iabervon.iabervon.org>
Cc: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt               |  7 +++++
 Documentation/git-check-ref-format.txt | 12 ++++++---
 builtin/check-ref-format.c             |  2 ++
 refs.c                                 | 48 ++++++++++++++++++++++------------
 refs.h                                 | 15 ++++++-----
 remote.c                               |  2 ++
 remote.h                               |  1 +
 7 files changed, 61 insertions(+), 26 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3e37b93ed2ac..626492de7a7f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2331,6 +2331,13 @@ remote.<name>.prune::
 	remote (as if the `--prune` option was given on the command line).
 	Overrides `fetch.prune` settings, if any.
 
+remote.<name>.arbitrarypattern::
+	When set to true, fetching from this remote will allow arbitrary complex
+	patterns for the fetch refspecs. For example,
+	refs/tags/prefix-*:refs/tags/prefix-* will work as expected. Care should be
+	taken as you could fetch refs into names that don't exist on the remote and
+	may end up pushing them again later by accident.
+
 remotes.<group>::
 	The list of remotes which are fetched by "git remote update
 	<group>".  See linkgit:git-remote[1].
diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index fc02959ba4ab..caab0e3037fa 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -43,8 +43,8 @@ Git imposes the following rules on how references are named:
   caret `^`, or colon `:` anywhere.
 
 . They cannot have question-mark `?`, asterisk `*`, or open
-  bracket `[` anywhere.  See the `--refspec-pattern` option below for
-  an exception to this rule.
+  bracket `[` anywhere.  See the `--refspec-pattern` and `--arbitrary-pattern`
+  options below for exceptions to this rule.
 
 . They cannot begin or end with a slash `/` or contain multiple
   consecutive slashes (see the `--normalize` option below for an
@@ -95,7 +95,13 @@ OPTIONS
 	(as used with remote repositories).  If this option is
 	enabled, <refname> is allowed to contain a single `*`
 	in place of a one full pathname component (e.g.,
-	`foo/*/bar` but not `foo/bar*`).
+	`foo/*/bar` but not `foo/bar*`). If '--arbitrary-pattern' is set, then
+	a single `foo/bar*baz` pattern will be accepted.
+
+--arbitrary-pattern::
+	If '--refspec-pattern' is set, allow arbitrary patterns instead of the
+	default simple case. Implies '--refspec-pattern'. Note that only one '*'
+	pattern will be accepted.
 
 --normalize::
 	Normalize 'refname' by removing any leading slash (`/`)
diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index fd915d59841e..e0b8d00d5337 100644
--- a/builtin/check-ref-format.c
+++ b/builtin/check-ref-format.c
@@ -70,6 +70,8 @@ int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
 			flags &= ~REFNAME_ALLOW_ONELEVEL;
 		else if (!strcmp(argv[i], "--refspec-pattern"))
 			flags |= REFNAME_REFSPEC_PATTERN;
+		else if (!strcmp(argv[i], "--arbitrary-pattern"))
+			flags |= REFNAME_ARBITRARY_PATTERN | REFNAME_REFSPEC_PATTERN;
 		else
 			usage(builtin_check_ref_format_usage);
 	}
diff --git a/refs.c b/refs.c
index 7ac05cf21a25..e4c24bfc778c 100644
--- a/refs.c
+++ b/refs.c
@@ -20,11 +20,12 @@ struct ref_lock {
  * 2: ., look for a preceding . to reject .. in refs
  * 3: {, look for a preceding @ to reject @{ in refs
  * 4: A bad character: ASCII control characters, "~", "^", ":" or SP
+ * 5: check for patterns to reject unless REFNAME_REFSPEC_PATTERN is set
  */
 static unsigned char refname_disposition[256] = {
 	1, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4,
 	4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4,
-	4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 2, 1,
+	4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 2, 1,
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 4,
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 0, 4, 0,
@@ -71,11 +72,14 @@ static unsigned char refname_disposition[256] = {
  * - any path component of it begins with ".", or
  * - it has double dots "..", or
  * - it has ASCII control character, "~", "^", ":" or SP, anywhere, or
- * - it ends with a "/".
- * - it ends with ".lock"
- * - it contains a "\" (backslash)
+ * - it ends with a "/", or
+ * - it ends with ".lock", or
+ * - it contains a "\" (backslash), or
+ * - it contains a "@{" portion, or
+ * - it contains a simple pattern unless REFNAME_REFSPEC_PATTERN is set, or
+ * - it contains a complex pattern unless REFNAME_ARBITRARY_PATTERN is set
  */
-static int check_refname_component(const char *refname, int flags)
+static int check_refname_component(const char *refname, int *flags)
 {
 	const char *cp;
 	char last = '\0';
@@ -96,6 +100,24 @@ static int check_refname_component(const char *refname, int flags)
 			break;
 		case 4:
 			return -1;
+		case 5:
+			if (!(*flags & REFNAME_REFSPEC_PATTERN))
+				return -1; /* refspec can't be a pattern */
+
+			/* Unset the pattern flag so that we only accept a single pattern.
+			 * This also conveniently makes us only accept the first '*' we
+			 * find in a single component. */
+			*flags &= ~ REFNAME_REFSPEC_PATTERN;
+
+			/* check if entire component is just a '*' */
+			if (refname[0] == '*' &&
+					(refname[1] == '\0' || refname[1] == '/'))
+				return 1;
+
+			if (!(*flags & REFNAME_ARBITRARY_PATTERN))
+				return -1; /* arbitrary patterns not allowed */
+
+			break;
 		}
 		last = ch;
 	}
@@ -120,18 +142,10 @@ int check_refname_format(const char *refname, int flags)
 
 	while (1) {
 		/* We are at the start of a path component. */
-		component_len = check_refname_component(refname, flags);
-		if (component_len <= 0) {
-			if ((flags & REFNAME_REFSPEC_PATTERN) &&
-					refname[0] == '*' &&
-					(refname[1] == '\0' || refname[1] == '/')) {
-				/* Accept one wildcard as a full refname component. */
-				flags &= ~REFNAME_REFSPEC_PATTERN;
-				component_len = 1;
-			} else {
-				return -1;
-			}
-		}
+		component_len = check_refname_component(refname, &flags);
+		if (component_len <= 0)
+			return -1;
+
 		component_count++;
 		if (refname[component_len] == '\0')
 			break;
diff --git a/refs.h b/refs.h
index 8c3d433a8a5b..1429776a975f 100644
--- a/refs.h
+++ b/refs.h
@@ -218,14 +218,17 @@ extern int for_each_reflog(each_ref_fn, void *);
 
 #define REFNAME_ALLOW_ONELEVEL 1
 #define REFNAME_REFSPEC_PATTERN 2
+#define REFNAME_ARBITRARY_PATTERN 4
 
 /*
- * Return 0 iff refname has the correct format for a refname according
- * to the rules described in Documentation/git-check-ref-format.txt.
- * If REFNAME_ALLOW_ONELEVEL is set in flags, then accept one-level
- * reference names.  If REFNAME_REFSPEC_PATTERN is set in flags, then
- * allow a "*" wildcard character in place of one of the name
- * components.  No leading or repeated slashes are accepted.
+ * Return 0 iff refname has the correct format for a refname according to the
+ * rules described in Documentation/git-check-ref-format.txt.  If
+ * REFNAME_ALLOW_ONELEVEL is set in flags, then accept one-level reference
+ * names.  If REFNAME_REFSPEC_PATTERN is set in flags, then allow a "*"
+ * wildcard character in place of one of the name components. If
+ * REFNAME_ARBITRARY_PATTERN is set in flags, then allow an arbitrary pattern
+ * with a single '*' wildcard character as one of the name components as well.
+ * No leading or repeated slashes are accepted.
  */
 extern int check_refname_format(const char *refname, int flags);
 
diff --git a/remote.c b/remote.c
index 26504b744786..49df6abad4ef 100644
--- a/remote.c
+++ b/remote.c
@@ -420,6 +420,8 @@ static int handle_config(const char *key, const char *value, void *cb)
 		remote->skip_default_update = git_config_bool(key, value);
 	else if (!strcmp(subkey, ".prune"))
 		remote->prune = git_config_bool(key, value);
+	else if (!strcmp(subkey, ".arbitrarypattern"))
+		remote->arbitrary_pattern = git_config_bool(key, value);
 	else if (!strcmp(subkey, ".url")) {
 		const char *v;
 		if (git_config_string(&v, key, value))
diff --git a/remote.h b/remote.h
index 312b7ca131c4..c885ab34f42e 100644
--- a/remote.h
+++ b/remote.h
@@ -46,6 +46,7 @@ struct remote {
 	int skip_default_update;
 	int mirror;
 	int prune;
+	int arbitrary_pattern;
 
 	const char *receivepack;
 	const char *uploadpack;
-- 
2.4.3
