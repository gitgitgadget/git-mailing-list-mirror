From: Larry D'Anna <larry@elder-gods.org>
Subject: [PATCH v2 3/3] make git push --dry-run --porcelain exit with status 0 even if updates will be rejected
Date: Fri,  5 Feb 2010 15:49:41 -0500
Message-ID: <cea7001d626116d76d885e24152d68cf41eca4dd.1265402797.git.larry@elder-gods.org>
References: <cover.1265402797.git.larry@elder-gods.org>
Cc: Larry D'Anna <larry@elder-gods.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 05 21:50:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdV8J-00059V-4c
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 21:50:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755012Ab0BEUto (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 15:49:44 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:54173 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031Ab0BEUtn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 15:49:43 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id E342B82218B; Fri,  5 Feb 2010 15:49:42 -0500 (EST)
X-Mailer: git-send-email 1.7.0.rc1.33.g07cf0f.dirty
In-Reply-To: <cover.1265402797.git.larry@elder-gods.org>
In-Reply-To: <cover.1265402797.git.larry@elder-gods.org>
References: <7v1vgz5ta7.fsf@alter.siamese.dyndns.org> <cover.1265402797.git.larry@elder-gods.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139084>

The script calling git push --dry-run --porcelain can see clearly from the
output that the updates will be rejected.  However, it will probably need to
distinguish this condition from the push failing for other reasons, such as the
remote not being reachable.

Signed-off-by: Larry D'Anna <larry@elder-gods.org>
---
 builtin-send-pack.c |    4 ++++
 send-pack.h         |    1 +
 transport.c         |    7 +++++--
 3 files changed, 10 insertions(+), 2 deletions(-)

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
index 00d986c..b41e1dc 100644
--- a/transport.c
+++ b/transport.c
@@ -558,8 +558,10 @@ static int fetch_refs_via_pack(struct transport *transport,
 	return (refs ? 0 : -1);
 }
 
-static int push_had_errors(struct ref *ref)
+static int push_had_errors(struct ref *ref, int flags)
 {
+	if (flags & TRANSPORT_PUSH_DRY_RUN && flags & TRANSPORT_PUSH_PORCELAIN)
+		return 0;
 	for (; ref; ref = ref->next) {
 		switch (ref->status) {
 		case REF_STATUS_NONE:
@@ -791,6 +793,7 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 	args.verbose = !!(flags & TRANSPORT_PUSH_VERBOSE);
 	args.quiet = !!(flags & TRANSPORT_PUSH_QUIET);
 	args.dry_run = !!(flags & TRANSPORT_PUSH_DRY_RUN);
+	args.porcelain = !!(flags & TRANSPORT_PUSH_PORCELAIN);
 
 	ret = send_pack(&args, data->fd, data->conn, remote_refs,
 			&data->extra_have);
@@ -1052,7 +1055,7 @@ int transport_push(struct transport *transport,
 			flags & TRANSPORT_PUSH_FORCE);
 
 		ret = transport->push_refs(transport, remote_refs, flags);
-		err = push_had_errors(remote_refs);
+		err = push_had_errors(remote_refs, flags);
 
 		ret |= err;
 
-- 
1.7.0.rc1.33.g07cf0f.dirty
