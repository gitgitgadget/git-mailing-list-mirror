From: James Nylen <jnylen@gmail.com>
Subject: [PATCH] Add --unannotate option to git-subtree
Date: Tue, 9 Oct 2012 16:26:50 -0400
Message-ID: <CABVa4NinSighUn7GKbzMx9qZj3Ao2dCtEZxUqCPwO9TocZ8Kkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 09 22:27:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLgOL-0005q5-Ni
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 22:27:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753896Ab2JIU0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2012 16:26:52 -0400
Received: from mail-ia0-f174.google.com ([209.85.210.174]:63587 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751275Ab2JIU0u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2012 16:26:50 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so1097211iag.19
        for <git@vger.kernel.org>; Tue, 09 Oct 2012 13:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=AgCbIonkOj4Im+ClvNp09vNZfe4l7SQGDacHEHpmbfw=;
        b=int9bz69v0jQn1oQSfTZpDIGOaLkkKfwxQRqLI+ImIl38VZf83lQFe0Uwjjxo1Ofvq
         0uXZ9jTV8iNBz7Xc7ue0Me4WYJk6Oy8vgOo695sYpxjwJ7drpovDPUNbadX1qra2/6Yj
         JgzTdKhAJTmFk99fL7RrjKkpNsBGwuUT+wMOLGXBMTM7J0bOv7eWpFrqgfWe+SPoGfRU
         PnoQbWvuj/YTTkwvHM8HNL5xvN3gUKZAw6M1dqFzeMZs8kWWoA7RWyBzyjtIkkCsMGao
         1IukFWD9EK1f0kKiLomfN+TElHKtdHEjKouGNEj5MCDDrGLu0wE3Mf+dGm2CDlhkfosG
         MyVg==
Received: by 10.50.202.71 with SMTP id kg7mr3057547igc.55.1349814410153; Tue,
 09 Oct 2012 13:26:50 -0700 (PDT)
Received: by 10.42.173.130 with HTTP; Tue, 9 Oct 2012 13:26:50 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207341>

This new option does the reverse of --annotate, which is more useful
when contributing back to a library which is also included in the
repository for a larger project, and perhaps in other situations as
well.

Rather than adding a marker to each commit when splitting out the
commits back to the subproject, --unannotate removes the specified
string (or bash glob pattern) from the beginning of the first line of
the commit message.  This enables the following workflow:

 - Commit to a library included in a large project, with message:
     Library: Make some amazing change

 - Use `git-subtree split` to send this change to the library maintainer

 - Pass ` --unannotate='Library: ' ` or ` --unannotate='*: ' `

 - This will turn the commit message for the library project into:
     Make some amazing change

This helps to keep the commit messages meaningful in both the large
project and the library project.

Signed-off-by: James Nylen <jnylen@gmail.com>
---
Let me know if gmail has munged this patch.  You can also get at it
like this:

$ git remote add nylen git://github.com/nylen/git.git
$ git fetch nylen
$ git show nylen/subtree-unannotate
---
 contrib/subtree/git-subtree.sh  | 11 +++++++++--
 contrib/subtree/git-subtree.txt | 15 +++++++++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 920c664..8d1ed05 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -21,6 +21,7 @@ P,prefix=     the name of the subdir to split out
 m,message=    use the given message as the commit message for the merge commit
  options for 'split'
 annotate=     add a prefix to commit message of new commits
+unannotate=   remove a prefix from new commit messages (supports bash globbing)
 b,branch=     create a new branch from the split subtree
 ignore-joins  ignore prior --rejoin commits
 onto=         try connecting new tree to an existing one
@@ -43,6 +44,7 @@ onto=
 rejoin=
 ignore_joins=
 annotate=
+unannotate=
 squash=
 message=

@@ -80,6 +82,8 @@ while [ $# -gt 0 ]; do
 		-d) debug=1 ;;
 		--annotate) annotate="$1"; shift ;;
 		--no-annotate) annotate= ;;
+		--unannotate) unannotate="$1"; shift ;;
+		--no-unannotate) unannotate= ;;
 		-b) branch="$1"; shift ;;
 		-P) prefix="$1"; shift ;;
 		-m) message="$1"; shift ;;
@@ -310,8 +314,11 @@ copy_commit()
 			GIT_COMMITTER_NAME \
 			GIT_COMMITTER_EMAIL \
 			GIT_COMMITTER_DATE
-		(echo -n "$annotate"; cat ) |
-		git commit-tree "$2" $3  # reads the rest of stdin
+		(
+			read FIRST_LINE
+			echo "$annotate${FIRST_LINE#$unannotate}"
+			cat  # reads the rest of stdin
+		) | git commit-tree "$2" $3
 	) || die "Can't copy commit $1"
 }

diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
index 0c44fda..ae420aa 100644
--- a/contrib/subtree/git-subtree.txt
+++ b/contrib/subtree/git-subtree.txt
@@ -198,6 +198,21 @@ OPTIONS FOR split
 	git subtree tries to make it work anyway, particularly
 	if you use --rejoin, but it may not always be effective.

+--unannotate=<annotation>::
+	This option is only valid for the split command.
+
+	When generating synthetic history, try to remove the prefix
+	<annotation> from each commit message (using bash's "strip
+	shortest match from beginning" command, which supports
+	globbing).  This makes sense if you format library commits
+	like "library: Change something or other" when you're working
+	in your project's repository, but you want to remove this
+	prefix when pushing back to the library's upstream repository.
+	(In this case --unannotate='*: ' would work well.)
+	
+	Like --annotate,  you need to use the same <annotation>
+	whenever you split, or you may run into problems.
+
 -b <branch>::
 --branch=<branch>::
 	This option is only valid for the split command.
-- 
1.7.11.3
