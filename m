From: Petr Baudis <pasky@suse.cz>
Subject: "Racy" GIT
Date: Mon, 24 Oct 2005 11:29:52 +0200
Message-ID: <20051024092952.GZ30889@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Oct 24 11:33:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETyg0-0007u1-Gv
	for gcvg-git@gmane.org; Mon, 24 Oct 2005 11:31:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbVJXJ3z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Oct 2005 05:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbVJXJ3z
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Oct 2005 05:29:55 -0400
Received: from w241.dkm.cz ([62.24.88.241]:16780 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750811AbVJXJ3z (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Oct 2005 05:29:55 -0400
Received: (qmail 796 invoked by uid 2001); 24 Oct 2005 11:29:52 +0200
To: git@vger.kernel.org
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10537>

  Hello,

  I've  thought that I might describe the race I've hit the last night
here so that if you meet it too, you will have an idea what is going on
and won't waste your time debugging it, like I did. ;-)

  What did I do:

  echo v1 >file
  cg-add file
  cg-commit -m"v1"

  echo v2 >file
  cg-commit -m"v2"

  Guess what - the second cg-commit didn't commit the new version of the
file. git-diff-index didn't show anything. GIT just didn't care about
the change.

  Obviously, the problem was that the stat information was exactly the
same after the change (it was in a script, so no ctime change, and the
size was the same as well). The solution is to tell git/Cogito about the
change explicitly (in Cogito, you can do that e.g. by calling cg-add on
the file again). This can be obviously very confusing (and dangerous),
but if we want to keep the stat caching, I guess there is no way around
this (except for sub-second ctimes, but that effectively killed the stat
caching on the filesystems which didn't support it).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
