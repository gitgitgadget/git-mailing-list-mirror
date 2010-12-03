From: =?ISO-8859-1?Q?Martin_Kr=FCger?= <martin.krueger@gmx.com>
Subject: Problem in Patches with commit-messages containing non-ascii
Date: Fri, 03 Dec 2010 12:19:31 +0100
Message-ID: <4CF8D243.50108@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 03 12:38:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POTxr-00005G-SR
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 12:38:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347Ab0LCLiF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Dec 2010 06:38:05 -0500
Received: from mailout08.t-online.de ([194.25.134.20]:33203 "EHLO
	mailout08.t-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916Ab0LCLiE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 06:38:04 -0500
X-Greylist: delayed 1105 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Dec 2010 06:38:04 EST
Received: from fwd03.aul.t-online.de (fwd03.aul.t-online.de )
	by mailout08.t-online.de with smtp 
	id 1POTft-0001Im-G3; Fri, 03 Dec 2010 12:19:37 +0100
Received: from twiggy.upnx.de (ZeMsF4Zp8hUWFJXjgzg9W+FhvBzVt7x5+dyZyFFaS8XxEHu-ruMnmIxBuSXzQVuwBE@[91.60.59.142]) by fwd03.aul.t-online.de
	with esmtp id 1POTfp-1zidGq0; Fri, 3 Dec 2010 12:19:33 +0100
Received: from [192.168.221.100] (unknown [192.168.221.100])
	by twiggy.upnx.de (Postfix) with ESMTP id 43B461C131
	for <git@vger.kernel.org>; Fri,  3 Dec 2010 12:20:57 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101030 Icedove/3.0.10
X-Enigmail-Version: 1.0.1
X-ID: ZeMsF4Zp8hUWFJXjgzg9W+FhvBzVt7x5+dyZyFFaS8XxEHu-ruMnmIxBuSXzQVuwBE@t-dialin.net
X-TOI-MSGID: 7e4cfb16-3e71-45b8-a69b-066cc013c5df
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162792>

Hello

I stumbled over a problem with git handling patches.
Perhaps i am then only developer who hast this problem because im am th=
e
only developer writing commit-mesages in german.

Consider this log-Message:
commit ea2cd63dfe9b3ac3581b6cff8b13a52e69066242
Author: martin <martin@chad.upnx.de>
Date:   Fri Nov 19 18:58:58 2010 +0100

    Methoden =FCberall angepasst.
    Ausser Aussnahmen

Using format-patch the result is:

=46rom ea2cd63dfe9b3ac3581b6cff8b13a52e69066242 Mon Sep 17 00:00:00 200=
1
=46rom: martin <martin@chad.upnx.de>
Date: Fri, 19 Nov 2010 18:58:58 +0100
Subject: [PATCH] =3D?UTF-8?q?Methoden=3D20=3DC3=3DBCberall=3D20angepass=
t.
=3D20Ausser=3D20Aussnahmen?=3D
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

The content of the subject field ist split up in two lines .
The blank in the second line indicates an header-folding according to
RFC2822 .
After this the string is encoded according to RFC2047 because it
contains non-ascii chars. The blank indicatinc the folding ist encoded
too, with =3D20.
That is a Problem because the unfolding according to RFC2822 cant't
detect the folding anymore. RFC2822 suggests that the unfolding must be
done before any further processing of the header which applies to the
RFC2047 decoding.

Applying this patch leads to this commit-Message:

commit 3949e57e4773e85e6c55482b68ade7c409426b3c
Author: martin <martin@chad.upnx.de>
Date:   Fri Nov 19 18:58:58 2010 +0100

    =3D?UTF-8?q?Methoden=3D20=3DC3=3DBCberall=3D20angepasst.

    =3D20Ausser=3D20Aussnahmen?=3D
    MIME-Version: 1.0
    Content-Type: text/plain; charset=3DUTF-8
    Content-Transfer-Encoding: 8bit

The solution is to make an exception not to encode blanks indicating a
folding.

I wrote this patch:

diff --git a/pretty.c b/pretty.c
index f85444b..8a78a4e 100644
--- a/pretty.c
+++ b/pretty.c
@@ -216,7 +216,7 @@ static int is_rfc2047_special(char ch)
 static void add_rfc2047(struct strbuf *sb, const char *line, int len,
 		       const char *encoding)
 {
-	int i, last;
+	int i, last, num_foldings;

 	for (i =3D 0; i < len; i++) {
 		int ch =3D line[i];
@@ -229,8 +229,14 @@ static void add_rfc2047(struct strbuf *sb, const
char *line, int len,
 	return;

 needquote:
-	strbuf_grow(sb, len * 3 + strlen(encoding) + 100);
+        num_foldings=3D0;
+        for (i =3D 1; i < len; i++)
+          if(line[i]=3D=3D' '&&line[i]=3D=3D'\n')
+           num_foldings++;
+
+	strbuf_grow(sb, len * 3 + num_foldings*(7+strlen(encoding)) + 100);
 	strbuf_addf(sb, "=3D?%s?q?", encoding);
+        unsigned last_ch=3D0;
 	for (i =3D last =3D 0; i < len; i++) {
 		unsigned ch =3D line[i] & 0xFF;
 		/*
@@ -240,10 +246,19 @@ needquote:
 		 * leave the underscore in place.
 		 */
 		if (is_rfc2047_special(ch) || ch =3D=3D ' ') {
-			strbuf_add(sb, line + last, i - last);
-			strbuf_addf(sb, "=3D%02X", ch);
-			last =3D i + 1;
+                    if(!(ch =3D=3D ' '&& last_ch=3D=3D'\n')){
+                        strbuf_add(sb, line + last, i - last);
+			strbuf_addf(sb, "=3D%02X", ch);
+                    }
+                    else{
+                     if(i>last+1)
+                      strbuf_add(sb, line + last, i - last-1);
+                     strbuf_addstr(sb, "?=3D\n ");
+                     strbuf_addf(sb, "=3D?%s?q?", encoding);
+                    }
+                  last =3D i + 1;
 		}
+           last_ch=3Dch;
 	}
 	strbuf_add(sb, line + last, len - last);
 	strbuf_addstr(sb, "?=3D");



Then git generates this patch:

=46rom ea2cd63dfe9b3ac3581b6cff8b13a52e69066242 Mon Sep 17 00:00:00 200=
1
=46rom: martin <martin@chad.upnx.de>
Date: Fri, 19 Nov 2010 18:58:58 +0100
Subject: [PATCH] =3D?UTF-8?q?Methoden=3D20=3DC3=3DBCberall=3D20angepass=
t.?=3D
 =3D?UTF-8?q?Ausser=3D20Aussnahmen?=3D
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Applyin leads to a correct commit-Messsage:

commit 62d06e3415ec0726dbd58c11ed93771502b77805
Author: martin <martin@chad.upnx.de>
Date:   Fri Nov 19 18:58:58 2010 +0100

    Methoden =FCberall angepasst.Ausser Aussnahmen


Best regards
   martin
