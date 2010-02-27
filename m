From: Larry D'Anna <larry@elder-gods.org>
Subject: [PATCH 3/4] git-push: make git push --porcelain print "Done"
Date: Fri, 26 Feb 2010 22:59:50 -0500
Message-ID: <04fc63d0f8114f0cd721bcf3dff1f108e30b5308.1267243044.git.larry@elder-gods.org>
References: <cover.1267242789.git.larry@elder-gods.org>
Cc: Larry D'Anna <larry@elder-gods.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 05:00:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlDqk-0003aU-Qf
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 05:00:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967781Ab0B0D7z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2010 22:59:55 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:59107 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967758Ab0B0D7x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2010 22:59:53 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id 2326B822021; Fri, 26 Feb 2010 22:59:53 -0500 (EST)
X-Mailer: git-send-email 1.7.0.rc2.40.g7d8aa
In-Reply-To: <cover.1267242789.git.larry@elder-gods.org>
In-Reply-To: <cover.1267243044.git.larry@elder-gods.org>
References: <cover.1267243044.git.larry@elder-gods.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141175>

The script calling git push --porcelain can see clearly from the output if an
update was rejected.  However, it will probably need to distinguish this
condition from the push failing for other reasons, such as the remote not being
reachable.

This patch modifies git push --porcelain to print "Done" after the rest of its
output unless any errors have occurred which were not reported in the ref status
lines.

Signed-off-by: Larry D'Anna <larry@elder-gods.org>
---
 builtin-send-pack.c |    4 ++++
 send-pack.h         |    1 +
 transport.c         |   15 ++++++++++-----
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 2183a47..87795f5 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -510,6 +510,10 @@ int send_pack(struct send_pack_args *args,
 
 	if (ret < 0)
 		return ret;
+
+	if (args->porcelain)
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
index 32885f7..5b880d7 100644
--- a/transport.c
+++ b/transport.c
@@ -791,6 +791,7 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 	args.verbose = !!(flags & TRANSPORT_PUSH_VERBOSE);
 	args.quiet = !!(flags & TRANSPORT_PUSH_QUIET);
 	args.dry_run = !!(flags & TRANSPORT_PUSH_DRY_RUN);
+	args.porcelain = !!(flags & TRANSPORT_PUSH_PORCELAIN);
 
 	ret = send_pack(&args, data->fd, data->conn, remote_refs,
 			&data->extra_have);
@@ -1055,8 +1056,6 @@ int transport_push(struct transport *transport,
 		ret = transport->push_refs(transport, remote_refs, flags);
 		err = push_had_errors(remote_refs);
 
-		ret |= err;
-
 		if (!quiet || err)
 			print_push_status(transport->url, remote_refs,
 					verbose | porcelain, porcelain,
@@ -1071,9 +1070,15 @@ int transport_push(struct transport *transport,
 				update_tracking_ref(transport->remote, ref, verbose);
 		}
 
-		if (!quiet && !ret && !refs_pushed(remote_refs))
-			fprintf(stderr, "Everything up-to-date\n");
-		return ret;
+
+		if (porcelain) {
+			if (ret==0)
+				fprintf (stdout, "Done\n");
+		} else
+			if (!quiet && !ret && !refs_pushed(remote_refs))
+				fprintf(stderr, "Everything up-to-date\n");
+
+		return ret | err;
 	}
 	return 1;
 }
-- 
1.7.0.rc2.40.g7d8aa
