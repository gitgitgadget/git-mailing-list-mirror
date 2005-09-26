From: Petr Baudis <pasky@suse.cz>
Subject: Re: Cogito: cg-clone doesn't like packed tag objects
Date: Mon, 26 Sep 2005 23:25:36 +0200
Message-ID: <20050926212536.GF26340@pasky.or.cz>
References: <43348086.2040006@zytor.com> <20050924011833.GJ10255@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 26 23:26:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EK0Tm-0005ts-0T
	for gcvg-git@gmane.org; Mon, 26 Sep 2005 23:25:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbVIZVZj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 17:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbVIZVZj
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 17:25:39 -0400
Received: from w241.dkm.cz ([62.24.88.241]:12959 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932319AbVIZVZi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Sep 2005 17:25:38 -0400
Received: (qmail 12549 invoked by uid 2001); 26 Sep 2005 23:25:36 +0200
To: "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <20050924011833.GJ10255@pasky.or.cz>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9337>

Dear diary, on Sat, Sep 24, 2005 at 03:18:33AM CEST, I got a letter
where Petr Baudis <pasky@suse.cz> told me that...
> Dear diary, on Sat, Sep 24, 2005 at 12:24:06AM CEST, I got a letter
> where "H. Peter Anvin" <hpa@zytor.com> told me that...
> > Packed tag objects breaks Cogito when using git+ssh:// transport.
> > 
> > Example:
> > 
> > cg-clone -s git+ssh://master.kernel.org/pub/scm/libs/klibc/klibc.git
> 
> I changed the code to use the git-*-fetch tools to fetch the objects
> referenced by tags, so this works properly now. Thanks for the report.

And now thanks to "walt" I realized that this is a completely wrong way
to go. The problem is that the tags don't have to tag anything on your
branch, and if you are fetching a given branch, you want only commits
from that branch. But fetching the tags will cause all the commits
connected to the tags getting slurped too, and we didn't want that.

So the strategy I'm thinking of now is to manually (I think no GIT tool
can do that for me) dereference the possible tag chain until I end up at
some non-tag object. Now, if it is a commit and I don't have it yet, it
means that it is not interesting to me because it does not belong to a
branch I'm following, so I will just ignore the tag (won't download
anything else and won't record it in the refs/tags directory).

If it's NOT a commit, well, that's a question.  On the assumption that
it won't be a great deal of data and it's likely to be assumed that we
have it, I would be inclined to fetching it, but I don't feel strongly
about it.

The ideal and the least expensive solution for this, obviously, would be
having this logic in git-fetch-pack. :-)

Opinions?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
