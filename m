From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 4/4] dir: revert work-around for retired dangerous behavior
Date: Tue, 17 Sep 2013 03:06:17 -0400
Message-ID: <1379401577-36799-5-git-send-email-sunshine@sunshineco.com>
References: <1379401577-36799-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 17 09:06:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLpNC-0002IA-KO
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 09:06:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752123Ab3IQHGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 03:06:51 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:46904 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751963Ab3IQHGs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 03:06:48 -0400
Received: by mail-oa0-f48.google.com with SMTP id i10so926289oag.35
        for <git@vger.kernel.org>; Tue, 17 Sep 2013 00:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=owjBeqCIKutla1cdFmEirck4X7VzF+ajPyl/C+23PqY=;
        b=Y5BrNIsHCsxno7nya+TaJs7cIVtss1ClyU7WdzcQdYucBuEsGdM+JLCPismoqamAjq
         NvDzLaah7HQqRv4TxA1zph2kRbWu5gSe5N37Qfz1uShOtZFSZnQHF0D5wNZ6KoCctIbT
         +P/UO/5Qz7kF97nTox8Lg+CVFZvEYIyTuVj1RvWtfhLHLwnFSzQcJa1f8pTswPF4nm4N
         xUWbvEA4xPJ6u87pe5d6Z44gWrBrwk/zW/TxWWbps2Ol8wVeoGtwHGHP++jz6aivLbRq
         eFDxeA/BL6p2bty4wnltEBaSI5H+xJ2KlAz7ituDgaLLZxGungkNnVphhAcqt7nw6t5+
         f+4A==
X-Received: by 10.60.131.232 with SMTP id op8mr205449oeb.75.1379401607370;
        Tue, 17 Sep 2013 00:06:47 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dr8.cable.mindspring.com. [69.81.183.104])
        by mx.google.com with ESMTPSA id d8sm37304079oeu.6.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 17 Sep 2013 00:06:46 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.535.g7b94f8e
In-Reply-To: <1379401577-36799-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234856>

directory_exists_in_index_icase() dangerously assumed that it could
access one character beyond the end of its directory argument, and that
that character would unconditionally be '/'.  2eac2a4c (ls-files -k: a
directory only can be killed if the index has a non-directory,
2013-08-15) added a caller which did not respect this undocumented
assumption, and 680be044 (dir.c::test_one_path(): work around
directory_exists_in_index_icase() breakage, 2013-08-23) added a
work-around which temporarily appends a '/' before invoking
directory_exists_in_index_icase().

Since the dangerous behavior of directory_exists_in_index_icase() has
been eliminated, the work-around is now redundant, so retire it (but not
the tests added by the same commit).

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 dir.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/dir.c b/dir.c
index fccd479..23b6de4 100644
--- a/dir.c
+++ b/dir.c
@@ -1160,21 +1160,9 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 	 */
 	if ((dir->flags & DIR_COLLECT_KILLED_ONLY) &&
 	    (dtype == DT_DIR) &&
-	    !has_path_in_index) {
-		/*
-		 * NEEDSWORK: directory_exists_in_index_icase()
-		 * assumes that one byte past the given path is
-		 * readable and has '/', which needs to be fixed, but
-		 * until then, work it around in the caller.
-		 */
-		strbuf_addch(path, '/');
-		if (directory_exists_in_index(path->buf, path->len - 1) ==
-		    index_nonexistent) {
-			strbuf_setlen(path, path->len - 1);
-			return path_none;
-		}
-		strbuf_setlen(path, path->len - 1);
-	}
+	    !has_path_in_index &&
+	    (directory_exists_in_index(path->buf, path->len) == index_nonexistent))
+		return path_none;
 
 	exclude = is_excluded(dir, path->buf, &dtype);
 
-- 
1.8.4.535.g7b94f8e
