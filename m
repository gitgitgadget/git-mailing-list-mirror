From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 8/8] Remove pack file handling dependency from wrapper.o
Date: Sat, 6 Nov 2010 14:00:38 -0500
Message-ID: <20101106190038.GB14288@burratino>
References: <20101106113905.GA27405@burratino>
 <20101106115237.GH27641@burratino>
 <4CD5996F.6010809@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Nov 06 20:00:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEo0W-0006pi-3Y
	for gcvg-git-2@lo.gmane.org; Sat, 06 Nov 2010 20:00:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752079Ab0KFTAs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Nov 2010 15:00:48 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:50065 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261Ab0KFTAr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Nov 2010 15:00:47 -0400
Received: by ywc21 with SMTP id 21so2740186ywc.19
        for <git@vger.kernel.org>; Sat, 06 Nov 2010 12:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=x8ee8Nd/T+0MY6wJcAiSvnweXzeYa6El7n87WCdSpcI=;
        b=nSdFpbV1PBKDJ/w/J2XqOIBNA5QrH3gz29XU8l5U+mAve3DVZPH1lnDWOHovt5aVki
         P+CzgunSqtPdtmuoPa7rsn8xuLxjfqB7QsL0ORSNDaWk40b7r/6SkV8dEp4g2n/ZK+IF
         32WeBzl8ZxuHAEKpRg3GkI8nz9fOJk3FLCftY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=xQP6HLKXWLlesgf2Ysyr910pM6S4NsShfJ0q2SHlE4sPuVyUpVoL7+q73z+qs4bbR0
         UG52WwCIhQObwCH1b21I0lqScmO/cKdut/Tj17OROogPuErfWfxiFcLF/dkf0ymbQpyQ
         QCjT+nmwkxOSlLSvA140Zm1U3sLShsPRCstXw=
Received: by 10.151.100.9 with SMTP id c9mr5809372ybm.9.1289070046958;
        Sat, 06 Nov 2010 12:00:46 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id a32sm2090157yhc.25.2010.11.06.12.00.45
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 06 Nov 2010 12:00:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4CD5996F.6010809@lsrfire.ath.cx>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160855>

Ren=C3=A9 Scharfe wrote:

> Can it be set automatically once the first pack is loaded?  A quick l=
ook
> suggests that use_pack() would be the right place to do it.

How about this?  Replaces patches 7 and 8.

--8 <--
Subject: Remove pack file handling dependency from wrapper.o

As v1.7.0-rc0~43 (slim down "git show-index", 2010-01-21) explains,
use of xmalloc() brings in a dependency on zlib, the sha1 lib, and the
rest of git's object file access machinery via try_to_free_pack_memory.
That is overkill when xmalloc is just being used as a convenience
wrapper to exit when no memory is available.

So defer setting try_to_free_pack_memory as try_to_free_routine until
the first packfile is opened in add_packed_git().

After this change, a simple program using xmalloc() and no other
functions will not pull in any code from libgit.a aside from wrapper.o
and usage.o.

Improved-by: Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 sha1_file.c |   11 +++++++++++
 wrapper.c   |    5 ++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 8e299ae..e0d2496 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -818,11 +818,22 @@ static struct packed_git *alloc_packed_git(int ex=
tra)
 	return p;
 }
=20
+static void try_to_free_pack_memory(size_t size)
+{
+	release_pack_memory(size, -1);
+}
+
 struct packed_git *add_packed_git(const char *path, int path_len, int =
local)
 {
+	static int have_set_try_to_free_routine;
 	struct stat st;
 	struct packed_git *p =3D alloc_packed_git(path_len + 2);
=20
+	if (!have_set_try_to_free_routine) {
+		have_set_try_to_free_routine =3D 1;
+		set_try_to_free_routine(try_to_free_pack_memory);
+	}
+
 	/*
 	 * Make sure a corresponding .pack file exists and that
 	 * the index looks sane.
diff --git a/wrapper.c b/wrapper.c
index 185dfbc..4c1639f 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -3,12 +3,11 @@
  */
 #include "cache.h"
=20
-static void try_to_free_builtin(size_t size)
+static void do_nothing(size_t size)
 {
-	release_pack_memory(size, -1);
 }
=20
-static void (*try_to_free_routine)(size_t size) =3D try_to_free_builti=
n;
+static void (*try_to_free_routine)(size_t size) =3D do_nothing;
=20
 try_to_free_t set_try_to_free_routine(try_to_free_t routine)
 {
--=20
1.7.2.3.557.gab647.dirty
