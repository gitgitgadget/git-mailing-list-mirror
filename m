From: "Eric Raible" <raible@gmail.com>
Subject: PATCH: allow ':/<oneline prefix>' notation to specify a specific file
Date: Thu, 3 Jul 2008 01:52:45 -0700
Message-ID: <279b37b20807030152g13492d5dxf21367ab17719993@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 14:53:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEOIn-0005Az-4D
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 14:52:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759851AbYGCMlo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 08:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759846AbYGCMlo
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 08:41:44 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:58798 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759834AbYGCMln (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 08:41:43 -0400
Received: by wf-out-1314.google.com with SMTP id 27so777464wfd.4
        for <git@vger.kernel.org>; Thu, 03 Jul 2008 05:41:43 -0700 (PDT)
Received: by 10.143.30.16 with SMTP id h16mr3488161wfj.44.1215075165360;
        Thu, 03 Jul 2008 01:52:45 -0700 (PDT)
Received: by 10.142.14.12 with HTTP; Thu, 3 Jul 2008 01:52:45 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87282>

Although the rev-parse documentation claims that the tree-ish:path/to/file
syntax is applicable to all tree-ish forms this is not so when using the
:/ "oneline prefix" syntax introduced in v1.5.0.1-227-g28a4d94.

This patch allows git show ":/PATCH: allow":sha1_name.c to show the
change to the file changed by this patch.

Signed-off-by: Eric Raible <raible@gmail.com>
---
 sha1_name.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index b0b2167..a1acfcd 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -684,6 +684,7 @@ int get_sha1_with_mode(const char *name, unsigned
char *sha1, unsigned *mode)
 	int ret, bracket_depth;
 	int namelen = strlen(name);
 	const char *cp;
+	char *copy, *colon;

 	*mode = S_IFINVALID;
 	ret = get_sha1_1(name, namelen, sha1);
@@ -697,8 +698,18 @@ int get_sha1_with_mode(const char *name, unsigned
char *sha1, unsigned *mode)
 		int stage = 0;
 		struct cache_entry *ce;
 		int pos;
-		if (namelen > 2 && name[1] == '/')
-			return get_sha1_oneline(name + 2, sha1);
+		if (namelen > 2 && name[1] == '/') {
+			name += 2;
+			colon = strrchr(name, ':');
+			if (!get_sha1_oneline(name, sha1) || !colon)
+				return 0;
+			copy = xstrdup(name);
+			*(colon = strrchr(copy, ':')) = '\0';
+			ret = get_sha1_oneline(copy, sha1) ||
+				get_tree_entry(sha1, colon+1, sha1, mode);
+			free(copy);
+			return ret;
+		}
 		if (namelen < 3 ||
 		    name[2] != ':' ||
 		    name[1] < '0' || '3' < name[1])
-- 
1.5.6.1.1356.g3be5f.dirty
