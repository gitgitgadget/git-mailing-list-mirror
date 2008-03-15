From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Fix recent 'unpack_trees()'-related changes breaking 'git
 stash'
Date: Sat, 15 Mar 2008 09:51:21 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803150934100.3557@woody.linux-foundation.org>
References: <20080315014133.GB32265@neumann> <alpine.LFD.1.00.0803142023490.3557@woody.linux-foundation.org> <7v1w6cpox6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: SZEDER G?bor <szeder@ira.uka.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 15 17:53:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaZd8-000109-Vo
	for gcvg-git-2@gmane.org; Sat, 15 Mar 2008 17:53:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913AbYCOQwG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2008 12:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751898AbYCOQwF
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Mar 2008 12:52:05 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58823 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751110AbYCOQwE (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Mar 2008 12:52:04 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2FGqMFn021414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 15 Mar 2008 09:52:24 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2FGpLuV024804;
	Sat, 15 Mar 2008 09:51:21 -0700
In-Reply-To: <7v1w6cpox6.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.31 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77332>



On Fri, 14 Mar 2008, Junio C Hamano wrote:
> 
> It would be slightly simpler to write the above sequence like this:
> 
> 	w_tree=$( (
> 		rm -f "$TMP-index" &&
>                 git read-tree --index-output="$TMP-index" -m $i_tree &&

Ack. That's an independent cleanup.

In fact, I would almost prefer to try to stop using GIT_INDEX_FILE 
entirely, and add it as a top-level git flag, so you can then make the 
rest be:

	git --index-file "$TMP-index" add -u &&
	git --index-file "$TMP-index" write-tree &&
	rm -f "$TMP-index"

instead of doing that

>                 GIT_INDEX_FILE="$TMP-index" &&
>                 export GIT_INDEX_FILE &&
>                 git add -u &&
>                 git write-tree &&
>                 rm -f "$TMP-index"

thing.


Something like the appended, in other words.

Oh, and that whole git.c argument parsing should be made to use the proper 
arg parser, too. But I'm too damn lazy and not comfy enough with 
'parse_options()' usage. Somebody who is should take a look..

		Linus

---
 git-stash.sh |    9 +++------
 git.c        |   15 +++++++++++++++
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index c2b6820..95b65dc 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -63,12 +63,9 @@ create_stash () {
 	# state of the working tree
 	w_tree=$( (
 		rm -f "$TMP-index" &&
-		cp -p ${GIT_INDEX_FILE-"$GIT_DIR/index"} "$TMP-index" &&
-		GIT_INDEX_FILE="$TMP-index" &&
-		export GIT_INDEX_FILE &&
-		git read-tree -m $i_tree &&
-		git add -u &&
-		git write-tree &&
+		git read-tree --index-output="$TMP-index" -m $i_tree &&
+		git --index-file "$TMP-index" add -u &&
+		git --index-file "$TMP-index" write-tree &&
 		rm -f "$TMP-index"
 	) ) ||
 		die "Cannot save the current worktree state"
diff --git a/git.c b/git.c
index 13de801..a615df9 100644
--- a/git.c
+++ b/git.c
@@ -55,6 +55,21 @@ static int handle_options(const char*** argv, int* argc, int* envchanged)
 			setenv(GIT_DIR_ENVIRONMENT, cmd + 10, 1);
 			if (envchanged)
 				*envchanged = 1;
+		} else if (!strcmp(cmd, "--index-file")) {
+			if (*argc < 2) {
+				fprintf(stderr, "No directory given for --index-file.\n" );
+				usage(git_usage_string);
+			}
+			setenv(INDEX_ENVIRONMENT, (*argv)[1], 1);
+			if (envchanged)
+				*envchanged = 1;
+			(*argv)++;
+			(*argc)--;
+			handled++;
+		} else if (!prefixcmp(cmd, "--index-file=")) {
+			setenv(INDEX_ENVIRONMENT, cmd + 13, 1);
+			if (envchanged)
+				*envchanged = 1;
 		} else if (!strcmp(cmd, "--work-tree")) {
 			if (*argc < 2) {
 				fprintf(stderr, "No directory given for --work-tree.\n" );
