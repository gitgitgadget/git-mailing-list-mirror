From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] daemon.c: avoid accessing ss_family member of struct sockaddr_storage
Date: Mon, 15 Mar 2010 16:03:00 -0500
Message-ID: <XI3O9HirgFwPkEqC3RdYR4j56mg_uuJQZk1YFST6ukqbKXjgxaqJdNDHwlLXg5R_FVXWmWQSGmg@cipher.nrlssc.navy.mil>
References: <alpine.DEB.2.00.1003120922040.29993@cone.home.martin.st>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@mlists.thewrittenword.com, peff@peff.net, kusmabite@gmail.com,
	martin@martin.st, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 15 22:03:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrHRx-00078U-MW
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 22:03:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936741Ab0COVDk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Mar 2010 17:03:40 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:49060 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936705Ab0COVDj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 17:03:39 -0400
Received: by mail.nrlssc.navy.mil id o2FL3WKo024438; Mon, 15 Mar 2010 16:03:32 -0500
In-Reply-To: <alpine.DEB.2.00.1003120922040.29993@cone.home.martin.st>
X-OriginalArrivalTime: 15 Mar 2010 21:03:32.0158 (UTC) FILETIME=[F82705E0:01CAC482]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142249>

=46rom: Brandon Casey <drafnel@gmail.com>

When NO_SOCKADDR_STORAGE is set for a platform, either sockaddr_in or
sockaddr_in6 is used intead.  Neither of which has an ss_family member.
They have an sin_family and sin6_family member respectively.  Since the
addrcmp() function accesses the ss_family member of a sockaddr_storage
struct, compilation fails on platforms which define NO_SOCKADDR_STORGAG=
E.

Since any sockaddr_* structure can be cast to a struct sockaddr and
have its sa_family member read, do so here to workaround this issue.

Thanks to Martin Storsj=C3=B6 for pointing out the fix, and Gary Vaugha=
n
for drawing attention to the issue.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 daemon.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/daemon.c b/daemon.c
index 3769b6f..8a52fdc 100644
--- a/daemon.c
+++ b/daemon.c
@@ -590,9 +590,11 @@ static int execute(struct sockaddr *addr)
 static int addrcmp(const struct sockaddr_storage *s1,
     const struct sockaddr_storage *s2)
 {
-	if (s1->ss_family !=3D s2->ss_family)
-		return s1->ss_family - s2->ss_family;
-	if (s1->ss_family =3D=3D AF_INET)
+	if (((const struct sockaddr*) s1)->sa_family !=3D
+	    ((const struct sockaddr*) s2)->sa_family)
+		return ((const struct sockaddr*) s1)->sa_family -
+		       ((const struct sockaddr*) s2)->sa_family;
+	if (((const struct sockaddr*) s1)->sa_family =3D=3D AF_INET)
 		return memcmp(&((struct sockaddr_in *)s1)->sin_addr,
 		    &((struct sockaddr_in *)s2)->sin_addr,
 		    sizeof(struct in_addr));
--=20
1.6.6.2
