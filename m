From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH v2] daemon.c: avoid accessing ss_family member of struct sockaddr_storage
Date: Mon, 15 Mar 2010 17:10:06 -0500
Message-ID: <Ulrh6ePYHqfB90btctT3EMJiuUz4wjLndvupvp0xJR1sBAao-hZxS0PI6-IxWscYhjaEno7FzgY@cipher.nrlssc.navy.mil>
References: <alpine.DEB.2.00.1003152336520.29993@cone.home.martin.st>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, git@mlists.thewrittenword.com, peff@peff.net,
	kusmabite@gmail.com, drafnel@gmail.com
To: martin@martin.st
X-From: git-owner@vger.kernel.org Mon Mar 15 23:10:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrIUo-0003jD-AO
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 23:10:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936951Ab0COWKh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Mar 2010 18:10:37 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:51051 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936948Ab0COWKZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 18:10:25 -0400
Received: by mail.nrlssc.navy.mil id o2FMAJjg028546; Mon, 15 Mar 2010 17:10:19 -0500
In-Reply-To: <alpine.DEB.2.00.1003152336520.29993@cone.home.martin.st>
X-OriginalArrivalTime: 15 Mar 2010 22:10:19.0374 (UTC) FILETIME=[4CA3A8E0:01CAC48C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142263>

=46rom: Brandon Casey <drafnel@gmail.com>

When NO_SOCKADDR_STORAGE is set for a platform, either sockaddr_in or
sockaddr_in6 is used intead.  Neither of which has an ss_family member.
They have an sin_family and sin6_family member respectively.  Since the
addrcmp() function accesses the ss_family member of a sockaddr_storage
struct, compilation fails on platforms which define NO_SOCKADDR_STORAGE=
=2E

Since any sockaddr_* structure can be cast to a struct sockaddr and
have its sa_family member read, do so here to workaround this issue.

Thanks to Martin Storsj=C3=B6 for pointing out the fix, and Gary Vaugha=
n
for drawing attention to the issue.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


On 03/15/2010 04:37 PM, Martin Storsj=C3=B6 wrote:
> Coming to think about it, would it simplify the code even more if the=
=20
> function were to take a const struct sockaddr* as a parameter instead=
?=20
> That would, on the other hand, require more casts where it's called,=20
> though...

How about this.

-brandon


 daemon.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/daemon.c b/daemon.c
index 3769b6f..2e6766f 100644
--- a/daemon.c
+++ b/daemon.c
@@ -590,14 +590,17 @@ static int execute(struct sockaddr *addr)
 static int addrcmp(const struct sockaddr_storage *s1,
     const struct sockaddr_storage *s2)
 {
-	if (s1->ss_family !=3D s2->ss_family)
-		return s1->ss_family - s2->ss_family;
-	if (s1->ss_family =3D=3D AF_INET)
+	const struct sockaddr *sa1 =3D (const struct sockaddr*) s1;
+	const struct sockaddr *sa2 =3D (const struct sockaddr*) s2;
+
+	if (sa1->sa_family !=3D sa2->sa_family)
+		return sa1->sa_family - sa2->sa_family;
+	if (sa1->sa_family =3D=3D AF_INET)
 		return memcmp(&((struct sockaddr_in *)s1)->sin_addr,
 		    &((struct sockaddr_in *)s2)->sin_addr,
 		    sizeof(struct in_addr));
 #ifndef NO_IPV6
-	if (s1->ss_family =3D=3D AF_INET6)
+	if (sa1->sa_family =3D=3D AF_INET6)
 		return memcmp(&((struct sockaddr_in6 *)s1)->sin6_addr,
 		    &((struct sockaddr_in6 *)s2)->sin6_addr,
 		    sizeof(struct in6_addr));
--=20
1.6.6.2
