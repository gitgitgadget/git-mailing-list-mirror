From: Imre Deak <imre.deak@gmail.com>
Subject: [PATCH] builtin-apply: check for empty files when detecting creation patch
Date: Thu,  8 May 2008 17:39:39 +0300
Message-ID: <1210257579-30975-1-git-send-email-imre.deak@gmail.com>
Cc: imre.deak@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 08 16:40:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ju7IP-000174-RB
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 16:40:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752327AbYEHOjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 10:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753114AbYEHOjo
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 10:39:44 -0400
Received: from hu-out-0506.google.com ([72.14.214.234]:41715 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327AbYEHOjm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 10:39:42 -0400
Received: by hu-out-0506.google.com with SMTP id 19so949569hue.21
        for <git@vger.kernel.org>; Thu, 08 May 2008 07:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=/03CiAtqZTr3INQ1pspp2yBClMThWI9uf0DSPJdYr4w=;
        b=lCFBw4pGYZOotZIfkMbwVbo53MRV8ljYhrmXBnPb9dVmoCImbyG/yMLjVbDRwgoGHLI0U6rU/tuwWP29zKZGDrvwEQfXn+uuWRpK5zHKtbjNFS54r1w/wDJ1lmOvdQeapAYG9O5Bjyxu4C3x7rGo0B9ff9TEaduqMfPgwgYKlBk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=uu1d/QcUYPl5s9Q8e8LRXfkzHzbQBwAq/gpYAptscVG1g3WzlJs141UKVgKrfVeO0XXGpoVfnIbwgGT3WGkFbLY7q7Nh+mOQ1FCyxw/bsiXphqystW7K4qyqAL2Hw2PeOZRApLKgrzEDlHQH+zDd/seqUzTDuumLSjJ7FwC0tXE=
Received: by 10.210.56.10 with SMTP id e10mr3217862eba.20.1210257581303;
        Thu, 08 May 2008 07:39:41 -0700 (PDT)
Received: from localhost ( [212.213.55.210])
        by mx.google.com with ESMTPS id z37sm4508900ikz.6.2008.05.08.07.39.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 08 May 2008 07:39:40 -0700 (PDT)
X-Mailer: git-send-email 1.5.4.2.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81531>

When we can only guess if we have a creation patch, we do
this by treating the patch as such if there weren't any old
lines. Zero length files can be patched without old lines
though, so do an extra check for file size.

Signed-off-by: Imre Deak <imre.deak@gmail.com>
---
 builtin-apply.c |   34 +++++++++++++++++++++++++++++++++-
 1 files changed, 33 insertions(+), 1 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index caa3f2a..80d0779 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1096,6 +1096,33 @@ static int parse_fragment(char *line, unsigned long size,
 	return offset;
 }
 
+static size_t existing_file_size(const char *file)
+{
+	size_t st_size = -1;
+
+	if (file == NULL)
+		return -1;
+
+	if (cached) {
+		struct cache_entry *ce;
+		int pos;
+
+		pos = cache_name_pos(file, strlen(file));
+		if (pos < 0)
+			return -1;
+		ce = active_cache[pos];
+		st_size = ntohl(ce->ce_size);
+	} else {
+		struct stat st;
+
+		if (lstat(file, &st) < 0)
+			return -1;
+		st_size = st.st_size;
+	}
+
+	return st_size;
+}
+
 static int parse_single_patch(char *line, unsigned long size, struct patch *patch)
 {
 	unsigned long offset = 0;
@@ -1143,13 +1170,18 @@ static int parse_single_patch(char *line, unsigned long size, struct patch *patc
 	if (patch->is_delete < 0 &&
 	    (newlines || (patch->fragments && patch->fragments->next)))
 		patch->is_delete = 0;
+	/* FIXME: How can be there context if it's a creation / deletion? */
 	if (!unidiff_zero || context) {
 		/* If the user says the patch is not generated with
 		 * --unified=0, or if we have seen context lines,
 		 * then not having oldlines means the patch is creation,
 		 * and not having newlines means the patch is deletion.
+		 *
+		 * It's also possible that a zero length file is added
+		 * to.
 		 */
-		if (patch->is_new < 0 && !oldlines) {
+		if (patch->is_new < 0 && !oldlines &&
+		    existing_file_size(patch->old_name) != 0) {
 			patch->is_new = 1;
 			patch->old_name = NULL;
 		}
-- 
1.5.4.2.dirty
