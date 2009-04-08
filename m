From: Thomas Jarosch <thomas.jarosch@intra2net.com>
Subject: [PATCH] Fix buffer overflow in config parser
Date: Thu, 09 Apr 2009 00:13:52 +0200
Message-ID: <49DD21A0.3040505@intra2net.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060701050800020103050209"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 09 00:15:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lrg3N-0006RP-VZ
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 00:15:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752910AbZDHWN4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 18:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752755AbZDHWN4
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 18:13:56 -0400
Received: from rs02.intra2net.com ([81.169.173.116]:33597 "EHLO
	rs02.intra2net.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155AbZDHWNz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 18:13:55 -0400
Received: from intranator.m.i2n (unknown [172.16.1.99])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rs02.intra2net.com (Postfix) with ESMTP id 1F8414E8D
	for <git@vger.kernel.org>; Thu,  9 Apr 2009 00:13:54 +0200 (CEST)
Received: from localhost (intranator.m.i2n [127.0.0.1])
	by localhost (Postfix) with ESMTP id B591D2AC4B
	for <git@vger.kernel.org>; Thu,  9 Apr 2009 00:13:53 +0200 (CEST)
Received: from pikkukde.a.i2n (pikkukde.m.i2n [192.168.12.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by intranator.m.i2n (Postfix) with ESMTP id 596CD2AC4A
	for <git@vger.kernel.org>; Thu,  9 Apr 2009 00:13:52 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
X-Virus-Scanned: by Intranator (www.intra2net.com) with AMaViS and F-Secure AntiVirus (fsavdb 2009-04-08_07)
X-Spam-Status: hits=-2.9 tests=[ALL_TRUSTED=-1.8,BAYES_05=-1.11]
X-Spam-Level: 971
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116128>

This is a multi-part message in MIME format.
--------------060701050800020103050209
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello together,

attached is a small patch to fix a buffer overflow in config.c.
Patch is against git master's HEAD.

I didn't send this one inline as I wanted to
preserve the 1024+ byte long line.

Best regards,
Thomas Jarosch


--------------060701050800020103050209
Content-Type: text/x-patch;
 name="git-fix-config-buffer-overflow.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="git-fix-config-buffer-overflow.patch"

Fix buffer overflow in config parser.

Segfaulting config looks like this:
---------------------------------------
[core]
        repositoryformatversion =3D 0
        filemode =3D true
        bare =3D false
        logallrefupdates =3D true
    foobar =3D aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaxxxbb=
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcccccccccccccccccccccaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaa123 4
---------------------------------------

Signed-off-by: Thomas Jarosch <thomas.jarosch@intra2net.com>

diff --git a/config.c b/config.c
index b76fe4c..a9c67e8 100644
--- a/config.c
+++ b/config.c
@@ -72,7 +72,7 @@ static char *parse_value(void)
 			}
 		}
 		if (space) {
-			if (len)
+			if (len && len < sizeof(value)-1)
 				value[len++] =3D ' ';
 			space =3D 0;
 		}


--------------060701050800020103050209--
