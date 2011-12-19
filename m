From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] push: hint to use push.default=upstream when appropriate
Date: Sun, 18 Dec 2011 21:38:29 -0800
Message-ID: <7vbor5nmsq.fsf_-_@alter.siamese.dyndns.org>
References: <7vobvct58u.fsf@alter.siamese.dyndns.org>
 <20111215073816.GD1327@sigill.intra.peff.net>
 <7vmxatofvr.fsf@alter.siamese.dyndns.org>
 <7vliq9nn0l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 19 06:38:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RcVvp-0006mE-BB
	for gcvg-git-2@lo.gmane.org; Mon, 19 Dec 2011 06:38:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204Ab1LSFie (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Dec 2011 00:38:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59578 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750910Ab1LSFic (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2011 00:38:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EBF356C83;
	Mon, 19 Dec 2011 00:38:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jz41sKpS54PJRUN75NYphD6J04w=; b=e5EHNX
	e5pjIe1yPQ9xz3oR0mZEXnH/3XrM3cc0hgk4otQe4WhAmCqZa1e+CAqQGLOT8KZT
	cZ1KhsOve/uPWeKbTahHWt3h50P3VQyCTlG8siCh4aY2pflw577k9vS6w2xRo3nf
	sbLnet/4Lw+1Klx5+ZsBOg8T8mgvU+XDd4j2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RyjyzVfcEuXxmjAvXmcmRTd1Camox39d
	FU9MNw9SOBLjvlkGqlYWdTJoBVB0jRxQlHG2QJ8VCc447iXy3hwq3VgO71gS8+Cv
	VzyySbnBdhzjCu738Ief34ak+Vuk+u8lzCJBjTugZoYAiiN5NA5PN0880UuRHMPo
	ZqcwZ4vyw7I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E3DAC6C82;
	Mon, 19 Dec 2011 00:38:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1710E6C81; Mon, 19 Dec 2011
 00:38:30 -0500 (EST)
In-Reply-To: <7vliq9nn0l.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 18 Dec 2011 21:33:46 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AF3C270A-2A03-11E1-B705-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187437>

If you push into a shared repository that others push to, and you have
local branches in your repository that matches the remote side but do not
keep them up-to-date, then 'matching refs' is not an appropriate default
for you.

Detect when push failed due to non-fast-forward _and_ we did matching refs
by default (i.e. if the user explicitly said ':' from the command line, or
had push.default set to 'matching', then we do not want to advise), and
give a hint to tell the user that the user may want to set 'push.default'
configuration variable to 'upstream', if the remote repository receives
pushes from other places.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt |    6 ++++++
 advice.c                 |    2 ++
 advice.h                 |    1 +
 builtin/push.c           |   25 +++++++++++++++++++++++++
 cache.h                  |    3 ++-
 environment.c            |    2 +-
 6 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 9be7106..8da7063 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -141,6 +141,12 @@ advice.*::
 		Advice shown when you used linkgit:git-checkout[1] to
 		move to the detach HEAD state, to instruct how to create
 		a local branch after the fact.
+	pushUseUpstream::
+		Advice to set 'push.default' to 'upstream' when you ran
+		linkgit:git-push[1] and pushed 'matching refs' by default
+		(i.e. you did not have any explicit refspec on the command
+		line, and no 'push.default' configuration was set) and it
+		resulted in a non-fast-forward error.
 --
 
 core.fileMode::
diff --git a/advice.c b/advice.c
index e02e632..9b56709 100644
--- a/advice.c
+++ b/advice.c
@@ -6,6 +6,7 @@ int advice_commit_before_merge = 1;
 int advice_resolve_conflict = 1;
 int advice_implicit_identity = 1;
 int advice_detached_head = 1;
+int advice_push_use_upstream = 1;
 
 static struct {
 	const char *name;
@@ -17,6 +18,7 @@ static struct {
 	{ "resolveconflict", &advice_resolve_conflict },
 	{ "implicitidentity", &advice_implicit_identity },
 	{ "detachedhead", &advice_detached_head },
+	{ "pushuseupstream", &advice_push_use_upstream },
 };
 
 void advise(const char *advice, ...)
diff --git a/advice.h b/advice.h
index e5d0af7..6bb89cd 100644
--- a/advice.h
+++ b/advice.h
@@ -9,6 +9,7 @@ extern int advice_commit_before_merge;
 extern int advice_resolve_conflict;
 extern int advice_implicit_identity;
 extern int advice_detached_head;
+extern int advice_push_use_upstream;
 
 int git_default_advice_config(const char *var, const char *value);
 void advise(const char *advice, ...);
diff --git a/builtin/push.c b/builtin/push.c
index 35cce53..5f8c7f4 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -9,6 +9,7 @@
 #include "transport.h"
 #include "parse-options.h"
 #include "submodule.h"
+#include "advice.h"
 
 static const char * const push_usage[] = {
 	"git push [<options>] [<repository> [<refspec>...]]",
@@ -24,6 +25,7 @@ static int progress;
 static const char **refspec;
 static int refspec_nr;
 static int refspec_alloc;
+static int default_matching_used;
 
 static void add_refspec(const char *ref)
 {
@@ -95,6 +97,9 @@ static void setup_default_push_refspecs(struct remote *remote)
 {
 	switch (push_default) {
 	default:
+	case PUSH_DEFAULT_UNSPECIFIED:
+		default_matching_used = 1;
+		/* fallthru */
 	case PUSH_DEFAULT_MATCHING:
 		add_refspec(":");
 		break;
@@ -114,6 +119,23 @@ static void setup_default_push_refspecs(struct remote *remote)
 	}
 }
 
+static const char *message_advice_use_upstream[] = {
+	"If you are pushing into a repository that receives pushes from",
+	"repositories other than the current repository, you may want to",
+	"set 'push.default' configuration variable to 'upstream' to avoid",
+	"pushing branches you haven't worked on that others have updated.",
+};
+
+static void advise_use_upstream(void)
+{
+	int i;
+
+	if (!advice_push_use_upstream)
+		return;
+	for (i = 0; i < ARRAY_SIZE(message_advice_use_upstream); i++)
+		advise(message_advice_use_upstream[i]);
+}
+
 static int push_with_options(struct transport *transport, int flags)
 {
 	int err;
@@ -136,6 +158,9 @@ static int push_with_options(struct transport *transport, int flags)
 
 	err |= transport_disconnect(transport);
 
+	if (nonfastforward && default_matching_used)
+		advise_use_upstream();
+
 	if (!err)
 		return 0;
 
diff --git a/cache.h b/cache.h
index 627fb6a..6c86725 100644
--- a/cache.h
+++ b/cache.h
@@ -624,7 +624,8 @@ enum push_default_type {
 	PUSH_DEFAULT_NOTHING = 0,
 	PUSH_DEFAULT_MATCHING,
 	PUSH_DEFAULT_UPSTREAM,
-	PUSH_DEFAULT_CURRENT
+	PUSH_DEFAULT_CURRENT,
+	PUSH_DEFAULT_UNSPECIFIED
 };
 
 extern enum branch_track git_branch_track;
diff --git a/environment.c b/environment.c
index c93b8f4..d7e6c65 100644
--- a/environment.c
+++ b/environment.c
@@ -52,7 +52,7 @@ enum safe_crlf safe_crlf = SAFE_CRLF_WARN;
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
 enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
 enum rebase_setup_type autorebase = AUTOREBASE_NEVER;
-enum push_default_type push_default = PUSH_DEFAULT_MATCHING;
+enum push_default_type push_default = PUSH_DEFAULT_UNSPECIFIED;
 #ifndef OBJECT_CREATION_MODE
 #define OBJECT_CREATION_MODE OBJECT_CREATION_USES_HARDLINKS
 #endif
-- 
1.7.8.370.gb3269
