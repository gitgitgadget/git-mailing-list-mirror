From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Alternate Patch: [PATCH] Don't include device number in cache invalidation when running on NFS
Date: Sun, 22 May 2005 23:41:15 +0200
Message-ID: <20050522214115.GD23388@cip.informatik.uni-erlangen.de>
References: <20050522122849.GJ15178@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0505221205580.2307@ppc970.osdl.org> <20050522192734.GB23388@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0505221332590.2307@ppc970.osdl.org> <20050522212312.GC23388@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun May 22 23:41:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZyB7-0001hc-CX
	for gcvg-git@gmane.org; Sun, 22 May 2005 23:40:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbVEVVlY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 May 2005 17:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbVEVVlY
	(ORCPT <rfc822;git-outgoing>); Sun, 22 May 2005 17:41:24 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:4856 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261780AbVEVVlT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2005 17:41:19 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4MLfFS8007238
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 22 May 2005 21:41:15 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4MLfFVc007237;
	Sun, 22 May 2005 23:41:15 +0200 (CEST)
To: GIT <git@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
Mail-Followup-To: GIT <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <20050522212312.GC23388@cip.informatik.uni-erlangen.de>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

* Thomas Glanzmann <sithglan@stud.uni-erlangen.de> [050522 23:24]:
> Hello,

> > Sorry, I meant "rename", not "link", and yes, it should be NFS-safe. It's 
> > how all the mailers do things too, afaik.

> okay. I will doublecheck that and come back.

yes, you're right.

While reading liblockfile I saw the following:

/*
 *      See if the directory where is certain file is in
 *      is located on an NFS mounted volume.
 */
static int is_nfs(const char *file)
{
        char dir[1024];
        char *s;
        struct stat st;

        strncpy(dir, file, sizeof(dir));
        if ((s = strrchr(dir, '/')) != NULL)
                *s = 0;
        else
                strcpy(dir, ".");

        if (stat(dir, &st) < 0)
                return 0;

        return ((st.st_dev & 0xFF00) == 0);
}

So here comes an alternate patch if you like to verify the st_dev for non
NFS stuff. Also tested.

[PATCH] Don't include device number in cache invalidation when running on NFS

This patches includes the device number only in the cache invalidation
process when not running on a NFS volume.

Signed-off-by: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>

diff --git a/read-cache.c b/read-cache.c
--- a/read-cache.c
+++ b/read-cache.c
@@ -65,8 +65,11 @@ int ce_match_stat(struct cache_entry *ce
 	if (ce->ce_uid != htonl(st->st_uid) ||
 	    ce->ce_gid != htonl(st->st_gid))
 		changed |= OWNER_CHANGED;
-	if (ce->ce_dev != htonl(st->st_dev) ||
-	    ce->ce_ino != htonl(st->st_ino))
+	/* Only include device number if not running on NFS */
+	if (ce->ce_dev != htonl(st->st_dev) &&
+	    ((st->st_dev & 0xFF00) == 0))
+		changed |= INODE_CHANGED;
+	if (ce->ce_ino != htonl(st->st_ino))
 		changed |= INODE_CHANGED;
 	if (ce->ce_size != htonl(st->st_size))
 		changed |= DATA_CHANGED;
