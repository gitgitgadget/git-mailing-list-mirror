From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] parse_tag_buffer(): avoid out of bound access
Date: Fri, 18 Feb 2011 19:49:32 +0700
Message-ID: <1298033372-29069-1-git-send-email-pclouds@gmail.com>
References: <4D5D17F7.4010003@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 18 13:46:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqPiz-0000hE-EL
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 13:46:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754230Ab1BRMqN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Feb 2011 07:46:13 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:61313 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752856Ab1BRMqL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Feb 2011 07:46:11 -0500
Received: by pzk35 with SMTP id 35so529828pzk.19
        for <git@vger.kernel.org>; Fri, 18 Feb 2011 04:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=fluri3xFdkuL4JGWOc4H7ygA9ZYIdO4t8pJAWc5skyU=;
        b=EOe/XEZC5yQ0KILs0YtythjlccHc9XwlaX/2539TJPSxyvLzQTL6aEgSrf4x1m76ht
         jBAwEU+pHMpGQACvLzjq+7Zk/SBBBZN7JgAEskLEeNruU1wN49ow5zKD/MFjAwKudp3D
         OdiYHtShQri9oTTaqn5kTkYLHiH7EvW1jsL9U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=lw91QKRJpIunWq6qYyAC18q50k5ZwqCcPlAI7slTue1+29o6dazSoXu43lkIDbUJRG
         ZIevSlq+HPTFv5cUKmTZ0gORL4zyea8/KS1+UNV5MwyyKE3SB252AEKjtjGoRywepdUA
         t0A4Z++tWzffCMa1xBoNwcuiLogzQfeErUfV8=
Received: by 10.142.142.5 with SMTP id p5mr511164wfd.257.1298033170483;
        Fri, 18 Feb 2011 04:46:10 -0800 (PST)
Received: from tre ([115.73.232.10])
        by mx.google.com with ESMTPS id e14sm2739398wfg.8.2011.02.18.04.46.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Feb 2011 04:46:09 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Fri, 18 Feb 2011 19:49:33 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <4D5D17F7.4010003@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167205>

There is a check (size < 64) at the beginning of the function, but
that only covers object+type lines. Code for parsing "tag" and
"tagger" may access outside buffer. Fix it.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 On Thu, Feb 17, 2011 at 7:43 PM, Ren=C3=A9 Scharfe <rene.scharfe@lsrfi=
re.ath.cx> wrote:
 > memchr() won't notice if a negative value has been passed as third p=
arameter
 > because its type is size_t, which is unsigned.  Negative values are
 > converted to big positive ones..

 I did not notice that. Fixed commit message.

 tag.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tag.c b/tag.c
index ecf7c1e..7d38cc0 100644
--- a/tag.c
+++ b/tag.c
@@ -97,7 +97,9 @@ int parse_tag_buffer(struct tag *item, const void *da=
ta, unsigned long size)
 		item->tagged =3D NULL;
 	}
=20
-	if (prefixcmp(bufptr, "tag "))
+	if (bufptr + 4 < tail && !prefixcmp(bufptr, "tag "))
+		; 		/* good */
+	else
 		return -1;
 	bufptr +=3D 4;
 	nl =3D memchr(bufptr, '\n', tail - bufptr);
@@ -106,7 +108,7 @@ int parse_tag_buffer(struct tag *item, const void *=
data, unsigned long size)
 	item->tag =3D xmemdupz(bufptr, nl - bufptr);
 	bufptr =3D nl + 1;
=20
-	if (!prefixcmp(bufptr, "tagger "))
+	if (bufptr + 7 < tail && !prefixcmp(bufptr, "tagger "))
 		item->date =3D parse_tag_date(bufptr, tail);
 	else
 		item->date =3D 0;
--=20
1.7.4.74.g639db
