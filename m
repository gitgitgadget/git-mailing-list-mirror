From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] diff.c: fix pointer type warning
Date: Fri, 19 Dec 2008 23:10:48 +0100
Message-ID: <494C1BE8.20607@lsrfire.ath.cx>
References: <alpine.LFD.2.00.0812171034520.14014@localhost.localdomain>	<alpine.LFD.2.00.0812171042120.14014@localhost.localdomain>	<alpine.LFD.2.00.0812171042500.14014@localhost.localdomain>	<alpine.LFD.2.00.0812171043180.14014@localhost.localdomain>	<alpine.LFD.2.00.0812171043440.14014@localhost.localdomain> <20081218121118.3635c53c@crow>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Burton <markb@ordern.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 19 23:13:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDnah-0006Fs-CX
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 23:13:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758536AbYLSWK4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Dec 2008 17:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756629AbYLSWK4
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 17:10:56 -0500
Received: from india601.server4you.de ([85.25.151.105]:32788 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758522AbYLSWKz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2008 17:10:55 -0500
Received: from [10.0.1.101] (p57B7D545.dip.t-dialin.net [87.183.213.69])
	by india601.server4you.de (Postfix) with ESMTPSA id 1D0FD2F805F;
	Fri, 19 Dec 2008 23:10:53 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <20081218121118.3635c53c@crow>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103588>

As Mark Burton noted, the conversion to strbuf_readlink() caused a
compile warning on some architectures:

> diff.c: In function =E2=80=98diff_populate_filespec=E2=80=99:
> diff.c:1781: warning: passing argument 2 of =E2=80=98strbuf_detach=E2=
=80=99 from incompatible pointer type

A pointer to an unsigned long is given while a pointer to a size_t is
expected; the two types are not considered to be equivalent everywhere.

The real fix would be to change the type of the size member of struct
diff_filespec to size_t, but that would cause other warnings in
connection with functions expecting unsigned long, and attempts to fix
them might loose an avalanche of changes.  Later.  This patch just
silences the warning by adding an (implicit) casting step.

Reported-by: Mark Burton <markb@ordern.com>
Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 diff.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/diff.c b/diff.c
index f160c1a..0484601 100644
--- a/diff.c
+++ b/diff.c
@@ -1778,7 +1778,8 @@ int diff_populate_filespec(struct diff_filespec *=
s, int size_only)
=20
 			if (strbuf_readlink(&sb, s->path, s->size))
 				goto err_empty;
-			s->data =3D strbuf_detach(&sb, &s->size);
+			s->size =3D sb.len;
+			s->data =3D strbuf_detach(&sb, NULL);
 			s->should_free =3D 1;
 			return 0;
 		}
