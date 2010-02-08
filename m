From: Larry D'Anna <larry@elder-gods.org>
Subject: [PATCH] git-push: clean up some of the output from git push
Date: Mon,  8 Feb 2010 17:33:18 -0500
Message-ID: <1265668398-8635-1-git-send-email-larry@elder-gods.org>
References: <20100208223107.GB21718@cthulhu>
Cc: Larry D'Anna <larry@elder-gods.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 08 23:33:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NecAa-0002Yf-F9
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 23:33:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752079Ab0BHWdY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2010 17:33:24 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:54157 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752046Ab0BHWdX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 17:33:23 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id 029BF82205A; Mon,  8 Feb 2010 17:33:23 -0500 (EST)
X-Mailer: git-send-email 1.7.0.rc1.33.g07cf0f.dirty
In-Reply-To: <20100208223107.GB21718@cthulhu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139328>

* send the "To prevent you from losing history, non-fast-forward...." message to
  the standard error.  That's where these sort of advice messages typically go

* for git push --porcelain: squelch the above advice.

* for git push --porcelain: send "To dest" lines to the standard output so
  whoever is reading from the process which ref updates went to which remotes.

* for git push --porcelain: only send the "Everything up-to-date" line if
  verbose.

* for git push --porcelain --dry-run: exit with status 0 even if updates will be
  rejected.  Whoever is reading the output of git push--dry-run --porcelain can
  clearly see if updates will be rejected.  However, it will probably need to
  distinguish this condition from other unknown errors that it does not know how
  to handle.

Signed-off-by: Larry D'Anna <larry@elder-gods.org>
---
 builtin-push.c      |   11 ++++++++---
 builtin-send-pack.c |    4 ++++
 send-pack.h         |    1 +
 transport.c         |    7 ++++---
 4 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/builtin-push.c b/builtin-push.c
index 5633f0a..aacba45 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -124,9 +124,9 @@ static int push_with_options(struct transport *transport, int flags)
 		return 0;
 
 	if (nonfastforward && advice_push_nonfastforward) {
-		printf("To prevent you from losing history, non-fast-forward updates were rejected\n"
-		       "Merge the remote changes before pushing again.  See the 'Note about\n"
-		       "fast-forwards' section of 'git push --help' for details.\n");
+		fprintf(stderr, "To prevent you from losing history, non-fast-forward updates were rejected\n"
+				"Merge the remote changes before pushing again.  See the 'Note about\n"
+				"fast-forwards' section of 'git push --help' for details.\n");
 	}
 
 	return 1;
@@ -226,6 +226,11 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, options, push_usage, 0);
 
+	if (flags & TRANSPORT_PUSH_PORCELAIN) {
+		/* Do not give advice messages to Porcelain scripts */
+		advice_push_nonfastforward = 0;
+	}
+
 	if (deleterefs && (tags || (flags & (TRANSPORT_PUSH_ALL | TRANSPORT_PUSH_MIRROR))))
 		die("--delete is incompatible with --all, --mirror and --tags");
 	if (deleterefs && argc < 2)
diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 76c7206..358f5e1 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -476,6 +476,10 @@ int send_pack(struct send_pack_args *args,
 
 	if (ret < 0)
 		return ret;
+
+	if (args->porcelain && args->dry_run)
+		return 0;
+
 	for (ref = remote_refs; ref; ref = ref->next) {
 		switch (ref->status) {
 		case REF_STATUS_NONE:
diff --git a/send-pack.h b/send-pack.h
index 28141ac..60b4ba6 100644
--- a/send-pack.h
+++ b/send-pack.h
@@ -4,6 +4,7 @@
 struct send_pack_args {
 	unsigned verbose:1,
 		quiet:1,
+		porcelain:1,
 		send_mirror:1,
 		force_update:1,
 		use_thin_pack:1,
diff --git a/transport.c b/transport.c
index 3846aac..2b9e4be 100644
--- a/transport.c
+++ b/transport.c
@@ -675,7 +675,7 @@ static void print_ok_ref_status(struct ref *ref, int porcelain)
 static int print_one_push_status(struct ref *ref, const char *dest, int count, int porcelain)
 {
 	if (!count)
-		fprintf(stderr, "To %s\n", dest);
+		fprintf(porcelain ? stdout : stderr, "To %s\n", dest);
 
 	switch(ref->status) {
 	case REF_STATUS_NONE:
@@ -791,6 +791,7 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 	args.verbose = !!(flags & TRANSPORT_PUSH_VERBOSE);
 	args.quiet = !!(flags & TRANSPORT_PUSH_QUIET);
 	args.dry_run = !!(flags & TRANSPORT_PUSH_DRY_RUN);
+	args.porcelain = !!(flags & TRANSPORT_PUSH_PORCELAIN);
 
 	ret = send_pack(&args, data->fd, data->conn, remote_refs,
 			&data->extra_have);
@@ -1052,7 +1053,7 @@ int transport_push(struct transport *transport,
 			flags & TRANSPORT_PUSH_FORCE);
 
 		ret = transport->push_refs(transport, remote_refs, flags);
-		err = push_had_errors(remote_refs);
+		err = (pretend && porcelain) ? 0 : push_had_errors(remote_refs);
 
 		ret |= err;
 
@@ -1070,7 +1071,7 @@ int transport_push(struct transport *transport,
 				update_tracking_ref(transport->remote, ref, verbose);
 		}
 
-		if (!quiet && !ret && !refs_pushed(remote_refs))
+		if (!quiet && (!porcelain || verbose) && !ret && !refs_pushed(remote_refs))
 			fprintf(stderr, "Everything up-to-date\n");
 		return ret;
 	}
-- 
1.7.0.rc1.33.g07cf0f.dirty
