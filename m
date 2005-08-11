From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-http-pull broken in latest git
Date: Thu, 11 Aug 2005 16:21:46 -0700
Message-ID: <7v4q9wf4ad.fsf@assigned-by-dhcp.cox.net>
References: <42F8D472.3080404@de.bosch.com>
	<20050811223349.GI25280@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 01:22:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3MN4-00016q-PA
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 01:22:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbVHKXVt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Aug 2005 19:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbVHKXVt
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Aug 2005 19:21:49 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:32419 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932405AbVHKXVs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2005 19:21:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050811232146.JRCL19627.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 11 Aug 2005 19:21:46 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050811223349.GI25280@pasky.ji.cz> (Petr Baudis's message of
	"Fri, 12 Aug 2005 00:33:49 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis <pasky@suse.cz> writes:

> $ git-cat-file commit bf570303153902ec3d85570ed24515bcf8948848 | grep tree
> tree 41f10531f1799bbb31a1e0f7652363154ce96f45
> $ git-read-tree 41f10531f1799bbb31a1e0f7652363154ce96f45
> fatal: failed to unpack tree object 41f10531f1799bbb31a1e0f7652363154ce96f45

> Kaboom. I think the issue might be that the reference dependency tree
> building is broken and it should've pulled the other pack as well.

Last time I checked, git-http-pull did not utilize the pack
dependency information, which indeed is wrong.  When it decides
to fetch a pack instead of an asked-for object, it should check
which commits the pack expects to have in your local repository
and add them to its list of things to slurp.

A good news is that "git clone" as a whole works fine.

    prompt$ cd /var/tmp/
    prompt$ rm -fr junk
    prompt$ git clone http://www.kernel.org/pub/scm/git/git.git junk
    defaulting to local storage area
    prompt$ cd junk
    prompt$ git-cat-file commit bf570303153902ec3d85570ed24515bcf8948848 |
            grep tree
    tree 41f10531f1799bbb31a1e0f7652363154ce96f45
    prompt$ git-read-tree 41f10531f1799bbb31a1e0f7652363154ce96f45
    prompt$ /bin/ls .git/objects/pack
    pack-37cba29d3df65b160afabe769470f7857f98d729.idx
    pack-37cba29d3df65b160afabe769470f7857f98d729.pack
    pack-3c5133604508466855453f3e609428f4bbba9131.idx
    pack-3c5133604508466855453f3e609428f4bbba9131.pack
    prompt$ 
