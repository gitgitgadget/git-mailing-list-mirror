From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Serious bug with pretty format strings & empty bodies?
Date: Thu, 20 Dec 2007 13:20:15 +0100
Message-ID: <476A5DFF.40803@lsrfire.ath.cx>
References: <57518fd10712190632o490af924n61326fddf1819014@mail.gmail.com>	 <20071219184457.GC3015@steel.home>	 <57518fd10712191437s6f192feds50d006fdfc624444@mail.gmail.com>	 <4769A7FB.1070904@lsrfire.ath.cx> <57518fd10712200244o656c7f44j426cc71c89515de3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Thu Dec 20 13:21:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5KOd-00042X-Qu
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 13:21:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758741AbXLTMUj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Dec 2007 07:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758229AbXLTMUj
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 07:20:39 -0500
Received: from india601.server4you.de ([85.25.151.105]:40045 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758203AbXLTMUi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2007 07:20:38 -0500
Received: from [10.0.1.201] (p57B7E0E2.dip.t-dialin.net [87.183.224.226])
	by india601.server4you.de (Postfix) with ESMTP id 14DBD2F8072;
	Thu, 20 Dec 2007 13:20:37 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <57518fd10712200244o656c7f44j426cc71c89515de3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68999>

Jonathan del Strother schrieb:
> On Dec 19, 2007 11:23 PM, Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx=
> wrote:
>> Just a shot in the dark: does this patch on top of master make a dif=
ference?
> No luck with that, I'm afraid.

And how is this one?

The first chunk is the same as in the last try -- it guards against com=
mit
messages ending with a NUL without a prior \n _and_ being followed by a=
 \n
(in memory which shouldn't be accessed by us at all as it doesn't belon=
g to
the commit message).  I guess that's quite rare.

The second chunk keeps the body offset from being incremented by the fo=
r
loop if we've already found a terminating NUL.

diff --git a/pretty.c b/pretty.c
index 9db75b4..5b1078b 100644
--- a/pretty.c
+++ b/pretty.c
@@ -412,7 +412,7 @@ static void parse_commit_header(struct format_commi=
t_context *context)
 		if (i =3D=3D eol) {
 			state++;
 			/* strip empty lines */
-			while (msg[eol + 1] =3D=3D '\n')
+			while (msg[eol] =3D=3D '\n' && msg[eol + 1] =3D=3D '\n')
 				eol++;
 		} else if (!prefixcmp(msg + i, "author ")) {
 			context->author.off =3D i + 7;
@@ -425,6 +425,8 @@ static void parse_commit_header(struct format_commi=
t_context *context)
 			context->encoding.len =3D eol - i - 9;
 		}
 		i =3D eol;
+		if (!msg[i])
+			break;
 	}
 	context->body_off =3D i;
 	context->commit_header_parsed =3D 1;
