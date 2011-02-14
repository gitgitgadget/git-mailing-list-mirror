From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] parse_tag_buffer(): do not prefixcmp() out of range
Date: Mon, 14 Feb 2011 20:02:51 +0700
Message-ID: <1297688571-1962-1-git-send-email-pclouds@gmail.com>
References: <20110212144706.GA25124@do>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Feb 14 14:04:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Poy6S-0007vO-KE
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 14:04:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754569Ab1BNNEZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Feb 2011 08:04:25 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:53054 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754174Ab1BNNEX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 08:04:23 -0500
Received: by pwj3 with SMTP id 3so940093pwj.19
        for <git@vger.kernel.org>; Mon, 14 Feb 2011 05:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=/rEpAiclSMEoWtdYPbzeKRwn5sXQpfGrgseGOfXHnf4=;
        b=MDl2trPKINnYt8xM8KPO45DutZ9ZA1KATXMY6R9x8H8etWsRMvvbH4EFiZXUAyf+qP
         669x2lkB7u3pkuVIqSC3VDOO9Rk8FT1HrIlG0Z0/wvaUZGyBsCpLdJlX+54hkkXMcFic
         vnEBqWQVP7rZMi5jo/xnpvQt87iSt6N1k4Zd0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=bfgILj3ZkciFJjxCawVM/aJwNf49De3EFc4D4xfbPxNJdnem0OBs0uhz6136gN7E3H
         FYjlEPN2bNXDfTmLrl8jNem74GPPLCbY4Vdvg8McRAhQsrMz7f7zj8Dtj33rv8xSTUQs
         q/wRHB9dSlFVJ1OJsGApTkcvthzds8Ad9ZskM=
Received: by 10.142.186.7 with SMTP id j7mr3154186wff.53.1297688663109;
        Mon, 14 Feb 2011 05:04:23 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.232.10])
        by mx.google.com with ESMTPS id w42sm4141958wfh.3.2011.02.14.05.04.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 Feb 2011 05:04:22 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 14 Feb 2011 20:02:52 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <20110212144706.GA25124@do>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166706>

There is a check (size < 64) at the beginning of the function, but
that only covers object+type lines.

Strictly speaking the current code is still correct even if it
accesses outside 'data' because 'tail' is used right after
prefixcmp() calls.

Anyway accessing out of range is not good. Avoid it.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Unfortunately I installed valgrind but could not reproduce t9350.15
 failure.

 Another option is to add prefixncmp(const char *, const char *,int).
 Probably not worth it.

 tag.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tag.c b/tag.c
index ecf7c1e..9318ae5 100644
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
