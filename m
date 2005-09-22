From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH 6/8] cogito: Don't ever assume object type in
	cg-object-id
Date: Thu, 22 Sep 2005 11:37:59 -0400
Message-ID: <1127403479.14856.13.camel@dv>
References: <1127183120.31115.34.camel@dv>
	 <20050921100040.GE24902@pasky.or.cz> <1127359625.8074.18.camel@dv>
	 <20050922094643.GC21019@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 22 17:38:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIT9J-0008Ol-Gb
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 17:38:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030407AbVIVPiK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 11:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030411AbVIVPiK
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 11:38:10 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:31119 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1030407AbVIVPiI
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2005 11:38:08 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EIT9A-0007xF-Q6
	for git@vger.kernel.org; Thu, 22 Sep 2005 11:38:04 -0400
Received: from proski by dv.roinet.com with local (Exim 4.52)
	id 1EIT95-0006P5-Vi; Thu, 22 Sep 2005 11:37:59 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050922094643.GC21019@pasky.or.cz>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9127>

Hi, Petr!

On Thu, 2005-09-22 at 11:46 +0200, Petr Baudis wrote:
> $ git-fsck-objects
> error: b3e9704ecdf48869f635f0aa99ddfb513f885aff: object not found
> 
> and some dangling stuff, that's all I get. This seems to be caused by
> the mere existence of that (empty) file, so I just removed it from the
> objects database and all is fine now.

Maybe kernel.org site is not in sync yet, but anyway, here's what I
found.

I ran this script:

[proski@dv cogito]$ for i in .git/refs/tags/*; do git-tar-tree `cat $i` >/dev/null || echo $i; done
fatal: not a reference to a tag, commit or tree object: 463d05c7c4fe7f24da29749f4c7f25893fc20b8c
.git/refs/tags/git-pasky-0.1
fatal: not a reference to a tag, commit or tree object: 2c70421be7d88fbee49986d7a5584d1f010a25de
.git/refs/tags/git-pasky-0.2
fatal: not a reference to a tag, commit or tree object: d14925c87cdb6ca6345bcb3c8e34a2d659c79451
.git/refs/tags/git-pasky-0.3

If I delete the bad tags and prune the tree, git-fsck-objects has
nothing to complain about:

[proski@dv cogito]$ rm .git/refs/tags/git-pasky-0.1
[proski@dv cogito]$ rm .git/refs/tags/git-pasky-0.2
[proski@dv cogito]$ rm .git/refs/tags/git-pasky-0.3
[proski@dv cogito]$ git-prune origin `cat .git/refs/tags/*`
[proski@dv cogito]$ git-fsck-objects 
[proski@dv cogito]$

That's probably what you should do on the master tree if you haven't
done it.

I can run "git-prune origin", but then cg-fetch would refetch objects
for more tags:

Missing object of tag cogito-0.12... retrieved
Missing object of tag cogito-0.12.1... retrieved
Missing object of tag cogito-0.13... retrieved
Missing object of tag cogito-0.14... retrieved
Missing object of tag cogito-0.14.1... retrieved
Missing object of tag cogito-0.14.2... retrieved
Missing object of tag cogito-0.15... retrieved
Missing object of tag git-pasky-0.1... retrieved
Missing object of tag git-pasky-0.2... retrieved
Missing object of tag git-pasky-0.3... retrieved

How come that cogito-0.12 - cogito-0.15 are not on the origin tree, but
older cogito tags are?

-- 
Regards,
Pavel Roskin
