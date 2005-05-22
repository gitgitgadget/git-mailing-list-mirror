From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: [PATCH] Don't include devicenumber into INODE_CHANGED test [WAS: Re: running git-update-cache --refresh on different machines on a NFS share always ends up in a lot of io/cpu/time waste]
Date: Sun, 22 May 2005 23:23:12 +0200
Message-ID: <20050522212312.GC23388@cip.informatik.uni-erlangen.de>
References: <20050522122849.GJ15178@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0505221205580.2307@ppc970.osdl.org> <20050522192734.GB23388@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0505221332590.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun May 22 23:22:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZxtl-0000Ks-KZ
	for gcvg-git@gmane.org; Sun, 22 May 2005 23:22:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbVEVVXa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 May 2005 17:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbVEVVXa
	(ORCPT <rfc822;git-outgoing>); Sun, 22 May 2005 17:23:30 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:12788 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261724AbVEVVXT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2005 17:23:19 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4MLNDS8005964
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 22 May 2005 21:23:13 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4MLNDC4005962;
	Sun, 22 May 2005 23:23:13 +0200 (CEST)
To: GIT <git@vger.kernel.org>
Mail-Followup-To: GIT <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505221332590.2307@ppc970.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

> Sorry, I meant "rename", not "link", and yes, it should be NFS-safe. It's 
> how all the mailers do things too, afaik.

okay. I will doublecheck that and come back.

> As to your update-cache problem, it seems to be just due to NFS stat
> caching. You generally should _not_ work on two machines at the same time,
> but it probably does the right thing in the end.

I added some debugging output (see attached patch) and saw that the
reason for the invalid thing is that the inode has changed:

...
name: pull.h 0x00000010
name: read-cache.c 0x00000010
...

#define INODE_CHANGED   0x0010

Same problem tla had. It looked at the device number. And of course the
device number for NFS shares isn't the same on all machines. So I
attached a little patch which fixes the issue for me (and others).

> In general, I would suggest using separate GIT repositories over sharing
> them over NFS. As far as I'm concerned, I think NFS should work in the
> sense that you can work from different clients at _different_times_, and
> I'm certainly not going to guarantee that two different clients that work
> at the same time against the same repository will get sane results.

It is more like that I don't remember on which machine I worked last and
working accidently on my next free window in screen (and I have a lot of
windows). And getting 370 Mbyte over NFS hits my nerves. ;-)

> For example, if you do a "git-checkout-cache -f -a" at the same time, I 
> won't guarantee that things won't race on the working files. Don't do it.

I will not do that. And I will add locking for such operations in my frontend
anyway.

	Thomas

CRAP CRAP CRAP: This is just the patch which showed me the debugging
output:

diff --git a/update-cache.c b/update-cache.c
--- a/update-cache.c
+++ b/update-cache.c
@@ -174,6 +174,8 @@ static struct cache_entry *refresh_entry
 	if (!changed)
 		return ce;
 
+	fprintf(stderr, "name: %s 0x%08x\n", ce->name, changed);
+
 	/*
 	 * If the mode or type has changed, there's no point in trying
 	 * to refresh the entry - it's not going to match

Here is the real patch:

[PATCH] Don't include devicenumber into INODE_CHANGED test

This fixes the problem that git-update-cache --refresh rebuilds the
cache stat information everytime it is started on a different host while
working in the same NFS shared repository.

Signed-off-by: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>

diff --git a/read-cache.c b/read-cache.c
--- a/read-cache.c
+++ b/read-cache.c
@@ -65,8 +65,7 @@ int ce_match_stat(struct cache_entry *ce
 	if (ce->ce_uid != htonl(st->st_uid) ||
 	    ce->ce_gid != htonl(st->st_gid))
 		changed |= OWNER_CHANGED;
-	if (ce->ce_dev != htonl(st->st_dev) ||
-	    ce->ce_ino != htonl(st->st_ino))
+	if (ce->ce_ino != htonl(st->st_ino))
 		changed |= INODE_CHANGED;
 	if (ce->ce_size != htonl(st->st_size))
 		changed |= DATA_CHANGED;
