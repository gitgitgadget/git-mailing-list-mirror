From: Sam Hocevar <sam@zoy.org>
Subject: git-svn equivalent to "svn switch --relocate"
Date: Tue, 17 Jun 2008 18:06:02 +0200
Message-ID: <20080617160602.GB29897@zoy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 18:42:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8eFT-0006Vf-SU
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 18:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754157AbYFQQkk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 12:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753340AbYFQQkk
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 12:40:40 -0400
Received: from poulet.zoy.org ([80.65.228.129]:42998 "EHLO poulet.zoy.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752846AbYFQQkk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 12:40:40 -0400
X-Greylist: delayed 2076 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Jun 2008 12:40:39 EDT
Received: by poulet.zoy.org (Postfix, from userid 1000)
	id 1176E1203FC; Tue, 17 Jun 2008 18:06:02 +0200 (CEST)
Content-Disposition: inline
Mail-Copies-To: never
X-No-CC: I read mailing-lists; do not CC me on replies.
X-Snort: uid=0(root) gid=0(root)
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85312>

   I know this has been addressed a few times, but since I haven't found
any reasonable way to relocate a git-svn repository (after a protocol
change, or a server name change) I thought I'd share how I did it.

   Step 1 is to edit ".git/config" and modify the "url = " line so
that it reflects the new repository address. For instance:

-	url = http://svn.gnome.org/svn/gimp
+	url = svn+ssh://svn.gnome.org/svn/gimp

   From now on, git-svn will basically stop working, because the
"git-svn-id:" lines in the commit logs will no longer match its
configuration. And git-filter-branch is of no use here either, because
it will change the md5sum of each commit, and git-svn will no longer be
able to track the commits.

   Step 2 is therefore to temporarily hack git-svn to make it think
the commit messages do use the new URL. This is done at the end of the
"extract_metadata" subroutine:

 		($rev, $uuid) = ($id =~/^\s*git-svn-id:\s(\d+)\@([a-f\d\-]+)/);
 	}
+	$url =~ s|http://svn.gnome.org/svn/gimp/|svn+ssh://svn.gnome.org/svn/gimp/|;
 	return ($url, $rev, $uuid);
 }

   This will usually be needed only until the next SVN commit is merged
and the git-svn tree is rebased.

   Hope this can help a few. Unfortunately I don't understand the
git-svn source code well enough to work on a cleaner way to do that.

Cheers,
-- 
Sam.
