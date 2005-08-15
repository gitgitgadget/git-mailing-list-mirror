From: Matt Draisey <mattdraisey@sympatico.ca>
Subject: symlinked directories in refs are now unreachable
Date: Mon, 15 Aug 2005 02:41:17 +0000
Message-ID: <1124073677.27393.15.camel@della.draisey.ca>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Aug 15 04:45:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4Uxk-0005RI-FG
	for gcvg-git@gmane.org; Mon, 15 Aug 2005 04:44:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932644AbVHOCo3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Aug 2005 22:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932645AbVHOCo3
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Aug 2005 22:44:29 -0400
Received: from tomts36-srv.bellnexxia.net ([209.226.175.93]:62886 "EHLO
	tomts36-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S932644AbVHOCo2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2005 22:44:28 -0400
Received: from Windsor-ppp121612.sympatico.ca ([216.209.168.97])
          by tomts36-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050815024421.XPHU16985.tomts36-srv.bellnexxia.net@Windsor-ppp121612.sympatico.ca>
          for <git@vger.kernel.org>; Sun, 14 Aug 2005 22:44:21 -0400
To: git-list <git@vger.kernel.org>
X-Mailer: Evolution 2.0.4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The behaviour of the symlinked in ref directories has changed from
earlier versions of git.  They used to be taken into account in
git-fsck-cache --unreachable.  The code in question would simply stat
the contents of .git/refs and recursively expand any S_ISDIR.  Now the
code does an lstat and effectively throws symlinks away.

refs.c lines 48,52 @ do_for_each_ref

...
	memcpy(path + baselen, de->d_name, namelen+1);
	if (lstat(git_path("%s", path), &st) < 0)
		continue;
	if (S_ISDIR(st.st_mode)) {
		retval = do_for_each_ref(path, fn);
...

Can the previous behaviour be reinstated?
