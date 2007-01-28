From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] document 'blame --incremental'
Date: Sun, 28 Jan 2007 12:20:37 -0800
Message-ID: <7v8xfmewdm.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net>
	<20070127080126.GC9966@spearce.org>
	<Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org>
	<Pine.LNX.4.64.0701270945260.25027@woody.linux-foundation.org>
	<7vzm84gmei.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0701271439340.25027@woody.linux-foundation.org>
	<7vps8zfqlx.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0701281107050.25027@woody.linux-foundation.org>
	<7vveirdkpb.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0701281143190.25027@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 28 21:20:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBGWH-0003m8-Vd
	for gcvg-git@gmane.org; Sun, 28 Jan 2007 21:20:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbXA1UUl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Jan 2007 15:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932820AbXA1UUk
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jan 2007 15:20:40 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:38184 "EHLO
	fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932255AbXA1UUj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jan 2007 15:20:39 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070128202038.NFZM20530.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Sun, 28 Jan 2007 15:20:38 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id GkKf1W00j1kojtg0000000; Sun, 28 Jan 2007 15:19:40 -0500
In-Reply-To: <Pine.LNX.4.64.0701281143190.25027@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sun, 28 Jan 2007 11:57:33 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38047>

diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index 5dd8e36..a4e4bee 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -8,7 +8,7 @@ git-blame - Show what revision and author last modified each line of a file
 SYNOPSIS
 --------
 [verse]
-'git-blame' [-c] [-l] [-t] [-f] [-n] [-p] [-L n,m] [-S <revs-file>]
+'git-blame' [-c] [-l] [-t] [-f] [-n] [-p] [--incremental] [-L n,m] [-S <revs-file>]
             [-M] [-C] [-C] [--since=<date>] [<rev>] [--] <file>
 
 DESCRIPTION
@@ -63,6 +63,10 @@ OPTIONS
 -p, --porcelain::
 	Show in a format designed for machine consumption.
 
+--incremental::
+	Show the result incrementally in a format designed for
+	machine consumption.
+
 -M::
 	Detect moving lines in the file as well.  When a commit
 	moves a block of lines in a file (e.g. the original file
@@ -158,6 +162,46 @@ parents, using `commit{caret}!` notation:
 	git blame -C -C -f $commit^! -- foo
 
 
+INCREMENTAL OUTPUT
+------------------
+
+When called with `--incremental` option, the command outputs the
+result as it is built.  The output generally will talk about
+lines touched by more recent commits first and is meant to be
+used by interactive viewers.
+
+The output format is similar to the Porcelain format, but it
+does not contain the actual lines from the file that is being
+annotated.  
+
+. Each blame entry always starts with a line of:
+
+	<40-byte hex sha1> <sourceline> <resultline> <num_lines>
++
+Line numbers count from 1.
+
+. The first time that commit shows up in the stream, it has various
+  other information about it printed out with a one-word tag at the 
+  beginning of each line about that "extended commit info" (author, 
+  email, committer, dates, summary etc).
+
+. Unlike Porcelain format, the filename information is always
+  given and terminates the entry:
+
+	"filename" <whitespace-quoted-filename-goes-here>
++
+and thus it's really quite easy to parse for some line- and word-oriented
+parser (which should be quite natural for most scripting languages).
++
+[NOTE]
+For people who do parsing: to make it more robust, just ignore any 
+lines in between the first and last one ("<sha1>" and "filename" lines) 
+where you don't recognize the tag-words (or care about that particular 
+one) at the beginning of the "extended information" lines. That way, if 
+there is ever added information (like the commit encoding or extended 
+commit commentary), a blame viewer won't ever care.
+
+
 SEE ALSO
 --------
 gitlink:git-annotate[1]
