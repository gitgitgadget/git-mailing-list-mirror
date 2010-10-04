From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2] cache.h: work around broken NetBSD system headers
Date: Mon,  4 Oct 2010 18:10:13 +0000
Message-ID: <1286215813-21224-1-git-send-email-avarab@gmail.com>
References: <7v8w2d972o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	der Mouse <mouse@Rodents-Montreal.ORG>,
	Dan McMahill <dmcmahill@netbsd.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 04 20:10:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2pV1-0007aP-Ay
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 20:10:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756777Ab0JDSK0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 14:10:26 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41928 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756787Ab0JDSKW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 14:10:22 -0400
Received: by mail-ww0-f44.google.com with SMTP id 40so4476265wwj.1
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 11:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=OnxPSDVH2l+i04psolMhqja0TTnAFsDLhCsY/JlhAY8=;
        b=hFo1P+UYY0SNNeMZF+yu0ZXRCxFd2IwXkX9FHvp6mSx8W0NQLUgkGfutJnj1EgTuvT
         gcBbMfCE0+J+8lRVUISSze/ZLRWlOB53eVwVnfburT7Tja7vtfXL3zUX+dVp5+xb3fBO
         z5mCeBzCon4uNGGbZ2ciT1+JurWZOVpj1BsY4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=wtV+FEyoOS1cwWX0hHd7iq4Ad/EBsuZA7DFTtQp4E5Rm61lQUy3SgxcTQBPTEgyopB
         2yE00SlEk/sJwUNttFCUTHVRiP4E/fRw+5EoE7dnyzo0B5oe/6MQGmYfQFuEIIuGa992
         hhXcEbKIkQN2a0dpZk40QgQocG295exl9MkUA=
Received: by 10.216.145.99 with SMTP id o77mr8001381wej.113.1286215821585;
        Mon, 04 Oct 2010 11:10:21 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id k46sm3196720weq.10.2010.10.04.11.10.19
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 11:10:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.159.g610493
In-Reply-To: <7v8w2d972o.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158082>

Wrap the `mode' argument to the `canon_mode' macro in extra
parentheses to avoid a bug with the S_* macros in sys/stat.h on
NetBSD.

This issue was originally spotted in NetBSD Problem Report #42168 and
worked around by der Mouse, but later filed as a bug with NetBSD
itself in NetBSD Problem Report #43937 by me.

The issue is that NetBSD doesn't take care to wrap its macro arguments
in parentheses, so on Linux and other sane systems we have S_ISREG(m)
defined as something like:

    (((m) & S_IFMT) =3D=3D S_IFREG)

But on NetBSD:

    ((m & _S_IFMT) =3D=3D _S_IFREG)

Since a caller in builtin/diff.c called our macro as `S_IFREG | 0644'
this bug introduced a logic error on NetBSD, since the precedence of
bit-wise & is higher than | in C.

NetBSD-PR: http://gnats.netbsd.org/cgi-bin/query-pr-single.pl?number=3D=
43937
Originally-reported-by: der Mouse <mouse@Rodents-Montreal.ORG>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

On Mon, Oct 4, 2010 at 17:54, Junio C Hamano <gitster@pobox.com> wrote:
> instead of contaminating the calling sites.  Otherwise new calling si=
tes
> we will add in the future need to be aware of the same bug for no goo=
d
> reason.

Agreed. Here's a v2 that does that. With an updated commit message to
mention the bug I filed with NetBSD.

 cache.h |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index 2ef2fa3..891d5d0 100644
--- a/cache.h
+++ b/cache.h
@@ -277,9 +277,15 @@ static inline int ce_to_dtype(const struct cache_e=
ntry *ce)
 	else
 		return DT_UNKNOWN;
 }
+
+/*
+ * We use extra parentheses around mode to work around a NetBSD issue
+ * described in NetBSD Problem Report #43937. See
+ * http://www.netbsd.org/cgi-bin/query-pr-single.pl?number=3D43937
+ */
 #define canon_mode(mode) \
-	(S_ISREG(mode) ? (S_IFREG | ce_permissions(mode)) : \
-	S_ISLNK(mode) ? S_IFLNK : S_ISDIR(mode) ? S_IFDIR : S_IFGITLINK)
+	(S_ISREG((mode)) ? (S_IFREG | ce_permissions(mode)) : \
+	S_ISLNK((mode)) ? S_IFLNK : S_ISDIR((mode)) ? S_IFDIR : S_IFGITLINK)
=20
 #define flexible_size(STRUCT,len) ((offsetof(struct STRUCT,name) + (le=
n) + 8) & ~7)
 #define cache_entry_size(len) flexible_size(cache_entry,len)
--=20
1.7.3.159.g610493
