From: sean <seanlkml@sympatico.ca>
Subject: Re: git-commit: allow From: line to be entered in commit message
Date: Thu, 12 Jan 2006 10:21:23 -0500
Message-ID: <BAYC1-PASMTP07EE5172C7652A5DD3131DAE270@CEZ.ICE>
References: <BAYC1-PASMTP117A18814EAAFACFE0F31DAE270@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jan 12 16:27:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ex4Ki-0002tu-4t
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 16:25:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030447AbWALPZo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 10:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030450AbWALPZo
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 10:25:44 -0500
Received: from bayc1-pasmtp07.bayc1.hotmail.com ([65.54.191.167]:14357 "EHLO
	BAYC1-PASMTP07.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1030447AbWALPZn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2006 10:25:43 -0500
X-Originating-IP: [69.156.6.171]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.6.171]) by BAYC1-PASMTP07.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 12 Jan 2006 07:26:49 -0800
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 38E8D644C23
	for <git@vger.kernel.org>; Thu, 12 Jan 2006 10:25:42 -0500 (EST)
To: git@vger.kernel.org
Message-Id: <20060112102123.581e373e.seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP117A18814EAAFACFE0F31DAE270@CEZ.ICE>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.9; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 12 Jan 2006 15:26:50.0140 (UTC) FILETIME=[9BAE75C0:01C6178C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 12 Jan 2006 09:37:00 -0500
sean <seanlkml@sympatico.ca> wrote:

> Mostly just for comment to see if there is any support
> for this feature....

Sorry.  Slightly better version of the patch below:

---
Use the author name and email information given as the 
first line of the commit message in the form of:
 
From: name <email>
 
as the author's name and email address in the resulting
commit object.  This makes committing foreign patches
a little less cumbersome to handle for some workflows.

diff --git a/git-commit.sh b/git-commit.sh
index 193feeb..163e2d7 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -219,14 +219,19 @@ t)
 	fi
 esac
 
-grep -v '^#' < "$GIT_DIR"/COMMIT_EDITMSG |
-git-stripspace > "$GIT_DIR"/COMMIT_MSG
+grep -v '^#' < "$GIT_DIR"/COMMIT_EDITMSG | git-stripspace | 
+sed -e '1s/^[ \t]*from:.*//I' | git-stripspace > "$GIT_DIR"/COMMIT_MSG
 
 if cnt=`grep -v -i '^Signed-off-by' "$GIT_DIR"/COMMIT_MSG |
 	git-stripspace |
 	wc -l` &&
    test 0 -lt $cnt
 then
+	FROM=$(sed -ne '/^#/d;/^[ \t]*$/d;s/from:[ \t]*\(.*\)/\1/Ip;q' "$GIT_DIR"/COMMIT_EDITMSG)
+	if test -n "$FROM"; then
+		export GIT_AUTHOR_NAME=$(echo "$FROM" | sed -e 's/[ \t]*<.*//')
+		export GIT_AUTHOR_EMAIL=$(echo "$FROM" | sed -e 's/.*<\(.*\)>.*/\1/')
+	fi
 	tree=$(git-write-tree) &&
 	commit=$(cat "$GIT_DIR"/COMMIT_MSG | git-commit-tree $tree $PARENTS) &&
 	git-update-ref HEAD $commit $current &&
