X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH/RFC] avoid accessing _all_ loose refs in git-show-ref
Date: Sat, 16 Dec 2006 13:36:43 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612161335140.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sat, 16 Dec 2006 12:37:05 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34611>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvYmh-0007uJ-MG for gcvg-git@gmane.org; Sat, 16 Dec
 2006 13:37:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030905AbWLPMgq (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 07:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030909AbWLPMgq
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 07:36:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:50202 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1030905AbWLPMgp
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006 07:36:45 -0500
Received: (qmail invoked by alias); 16 Dec 2006 12:36:43 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp019) with SMTP; 16 Dec 2006 13:36:43 +0100
To: git@vger.kernel.org, junkio@cox.net
Sender: git-owner@vger.kernel.org


If you want to verify a ref, it is overkill to first read all loose refs
into a linked list, and then check if the desired ref is there.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	This is kind of quick and dirty.

	An alternative would be to pack the tags _per default_. I once
	argued for that, but it appears nobody liked that idea. I even
	proposed to pack _all_ refs, and I still think this would be
	a good idea.

	However, HTTP/FTP transport would have to learn about that long
	before, and/or a config option would be needed to allow public
	repos to cater for older clients.

	Isn't it a bug that --verify succeeds, if only _one_ ref passed to 
	the command exists?

 builtin-show-ref.c |   14 +++++++++++++-
 refs.c             |   17 +++++++++++------
 refs.h             |    1 +
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/builtin-show-ref.c b/builtin-show-ref.c
index 0739798..b57b074 100644
--- a/builtin-show-ref.c
+++ b/builtin-show-ref.c
@@ -157,7 +157,19 @@ int cmd_show_ref(int argc, const char **argv, const char *prefix)
 	}
 	if (show_head)
 		head_ref(show_ref, NULL);
-	for_each_ref(show_ref, NULL);
+	if (verify) {
+		for (i = 0; pattern[i]; i++)
+			if (!access(git_path(pattern[i]), R_OK)) {
+				unsigned char sha1[20];
+				if (resolve_ref(pattern[i], sha1, 1, NULL)) {
+					found_match++;
+					printf("%s %s\n", sha1_to_hex(sha1),
+							pattern[i]);
+				}
+			}
+		for_each_packed_ref(show_ref, NULL);
+	} else
+		for_each_ref(show_ref, NULL);
 	if (!found_match) {
 		if (verify && !quiet)
 			die("No match");
diff --git a/refs.c b/refs.c
index a02957c..7e6a459 100644
--- a/refs.c
+++ b/refs.c
@@ -413,11 +413,11 @@ int peel_ref(const char *ref, unsigned char *sha1)
 }
 
 static int do_for_each_ref(const char *base, each_ref_fn fn, int trim,
-			   void *cb_data)
+			   void *cb_data, int packed_only)
 {
 	int retval;
 	struct ref_list *packed = get_packed_refs();
-	struct ref_list *loose = get_loose_refs();
+	struct ref_list *loose = packed_only ? NULL : get_loose_refs();
 
 	while (packed && loose) {
 		struct ref_list *entry;
@@ -456,24 +456,29 @@ int head_ref(each_ref_fn fn, void *cb_data)
 	return 0;
 }
 
+int for_each_packed_ref(each_ref_fn fn, void *cb_data)
+{
+	return do_for_each_ref("refs/", fn, 0, cb_data, 1);
+}
+
 int for_each_ref(each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref("refs/", fn, 0, cb_data);
+	return do_for_each_ref("refs/", fn, 0, cb_data, 0);
 }
 
 int for_each_tag_ref(each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref("refs/tags/", fn, 10, cb_data);
+	return do_for_each_ref("refs/tags/", fn, 10, cb_data, 0);
 }
 
 int for_each_branch_ref(each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref("refs/heads/", fn, 11, cb_data);
+	return do_for_each_ref("refs/heads/", fn, 11, cb_data, 0);
 }
 
 int for_each_remote_ref(each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref("refs/remotes/", fn, 13, cb_data);
+	return do_for_each_ref("refs/remotes/", fn, 13, cb_data, 0);
 }
 
 /* NEEDSWORK: This is only used by ssh-upload and it should go; the
diff --git a/refs.h b/refs.h
index 51aab1e..0cfe7b5 100644
--- a/refs.h
+++ b/refs.h
@@ -19,6 +19,7 @@ struct ref_lock {
  */
 typedef int each_ref_fn(const char *refname, const unsigned char *sha1, int flags, void *cb_data);
 extern int head_ref(each_ref_fn, void *);
+extern int for_each_packed_ref(each_ref_fn, void *);
 extern int for_each_ref(each_ref_fn, void *);
 extern int for_each_tag_ref(each_ref_fn, void *);
