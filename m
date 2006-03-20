From: Francis Daly <francis@daoine.org>
Subject: Re: [PATCH] Fix multi-paragraph list items in OPTIONS section
Date: Mon, 20 Mar 2006 10:41:18 +0000
Message-ID: <20060320104118.GA32151@craic.sysops.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Mar 20 11:42:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLHq9-0002mn-3w
	for gcvg-git@gmane.org; Mon, 20 Mar 2006 11:42:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979AbWCTKmR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Mar 2006 05:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbWCTKmR
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Mar 2006 05:42:17 -0500
Received: from craic.sysops.org ([217.75.2.2]:28550 "EHLO craic.sysops.org")
	by vger.kernel.org with ESMTP id S1750840AbWCTKmQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Mar 2006 05:42:16 -0500
Received: from craic.sysops.org (craic.sysops.org [127.0.0.1])
	by craic.sysops.org (8.12.11/8.12.11) with SMTP id k2KAfIaC032161
	for <git@vger.kernel.org>; Mon, 20 Mar 2006 10:41:18 GMT
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Virus-Scanned: ClamAV 0.87.1/1342/Sun Mar 19 21:40:32 2006 on craic.sysops.org
X-Virus-Status: Clean
X-Spam-Status: No, hits=-3.0 required=2.0
	tests=EMAIL_ATTRIBUTION,USER_AGENT_MUTT
	version=2.55
X-Spam-Checker-Version: SpamAssassin 2.55 (1.174.2.19-2003-05-19-exp)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17747>

On Mon, Mar 20, 2006 at 10:39:46, Jonas Fonseca wrote:

> Asciidoc cannot handle multi-paragraph description list items without the
> need for adding special control characters and reindenting all paragraphs
> but the first. 

This issue affects the display of current git-cvsimport and
git-svnimport doc pages. There was a general tidy-up done in
df8baa42fe4eeb5a021ac262caf601f44d2a5746 last October, but additions
since then didn't keep the layout.

I don't think there is a full "fix" for this; either the html docs are
ugly (see the -A section in the pages mentioned above as they are now),
or the asciidoc source files look odd (although that's probably not a
big problem) or the manpages look a bit funny.

This patch makes the html docs right, makes the asciidoc docs a bit odd
but consistent with what is there already, and makes the manpages look
OK using docbook-xsl 1.68, but miss a paragraph separator when using 1.69.

For the manpages, current is like

       -A <author_file>
              Read a file with lines on the form

              username = User's Full Name <email@addr.es>

              and use "User's Full Name <email@addr.es>" as the GIT

With this patch, docbook-xsl v1.68 looks like

       -A <author_file>
              Read a file with lines on the form

                      username = User's Full Name <email@addr.es>

              and use "User's Full Name <email@addr.es>" as the GIT author and

while docbook-xsl v1.69 becomes

       -A <author_file>
              Read a file with lines on the form

                        username = User's Full Name <email@addr.es>
              and use "User's Full Name <email@addr.es>" as the GIT author and

The extra indentation is to keep the v1.69 manpage looking sane.

---
diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index 57027b4..b0c6d7c 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -99,21 +99,24 @@ If you need to pass multiple options, se
 	CVS by default uses the unix username when writing its
 	commit logs. Using this option and an author-conv-file
 	in this format
-
++
+---------
 	exon=Andreas Ericsson <ae@op5.se>
 	spawn=Simon Pawn <spawn@frog-pond.org>
 
-	git-cvsimport will make it appear as those authors had
-	their GIT_AUTHOR_NAME and GIT_AUTHOR_EMAIL set properly
-	all along.
-
-	For convenience, this data is saved to $GIT_DIR/cvs-authors
-	each time the -A option is provided and read from that same
-	file each time git-cvsimport is run.
-
-	It is not recommended to use this feature if you intend to
-	export changes back to CVS again later with
-	git-link[1]::git-cvsexportcommit.
+---------
++
+git-cvsimport will make it appear as those authors had
+their GIT_AUTHOR_NAME and GIT_AUTHOR_EMAIL set properly
+all along.
++
+For convenience, this data is saved to $GIT_DIR/cvs-authors
+each time the -A option is provided and read from that same
+file each time git-cvsimport is run.
++
+It is not recommended to use this feature if you intend to
+export changes back to CVS again later with
+git-link[1]::git-cvsexportcommit.
 
 OUTPUT
 ------
diff --git a/Documentation/git-svnimport.txt b/Documentation/git-svnimport.txt
index 9d38657..b1b87c2 100644
--- a/Documentation/git-svnimport.txt
+++ b/Documentation/git-svnimport.txt
@@ -75,18 +75,21 @@ When importing incrementally, you might 
 
 -A <author_file>::
 	Read a file with lines on the form
++
+------
+	username = User's Full Name <email@addr.es>
 
-	  username = User's Full Name <email@addr.es>
-
-	and use "User's Full Name <email@addr.es>" as the GIT
-	author and committer for Subversion commits made by
-	"username". If encountering a commit made by a user not in the
-	list, abort.
-
-	For convenience, this data is saved to $GIT_DIR/svn-authors
-	each time the -A option is provided, and read from that same
-	file each time git-svnimport is run with an existing GIT
-	repository without -A.
+------
++
+and use "User's Full Name <email@addr.es>" as the GIT
+author and committer for Subversion commits made by
+"username". If encountering a commit made by a user not in the
+list, abort.
++
+For convenience, this data is saved to $GIT_DIR/svn-authors
+each time the -A option is provided, and read from that same
+file each time git-svnimport is run with an existing GIT
+repository without -A.
 
 -m::
 	Attempt to detect merges based on the commit message. This option

-- 
Francis Daly        francis@daoine.org
