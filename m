From: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: Re: git 565ebbf79f61873042c22a7126d002c104e056f4 broken on OpenBSD
Date: Wed, 26 Oct 2005 12:55:15 -0400
Message-ID: <20051026165515.GA16616@delft.aura.cs.cmu.edu>
References: <86y84gfjv4.fsf@blue.stonehenge.com> <86u0f4fjah.fsf@blue.stonehenge.com> <Pine.LNX.4.63.0510261708280.2803@wbgn013.biozentrum.uni-wuerzburg.de> <86mzkwfh54.fsf@blue.stonehenge.com> <Pine.LNX.4.63.0510261725150.8507@wbgn013.biozentrum.uni-wuerzburg.de> <86irvkfg80.fsf@blue.stonehenge.com> <20051026161552.GA11483@delft.aura.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Oct 26 18:57:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUoYc-0004PF-UO
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 18:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbVJZQzS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Oct 2005 12:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964818AbVJZQzS
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Oct 2005 12:55:18 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:8413 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S964820AbVJZQzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2005 12:55:16 -0400
Received: from jaharkes by delft.aura.cs.cmu.edu with local (Exim 3.36 #1 (Debian))
	id 1EUoYV-00050K-00
	for <git@vger.kernel.org>; Wed, 26 Oct 2005 12:55:15 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20051026161552.GA11483@delft.aura.cs.cmu.edu>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10680>

On Wed, Oct 26, 2005 at 12:15:52PM -0400, Jan Harkes wrote:
> Checking the SuSv2 manpage for link(2), it doesn't mention either of
> these error codes. But does mention EPERM as a valid error when the
> filesystem doesn't support hardlinks.
>     http://www.opengroup.org/onlinepubs/007908799/xsh/link.html

Re-reading this, I seem to have misinterpreted the text. EPERM is
returned when the filesystem doesn't allow hard linking a directory.
I guess the closest error would actually be EMLINK, assuming that a
filesystem that doesn't support hardlinks would have LINK_MAX set to 1.

    Linux returns EPERM
    Coda returns EXDEV
    BSDs seem to return EOPNOTSUPP.
    MacOS X/Darwin doesn't mention it in their manpages.

Simply falling back on rename when there is any error, as Linus
suggested, seems like a pretty good solution right now. Rename should
give the same set of errors except when the link target already existed.

Jan


diff --git a/sha1_file.c b/sha1_file.c
index e456799..0eba58c 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1234,15 +1234,14 @@ int move_temp_to_file(const char *tmpfil
 	int ret = link_temp_to_file(tmpfile, filename);
 	if (ret) {
 		/*
-		 * Coda hack - coda doesn't like cross-directory links,
-		 * so we fall back to a rename, which will mean that it
-		 * won't be able to check collisions, but that's not a
-		 * big deal.
+		 * The file system may not support hardlinks, so we fall back
+		 * to a rename. We won't be able to check for collisions, but
+		 * that's not a big deal.
 		 *
 		 * When this succeeds, we just return 0. We have nothing
 		 * left to unlink.
 		 */
-		if (ret == EXDEV && !rename(tmpfile, filename))
+		if (ret && ret != EEXIST && !rename(tmpfile, filename))
 			return 0;
 	}
 	unlink(tmpfile);
