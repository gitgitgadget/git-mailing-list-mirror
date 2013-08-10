From: Josh Triplett <josh@joshtriplett.org>
Subject: git stash takes excessively long when many untracked files present
Date: Sat, 10 Aug 2013 14:44:55 -0700
Message-ID: <20130810214453.GA5719@jtriplet-mobl1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 10 23:45:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8GyG-0000Fe-Qa
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 23:45:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758856Ab3HJVpG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Aug 2013 17:45:06 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:58939 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758850Ab3HJVpF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Aug 2013 17:45:05 -0400
Received: from mfilter9-d.gandi.net (mfilter9-d.gandi.net [217.70.178.138])
	by relay3-d.mail.gandi.net (Postfix) with ESMTP id 3B4BFA80B9;
	Sat, 10 Aug 2013 23:45:02 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter9-d.gandi.net
Received: from relay3-d.mail.gandi.net ([217.70.183.195])
	by mfilter9-d.gandi.net (mfilter9-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id awtzpKi4ew3E; Sat, 10 Aug 2013 23:45:00 +0200 (CEST)
X-Originating-IP: 50.43.39.152
Received: from jtriplet-mobl1 (static-50-43-39-152.bvtn.or.frontiernet.net [50.43.39.152])
	(Authenticated sender: josh@joshtriplett.org)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id E83FBA80C6;
	Sat, 10 Aug 2013 23:44:57 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232113>

[CCing folks involved in the recent "stash-refuse-to-kill" merge.]

I keep portions of my home directory in git.  I tried to "git stash"
some local changes, and it ran for several minutes with no progress.  ps
showed that it was running "git ls-files --killed", which was taking
100% CPU, and occasionally reading the disk very slowly.

strace shows that git ls-files --killed is doing a full recursive
enumeration of my entire home directory.  That's a Really Bad Idea:

~$ find | wc -l
3248997
~$ find -type d | wc -l
350680

Not only that, but it also appears to be attempting to stat and open
several files in every single directory; for instance:

stat(".ccache/1/3/.git", 0x7fff254bc7a0) = -1 ENOENT (No such file or directory)
open(".ccache/1/3/.git/HEAD", O_RDONLY) = -1 ENOENT (No such file or directory)
stat(".ccache/1/3/.git", 0x7fff254bc770) = -1 ENOENT (No such file or directory)
open(".ccache/1/3/.git/packed-refs", O_RDONLY) = -1 ENOENT (No such file or directory)

(Yes, in that order.)

I see a lot of room for optimization here.  Most importantly, git
ls-files --killed really doesn't need to look at any directory entry
unless something in the index would conflict with it.

- Josh Triplett
