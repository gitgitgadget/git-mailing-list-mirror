From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Correct pack memory leak causing git gc to try to exceed
	ulimit
Date: Wed, 9 Jul 2008 07:10:07 +0000
Message-ID: <20080709071007.GA31974@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 09:11:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGTpT-0002Bw-GM
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 09:11:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049AbYGIHKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 03:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752018AbYGIHKI
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 03:10:08 -0400
Received: from george.spearce.org ([209.20.77.23]:49965 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119AbYGIHKH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 03:10:07 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 17634381FC; Wed,  9 Jul 2008 07:10:07 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87854>

When recursing to unpack a delta base we must unuse_pack() so that
the pack window for the current object does not remain pinned in
memory while the delta base is itself being unpacked and materialized
for our use.

On a long delta chain of 50 objects we may need to access 6 different
windows from a very large (>3G) pack file in order to obtain all
of the delta base content.  If the process ulimit permits us to
map/allocate only 1.5G we must release windows during this recursion
to ensure we stay within the ulimit and transition memory from pack
cache to standard malloc, or other mmap needs.

Inserting an unuse_pack() call prior to the recursion allows us to
avoid pinning the current window, making it available for garbage
collection if memory runs low.

This has been broken since at least before 1.5.1-rc1, and very
likely earlier than that.  Its fixed now.  :)

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 sha1_file.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index d1c4060..10346b6 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1609,6 +1609,7 @@ static void *unpack_delta_entry(struct packed_git *p,
 	off_t base_offset;
 
 	base_offset = get_delta_base(p, w_curs, &curpos, *type, obj_offset);
+	unuse_pack(w_curs);
 	base = cache_or_unpack_entry(p, base_offset, &base_size, type, 0);
 	if (!base)
 		die("failed to read delta base object"
-- 
1.5.6.74.g8a5e
