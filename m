From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: [RFH] Merge driver
Date: Tue, 13 Sep 2005 22:33:06 +0200
Message-ID: <20050913203252.GA1737@c165.ib.student.liu.se>
References: <7vvf1cz64l.fsf@assigned-by-dhcp.cox.net> <4320536D.2010706@citi.umich.edu> <7v7jdrwlih.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0509081012540.3208@g5.osdl.org> <43207FE6.2030108@citi.umich.edu> <Pine.LNX.4.58.0509081131070.5940@g5.osdl.org> <432089D8.4060507@citi.umich.edu> <7v3boen0rb.fsf_-_@assigned-by-dhcp.cox.net> <20050912210813.GA6644@c165.ib.student.liu.se> <7vmzmi9ebj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Linus Torvalds <torvalds@osdl.org>, cel@citi.umich.edu,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 13 22:34:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFHT3-0005WX-TN
	for gcvg-git@gmane.org; Tue, 13 Sep 2005 22:33:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbVIMUdW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Sep 2005 16:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbVIMUdW
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Sep 2005 16:33:22 -0400
Received: from [85.8.31.11] ([85.8.31.11]:56198 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S932275AbVIMUdW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Sep 2005 16:33:22 -0400
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id A5351411B; Tue, 13 Sep 2005 22:38:15 +0200 (CEST)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1EFHSn-0002FR-00; Tue, 13 Sep 2005 22:33:09 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vmzmi9ebj.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8483>

On Mon, Sep 12, 2005 at 02:16:48PM -0700, Junio C Hamano wrote:
> Fredrik Kuivinen <freku045@student.liu.se> writes:
> 
> > git-read-tree A
> > git-update-cache --refresh
> > git-read-tree -u -m T A B
> >
> > We need the second step because otherwise git-read-tree will complain
> > that the cache isn't uptodate. But we _know_ that the contents are
> > uptodate, so the second step is unnecessary and just eats time.
> 
> If we _know_ it should match, isn't there a way to tell the
> first "git-read-tree A" not to mess with the dirtiness, like,
> ah, one-way merge?
> 

I don't think a one way merge will do what we want in this case.

At the start of the merge we know that the working directory is in
sync with the index. But during the merge we will merge the common
ancestors, and the index file will be overwritten. When we are done
with merging the common ancestors we want to merge the heads that we
wanted to merge from the begining (A and B) using T as the common
ancestor. When 'git-read-tree A' is executed we get a cache which has
zeroed stat data, but SHAs and mode information which match the
working directory. If we do 'git-update-cache --refresh' the stat data
will be updated to match the working directory.

Using 'git-read-tree -m A' will not work because the stat data in the
cache is zeroed before we run this command.

I see two solutions, either allow passing '-i' together with '-u' to
git-read-tree or use a temporary index file when we are merging the
common ancestors.

Thinking a bit more about it, maybe it's better to use a temporary
index file. If go this way we could, at least in principle, allow
merges which starts with a dirty working directory.

- Fredrik
