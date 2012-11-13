From: Tomo Krajina <tkrajina@gmail.com>
Subject: [PATCH] gitk - fix a problem with multiline author names
Date: Tue, 13 Nov 2012 21:26:05 +0100
Message-ID: <CAEEdOy+6mBuvyemD8r5H1qVqag4s03AqG1aYN2J+w5PNjEKhhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 13 21:26:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYN4B-0005vf-Uv
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 21:26:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755784Ab2KMU00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 15:26:26 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:38229 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755763Ab2KMU0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 15:26:25 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so7866417oag.19
        for <git@vger.kernel.org>; Tue, 13 Nov 2012 12:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=vkQ/Eec5jTemiFzJE6JSGmTx7gQJAyjnlkwI05Q2q/s=;
        b=RSeJxSc/JY+r0ZwvA5NYqkHSNVuCpTiV1wkWCxC7BX8q+VvznxIaL/jFUchWcqrT2s
         qEsrwpJoPy9vnuH2kxc9UR8/taB02zlvOQM+15cmZ5qjmeIBgXUgFHW+Da6m3FcQv9V/
         9izT2BWooscCRGUIBg5ntEwq5PaywYHJIeYDPMmhrFasCCj7TZtz/kPKuT+vIdSlxxGy
         gEs7LgsmsfAmGeck3mvnfQA+9BsDyoNTZhQpji4BhAVySUw+Og62zeaRQJNh4DZ0i0Io
         77tWjMS7qrab107cD4I76ynHrnTWgMpBzp7OD68H2qSBdh29fQAZMW0zJDh+1yAKq/yM
         66sg==
Received: by 10.60.170.200 with SMTP id ao8mr18212458oec.104.1352838385206;
 Tue, 13 Nov 2012 12:26:25 -0800 (PST)
Received: by 10.182.59.108 with HTTP; Tue, 13 Nov 2012 12:26:05 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209667>

When commiting with "git-commit" no newline in the author string
is possible. But other git clients don't have the same validations
for the author name. And, it is possible to have a commit like:

commit xxxxxxxx
Merge: aaaaa bbbbb
Author: User Name
 <user.name@domain.com>
Date:   Thu Nov 8 17:01:02 2012 +0100

    Merge branch 'master' of ...

Note that the "Author:" string is split in two lines.

The git-log command work without problems with a commit like this, but
in gitk there is a problem because it splits the headers by a newline
character and that's why the email and time is not correctly parsed
and the history tree below this commit is not shown.

Signed-off-by: Tomo Krajina <tkrajina@gmail.com>
---
 gitk-git/gitk |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 6f24f53..87300db 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -1672,13 +1672,15 @@ proc parsecommit {id contents listed} {
     foreach line [split $header "\n"] {
  set line [split $line " "]
  set tag [lindex $line 0]
- if {$tag == "author"} {
-    set audate [lrange $line end-1 end]
-    set auname [join [lrange $line 1 end-2] " "]
- } elseif {$tag == "committer"} {
-    set comdate [lrange $line end-1 end]
-    set comname [join [lrange $line 1 end-2] " "]
- }
+        if {$tag == "author"} {
+            regexp -lineanchor {\nauthor([^<]*)<([^>]*)>\s+([^\n]+)}
$header all auname email audate
+            set auname [string trim $auname]
+            set auname "$auname <$email>"
+        } elseif {$tag == "committer"} {
+            regexp -lineanchor
{\ncommitter([^<]*)<([^>]*)>\s+([^\n]+)} $header all comname email
comdate
+            set comname [string trim $comname]
+            set comname "$comname <$email>"
+        }
     }
     set headline {}
     # take the first non-blank line of the comment as the headline
--
1.7.9.5
