From: Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH 2/4] mirror pushing -- clean up match_refs flags
Date: Thu, 8 Nov 2007 17:01:13 -0000
Message-ID: <1194541273.0@pinky>
References: <20071108165801.GM9736@shadowen.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 08 18:02:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqAlW-0005gQ-63
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 18:02:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759478AbXKHRBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 12:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761445AbXKHRBF
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 12:01:05 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:4167 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761093AbXKHRBD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 12:01:03 -0500
Received: from localhost ([127.0.0.1] helo=pinky)
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1IqAkY-0003u4-T9
	for git@vger.kernel.org; Thu, 08 Nov 2007 17:01:02 +0000
InReply-To: <20071108165801.GM9736@shadowen.org>
Received-SPF: pass
X-SPF-Guess: pass
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64055>


Add a new enum to define the match_refs flags field and switch
all callers to it.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
 builtin-send-pack.c |    8 +++++++-
 http-push.c         |    4 ++--
 remote.c            |    4 ++--
 remote.h            |    7 +++++++
 4 files changed, 18 insertions(+), 5 deletions(-)
diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index d5ead97..d42164e 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -227,6 +227,12 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 	int allow_deleting_refs = 0;
 	int expect_status_report = 0;
 	int shown_dest = 0;
+	int flags = MATCH_REFS_NONE;
+
+	if (args.send_all)
+		flags |= MATCH_REFS_ALL;
+	if (args.send_mirror)
+		flags |= MATCH_REFS_MIRROR;
 
 	/* No funny business with the matcher */
 	remote_tail = get_remote_heads(in, &remote_refs, 0, NULL, REF_NORMAL);
@@ -242,7 +248,7 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 	if (!remote_tail)
 		remote_tail = &remote_refs;
 	if (match_refs(local_refs, remote_refs, &remote_tail,
-		       nr_refspec, refspec, args.send_all | (args.send_mirror << 1)))
+					       nr_refspec, refspec, flags))
 		return -1;
 
 	if (!remote_refs) {
diff --git a/http-push.c b/http-push.c
index 99328f5..66b81f1 100644
--- a/http-push.c
+++ b/http-push.c
@@ -78,7 +78,7 @@ static struct curl_slist *no_pragma_header;
 static struct curl_slist *default_headers;
 
 static int push_verbosely;
-static int push_all;
+static int push_all = MATCH_REFS_NONE;
 static int force_all;
 static int dry_run;
 
@@ -2300,7 +2300,7 @@ int main(int argc, char **argv)
 
 		if (*arg == '-') {
 			if (!strcmp(arg, "--all")) {
-				push_all = 1;
+				push_all = MATCH_REFS_ALL;
 				continue;
 			}
 			if (!strcmp(arg, "--force")) {
diff --git a/remote.c b/remote.c
index 45dd59b..09b7aad 100644
--- a/remote.c
+++ b/remote.c
@@ -726,8 +726,8 @@ int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
 {
 	struct refspec *rs =
 		parse_ref_spec(nr_refspec, (const char **) refspec);
-	int send_all = flags & 01;
-	int send_mirror = flags & 02;
+	int send_all = flags & MATCH_REFS_ALL;
+	int send_mirror = flags & MATCH_REFS_MIRROR;
 
 	if (match_explicit_refs(src, dst, dst_tail, rs, nr_refspec))
 		return -1;
diff --git a/remote.h b/remote.h
index 6a4c7a0..b10036c 100644
--- a/remote.h
+++ b/remote.h
@@ -102,4 +102,11 @@ struct branch *branch_get(const char *name);
 int branch_has_merge_config(struct branch *branch);
 int branch_merge_matches(struct branch *, int n, const char *);
 
+/* Flags to match_refs. */
+enum match_refs_flags {
+	MATCH_REFS_NONE		= 0,
+	MATCH_REFS_ALL 		= (1 << 0),
+	MATCH_REFS_MIRROR	= (1 << 1),
+};
+
 #endif
