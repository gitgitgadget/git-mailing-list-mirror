From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Fix potentially dangerous uses of mkpath and git_path
Date: Sun, 26 Oct 2008 23:08:52 +0100
Message-ID: <20081026220852.GC18594@blimp.localdomain>
References: <20081026215913.GA18594@blimp.localdomain>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 26 23:10:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuDoG-0006Jx-C3
	for gcvg-git-2@gmane.org; Sun, 26 Oct 2008 23:10:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752461AbYJZWIz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2008 18:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752416AbYJZWIz
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Oct 2008 18:08:55 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:53019 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752382AbYJZWIz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2008 18:08:55 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :Pm0FVUW6aauhRGJJc5OfA4AU8DM8ZlijdmJYxKn/UQvEQQx8AE81pE/a
Received: from tigra.home (Fab75.f.strato-dslnet.de [195.4.171.117])
	by post.webmailer.de (mrclete mo64) (RZmta 17.14)
	with ESMTP id t00e4ck9QKq8je ; Sun, 26 Oct 2008 23:08:53 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp.localdomain (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 08C7A277C8;
	Sun, 26 Oct 2008 23:08:53 +0100 (CET)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id BA94F36D27; Sun, 26 Oct 2008 23:08:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081026215913.GA18594@blimp.localdomain>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99188>

Replace them  with mksnpath/git_snpath and a local buffer
for the resulting string.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 builtin-apply.c        |    4 ++--
 builtin-for-each-ref.c |    6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index cfd8fce..4c4d1e1 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2841,8 +2841,8 @@ static void create_one_file(char *path, unsigned mode, const char *buf, unsigned
 		unsigned int nr = getpid();
 
 		for (;;) {
-			const char *newpath;
-			newpath = mkpath("%s~%u", path, nr);
+			char newpath[PATH_MAX];
+			mksnpath(newpath, sizeof(newpath), "%s~%u", path, nr);
 			if (!try_create_file(newpath, mode, buf, size)) {
 				if (!rename(newpath, path))
 					return;
diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index fa6c1ed..e46b7ad 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -620,14 +620,16 @@ static char *get_short_ref(struct refinfo *ref)
 		for (j = 0; j < i; j++) {
 			const char *rule = ref_rev_parse_rules[j];
 			unsigned char short_objectname[20];
+			char refname[PATH_MAX];
 
 			/*
 			 * the short name is ambiguous, if it resolves
 			 * (with this previous rule) to a valid ref
 			 * read_ref() returns 0 on success
 			 */
-			if (!read_ref(mkpath(rule, short_name_len, short_name),
-				      short_objectname))
+			mksnpath(refname, sizeof(refname),
+				 rule, short_name_len, short_name);
+			if (!read_ref(refname, short_objectname))
 				break;
 		}
 
-- 
1.6.0.3.540.g3f8b
