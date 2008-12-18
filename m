From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 4/5] Make 'diff_populate_filespec()' use the new   'strbuf_readlink()'
Date: Thu, 18 Dec 2008 17:56:51 +0100
Message-ID: <494A80D3.7070605@lsrfire.ath.cx>
References: <alpine.LFD.2.00.0812171034520.14014@localhost.localdomain>	<alpine.LFD.2.00.0812171042120.14014@localhost.localdomain>	<alpine.LFD.2.00.0812171042500.14014@localhost.localdomain>	<alpine.LFD.2.00.0812171043180.14014@localhost.localdomain>	<alpine.LFD.2.00.0812171043440.14014@localhost.localdomain> <20081218121118.3635c53c@crow>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Mark Burton <markb@ordern.com>
X-From: git-owner@vger.kernel.org Thu Dec 18 17:58:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDMCZ-0001iG-Ef
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 17:58:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbYLRQ5A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Dec 2008 11:57:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbYLRQ5A
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 11:57:00 -0500
Received: from india601.server4you.de ([85.25.151.105]:36808 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892AbYLRQ47 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 11:56:59 -0500
Received: from [10.0.1.101] (p57B7E582.dip.t-dialin.net [87.183.229.130])
	by india601.server4you.de (Postfix) with ESMTPSA id 0AB792F805F;
	Thu, 18 Dec 2008 17:56:56 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <20081218121118.3635c53c@crow>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103472>

Mark Burton schrieb:
> Howdy folks,
>=20
> When I compile this latest version of diff.c on a i686 dual-core Pent=
ium box
> I see:
>=20
> diff.c: In function =E2=80=98diff_populate_filespec=E2=80=99:
> diff.c:1781: warning: passing argument 2 of =E2=80=98strbuf_detach=E2=
=80=99 from incompatible pointer type
>=20
> The same code compiles without warning on a x86_64 AMD box. Both
> machines are running stock Ubuntu 8.04.
>=20
> Does it need a cast on some architectures?

The type of the size member of struct stat is off_t, while strbuf_detac=
h expects
a size_t pointer.  This patch should fix the warning:

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
