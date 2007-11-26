From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH v2] builtin-commit: Include the diff in the commit
	message when verbose.
Date: Mon, 26 Nov 2007 10:21:15 -0500
Message-ID: <1196090475.2875.10.camel@hinata.boston.redhat.com>
References: <1195700089-8326-1-git-send-email-krh@redhat.com>
	 <Pine.LNX.4.64.0711221049350.27959@racer.site>
	 <7vzlx63xey.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 16:29:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iwftq-0004hJ-3W
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 16:29:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbXKZP3L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Nov 2007 10:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbXKZP3K
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 10:29:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:40902 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750716AbXKZP3J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 10:29:09 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lAQFLVd3012718;
	Mon, 26 Nov 2007 10:21:31 -0500
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lAQFLMOk003928;
	Mon, 26 Nov 2007 10:21:30 -0500
Received: from [192.168.1.100] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lAQFLKV1003461;
	Mon, 26 Nov 2007 10:21:20 -0500
In-Reply-To: <7vzlx63xey.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.11.90 (2.11.90-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66076>


On Thu, 2007-11-22 at 11:14 -0800, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>=20
> > On Wed, 21 Nov 2007, Kristian H=C3=B8gsberg wrote:
> >
> >> +
> >> +	/* Truncate the message just before the diff, if any. */
> >> +	p =3D strstr(sb.buf, "\ndiff --git a/");
> >> +	if (p !=3D NULL)
> >> +		strbuf_setlen(&sb, p - sb.buf);
> >> +
> >
> > Is this related to the change in wt_status?  If so, wouldn't we wan=
t to=20
> > suppress the diff, instead of generating it, and then killing it la=
ter?
>=20
> This corresponds to the sed script near l.545 in git-commit.sh.
>=20
> I've been wondering if it would be better not to have this logic
> but instead "git commit -v" to show the diff text prefixed with
> '# ' to make it a proper comment, by the way.

Yeah, that would be nicer... I think the best way to do this is to do a
formatting callback for the diff machinery as Jeff suggests, which can
then prefix '# ' and write it to a FILE *.

> > Besides, you'd want to leave the \n there: strbuf_setlen(&sb, p + 1=
 -=20
> > sb.buf);
>=20
> Yup.

Right, off-by-one.  Effectively it doesn't make a difference, since
there will always be a comment line above the diff,  When stripspace
removes the comments it fixes up the end-of-line problem.  Patch below.

cheers,
Kristian


>From 58eac54a00d3eb6a311c6fb4faa67eb831c60e01 Mon Sep 17 00:00:00 2001
=46rom: =3D?utf-8?q?Kristian=3D20H=3DC3=3DB8gsberg?=3D <krh@redhat.com>
Date: Mon, 26 Nov 2007 10:16:08 -0500
Subject: [PATCH] Fix off-by-one error when truncating the diff out of t=
he commit message.
MIME-Version: 1.0
Content-Type: text/plain; charset=3Dutf-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
---
 builtin-commit.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 45e51b1..330f778 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -762,7 +762,7 @@ int cmd_commit(int argc, const char **argv, const c=
har *prefix)
 	/* Truncate the message just before the diff, if any. */
 	p =3D strstr(sb.buf, "\ndiff --git a/");
 	if (p !=3D NULL)
-		strbuf_setlen(&sb, p - sb.buf);
+		strbuf_setlen(&sb, p - sb.buf + 1);
=20
 	stripspace(&sb, 1);
 	if (sb.len < header_len || message_is_empty(&sb, header_len)) {
--=20
1.5.3.4.206.g58ba4
