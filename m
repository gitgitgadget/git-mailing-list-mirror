From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 5/9] match_pathspec: match pathspec "foo/" against directory "foo"
Date: Fri, 24 Jan 2014 20:40:32 +0700
Message-ID: <1390570836-20394-6-git-send-email-pclouds@gmail.com>
References: <1390483326-32258-1-git-send-email-pclouds@gmail.com>
 <1390570836-20394-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, pawel.sikora@agmk.net,
	Jens.Lehmann@web.de,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 24 14:35:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6gv9-00058p-BI
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 14:35:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752689AbaAXNfh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Jan 2014 08:35:37 -0500
Received: from mail-pb0-f53.google.com ([209.85.160.53]:57544 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209AbaAXNfg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jan 2014 08:35:36 -0500
Received: by mail-pb0-f53.google.com with SMTP id md12so3247253pbc.12
        for <git@vger.kernel.org>; Fri, 24 Jan 2014 05:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=0irdkEOiFhImd3+RGOtECx7B/4051GdmfuqCWmIudKk=;
        b=X+Nc5JfVlkacVFMymte+FwC1xcXOge8/xGBWuVSW/wp1eY/7dzKsdB1qEmsIcKyWQI
         0vtcoll0pbLnfBTK2+jb3Z3rR8Jm1hEe7ndyxz5vfw1iFhzElSXTVBpeTWeuOxYVJ5r5
         6gdeShHysPxFMTPXmN433viMuHm1t6AsxkLZuQLg4ivop6HI7tGx8dGBOu6+ulfmTTTj
         9NzqbhGVvQKtKxYHgswrYLLV0Ayxrpqa+68nCywcqo0YDHX5os/EIsAKNZJANlrQM/pu
         tY5yOz3jXXhe05TXbq/sAnCiQpwtfZhTw17PNs6UzCOirlM6MJSlpZ+B1UHC8Q44djn2
         bGNg==
X-Received: by 10.68.43.2 with SMTP id s2mr2735969pbl.60.1390570536340;
        Fri, 24 Jan 2014 05:35:36 -0800 (PST)
Received: from lanh ([115.73.192.112])
        by mx.google.com with ESMTPSA id nw11sm7699663pab.13.2014.01.24.05.35.33
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 24 Jan 2014 05:35:35 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 24 Jan 2014 20:41:11 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1390570836-20394-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241002>

Currently we do support matching pathspec "foo/" against directory
"foo". That is because match_pathspec() has no way to tell "foo" is a
directory and matching "foo/" against _file_ "foo" is wrong.

The callers can now tell match_pathspec if "foo" is a directory, we
could make an exception for this case. Code is not executed though
because no callers pass the flag yet.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 35e09bd..7b50072 100644
--- a/dir.c
+++ b/dir.c
@@ -196,6 +196,7 @@ int within_depth(const char *name, int namelen,
 }
=20
 #define DO_MATCH_EXCLUDE   1
+#define DO_MATCH_DIRECTORY 2
=20
 /*
  * Does 'match' match the given name?
@@ -259,7 +260,11 @@ static int match_pathspec_item(const struct pathsp=
ec_item *item, int prefix,
=20
 		if (match[matchlen-1] =3D=3D '/' || name[matchlen] =3D=3D '/')
 			return MATCHED_RECURSIVELY;
-	}
+	} else if ((flags & DO_MATCH_DIRECTORY) &&
+		   match[matchlen - 1] =3D=3D '/' &&
+		   namelen =3D=3D matchlen - 1 &&
+		   !ps_strncmp(item, match, name, namelen))
+		return MATCHED_EXACTLY;
=20
 	if (item->nowildcard_len < item->len &&
 	    !git_fnmatch(item, match, name,
--=20
1.8.5.2.240.g8478abd
