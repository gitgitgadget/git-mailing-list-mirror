From: Larry D'Anna <larry@elder-gods.org>
Subject: [PATCH 2/3] silence human readable info messages going to stderr from git push --porcelain
Date: Fri,  5 Feb 2010 14:34:21 -0500
Message-ID: <1265398462-17316-2-git-send-email-larry@elder-gods.org>
References: <20100205150638.GB14116@coredump.intra.peff.net>
Cc: Larry D'Anna <larry@elder-gods.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 05 20:34:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdTwo-00041h-VI
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 20:34:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755467Ab0BETe0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 14:34:26 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:50486 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753751Ab0BETeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 14:34:25 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id E4602822180; Fri,  5 Feb 2010 14:34:23 -0500 (EST)
X-Mailer: git-send-email 1.7.0.rc1.33.g07cf0f.dirty
In-Reply-To: <20100205150638.GB14116@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139067>

These messages are redundant information to a script that's calling git-push.

Signed-off-by: Larry D'Anna <larry@elder-gods.org>
---
 builtin-push.c |    4 ++--
 transport.c    |    6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin-push.c b/builtin-push.c
index 0a27072..3fa4516 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -111,7 +111,7 @@ static int push_with_options(struct transport *transport, int flags)
 	if (thin)
 		transport_set_option(transport, TRANS_OPT_THIN, "yes");
 
-	if (flags & TRANSPORT_PUSH_VERBOSE)
+	if (flags & TRANSPORT_PUSH_VERBOSE && !(flags & TRANSPORT_PUSH_PORCELAIN))
 		fprintf(stderr, "Pushing to %s\n", transport->url);
 	err = transport_push(transport, refspec_nr, refspec, flags,
 			     &nonfastforward);
@@ -123,7 +123,7 @@ static int push_with_options(struct transport *transport, int flags)
 	if (!err)
 		return 0;
 
-	if (nonfastforward && advice_push_nonfastforward) {
+	if (!(flags & TRANSPORT_PUSH_PORCELAIN) && nonfastforward && advice_push_nonfastforward) {
 		fprintf(stderr, "To prevent you from losing history, non-fast-forward updates were rejected\n"
 				"Merge the remote changes before pushing again.  See the 'Note about\n"
 				"fast-forwards' section of 'git push --help' for details.\n");
diff --git a/transport.c b/transport.c
index 3846aac..f707c7b 100644
--- a/transport.c
+++ b/transport.c
@@ -674,7 +674,7 @@ static void print_ok_ref_status(struct ref *ref, int porcelain)
 
 static int print_one_push_status(struct ref *ref, const char *dest, int count, int porcelain)
 {
-	if (!count)
+	if (!count && !porcelain)
 		fprintf(stderr, "To %s\n", dest);
 
 	switch(ref->status) {
@@ -1067,10 +1067,10 @@ int transport_push(struct transport *transport,
 		if (!(flags & TRANSPORT_PUSH_DRY_RUN)) {
 			struct ref *ref;
 			for (ref = remote_refs; ref; ref = ref->next)
-				update_tracking_ref(transport->remote, ref, verbose);
+				update_tracking_ref(transport->remote, ref, verbose && !porcelain);
 		}
 
-		if (!quiet && !ret && !refs_pushed(remote_refs))
+		if (!quiet && !porcelain && !ret && !refs_pushed(remote_refs))
 			fprintf(stderr, "Everything up-to-date\n");
 		return ret;
 	}
-- 
1.7.0.rc1.33.g07cf0f.dirty
