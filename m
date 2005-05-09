From: Eugene Surovegin <ebs@ebshome.net>
Subject: [RFC] allow file list editing during cg-commit
Date: Sun, 8 May 2005 21:14:59 -0700
Message-ID: <20050509041459.GA13475@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon May 09 06:08:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUzZ9-0003Hz-4L
	for gcvg-git@gmane.org; Mon, 09 May 2005 06:08:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263040AbVEIEPJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 00:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263042AbVEIEPJ
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 00:15:09 -0400
Received: from gate.ebshome.net ([64.81.67.12]:31192 "EHLO gate.ebshome.net")
	by vger.kernel.org with ESMTP id S263040AbVEIEPA (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2005 00:15:00 -0400
Received: (qmail 13541 invoked by uid 1000); 8 May 2005 21:14:59 -0700
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
X-ICQ-UIN: 1193073
X-Operating-System: Linux i686
X-PGP-Key: http://www.ebshome.net/pubkey.asc
User-Agent: Mutt/1.5.5.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi!

I just started playing with cogito and failed to find _easy_ way to
select which files will be committed and which won't. cg-commit seems
to support specifying file list in command line, but this isn't very
convenient when the list is big.

I tend to have many modified files in my repo, but commit them in
several different changeset.

I just made simple change to cg-commit which allows  editing file
list while editing log message; for example, if I have 30 files  ready
for commit, but want to commit only 29, I just remove this file
from "CG:" list.

Patch which demonstrates the idea follows. Please note, this is
just a quick hack, and I probably missed some cg-commit cases, when
such behavior is undesirable; also, I cheated a little to make
grepping easy :).

Signed-off-by: Eugene Surovegin <ebs@ebshome.net>

Index: cg-commit
===================================================================
--- 3974261da777f55a7a11aff6e02f584bbfe2b475/cg-commit  (mode:100755)
+++ uncommitted/cg-commit  (mode:100755)
@@ -116,7 +116,7 @@
 	for file in "${commitfiles[@]}"; do
 		# TODO: Prepend a letter describing whether it's addition,
 		# removal or update. Or call git status on those files.
-		echo "CG:    $file" >>$LOGMSG
+		echo "CG:F    $file" >>$LOGMSG
 		[ "$msgs" ] && ! [ "$forceeditor" ] && echo $file
 	done
 fi
@@ -131,6 +131,11 @@
 		rm $LOGMSG $LOGMSG2
 		die 'Commit message not modified, commit aborted'
 	fi
+	eval commitfiles=($(grep ^CG:F $LOGMSG2 | sed 's/^CG:F//'))
+	if [ ! "${commitfiles[*]}" ]; then
+		rm $LOGMSG $LOGMSG2
+		die 'Nothing to commit'
+	fi
 else
 	cat >>$LOGMSG2
 fi
