From: Jan Hudec <bulb@ucw.cz>
Subject: [BUG] git describe number of commits different from git log count
Date: Fri, 05 Feb 2016 12:17:25 +0100
Message-ID: <1701823.75Syo8h0k0@box>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 05 12:25:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aReWU-0002P0-JS
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 12:25:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbcBELZx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 06:25:53 -0500
Received: from smtp02.tmcz.cz ([93.153.104.113]:38012 "EHLO smtp02.tmcz.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751245AbcBELZw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 06:25:52 -0500
X-Greylist: delayed 495 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Feb 2016 06:25:52 EST
Received: from smtp02.tmcz.cz (localhost [127.0.0.1])
	by sagator.hkvnode045 (Postfix) with ESMTP id 22C0694BDD6
	for <git@vger.kernel.org>; Fri,  5 Feb 2016 12:17:29 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on hkvnode046.tmo.cz
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=8.0 tests=RDNS_NONE,URIBL_BLOCKED
	autolearn=disabled version=3.3.1
X-Sagator-Scanner: 1.2.3-1 at hkvnode046;
	log(status(custom_action(quarantine(clamd()))),
	status(custom_action(quarantine(SpamAssassinD()))))
X-Sagator-ID: 20160205-121729-0001-04045-BbGlaC@hkvnode046
Received: from box.local (unknown [78.80.31.152])
	by smtp02.tmcz.cz (Postfix) with ESMTPS
	for <git@vger.kernel.org>; Fri,  5 Feb 2016 12:17:28 +0100 (CET)
Received: from bulb by box.local with local (Exim 4.86)
	(envelope-from <bulb@ucw.cz>)
	id 1aReOF-0001PN-7Y
	for git@vger.kernel.org; Fri, 05 Feb 2016 12:17:27 +0100
User-Agent: KMail/4.14.10 (Linux/4.3.0-1-amd64; KDE/4.14.14; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285570>

Hello,

I have a repository with following situation:

    $ git describe next
    v4.1-2196-g5a414d7
    $ git describe next --match=v4.2
    v4.2-4757-g5a414d7

Since the tag with fewest commits since is selected, it appears logical. 
However, v4.2 is descendant of v4.1, so it does not make sense for it to have 
more commits since. And rev-list or log confirm that:

    $ git rev-list v4.1..next | wc -l
    2196
    $ git rev-list v4.2..next | wc -l
    1152

The number of commits since v4.1 matches what the describe counted, but the 
number of commits since v4.2 does not.

The v4.1 tag should be reachable along the first parent path, the v4.2 
definitely isn't, but I am not asking for first parent path.

I am using

    $ git --version
    git version 2.7.0

from Debian git 1:2.7.0-1 package locally, but our build server is still using 
rather ancient

    $ git --version
    git version 1.8.4.msysgit.0

with exactly the same result.

Unfortunately I can't share the repository, but I could run some tests on it, 
including rebuilding git with some diagnostics and trying that.

Note that the tag v4.2 is otherwise perfectly good candidate for describe and 
gets used just fine when describing master:

    $ git describe master
    v4.2-2-g34eb80b
    $ git describe master --match=v4.1
    v4.1-1046-g34eb80b

However when I merged master into next, it started producing those incorrect 
results.

-- 
 - Jan Hudec <bulb@ucw.cz>
