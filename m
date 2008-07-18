From: Nick Andrew <nick@nick-andrew.net>
Subject: [PATCH] Enable git rev-list to parse --quiet
Date: Fri, 18 Jul 2008 14:05:00 +1000
Message-ID: <20080718040459.13073.76896.stgit@marcab.local.tull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 18 06:49:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJhu1-0008Db-6M
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 06:49:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbYGREsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 00:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbYGREsJ
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 00:48:09 -0400
Received: from vps1.tull.net ([66.180.172.116]:57771 "HELO vps1.tull.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751284AbYGREsI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 00:48:08 -0400
Received: (qmail 16354 invoked by uid 1015); 18 Jul 2008 14:48:07 +1000
Received: from [10.0.0.67] (HELO mail.local.tull.net) (10.0.0.67) by vps1.tull.net (qpsmtpd/0.26) with SMTP; Fri, 18 Jul 2008 14:48:07 +1000
Received: (qmail 16141 invoked by uid 1015); 18 Jul 2008 14:48:05 +1000
X-Spam-Status: No, hits=-3.4 required=5.0	tests=ALL_TRUSTED,AWL,BAYES_00
X-Spam-Check-By: mail.local.tull.net
Received: from [10.0.0.1] (HELO marcab.local.tull.net) (10.0.0.1)    by mail.local.tull.net (qpsmtpd/0.40) with SMTP; Fri, 18 Jul 2008 14:47:59 +1000
Received: by marcab.local.tull.net (sSMTP sendmail emulation); Fri, 18 Jul 2008 14:47:58 +1000
Mail-From: nobody Fri Jul 18 14:05:00 2008
User-Agent: StGIT/0.14.2
X-SMTPD: qpsmtpd/0.26, http://develooper.com/code/qpsmtpd/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88982>

Enable git rev-list to parse --quiet

git rev-list never sees the --quiet option because --quiet is
also an option for diff-files.

Example:

$ ./git rev-list --quiet ^HEAD~2 HEAD
1e102bf7c83281944ffd9202a7d35c514e4a5644
3bf0dd1f4e75ee1591169b687ce04dff00ae2e3e
$ echo $?
0

The fix scans the argument list to detect --quiet before passing it
to setup_revisions(). It also arranges to count the number of commits
or objects (whether sent to STDOUT or not) so --quiet can return an
appropriate exit code (1 if there were commits/objects, 0 otherwise).

After fix:

$ ./git rev-list --quiet ^HEAD~2 HEAD
$ echo $?
1
---

 builtin-rev-list.c |   28 ++++++++++++++++++++++++----
 1 files changed, 24 insertions(+), 4 deletions(-)


diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 8e1720c..e2e5e13 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -52,6 +52,11 @@ static const char rev_list_usage[] =
 
 static struct rev_info revs;
 
+/* Count of number of commits or objects noticed (even if not output).
+ * Used by --quiet option to set an appropriate exit status.
+ */
+static int seen_count;
+
 static int bisect_list;
 static int show_timestamp;
 static int hdr_termination;
@@ -167,12 +172,14 @@ static void finish_commit(struct commit *commit)
 	}
 	free(commit->buffer);
 	commit->buffer = NULL;
+	seen_count++;
 }
 
 static void finish_object(struct object_array_entry *p)
 {
 	if (p->item->type == OBJ_BLOB && !has_sha1_file(p->item->sha1))
 		die("missing blob object '%s'", sha1_to_hex(p->item->sha1));
+	seen_count++;
 }
 
 static void show_object(struct object_array_entry *p)
@@ -588,6 +595,17 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	init_revisions(&revs, prefix);
 	revs.abbrev = 0;
 	revs.commit_format = CMIT_FMT_UNSPECIFIED;
+
+	/* Parse options which are also recognised by git-diff-files */
+	for (i = 1 ; i < argc; i++) {
+		const char *arg = argv[i];
+
+		if (!strcmp(arg, "--quiet")) {
+			quiet = 1;
+			continue;
+		}
+	}
+
 	argc = setup_revisions(argc, argv, &revs, NULL);
 
 	for (i = 1 ; i < argc; i++) {
@@ -621,10 +639,6 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			read_revisions_from_stdin(&revs);
 			continue;
 		}
-		if (!strcmp(arg, "--quiet")) {
-			quiet = 1;
-			continue;
-		}
 		usage(rev_list_usage);
 
 	}
@@ -700,9 +714,15 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		}
 	}
 
+	seen_count = 0;
+
 	traverse_commit_list(&revs,
 		quiet ? finish_commit : show_commit,
 		quiet ? finish_object : show_object);
 
+	if (quiet) {
+		return seen_count ? 1 : 0;
+	}
+
 	return 0;
 }
