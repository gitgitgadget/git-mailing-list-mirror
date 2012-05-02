From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH v2 05/10] archive-tar: allow to accumulate writes before
 writing 512-byte blocks
Date: Wed, 02 May 2012 16:28:39 +0200
Message-ID: <4FA14497.5090203@lsrfire.ath.cx>
References: <1335965122-17458-1-git-send-email-pclouds@gmail.com> <1335965122-17458-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 02 16:28:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPaXu-0004iY-6r
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 16:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754387Ab2EBO2m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 May 2012 10:28:42 -0400
Received: from india601.server4you.de ([85.25.151.105]:58204 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752382Ab2EBO2l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 10:28:41 -0400
Received: from [192.168.2.105] (p4FFD98FB.dip.t-dialin.net [79.253.152.251])
	by india601.server4you.de (Postfix) with ESMTPSA id 0CC7F2F804F;
	Wed,  2 May 2012 16:28:40 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120420 Thunderbird/12.0
In-Reply-To: <1335965122-17458-6-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196825>

Am 02.05.2012 15:25, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy:
> This allows to split single write_blocked(buf, 123) call into multipl=
e
> calls
>=20
> write_blocked(buf, 100, 1);
> write_blocked(buf,  23, 1);
> write_blocked(buf,   0, 0);
>=20
> No call sites do this yet though.
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy<pclouds@gmai=
l.com>
> ---
>   archive-tar.c |   16 +++++++++-------
>   1 files changed, 9 insertions(+), 7 deletions(-)

Hmm, I'm not a fan of adding binary parameters to distinguish between t=
wo
modes of a function.  It's usually better to split it up at that point.
E.g. the patch below does that and still provides the old interface, i.=
e.
the existing callers don't need to be changed.


 archive-tar.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 20af005..a2babe1 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -30,10 +30,9 @@ static void write_if_needed(void)
  * queues up writes, so that all our write(2) calls write exactly one
  * full block; pads writes to RECORDSIZE
  */
-static void write_blocked(const void *data, unsigned long size)
+static void do_write_blocked(const void *data, unsigned long size)
 {
 	const char *buf =3D data;
-	unsigned long tail;
=20
 	if (offset) {
 		unsigned long chunk =3D BLOCKSIZE - offset;
@@ -54,6 +53,12 @@ static void write_blocked(const void *data, unsigned=
 long size)
 		memcpy(block + offset, buf, size);
 		offset +=3D size;
 	}
+}
+
+static void finish_record(void)
+{
+	unsigned long tail;
+
 	tail =3D offset % RECORDSIZE;
 	if (tail)  {
 		memset(block + offset, 0, RECORDSIZE - tail);
@@ -62,6 +67,12 @@ static void write_blocked(const void *data, unsigned=
 long size)
 	write_if_needed();
 }
=20
+static void write_blocked(const void *data, unsigned long size)
+{
+	do_write_blocked(data, size);
+	finish_record();
+}
+
 /*
  * The end of tar archives is marked by 2*512 nul bytes and after that
  * follows the rest of the block (if any).
