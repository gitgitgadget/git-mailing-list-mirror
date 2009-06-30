From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] git-mv: fix directory separator treatment on Windows
Date: Tue, 30 Jun 2009 15:33:57 +0200
Message-ID: <4A4A1445.6090704@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 15:34:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLdTT-0004bY-Ie
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 15:34:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752464AbZF3NeE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 09:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752229AbZF3NeE
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 09:34:04 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:16512 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019AbZF3NeD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 09:34:03 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MLdTE-0003zF-Pb; Tue, 30 Jun 2009 15:34:01 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 438CE795; Tue, 30 Jun 2009 15:33:58 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122512>

From: Johannes Sixt <j6t@kdbg.org>

The following invocations did not work as expected on Windows:

    git mv foo\bar dest
    git mv foo\ dest

The first command was interpreted as

    git mv foo/bar dest/foo/bar

because the Windows style directory separator was not obeyed when the
basename of 'foo\bar' was computed.

The second command failed because the Windows style directory separator was
not removed from the source directory, whereupon the lookup of the
directory in the index failed.

This fixes both issues by using is_dir_sep() and basename().

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 builtin-mv.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/builtin-mv.c b/builtin-mv.c
index 8b81d4b..68f4738 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -24,14 +24,10 @@ static const char **copy_pathspec(const char *prefix,
 	result[count] = NULL;
 	for (i = 0; i < count; i++) {
 		int length = strlen(result[i]);
-		if (length > 0 && result[i][length - 1] == '/') {
+		if (length > 0 && is_dir_sep(result[i][length - 1]))
 			result[i] = xmemdupz(result[i], length - 1);
-		}
-		if (base_name) {
-			const char *last_slash = strrchr(result[i], '/');
-			if (last_slash)
-				result[i] = last_slash + 1;
-		}
+		if (base_name)
+			result[i] = basename((char *)result[i]);
 	}
 	return get_pathspec(prefix, result);
 }
-- 
1.6.3.3.1337.g9661167.dirty
