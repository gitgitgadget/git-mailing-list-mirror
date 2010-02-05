From: Larry D'Anna <larry@elder-gods.org>
Subject: [PATCH 3/3] make git push --dry-run --porcelain exit with status 0 even if updates will be rejected
Date: Fri,  5 Feb 2010 14:34:22 -0500
Message-ID: <1265398462-17316-3-git-send-email-larry@elder-gods.org>
References: <20100205150638.GB14116@coredump.intra.peff.net>
Cc: Larry D'Anna <larry@elder-gods.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 05 20:34:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdTwn-00041h-TN
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 20:34:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755499Ab0BETe1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 14:34:27 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:50488 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755202Ab0BETeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 14:34:25 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id EF275822182; Fri,  5 Feb 2010 14:34:23 -0500 (EST)
X-Mailer: git-send-email 1.7.0.rc1.33.g07cf0f.dirty
In-Reply-To: <20100205150638.GB14116@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139066>

The script calling git push --dry-run --porcelain can see clearly from the
output that the updates will be rejected.  However, it will probably need to
distinguish this condition from the push failing for other reasons, such as the
remote not being reachable.

Signed-off-by: Larry D'Anna <larry@elder-gods.org>
---
 builtin-send-pack.c |    5 +++++
 send-pack.h         |    1 +
 transport.c         |   11 +++++++++--
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 76c7206..dfd7470 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -478,6 +478,11 @@ int send_pack(struct send_pack_args *args,
 		return ret;
 	for (ref = remote_refs; ref; ref = ref->next) {
 		switch (ref->status) {
+		case REF_STATUS_REJECT_NONFASTFORWARD:
+		case REF_STATUS_REJECT_NODELETE:
+			if (args->porcelain && args->dry_run)
+				break;
+			return -1;
 		case REF_STATUS_NONE:
 		case REF_STATUS_UPTODATE:
 		case REF_STATUS_OK:
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
index f707c7b..e61d288 100644
--- a/transport.c
+++ b/transport.c
@@ -558,10 +558,16 @@ static int fetch_refs_via_pack(struct transport *transport,
 	return (refs ? 0 : -1);
 }
 
-static int push_had_errors(struct ref *ref)
+static int push_had_errors(struct ref *ref, int flags)
 {
 	for (; ref; ref = ref->next) {
 		switch (ref->status) {
+		case REF_STATUS_REJECT_NONFASTFORWARD:
+		case REF_STATUS_REJECT_NODELETE:
+			if (flags & TRANSPORT_PUSH_DRY_RUN && flags & TRANSPORT_PUSH_PORCELAIN)
+				break;
+			else
+				return 1;
 		case REF_STATUS_NONE:
 		case REF_STATUS_UPTODATE:
 		case REF_STATUS_OK:
@@ -791,6 +797,7 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 	args.verbose = !!(flags & TRANSPORT_PUSH_VERBOSE);
 	args.quiet = !!(flags & TRANSPORT_PUSH_QUIET);
 	args.dry_run = !!(flags & TRANSPORT_PUSH_DRY_RUN);
+	args.porcelain = !!(flags & TRANSPORT_PUSH_PORCELAIN);
 
 	ret = send_pack(&args, data->fd, data->conn, remote_refs,
 			&data->extra_have);
@@ -1052,7 +1059,7 @@ int transport_push(struct transport *transport,
 			flags & TRANSPORT_PUSH_FORCE);
 
 		ret = transport->push_refs(transport, remote_refs, flags);
-		err = push_had_errors(remote_refs);
+		err = push_had_errors(remote_refs, flags);
 
 		ret |= err;
 
-- 
1.7.0.rc1.33.g07cf0f.dirty
