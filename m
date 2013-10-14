From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 04/14] grep: add --staged option
Date: Mon, 14 Oct 2013 17:29:16 -0500
Message-ID: <1381789769-9893-2-git-send-email-felipe.contreras@gmail.com>
References: <1381789769-9893-1-git-send-email-felipe.contreras@gmail.com>
Cc: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	William Swanson <swansontec@gmail.com>,
	Ping Yin <pkufranky@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 15 00:35:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVqjs-000719-Gj
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 00:35:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757553Ab3JNWfn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 18:35:43 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:43944 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756848Ab3JNWfm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 18:35:42 -0400
Received: by mail-oa0-f51.google.com with SMTP id h16so5074096oag.38
        for <git@vger.kernel.org>; Mon, 14 Oct 2013 15:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UIdvBSn4Is8qAm3qcPwEf3WNN7J0O/sZOcL2cL44RP4=;
        b=qw5RdASQjTMlcJb5rVe6MprleeXfxOIW6HrGXw1eFzDPeJ7FQxgz2GNYeyMyQ2JIny
         aA+wO7mwEWNLn5LwS4PV1TABabBBCjyyfFvI0/jWRF7s7/F/QzrmgiHKj8uPuV+jCTgv
         sf4U2AqijRbT6EXKyj3buzp2nG3Cng6sk/ZyJoCo1OjhwF8yQ7nf0LEtIlyL+NoLzO9E
         w6IPUM/q4rhbVcymhBBTUhSIuEcR2O4BLRnQc4Ud6h5ZDFhMEk9RE42qe4yCFtvexKoD
         ge09yuot0rfgGviSNdXBXL85YONWPXBHcYX9AL5dDQmdLXQWeM4dwwsEXNeQTTQUpY3w
         Fu5Q==
X-Received: by 10.60.173.205 with SMTP id bm13mr29991244oec.25.1381790142115;
        Mon, 14 Oct 2013 15:35:42 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id nw5sm44542358obc.9.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 14 Oct 2013 15:35:41 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381789769-9893-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236130>

Synonym for --cached.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-grep.txt | 5 ++++-
 builtin/grep.c             | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 8497aa4..9f7899c 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -25,7 +25,7 @@ SYNOPSIS
 	   [-W | --function-context]
 	   [-f <file>] [-e] <pattern>
 	   [--and|--or|--not|(|)|-e <pattern>...]
-	   [ [--[no-]exclude-standard] [--cached | --no-index | --untracked] | <tree>...]
+	   [ [--[no-]exclude-standard] [--cached | --staged | --no-index | --untracked] | <tree>...]
 	   [--] [<pathspec>...]
 
 DESCRIPTION
@@ -60,6 +60,9 @@ OPTIONS
 	Instead of searching tracked files in the working tree, search
 	blobs registered in the index file.
 
+--staged::
+	Synonym for `--cached`.
+
 --no-index::
 	Search files in the current directory that is not managed by Git.
 
diff --git a/builtin/grep.c b/builtin/grep.c
index d3b3b1d..b953911 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -640,6 +640,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_BOOLEAN(0, "cached", &cached,
 			N_("search in index instead of in the work tree")),
+		OPT_BOOLEAN(0, "staged", &cached,
+			N_("search in index instead of in the work tree")),
 		OPT_NEGBIT(0, "no-index", &use_index,
 			 N_("find in contents not managed by git"), 1),
 		OPT_BOOLEAN(0, "untracked", &untracked,
-- 
1.8.4-fc
