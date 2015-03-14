From: John Szakmeister <john@szakmeister.net>
Subject: [PATCH] contrib/completion: escape the forward slash in __git_match_ctag
Date: Sat, 14 Mar 2015 09:40:39 -0400
Message-ID: <1426340439-7171-1-git-send-email-john@szakmeister.net>
Cc: John Szakmeister <john@szakmeister.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 14 14:40:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWmJC-0007DA-9I
	for gcvg-git-2@plane.gmane.org; Sat, 14 Mar 2015 14:40:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752800AbbCNNks (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2015 09:40:48 -0400
Received: from mail-qc0-f180.google.com ([209.85.216.180]:35224 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752730AbbCNNkr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2015 09:40:47 -0400
Received: by qcbkw5 with SMTP id kw5so10355963qcb.2
        for <git@vger.kernel.org>; Sat, 14 Mar 2015 06:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=6heBnqGINuST5L55IflVIPL2UK1YlJndcQg9jl+RYPE=;
        b=c0O+DCJp6n9qQzRGf9rHLDLdUVkfLWA8GgN9kISQPYcmO10HyptkON949bNX+2w3K4
         xp477HKyYe6XSv3L0JIR0ebxsP+Z/BmizC4MaXiSpx1ZGQw3VkpCA8tRptaZqhQ7GrMm
         iLFXNyBrpFB016DrKIVh3lViztXdzqjELge9ya4QHNtYeHzbN7gAQm6uhioGI0p1ukj0
         QzqJt/XONO+IlBMrYSRZRzNv+HIgCGWAsvX08fxdyEok9fe6OQPXK4pomQPiCd1uLtSY
         fEyayqBDv75VQ2fpdFBXVISZmnuN4RNNTquZB0a7X5/W9B14GvoXU6dFq0AscoWlAwry
         cxIA==
X-Received: by 10.140.150.149 with SMTP id 143mr68497202qhw.4.1426340446837;
        Sat, 14 Mar 2015 06:40:46 -0700 (PDT)
Received: from sidious.home (pool-71-121-156-46.bltmmd.fios.verizon.net. [71.121.156.46])
        by mx.google.com with ESMTPSA id 7sm3455298qhv.44.2015.03.14.06.40.45
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 14 Mar 2015 06:40:45 -0700 (PDT)
X-Mailer: git-send-email 2.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265449>

The current definition results in an incorrect expansion of the term under zsh.
For instance "/^${1////\\/}/" under zsh with the argument "hi" results in:
    /^/\/h/\/i/

This results in an output similar to this when trying to complete `git grep
chartab` under zsh:

    :: git grep chartabawk: cmd. line:1: /^/\/c/\/h/\/a/\/r/\/t/\/a/\/b/ { print $1 }
    awk: cmd. line:1:    ^ backslash not last character on line
    awk: cmd. line:1: /^/\/c/\/h/\/a/\/r/\/t/\/a/\/b/ { print $1 }
    awk: cmd. line:1:    ^ syntax error

Leaving the prompt in a goofy state until the user hits a key.

Escaping the literal / in the parameter expansion (using "/^${1//\//\\/}/")
results in:
    /^chartab/

allowing the completion to work correctly.

This formulation also works under bash.

Signed-off-by: John Szakmeister <john@szakmeister.net>
---

I've been bit by this bug quite a bit, but didn't have time to track it down
until today.  I hope the proposed solution is acceptable.

-John

 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c21190d..a899234 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1305,7 +1305,7 @@ _git_gitk ()
 }
 
 __git_match_ctag() {
-	awk "/^${1////\\/}/ { print \$1 }" "$2"
+	awk "/^${1//\//\\/}/ { print \$1 }" "$2"
 }
 
 _git_grep ()
-- 
2.3.1
