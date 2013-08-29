From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 7/9] apply: add --stage option
Date: Thu, 29 Aug 2013 13:14:38 -0500
Message-ID: <1377800080-5309-8-git-send-email-felipe.contreras@gmail.com>
References: <20130829180129.GA4880@nysa>
 <1377800080-5309-1-git-send-email-felipe.contreras@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 29 20:20:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF6pr-00058J-2T
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 20:20:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756648Ab3H2SUo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 14:20:44 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:59979 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756283Ab3H2SUn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 14:20:43 -0400
Received: by mail-ob0-f169.google.com with SMTP id es8so878749obc.28
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 11:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nDgyhO92KPcP+vVZsDDB4EnnCZZwqSs7IMonFod7jP8=;
        b=ZAG5YJDlgEa0ZmDXEm9c4AceHsHMBkJSHX+HjzdOddTjuH40+8C/Il0gX46C7ODj3N
         9cWM5AGERc+JIO3Z+3NFLyh9XiUqvFT5LVQ47o8n1cnj9t2AQ5hVeNFZaCB+FA90Ldjm
         fOgrWt17g9p/8sjVFIgYSjVzMQGTQrTXXtW0++XnsVjVy9tIQrGgTWfkzcVqaj+ZJj/6
         ln0UqAPGBECO6OyNhnSNCDuQ7ve2PUtKAWg23nnieTpi3ZXuSHRcmMCHVe+/L2t/HYNW
         lMYIVkaXm5kSYCBNQqQ8gTF5hTR1juVpaK3JTNG5rQnAeCS+4WjX0KkVkRpWiq6kxNOo
         9vnw==
X-Received: by 10.182.66.82 with SMTP id d18mr3488299obt.98.1377800443568;
        Thu, 29 Aug 2013 11:20:43 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id s14sm33758786oeo.1.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 11:20:42 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377800080-5309-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233316>

Synonym for --index.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-apply.txt | 5 ++++-
 builtin/apply.c             | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index f605327..ce44327 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git apply' [--stat] [--numstat] [--summary] [--check] [--index] [--3way]
 	  [--apply] [--no-add] [--build-fake-ancestor=<file>] [-R | --reverse]
 	  [--allow-binary-replacement | --binary] [--reject] [-z]
-	  [-p<n>] [-C<n>] [--inaccurate-eof] [--recount] [--cached]
+	  [-p<n>] [-C<n>] [--inaccurate-eof] [--recount] [--cached|--staged]
 	  [--ignore-space-change | --ignore-whitespace ]
 	  [--whitespace=(nowarn|warn|fix|error|error-all)]
 	  [--exclude=<path>] [--include=<path>] [--directory=<root>]
@@ -67,6 +67,9 @@ OPTIONS
 	up-to-date, it is flagged as an error.  This flag also
 	causes the index file to be updated.
 
+--staged::
+	Synonym for --index.
+
 --cached::
 	Apply a patch without touching the working tree. Instead take the
 	cached data, apply the patch, and store the result in the index
diff --git a/builtin/apply.c b/builtin/apply.c
index 50912c9..42b5a4b 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4377,6 +4377,8 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			N_("instead of applying the patch, see if the patch is applicable")),
 		OPT_BOOLEAN(0, "index", &check_index,
 			N_("make sure the patch is applicable to the current index")),
+		OPT_BOOLEAN(0, "stage", &check_index,
+			N_("make sure the patch is applicable to the current index")),
 		OPT_BOOLEAN(0, "cached", &cached,
 			N_("apply a patch without touching the working tree")),
 		OPT_BOOLEAN(0, "apply", &force_apply,
-- 
1.8.4-fc
