From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: unpack_entry (was: [BUG] commit walk machinery is dangerous !)
Date: Tue, 15 Jul 2008 05:10:56 +0000
Message-ID: <20080715051056.GI2432@spearce.org>
References: <alpine.LFD.1.10.0807141641110.12484@xanadu.home> <7vbq10f7wr.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.10.0807141904250.12484@xanadu.home> <7vod50dote.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 07:12:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIcpR-0006FN-45
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 07:11:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753087AbYGOFK6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 01:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753147AbYGOFK6
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 01:10:58 -0400
Received: from george.spearce.org ([209.20.77.23]:49574 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752424AbYGOFK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 01:10:57 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 86A0C3836B; Tue, 15 Jul 2008 05:10:56 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vod50dote.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88524>

Junio C Hamano <gitster@pobox.com> wrote:
> This is unrelated to the issue at hand, but I also notice that there are
> few callsites outside sha1_file.c that bypasses cache_or_unpack_entry()
> and call unpack_entry() directly.  I wonder if they should be using the
> cached version, making unpack_entry() static...

There are two such callsites that I found:

$ git grep -n --cached unpack_entry
fast-import.c:1201:     return unpack_entry(p, oe->offset, &type, sizep);
pack-check.c:114:               data = unpack_entry(p, entries[i].offset, &type,

Now the one in fast-import.c could be using the cached version.
This is simply fast-import trying to reuse sha1_file.c for reading
a previously written object to the pack.

Stuffing the item into the cache is perhaps pointless here as gfi
does its own sort of caching and only goes through this code path
when that caching has tossed the least-recently-used data and its
suddenly needed again.

So yea, it could be using the caching form, but it would maybe be
doing more work (and using more memory) than it really needs.


In pack-check.c we are looping through the objects in the order they
appear in the index so we can unpack them and verify each object's
SHA-1 signature.  Please note this is perhaps the slowest way to
enumerate through the pack and is why you can clone a repository
over git:// faster than you can run `fsck --full`.

If you really want to verify every single object's SHA-1, run the
damn pack through index-pack and compare the new index to the old
index (hint they should be identical, bit-for-bit).

So again, in this case the caching may only cause us to do more
work (and use more memory) than we need as we are slamming the
delta base cache with all sorts of unrelated base objects.  It
probably has a low hit ratio anyway during this loop.  :-|

-- 
Shawn.
