From: Larry D'Anna <larry@elder-gods.org>
Subject: [PATCH v3 2/3] git-push: clean up some of the output from git push --porcelain
Date: Mon,  8 Feb 2010 15:31:23 -0500
Message-ID: <a1b71c9f6566549e6117f5c98c2f1e60754a7334.1265661033.git.larry@elder-gods.org>
References: <214a0317f2e4707a866b2f5d10509296bc1479c1.1265661033.git.larry@elder-gods.org>
Cc: Larry D'Anna <larry@elder-gods.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 08 21:31:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeaGf-0000pE-CN
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 21:31:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755427Ab0BHUba (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2010 15:31:30 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:47342 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753316Ab0BHUb3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 15:31:29 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id F2FEF822010; Mon,  8 Feb 2010 15:31:27 -0500 (EST)
X-Mailer: git-send-email 1.7.0.rc1.33.g07cf0f.dirty
In-Reply-To: <214a0317f2e4707a866b2f5d10509296bc1479c1.1265661033.git.larry@elder-gods.org>
In-Reply-To: <20100208201956.GA7015@cthulhu>
References: <20100208201956.GA7015@cthulhu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139312>

* don't emit long explanatory message about non-fast-forward updates.

* send "To dest" lines to standard out so whoever is reading standard out knows
  which ref updates went to which remotes.

* only send the "Everything up-to-date" line if verbose.

Signed-off-by: Larry D'Anna <larry@elder-gods.org>
---
 builtin-push.c |    2 +-
 transport.c    |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin-push.c b/builtin-push.c
index 0a27072..ff0b1c6 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -123,7 +123,7 @@ static int push_with_options(struct transport *transport, int flags)
 	if (!err)
 		return 0;
 
-	if (nonfastforward && advice_push_nonfastforward) {
+	if (!(flags & TRANSPORT_PUSH_PORCELAIN) && nonfastforward && advice_push_nonfastforward) {
 		fprintf(stderr, "To prevent you from losing history, non-fast-forward updates were rejected\n"
 				"Merge the remote changes before pushing again.  See the 'Note about\n"
 				"fast-forwards' section of 'git push --help' for details.\n");
diff --git a/transport.c b/transport.c
index 3846aac..00d986c 100644
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
@@ -1070,7 +1070,7 @@ int transport_push(struct transport *transport,
 				update_tracking_ref(transport->remote, ref, verbose);
 		}
 
-		if (!quiet && !ret && !refs_pushed(remote_refs))
+		if (!quiet && (!porcelain || verbose) && !ret && !refs_pushed(remote_refs))
 			fprintf(stderr, "Everything up-to-date\n");
 		return ret;
 	}
-- 
1.7.0.rc1.33.g07cf0f.dirty
