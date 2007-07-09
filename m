From: Junio C Hamano <gitster@pobox.com>
Subject: Re: rerere fails to record resolution if file doesn't exist in merge base
Date: Mon, 09 Jul 2007 01:22:29 -0700
Message-ID: <7vps32ugu2.fsf@assigned-by-dhcp.cox.net>
References: <20070709070725.GA4445@lala>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Mon Jul 09 10:22:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7oW0-0000Sc-Gd
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 10:22:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbXGIIWc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 9 Jul 2007 04:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbXGIIWc
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 04:22:32 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:55721 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043AbXGIIWb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Jul 2007 04:22:31 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070709082230.EXRT22777.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Mon, 9 Jul 2007 04:22:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id MLNV1X0061kojtg0000000; Mon, 09 Jul 2007 04:22:30 -0400
In-Reply-To: <20070709070725.GA4445@lala> (Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=
 =?utf-8?Q?'s?= message of
	"Mon, 9 Jul 2007 09:07:25 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51971>

Uwe Kleine-K=C3=B6nig  <ukleinek@informatik.uni-freiburg.de> writes:

> Anyhow, the failure still exists, even though the original report was
> sent when rerere was still a perl script ...
>
> 	zeisberg@cassiopeia:/tmp/rerere$ git init
> 	Initialized empty Git repository in .git/
> 	zeisberg@cassiopeia:/tmp/rerere$ mkdir .git/rerere

This should be creating .git/rr-cache, but what you said in your
message is correct regardless.

> In my eyes the last command should have recorded the resolution for
> lolo, shouldn't it?

I think two-file merge (ancestor did not have it, and you and he
added the path differently) is rare enough that it was dropped
outside of the radar.  A fix would probably be a trivial change
to builtin-rerere.c::find_conflict(), I think.  While it would
still be sane to insist that we do not do rerere for symlinks,
and require to have stages #2 and #3, we should be able to drop
the requirement to have stage #1.  rerere does not use
information from there anyway.

Not even compile tested, but something like this should do.

 builtin-rerere.c |   17 +++++++----------
 1 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/builtin-rerere.c b/builtin-rerere.c
index c25b3d5..6ffc43d 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -168,19 +168,16 @@ static int find_conflict(struct path_list *confli=
ct)
 	int i;
 	if (read_cache() < 0)
 		return error("Could not read index");
-	for (i =3D 0; i + 2 < active_nr; i++) {
-		struct cache_entry *e1 =3D active_cache[i];
-		struct cache_entry *e2 =3D active_cache[i+1];
-		struct cache_entry *e3 =3D active_cache[i+2];
-		if (ce_stage(e1) =3D=3D 1 &&
-		    ce_stage(e2) =3D=3D 2 &&
+	for (i =3D 0; i+1 < active_nr; i++) {
+		struct cache_entry *e2 =3D active_cache[i];
+		struct cache_entry *e3 =3D active_cache[i+1];
+		if (ce_stage(e2) =3D=3D 2 &&
 		    ce_stage(e3) =3D=3D 3 &&
-		    ce_same_name(e1, e2) && ce_same_name(e1, e3) &&
-		    S_ISREG(ntohl(e1->ce_mode)) &&
+		    ce_same_name(e2, e3) &&
 		    S_ISREG(ntohl(e2->ce_mode)) &&
 		    S_ISREG(ntohl(e3->ce_mode))) {
-			path_list_insert((const char *)e1->name, conflict);
-			i +=3D 2;
+			path_list_insert((const char *)e2->name, conflict);
+			i++; /* skip over both #2 and #3 */
 		}
 	}
 	return 0;
