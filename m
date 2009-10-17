From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] describe: load refnames before calling describe()
Date: Sat, 17 Oct 2009 18:30:48 +0200
Message-ID: <4AD9F138.3080405@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 17 18:31:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzCBU-0004jF-5d
	for gcvg-git-2@lo.gmane.org; Sat, 17 Oct 2009 18:31:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752387AbZJQQaz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Oct 2009 12:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751888AbZJQQay
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Oct 2009 12:30:54 -0400
Received: from india601.server4you.de ([85.25.151.105]:36767 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751828AbZJQQay (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Oct 2009 12:30:54 -0400
Received: from [10.0.1.101] (p57B7C517.dip.t-dialin.net [87.183.197.23])
	by india601.server4you.de (Postfix) with ESMTPSA id D0B122F803D;
	Sat, 17 Oct 2009 18:30:56 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130563>

Get rid of the static variable that was used to prevent loading all
the refnames multiple times by moving that code out of describe(),
simply making sure it is only run once that way.

Also change the error message that is shown in case no refnames are
found to not include a hash any more, as the error condition is not
specific to any particular revision.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 builtin-describe.c |   13 ++++---------
 1 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/builtin-describe.c b/builtin-describe.c
index df67a73..2dcfd3d 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -180,7 +180,6 @@ static void describe(const char *arg, int last_one)
 	unsigned char sha1[20];
 	struct commit *cmit, *gave_up_on = NULL;
 	struct commit_list *list;
-	static int initialized = 0;
 	struct commit_name *n;
 	struct possible_tag all_matches[MAX_TAGS];
 	unsigned int match_cnt = 0, annotated_cnt = 0, cur_match;
@@ -192,14 +191,6 @@ static void describe(const char *arg, int last_one)
 	if (!cmit)
 		die("%s is not a valid '%s' object", arg, commit_type);
 
-	if (!initialized) {
-		initialized = 1;
-		for_each_ref(get_name, NULL);
-	}
-
-	if (!found_names)
-		die("cannot describe '%s'", sha1_to_hex(sha1));
-
 	n = cmit->util;
 	if (n) {
 		/*
@@ -359,6 +350,10 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 		return cmd_name_rev(i + argc, args, prefix);
 	}
 
+	for_each_ref(get_name, NULL);
+	if (!found_names)
+		die("No names found, cannot describe anything.");
+
 	if (argc == 0) {
 		describe("HEAD", 1);
 	} else {
-- 
1.6.5
