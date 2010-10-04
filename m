From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] diff: "S_IFREG | 0644" to "(S_IFREG | 0644)" to avoid
 warning
Date: Mon, 04 Oct 2010 12:53:11 +0200
Message-ID: <4CA9B217.6050600@lsrfire.ath.cx>
References: <1286184071-28457-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Dan McMahill <dmcmahill@NetBSD.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 12:53:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2ifd-0005CU-E6
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 12:53:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755268Ab0JDKxW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 06:53:22 -0400
Received: from india601.server4you.de ([85.25.151.105]:45048 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755261Ab0JDKxV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 06:53:21 -0400
Received: from [10.0.1.100] (p4FC562DC.dip.t-dialin.net [79.197.98.220])
	by india601.server4you.de (Postfix) with ESMTPSA id A5A182F8064;
	Mon,  4 Oct 2010 12:53:19 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <1286184071-28457-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158025>

Am 04.10.2010 11:21, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> -	unsigned mode =3D canon_mode(S_IFREG | 0644);
> +	unsigned mode =3D canon_mode((S_IFREG | 0644));

That doesn't look pretty.

How about something like the following instead?  It untangles the
?-:-chain in canon_mode and allows passing of an argument with side
effects.  All the S_ISxxx macros get a single variable as parameter.
Does it fix the issue on NetBSD?
---
 cache.h |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 2ef2fa3..3d5ed51 100644
--- a/cache.h
+++ b/cache.h
@@ -277,9 +277,16 @@ static inline int ce_to_dtype(const struct cache_e=
ntry *ce)
 	else
 		return DT_UNKNOWN;
 }
-#define canon_mode(mode) \
-	(S_ISREG(mode) ? (S_IFREG | ce_permissions(mode)) : \
-	S_ISLNK(mode) ? S_IFLNK : S_ISDIR(mode) ? S_IFDIR : S_IFGITLINK)
+static inline unsigned int canon_mode(unsigned int mode)
+{
+	if (S_ISREG(mode))
+		return S_IFREG | ce_permissions(mode);
+	if (S_ISLNK(mode))
+		return S_IFLNK;
+	if (S_ISDIR(mode))
+		return S_IFDIR;
+	return S_IFGITLINK;
+}
=20
 #define flexible_size(STRUCT,len) ((offsetof(struct STRUCT,name) + (le=
n) + 8) & ~7)
 #define cache_entry_size(len) flexible_size(cache_entry,len)
--=20
1.7.3
