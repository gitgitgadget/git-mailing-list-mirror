From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/5] rev-parse: introduce --exclude=<glob> to tame wildcards
Date: Fri,  1 Nov 2013 12:34:15 -0700
Message-ID: <1383334455-18623-4-git-send-email-gitster@pobox.com>
References: <52264070.3080909@kdbg.org>
 <1383334455-18623-1-git-send-email-gitster@pobox.com>
Cc: Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 01 20:34:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VcKUN-0004QG-EN
	for gcvg-git-2@plane.gmane.org; Fri, 01 Nov 2013 20:34:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753218Ab3KATea (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Nov 2013 15:34:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60274 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753103Ab3KATe2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Nov 2013 15:34:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ACA9D4ECED;
	Fri,  1 Nov 2013 15:34:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=r1Gy
	TrskcErstK6PRDcSjqNCpRk=; b=KJkwC6mgBjZ9bHaCX4bK3UVkKYC0DVsCHmCM
	DULaDu9M/ng+JA4K9bzsKsgzYHStK5UPJLskVYMqBbcRxyS1yoGVwHQOFSRQyFM6
	y6MOd6XdxVlTdNEQWoySWwQkrD0AqA/Qq74uTamQFAZUKVgFGB4dcWOY+95SfrlQ
	EJJzZoM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	Sdwqf3rpDOcQfiUmAocQVQKVlRzSYDQx+9qle8vUVIIKUFtjS3r2DRqN+oIGE1dn
	57QIxfP0HBTf/BEP5LLSFbkLOLjhx0rckMQ+iDnpPifYq2kBfh9JzNapL98lGK7+
	qfFiwwVhl+8vzz0WRezEsGhNP6fkcle2Fnb4dco3QC0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9972F4ECEC;
	Fri,  1 Nov 2013 15:34:27 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C92AE4ECEB;
	Fri,  1 Nov 2013 15:34:26 -0400 (EDT)
X-Mailer: git-send-email 1.8.5-rc0-281-g8951339
In-Reply-To: <1383334455-18623-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 9E848896-432C-11E3-A78B-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237221>

Teach "rev-parse" the same "I'm going to glob, but omit the ones
that match these patterns" feature as "rev-list".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-rev-parse.txt | 14 ++++++++++++++
 builtin/rev-parse.c             | 17 +++++++++++++++++
 t/t6018-rev-list-glob.sh        | 12 ++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 2b126c0..d4639a2 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -155,6 +155,20 @@ shown.  If the pattern does not contain a globbing character (`?`,
 	character (`?`, `*`, or `[`), it is turned into a prefix
 	match by appending `/*`.
 
+--exclude=<glob-pattern>::
+	Do not include refs matching '<glob-pattern>' that the next `--all`,
+	`--branches`, `--tags`, `--remotes`, or `--glob` would otherwise
+	consider. Repetitions of this option accumulate exclusion patterns
+	up to the next `--all`, `--branches`, `--tags`, `--remotes`, or
+	`--glob` option (other options or arguments do not clear
+	accumlated patterns).
++
+The patterns given should not begin with `refs/heads`, `refs/tags`, or
+`refs/remotes` when applied to `--branches`, `--tags`, or `--remotes`,
+restrictively, and they must begin with `refs/` when applied to `--glob`
+or `--all`. If a trailing '/{asterisk}' is intended, it must be given
+explicitly.
+
 --show-toplevel::
 	Show the absolute path of the top-level directory.
 
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index de894c7..f52f804 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -9,6 +9,8 @@
 #include "quote.h"
 #include "builtin.h"
 #include "parse-options.h"
+#include "diff.h"
+#include "revision.h"
 
 #define DO_REVS		1
 #define DO_NOREV	2
@@ -30,6 +32,8 @@ static int abbrev_ref;
 static int abbrev_ref_strict;
 static int output_sq;
 
+static struct string_list *ref_excludes;
+
 /*
  * Some arguments are relevant "revision" arguments,
  * others are about output format or other details.
@@ -185,6 +189,8 @@ static int show_default(void)
 
 static int show_reference(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
+	if (ref_excluded(ref_excludes, refname))
+		return 0;
 	show_rev(NORMAL, sha1, refname);
 	return 0;
 }
@@ -633,32 +639,43 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 			if (!prefixcmp(arg, "--branches=")) {
 				for_each_glob_ref_in(show_reference, arg + 11,
 					"refs/heads/", NULL);
+				clear_ref_exclusion(&ref_excludes);
 				continue;
 			}
 			if (!strcmp(arg, "--branches")) {
 				for_each_branch_ref(show_reference, NULL);
+				clear_ref_exclusion(&ref_excludes);
 				continue;
 			}
 			if (!prefixcmp(arg, "--tags=")) {
 				for_each_glob_ref_in(show_reference, arg + 7,
 					"refs/tags/", NULL);
+				clear_ref_exclusion(&ref_excludes);
 				continue;
 			}
 			if (!strcmp(arg, "--tags")) {
 				for_each_tag_ref(show_reference, NULL);
+				clear_ref_exclusion(&ref_excludes);
 				continue;
 			}
 			if (!prefixcmp(arg, "--glob=")) {
 				for_each_glob_ref(show_reference, arg + 7, NULL);
+				clear_ref_exclusion(&ref_excludes);
 				continue;
 			}
 			if (!prefixcmp(arg, "--remotes=")) {
 				for_each_glob_ref_in(show_reference, arg + 10,
 					"refs/remotes/", NULL);
+				clear_ref_exclusion(&ref_excludes);
 				continue;
 			}
 			if (!strcmp(arg, "--remotes")) {
 				for_each_remote_ref(show_reference, NULL);
+				clear_ref_exclusion(&ref_excludes);
+				continue;
+			}
+			if (!prefixcmp(arg, "--exclude=")) {
+				add_ref_exclusion(&ref_excludes, arg + 10);
 				continue;
 			}
 			if (!strcmp(arg, "--show-toplevel")) {
diff --git a/t/t6018-rev-list-glob.sh b/t/t6018-rev-list-glob.sh
index 77ef323..d00f7db 100755
--- a/t/t6018-rev-list-glob.sh
+++ b/t/t6018-rev-list-glob.sh
@@ -129,6 +129,18 @@ test_expect_success 'rev-parse --remotes=foo' '
 
 '
 
+test_expect_success 'rev-parse --exclude with --branches' '
+	compare rev-parse "--exclude=*/* --branches" "master someref subspace-x"
+'
+
+test_expect_success 'rev-parse --exclude with --all' '
+	compare rev-parse "--exclude=refs/remotes/* --all" "--branches --tags"
+'
+
+test_expect_success 'rev-parse accumulates multiple --exclude' '
+	compare rev-parse "--exclude=refs/remotes/* --exclude=refs/tags/* --all" --branches
+'
+
 test_expect_success 'rev-list --glob=refs/heads/subspace/*' '
 
 	compare rev-list "subspace/one subspace/two" "--glob=refs/heads/subspace/*"
-- 
1.8.5-rc0-281-g8951339
