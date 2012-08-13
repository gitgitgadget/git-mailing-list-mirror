From: Bernd Jendrissek <bernd.jendrissek@gmail.com>
Subject: git diff vs git diff-files
Date: Mon, 13 Aug 2012 10:55:11 +0200
Message-ID: <CAF7PVPrex6sJMU+uvxQOSpB12qSTp2barTycow_-LZ8Ngbv7uQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 13 10:55:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0qQk-0000kt-No
	for gcvg-git-2@plane.gmane.org; Mon, 13 Aug 2012 10:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739Ab2HMIzN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Aug 2012 04:55:13 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:40917 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706Ab2HMIzL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2012 04:55:11 -0400
Received: by obbuo13 with SMTP id uo13so6565319obb.19
        for <git@vger.kernel.org>; Mon, 13 Aug 2012 01:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=3lGQnbh2NwwRnlojvhSydrQGZQoVQYQ4zPZh7vTTa7c=;
        b=zsf0P2q27zE8CazaUOKQHj+XNwxW7kMEGnq99tpW9JamWU5cXwAHtUElLwoVUd26pr
         rqTRVl+KLOeARSMX3uxdBpDx/9xYKBSz7F7MSpERqvcfaMTU2Nci4x8pd/nv8jnLBepw
         Nt02yqldtbrYLnx0XWDX3LWaxzqU0OJ3O5FwQAidNOE/FEsP0WLXpSndf9hnB63WVLV8
         GXEumvA5rQsnuYIJdJL0HnlNb46NlZL4Q0YUODTXDjgkX06w6KkWK1w+tQm49rQFQF96
         piOe4+iykDdq70e+KRl/MzVzx1Fn76xOPWg6iz0jG0i8oTy0Dy+M15ZtOYRIG1EzEcEm
         yj5Q==
Received: by 10.182.144.104 with SMTP id sl8mr10170626obb.74.1344848111229;
 Mon, 13 Aug 2012 01:55:11 -0700 (PDT)
Received: by 10.182.46.165 with HTTP; Mon, 13 Aug 2012 01:55:11 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203333>

I have a billion testsuite golden output files that have changed due
to an explicit ordering of objects I've imposed on output. A helper
script I wrote to help parse the diffs (to ignore order-only
differences) noticed that one hunk had a different number of additions
and deletions. I'm manually copying and pasting the hunks from git add
-i into the script. However, when I used git diff to get at the
changes, to discover which line was the offending one, all additions
and deletions were exactly matched!

With strace I noticed that git add -i calls git diff-files, and that's
about as far as I can conveniently trace where things are going weird.
Weird:

$ /usr/local/git/bin/git diff-files -p --color -- TwoStageAmp-output.net
diff --git a/gnetlist/tests/common/outputs/osmond/TwoStageAmp-output.net
b/gnetlist/tests/common/outputs/osmond/TwoStageAmp-output.net
index a5ee1e7..a9f3620 100644
--- a/gnetlist/tests/common/outputs/osmond/TwoStageAmp-output.net
+++ b/gnetlist/tests/common/outputs/osmond/TwoStageAmp-output.net
@@ -1,47 +1,47 @@
-Part unknown { Name Cout }
-Part unknown { Name R5 }
-Part unknown { Name R4 }
-Part unknown { Name RE2 }
-Part unknown { Name Q2 }
+Part unknown { Name R8 }
 Part unknown { Name A3 }
-Part unknown { Name R3 }
 Part unknown { Name A2 }
-Part unknown { Name RE1 }
 Part unknown { Name A1 }
[snip]

$ /usr/local/git/bin/git diff TwoStageAmp-output.netdiff --git
a/gnetlist/tests/common/outputs/osmond/TwoStageAmp-output.net
b/gnetlist/tests/common/outputs/osmond/TwoStageAmp-output.n
index a5ee1e7..a9f3620 100644
--- a/gnetlist/tests/common/outputs/osmond/TwoStageAmp-output.net
+++ b/gnetlist/tests/common/outputs/osmond/TwoStageAmp-output.net
@@ -1,47 +1,47 @@
-Part unknown { Name Cout }
-Part unknown { Name R5 }
-Part unknown { Name R4 }
-Part unknown { Name RE2 }
-Part unknown { Name Q2 }
+Part unknown { Name R8 }
 Part unknown { Name A3 }
-Part unknown { Name R3 }
 Part unknown { Name A2 }
-Part unknown { Name RE1 }
-Part unknown { Name Q1 }  <--- Not present with diff-files output
 Part unknown { Name A1 }
[snip]

The index is clean on TwoStageAmp-output.net (but by now a million
other files are dirty in the index). While I discovered this issue
with Ubuntu's 1.7.1, I got the same behaviour with git
1.7.12.rc2.18.g61b472e

What's going on here? I'll leave my tree in whatever weird state it
might be, for a while, in case anyone wants me to try various things.
At this point I want to understand what's going on, in case there's
either a learning moment for me or a bug, rather than just finding a
workaround.
