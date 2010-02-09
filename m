From: Larry D'Anna <larry@elder-gods.org>
Subject: [PATCH 4/4] git-push: make git push --dry-run --porcelain exit with status 0 even if updates will be rejected
Date: Tue,  9 Feb 2010 00:54:02 -0500
Message-ID: <d19f6773a0b44d4ec07738727dc474a354c6236d.1265694627.git.larry@elder-gods.org>
References: <1d1ce7e0ad28fd0cad8d9d7bfeda04ba58be36d4.1265694627.git.larry@elder-gods.org>
Cc: Larry D'Anna <larry@elder-gods.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 09 06:54:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nej3N-0006T5-B8
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 06:54:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752928Ab0BIFyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 00:54:09 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:36727 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751998Ab0BIFyH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 00:54:07 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id F113682201C; Tue,  9 Feb 2010 00:54:02 -0500 (EST)
X-Mailer: git-send-email 1.7.0.rc1.33.g07cf0f.dirty
In-Reply-To: <1d1ce7e0ad28fd0cad8d9d7bfeda04ba58be36d4.1265694627.git.larry@elder-gods.org>
In-Reply-To: <20100209054820.GA30907@cthulhu>
References: <20100209054820.GA30907@cthulhu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139367>

The script calling git push --dry-run --porcelain can see clearly from the
output that the updates will be rejected.  However, it will probably need to
distinguish this condition from the push failing for other reasons, such as the
remote not being reachable.

Signed-off-by: Larry D'Anna <larry@elder-gods.org>
---
 builtin-send-pack.c |    4 ++++
 send-pack.h         |    1 +
 transport.c         |    3 ++-
 3 files changed, 7 insertions(+), 1 deletions(-)

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
index fb653c6..0edcc16 100644
--- a/transport.c
+++ b/transport.c
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
 
-- 
1.7.0.rc1.33.g07cf0f.dirty
