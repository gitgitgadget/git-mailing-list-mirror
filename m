From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: [PATCH] name-rev: Fix segmentation fault when using --all
Date: Fri, 6 Jun 2008 01:31:55 +0200
Message-ID: <20080605233155.GA21698@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 01:32:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4Owx-0005Y1-Ii
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 01:32:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753823AbYFEXcB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Jun 2008 19:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753467AbYFEXcA
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 19:32:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:58545 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753138AbYFEXcA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 19:32:00 -0400
Received: (qmail invoked by alias); 05 Jun 2008 23:31:57 -0000
Received: from i577B9D3D.versanet.de (EHLO atjola.local) [87.123.157.61]
  by mail.gmx.net (mp041) with SMTP; 06 Jun 2008 01:31:57 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18tmslo8KMtykXhmuH+pxwkJXQ1RpAQHBzUXPCz91
	RL77MBOeR22i0X
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84000>

In commit da2478db "describe --always: fall back to showing an
abbreviated object name" we lost the check that skips empty entries in
the object hash table when iterating over it in cmd_name_rev. That may
cause a NULL pointer being handed to show_name(), leading to a
segmentation fault. So add that check back again.

Signed-off-by: Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>
---
I'm not totally sure if adding the check back to the loop is the correc=
t
fix, or if I should have added it to show_name(), but as the empty
entries in the object hash table are a property of that table, I figure=
d
that it's not show_name()'s business to handle that.

 builtin-name-rev.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin-name-rev.c b/builtin-name-rev.c
index cde5de5..f153da0 100644
--- a/builtin-name-rev.c
+++ b/builtin-name-rev.c
@@ -280,9 +280,13 @@ int cmd_name_rev(int argc, const char **argv, cons=
t char *prefix)
 		int i, max;
=20
 		max =3D get_max_object_index();
-		for (i =3D 0; i < max; i++)
-			show_name(get_indexed_object(i), NULL,
+		for (i =3D 0; i < max; i++) {
+			struct object *obj =3D get_indexed_object(i);
+			if (!obj)
+				continue;
+			show_name(obj, NULL,
 				  always, allow_undefined, data.name_only);
+		}
 	} else {
 		int i;
 		for (i =3D 0; i < revs.nr; i++)
--=20
1.5.6.rc1.dirty
