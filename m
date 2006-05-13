From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix git-pack-objects for 64-bit platforms
Date: Fri, 12 May 2006 22:58:23 -0700
Message-ID: <7viroav534.fsf@assigned-by-dhcp.cox.net>
References: <20060511173632.G60c08b4@leonov.stosberg.net>
	<Pine.LNX.4.64.0605111054290.3866@g5.osdl.org>
	<7v7j4swg0r.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605111218380.3866@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dennis Stosberg <dennis@stosberg.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 13 07:58:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fen9H-0001LA-9e
	for gcvg-git@gmane.org; Sat, 13 May 2006 07:58:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbWEMF6Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 May 2006 01:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbWEMF6Z
	(ORCPT <rfc822;git-outgoing>); Sat, 13 May 2006 01:58:25 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:17911 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932343AbWEMF6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 May 2006 01:58:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060513055824.FOYX17501.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 13 May 2006 01:58:24 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605111218380.3866@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 11 May 2006 12:27:48 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19927>

Linus Torvalds <torvalds@osdl.org> writes:

> Since I _do_ have a 64-bit big-endian architecture, I decided to install 
> some of the 64-bit development libraries that I didn't already have, and I 
> added "-m64" to the compiler flags.
>
> All the tests seem to pass with the simple fix (and without it, we do 
> indeed fail at least t5700-clone-reference.sh).
>
> Of course, there might well be something else that doesn't get coverage, 
> but passing all tests is at least a good sign. And since x86-64 has been 
> getting pretty extensive coverage, I don't think we have a lot of 64-bit 
> bugs per se, this one just happened to hide.
>
> 		Linus

Thanks, both.  This is what I am thinking of applying (but I am
sort of burned-out right now after a two-day meeting with my
sponsors, so the real work will be tomorrow).

It takes the uint32_t version but matches another place to use
that type instead of "int" (which would not matter in next 10
years perhaps).

-- >8 --

diff --git a/pack-objects.c b/pack-objects.c
index c0acc46..a81d609 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -156,7 +156,7 @@ static void prepare_pack_revindex(struct
 
 	rix->revindex = xmalloc(sizeof(unsigned long) * (num_ent + 1));
 	for (i = 0; i < num_ent; i++) {
-		long hl = *((long *)(index + 24 * i));
+		uint32_t hl = *((uint32_t *)(index + 24 * i));
 		rix->revindex[i] = ntohl(hl);
 	}
 	/* This knows the pack format -- the 20-byte trailer
diff --git a/sha1_file.c b/sha1_file.c
index f2d33af..642c45a 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1126,7 +1126,7 @@ int find_pack_entry_one(const unsigned c
 		int mi = (lo + hi) / 2;
 		int cmp = memcmp(index + 24 * mi + 4, sha1, 20);
 		if (!cmp) {
-			e->offset = ntohl(*((int*)(index + 24 * mi)));
+			e->offset = ntohl(*((uint32_t *)(index + 24 * mi)));
 			memcpy(e->sha1, sha1, 20);
 			e->p = p;
 			return 1;
