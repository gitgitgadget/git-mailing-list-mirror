X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH] pack-refs: Store the full name of the ref even when packing only tags.
Date: Thu, 02 Nov 2006 12:13:32 +0100
Message-ID: <871wom5cf7.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 2 Nov 2006 11:13:43 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.90 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30730>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfaVv-0004Pc-T1 for gcvg-git@gmane.org; Thu, 02 Nov
 2006 12:13:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752851AbWKBLNg (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 06:13:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752852AbWKBLNg
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 06:13:36 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:26817 "EHLO
 mail.codeweavers.com") by vger.kernel.org with ESMTP id S1752851AbWKBLNg
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 06:13:36 -0500
Received: from adsl-84-226-62-15.adslplus.ch ([84.226.62.15]
 helo=wine.dyndns.org) by mail.codeweavers.com with esmtpsa
 (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32) (Exim 4.50) id 1GfaVr-0005Qf-8r for
 git@vger.kernel.org; Thu, 02 Nov 2006 05:13:35 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000) id B1BAE109EB7; Thu,
  2 Nov 2006 12:13:32 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Using for_each_tag_ref() to enumerate tags is wrong since it removes
the refs/tags/ prefix, we need to always use for_each_ref() and filter
out non-tag references in the callback.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 builtin-pack-refs.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin-pack-refs.c b/builtin-pack-refs.c
index 1087657..042d271 100644
--- a/builtin-pack-refs.c
+++ b/builtin-pack-refs.c
@@ -12,6 +12,7 @@ struct ref_to_prune {
 
 struct pack_refs_cb_data {
 	int prune;
+	int all;
 	struct ref_to_prune *ref_to_prune;
 	FILE *refs_file;
 };
@@ -29,6 +30,8 @@ static int handle_one_ref(const char *pa
 {
 	struct pack_refs_cb_data *cb = cb_data;
 
+	if (!cb->all && strncmp(path, "refs/tags/", 10))
+		return 0;
 	/* Do not pack the symbolic refs */
 	if (!(flags & REF_ISSYMREF))
 		fprintf(cb->refs_file, "%s %s\n", sha1_to_hex(sha1), path);
@@ -68,7 +71,6 @@ int cmd_pack_refs(int argc, const char *
 {
 	int fd, i;
 	struct pack_refs_cb_data cbdata;
-	int (*iterate_ref)(each_ref_fn, void *) = for_each_tag_ref;
 
 	memset(&cbdata, 0, sizeof(cbdata));
 
@@ -79,7 +81,7 @@ int cmd_pack_refs(int argc, const char *
 			continue;
 		}
 		if (!strcmp(arg, "--all")) {
-			iterate_ref = for_each_ref;
+			cbdata.all = 1;
 			continue;
 		}
 		/* perhaps other parameters later... */
@@ -93,7 +95,7 @@ int cmd_pack_refs(int argc, const char *
 	if (!cbdata.refs_file)
 		die("unable to create ref-pack file structure (%s)",
 		    strerror(errno));
-	iterate_ref(handle_one_ref, &cbdata);
+	for_each_ref(handle_one_ref, &cbdata);
 	fflush(cbdata.refs_file);
 	fsync(fd);
 	fclose(cbdata.refs_file);
-- 
1.4.3.3.gac1f

-- 
Alexandre Julliard
