From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= <Uwe.Kleine-Koenig@digi.com>
Subject: [PATCH] rev-list: add --branches, --tags and --remotes
Date: Thu, 28 Feb 2008 08:24:25 +0100
Message-ID: <1204183465-1991-1-git-send-email-Uwe.Kleine-Koenig@digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 28 08:25:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUd8w-0004IK-EP
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 08:25:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753163AbYB1HYq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Feb 2008 02:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753294AbYB1HYq
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 02:24:46 -0500
Received: from mail29.messagelabs.com ([216.82.249.147]:36152 "HELO
	mail29.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753163AbYB1HYp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 02:24:45 -0500
X-VirusChecked: Checked
X-Env-Sender: Uwe.Kleine-Koenig@digi.com
X-Msg-Ref: server-11.tower-29.messagelabs.com!1204183484!7107568!1
X-StarScan-Version: 5.5.12.14.2; banners=-,-,-
X-Originating-IP: [66.77.174.21]
Received: (qmail 18206 invoked from network); 28 Feb 2008 07:24:44 -0000
Received: from unknown (HELO owa.digi.com) (66.77.174.21)
  by server-11.tower-29.messagelabs.com with SMTP; 28 Feb 2008 07:24:44 -0000
Received: from mtk-sms-mail01.digi.com ([10.10.8.120]) by owa.digi.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 28 Feb 2008 01:24:44 -0600
Received: from dor-sms-mail1.digi.com ([10.49.1.105]) by mtk-sms-mail01.digi.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 28 Feb 2008 01:24:27 -0600
Received: from zentaur.digi.com ([10.100.10.144]) by dor-sms-mail1.digi.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 28 Feb 2008 08:24:25 +0100
Received: by zentaur.digi.com (Postfix, from userid 1080)
	id 18A1C2AA08; Thu, 28 Feb 2008 08:24:25 +0100 (CET)
X-Mailer: git-send-email 1.5.4.3
X-OriginalArrivalTime: 28 Feb 2008 07:24:25.0372 (UTC) FILETIME=[F2391DC0:01C879DA]
X-TM-AS-Product-Ver: SMEX-8.0.0.1181-5.000.1023-15756.002
X-TM-AS-Result: No--6.173900-8.000000-31
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75363>

These flags are already known to rev-parse and have the same meaning.

This patch allows to run gitk as follows:

	gitk --branches --not --remotes

to show only your local work.

Signed-off-by: Uwe Kleine-K=C3=B6nig <Uwe.Kleine-Koenig@digi.com>
---
Hello,

I'm not sure that I catched all locations where to add these three new
options.  Maybe I missed something in the docs?

Best regards
Uwe

 Documentation/git-rev-list.txt |    3 +++
 builtin-rev-list.c             |    3 +++
 revision.c                     |   19 ++++++++++++++++---
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-lis=
t.txt
index a8d489f..d80cdf5 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -20,6 +20,9 @@ SYNOPSIS
 	     [ \--full-history ]
 	     [ \--not ]
 	     [ \--all ]
+	     [ \--branches ]
+	     [ \--tags ]
+	     [ \--remotes ]
 	     [ \--stdin ]
 	     [ \--quiet ]
 	     [ \--topo-order ]
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 6f7d5f8..6754e7f 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -25,6 +25,9 @@ static const char rev_list_usage[] =3D
 "    --no-merges\n"
 "    --remove-empty\n"
 "    --all\n"
+"    --branches\n"
+"    --tags\n"
+"    --remotes\n"
 "    --stdin\n"
 "    --quiet\n"
 "  ordering output:\n"
diff --git a/revision.c b/revision.c
index 84fbdd3..0eb6faa 100644
--- a/revision.c
+++ b/revision.c
@@ -633,12 +633,13 @@ static int handle_one_ref(const char *path, const=
 unsigned char *sha1, int flag,
 	return 0;
 }
=20
-static void handle_all(struct rev_info *revs, unsigned flags)
+static void handle_refs(struct rev_info *revs, unsigned flags,
+		int (*for_each)(each_ref_fn, void *))
 {
 	struct all_refs_cb cb;
 	cb.all_revs =3D revs;
 	cb.all_flags =3D flags;
-	for_each_ref(handle_one_ref, &cb);
+	for_each(handle_one_ref, &cb);
 }
=20
 static void handle_one_reflog_commit(unsigned char *sha1, void *cb_dat=
a)
@@ -1015,7 +1016,19 @@ int setup_revisions(int argc, const char **argv,=
 struct rev_info *revs, const ch
 				continue;
 			}
 			if (!strcmp(arg, "--all")) {
-				handle_all(revs, flags);
+				handle_refs(revs, flags, for_each_ref);
+				continue;
+			}
+			if (!strcmp(arg, "--branches")) {
+				handle_refs(revs, flags, for_each_branch_ref);
+				continue;
+			}
+			if (!strcmp(arg, "--tags")) {
+				handle_refs(revs, flags, for_each_tag_ref);
+				continue;
+			}
+			if (!strcmp(arg, "--remotes")) {
+				handle_refs(revs, flags, for_each_remote_ref);
 				continue;
 			}
 			if (!strcmp(arg, "--first-parent")) {
--=20
1.5.4.3
