From: Junio C Hamano <junkio@cox.net>
Subject: Re: Problem with pack
Date: Sun, 27 Aug 2006 14:55:38 -0700
Message-ID: <7vpselx2qt.fsf@assigned-by-dhcp.cox.net>
References: <44F1DA25.3050403@arces.unibo.it>
	<Pine.LNX.4.64.0608271102450.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 27 23:55:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHSb4-0005YC-4B
	for gcvg-git@gmane.org; Sun, 27 Aug 2006 23:55:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbWH0VzK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Aug 2006 17:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbWH0VzK
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Aug 2006 17:55:10 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:48535 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750952AbWH0VzI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Aug 2006 17:55:08 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060827215507.PHHA4015.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>;
          Sun, 27 Aug 2006 17:55:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
	by fed1rmimpo01.cox.net with bizsmtp
	id F9v41V00G4Noztg0000000
	Sun, 27 Aug 2006 17:55:05 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0608271102450.27779@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 27 Aug 2006 11:27:04 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26120>

Linus Torvalds <torvalds@osdl.org> writes:

> NOTE! This is all assuming my theory that a packed entry was broken in the 
> first place was correct. We obviously still don't _know_ what the problem 
> was. So far it's just a theory.

But it is a good theory.  More plausible than alpha particle
hitting the output buffer of zlib at the right moment, although
the effects are the same ;-).

> So it might well be the case that we should simply add an extra integrity 
> check to the raw data copy in builtin-pack-objects.c: write_object().

I would agree that it is a sensible thing to do to insert check
at places shown in the attached.  The revalidate_pack_piece()
would:

 - decode object header to make sure it decodes to sensible
   enum object_type value from the start of the buffer given as
   its first argument;

 - if it is of type OBJ_DELTA, skip 20-byte base object name;

 - the second argument is the length of the piece -- make sure
   the above steps did not require more than the length;

 - make sure the remainder is sane by running inflate() into
   void.  When fed the remainder in full, inflate() should
   return Z_OK.

For the first step we need to refactor unpack_object_header() in
sha1_file.c a tiny bit to reuse it.

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 46f524d..0521cad 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -276,6 +282,7 @@ static unsigned long write_object(struct
 		map = map_sha1_file(entry->sha1, &mapsize);
 		if (map && !legacy_loose_object(map)) {
 			/* We can copy straight into the pack file */
+			revalidate_pack_piece(map, mapsize);
 			sha1write(f, map, mapsize);
 			munmap(map, mapsize);
 			written++;
@@ -319,6 +326,7 @@ static unsigned long write_object(struct
 
 		datalen = find_packed_object_size(p, entry->in_pack_offset);
 		buf = (char *) p->pack_base + entry->in_pack_offset;
+		revalidate_pack_piece(buf, datalen);
 		sha1write(f, buf, datalen);
 		unuse_packed_git(p);
 		hdrlen = 0; /* not really */
