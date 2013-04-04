From: Chris Wilson <chris+gitscm@aptivate.org>
Subject: Possible bug: Git submodules can get into broken state
Date: Thu, 4 Apr 2013 18:10:17 +0100 (BST)
Message-ID: <alpine.DEB.2.02.1304041758140.965@lap-x201.fen.aptivate.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 04 20:18:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNokH-0005xh-9X
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 20:18:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764369Ab3DDSSQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 14:18:16 -0400
Received: from lin-mail.aptivate.org ([176.58.121.181]:51262 "EHLO
	lin-mail.aptivate.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764339Ab3DDSSP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 14:18:15 -0400
X-Greylist: delayed 4075 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Apr 2013 14:18:15 EDT
Received: from 82-68-244-70.dsl.in-addr.zen.co.uk ([82.68.244.70] helo=lap-x201.local)
	by lin-mail.aptivate.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.72)
	(envelope-from <chris+gitscm@aptivate.org>)
	id 1UNng2-0007HH-Q4
	for git@vger.kernel.org; Thu, 04 Apr 2013 18:10:18 +0100
X-X-Sender: chris@lap-x201.fen.aptivate.org
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220046>

Hi all,

If your git repo's .gitmodules contains a URL that you don't have access 
to (for example you download someone else's code and it references a 
submodule using their writable git@github.com URL) then:

* git submodule init will add them to .git/config, with the wrong URLs.

* git submodule update will fail to check out the repos, leaving an empty 
directory for the first one, and nothing for the others.

This state is broken (wrong URLs in .git/config), and AFAIK there's 
nothing you can do to check out these submodules without either:

(a) manually hacking them out of .git/config, or

(b) doing "git submodule rm" and then "git checkout .gitmodules" to undo 
the damage to that file.

The procedure I tried, which I expected to work, was:

* git submodule sync (doesn't sync them, because the directories don't 
exist or don't contain a valid git repo?)

* git submodule init (ignores them, because they're already in 
.git/config?)

* git submodule update (still fails because the URL in .git/config is 
wrong).

The new deinit command may help, but for the wrong reasons. I don't want 
to have to deinit my modules every time in the fabric deployment script, 
just so that if they get into this state, they will get unbroken 
automatically.

It seems wrong to me that neither "git submodule init" nor "git submodule 
sync" will modify the URL in .git/config, if the submodule is not already 
checked out. I think I'd expect "git submodule init" to be idempotent, so 
it would update the URLs in .git/config if they already exist, just like 
it adds the URLs if they don't.

Any advice? Is this a real bug?

Cheers, Chris.
-- 
Aptivate | http://www.aptivate.org | Phone: +44 1223 967 838
Future Business, Cam City FC, Milton Rd, Cambridge, CB4 1UY, UK

Aptivate is a not-for-profit company registered in England and Wales
with company number 04980791.
