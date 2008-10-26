From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Weird problem with long $PATH and alternates (bisected)
Date: Sun, 26 Oct 2008 18:53:17 +0100
Message-ID: <4904AE8D.9090706@lsrfire.ath.cx>
References: <237967ef0810260746w10e930c1sf36a2674f49afbe1@mail.gmail.com> <7vljwb5o4p.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Mikael Magnusson <mikachu@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 26 18:54:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ku9ox-0003C3-8l
	for gcvg-git-2@gmane.org; Sun, 26 Oct 2008 18:54:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901AbYJZRxV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Oct 2008 13:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751792AbYJZRxV
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Oct 2008 13:53:21 -0400
Received: from india601.server4you.de ([85.25.151.105]:45388 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbYJZRxV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2008 13:53:21 -0400
Received: from [10.0.1.101] (p57B7F906.dip.t-dialin.net [87.183.249.6])
	by india601.server4you.de (Postfix) with ESMTPSA id A45792F804C;
	Sun, 26 Oct 2008 18:53:19 +0100 (CET)
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
In-Reply-To: <7vljwb5o4p.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99175>

Junio C Hamano schrieb:
> "Mikael Magnusson" <mikachu@gmail.com> writes:
>=20
>> % mkdir 1; cd 1
>> % echo > a; git add a; git commit -m a
>> % cd ..
>> % git clone -s 1 2
>> % git push . master:master
>> fatal: Could not switch to
>> '/tmp/a/1/.git/objects/n:/usr/games/bin:/usr/local/ipod-chain'
>> fatal: The remote end hung up unexpectedly
>=20
> I think I see a bug in foreach_alt_odb() to add_refs_from_alternate()
> callchain, but I cannot explain why the contents of $PATH leaks to th=
e
> error message.

With the following patch, I can no longer reproduce the problem.  Does =
it
work fo you, too?

Thanks,
Ren=E9


diff --git a/sha1_file.c b/sha1_file.c
index ab2b520..8044e9c 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -269,7 +269,7 @@ static int link_alt_odb_entry(const char * entry, i=
nt len, const char * relative
 		entlen +=3D base_len;
 		pfxlen +=3D base_len;
 	}
-	ent =3D xmalloc(sizeof(*ent) + entlen);
+	ent =3D xcalloc(1, sizeof(*ent) + entlen);
=20
 	if (!is_absolute_path(entry) && relative_base) {
 		memcpy(ent->base, relative_base, base_len - 1);
