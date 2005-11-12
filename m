From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Remove unneeded packs
Date: Sat, 12 Nov 2005 14:30:38 +0100
Message-ID: <1131802238.29461.18.camel@blade>
References: <1131800663.29461.11.camel@blade>  <4375EA80.7070405@op5.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-xO+SxgdC5z4ebuvB7nTw"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 12 14:31:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EavT1-0001oE-46
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 14:30:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbVKLNad (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 08:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbVKLNad
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 08:30:33 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:33177 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S932281AbVKLNac
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Nov 2005 08:30:32 -0500
Received: from blade (p5487E170.dip.t-dialin.net [84.135.225.112])
	by mail.holtmann.net (8.12.3/8.12.3/Debian-7.1) with ESMTP id jACDUlGB026914
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Sat, 12 Nov 2005 14:30:48 +0100
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <4375EA80.7070405@op5.se>
X-Mailer: Evolution 2.5.1 
X-Virus-Scanned: ClamAV 0.85.1/1169/Fri Nov 11 22:28:05 2005 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11685>


--=-xO+SxgdC5z4ebuvB7nTw
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Andreas,

> > every time Linus re-creates the pack for his linux-2.6 tree, I end up
> > with another pack. I use HTTP as transport and thus the new pack will be
> > download (which is almost 100 MB), but that is fine. However it seems
> > that the old (previous) pack will never be deleted. For the no longer
> > needed object files I can use git-prune-packed, but the old pack I have
> > to identify and delete by myself. Exists an easy and nice way to get rid
> > of old unneeded packs? Can't git-prune-packed also do this job?
> > 
> 
> A patchset was posted to the list 2005-11-09 by Lukas Sandström, adding 
> "git-pack-intersect" which was subsequently renamed to the more 
> appropriate "git-pack-redundant".
> 
> If I remember the commit messages and understand your question correctly 
> it does what you want.

you are right. It is exactly what I was looking for. I just saw it some
minutes ago, when I pulled the latest git tree. However to make an old
GCC 2.95 happy, the attached patch is needed.

I am not sure if it is fully working. It deletes a lot of old packs, but
in case of the linux-2.6 tree it leaves on additional behind.

.git/objects/pack/pack-4d7682fb8230fef33eb518fa8e53885ec675795e.idx
.git/objects/pack/pack-4d7682fb8230fef33eb518fa8e53885ec675795e.pack
.git/objects/pack/pack-b3c6fbdfa36a326815de6358885c7a570a986b1b.pack
.git/objects/pack/pack-b3c6fbdfa36a326815de6358885c7a570a986b1b.idx

The 4d76... is the current pack, but the b3c6... is an old one that is
not needed anymore.

Regards

Marcel


--=-xO+SxgdC5z4ebuvB7nTw
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=utf-8
Content-Transfer-Encoding: 7bit

diff --git a/pack-redundant.c b/pack-redundant.c
index 1f8c577..4ed974e 100644
--- a/pack-redundant.c
+++ b/pack-redundant.c
@@ -358,11 +358,11 @@ size_t sizeof_union(struct packed_git *p
 size_t get_pack_redundancy(struct pack_list *pl)
 {
 	struct pack_list *subset;
+	size_t ret = 0;
 
 	if (pl == NULL)
 		return 0;
 
-	size_t ret = 0;
 	while ((subset = pl->next)) {
 		while(subset) {
 			ret += sizeof_union(pl->pack, subset->pack);

--=-xO+SxgdC5z4ebuvB7nTw--
