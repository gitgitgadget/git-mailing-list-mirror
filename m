From: Eugene Surovegin <ebs@ebshome.net>
Subject: Re: [RFC] allow file list editing during cg-commit
Date: Mon, 9 May 2005 15:24:35 -0700
Message-ID: <20050509222435.GA25901@gate.ebshome.net>
References: <20050509041459.GA13475@gate.ebshome.net> <1115627229.8949.132.camel@pegasus> <20050509084606.GD3599@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 00:17:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVGZ2-0006z2-3S
	for gcvg-git@gmane.org; Tue, 10 May 2005 00:17:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261549AbVEIWYl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 18:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261550AbVEIWYk
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 18:24:40 -0400
Received: from gate.ebshome.net ([64.81.67.12]:53979 "EHLO gate.ebshome.net")
	by vger.kernel.org with ESMTP id S261549AbVEIWYg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2005 18:24:36 -0400
Received: (qmail 28884 invoked by uid 1000); 9 May 2005 15:24:35 -0700
To: Petr Baudis <pasky@ucw.cz>
Mail-Followup-To: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050509084606.GD3599@pasky.ji.cz>
X-ICQ-UIN: 1193073
X-Operating-System: Linux i686
X-PGP-Key: http://www.ebshome.net/pubkey.asc
User-Agent: Mutt/1.5.5.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, May 09, 2005 at 10:46:06AM +0200, Petr Baudis wrote:

[snip]

> The only thing to watch out for is that cg-commit -C produces no such
> list at all; it should deal with that and tell the user he is not going
> to be able to control what is going to be committed then.
> 
> Another thing is that at the moment you modify the file list, you should
> set customfiles - otherwise you will commit even cg-adds and cg-rms of
> files you didn't select. But do that really only when you change the
> file list, since it is more expensive.
> 
> You should also place an appropriate hint near the CG: lines, saying
> that removing some of them will limit the list of files to be committed.

OK, how about the following patch? I tried to address all issues you 
mentioned and also $merging case as well.

Signed-off-by: Eugene Surovegin <ebs@ebshome.net>

Index: cg-commit
===================================================================
--- 972d8624458936868e6f392b40858b7c362af8cd/cg-commit  (mode:100755)
+++ uncommitted/cg-commit  (mode:100755)
@@ -111,12 +111,16 @@
 		rm $LOGMSG $LOGMSG2
 		die 'Nothing to commit'
 	fi
+	if [ ! "$merging" ]; then
+		echo "CG: By deleting lines beginning with CG:F the associated file" >>$LOGMSG 
+		echo "CG: will be removed from the commit list." >>$LOGMSG 
+	fi	
 	echo "CG:" >>$LOGMSG
 	echo "CG: Modified files:" >>$LOGMSG
 	for file in "${commitfiles[@]}"; do
 		# TODO: Prepend a letter describing whether it's addition,
 		# removal or update. Or call git status on those files.
-		echo "CG:    $file" >>$LOGMSG
+		echo "CG:F    $file" >>$LOGMSG
 		[ "$msgs" ] && ! [ "$forceeditor" ] && echo $file
 	done
 fi
@@ -131,6 +135,17 @@
 		rm $LOGMSG $LOGMSG2
 		die 'Commit message not modified, commit aborted'
 	fi
+	if [ ! "$ignorecache" ] && [ ! "$merging" ]; then
+		eval newcommitfiles=($(grep ^CG:F $LOGMSG2 | sed 's/^CG:F//'))
+		if [ ! "${newcommitfiles[*]}" ]; then
+			rm $LOGMSG $LOGMSG2
+			die 'Nothing to commit'
+		fi
+		if [ "${commitfiles[*]}" != "${newcommitfiles[*]}" ]; then
+			commitfiles="${newcommitfiles[*]}"
+			customfiles="${commitfiles[*]}"
+		fi
+	fi
 else
 	cat >>$LOGMSG2
 fi

