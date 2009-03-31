From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: [PATCH] tree_entry_interesting: Only recurse when the pathspec is
	a leading path component
Date: Tue, 31 Mar 2009 17:05:01 +0200
Message-ID: <20090331150501.GA11446@atjola.homenet>
References: <20090331094107.GC3307@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>, Anton Gyllenberg <anton@iki.fi>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 17:07:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LofXz-0006nr-Q9
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 17:06:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760993AbZCaPFK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Mar 2009 11:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760849AbZCaPFK
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 11:05:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:45209 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759206AbZCaPFI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 11:05:08 -0400
Received: (qmail invoked by alias); 31 Mar 2009 15:05:05 -0000
Received: from i59F54235.versanet.de (EHLO atjola.local) [89.245.66.53]
  by mail.gmx.net (mp006) with SMTP; 31 Mar 2009 17:05:05 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/SCdYfNCDSsSuRodvniXMojV7S7Ww/tvB4yMy+t3
	u/FEfAAqtrT4im
Content-Disposition: inline
In-Reply-To: <20090331094107.GC3307@atjola.homenet>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115265>

Previously the code did a simple prefix match, which means that it
treated for example "foo/" as a subdirectory of "f".

Signed-off-by: Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>
---
I'm not exactly happy with the commit message, but that's the best I
could come up with. Probably shows how little I know about that code :-=
/
The test suite still passes and I'll try to provide a new testcase
tonight or tommorow.

 tree-diff.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index 9f67af6..b05d0f4 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -118,10 +118,16 @@ static int tree_entry_interesting(struct tree_des=
c *desc, const char *base, int
 				continue;
=20
 			/*
-			 * The base is a subdirectory of a path which
-			 * was specified, so all of them are interesting.
+			 * If the base is a subdirectory of a path which
+			 * was specified, all of them are interesting.
 			 */
-			return 2;
+			if (!matchlen ||
+			    base[matchlen] =3D=3D '/' ||
+			    match[matchlen - 1] =3D=3D '/')
+				return 2;
+
+			/* Just a random prefix match */
+			continue;
 		}
=20
 		/* Does the base match? */
--=20
1.6.2.1.426.gf94cd
