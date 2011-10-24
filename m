From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] read-cache.c: fix index memory allocation
Date: Tue, 25 Oct 2011 10:34:27 +1100
Message-ID: <20111024233427.GA24956@duynguyen-vnpc.dektech.internal>
References: <4EA20C5B.3090808@gmail.com>
 <vpqfwiknmh3.fsf@bauges.imag.fr>
 <4EA3D1BB.2010802@gmail.com>
 <4EA415BD.1040109@lsrfire.ath.cx>
 <20111023162944.GB28156@sigill.intra.peff.net>
 <4EA453D3.7080002@lsrfire.ath.cx>
 <4EA4B8E7.5070106@lsrfire.ath.cx>
 <7vipne50lz.fsf@alter.siamese.dyndns.org>
 <4EA5DFB2.3050406@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	John Hsing <tsyj2007@gmail.com>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Oct 25 01:36:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIU4A-0006qx-9F
	for gcvg-git-2@lo.gmane.org; Tue, 25 Oct 2011 01:36:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755702Ab1JXXgP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Oct 2011 19:36:15 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:47657 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755493Ab1JXXgP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2011 19:36:15 -0400
Received: by gyb13 with SMTP id 13so6254126gyb.19
        for <git@vger.kernel.org>; Mon, 24 Oct 2011 16:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8+CM3pkUov5h22Y8VyjQhmfRz51yhumCHAxAI4Of63Y=;
        b=n5WOT9a3uVGLBe3QmtD5fdxXiNudpNcxMEBZoXeXywoe3t7l7e+CTXUbxjIlEDIhvR
         UvOLnZrYBIvI3sN6Kt0o+Z8/NT389XNBXGp+vr7QGeOC+tgt12yNDMuEoFY6u7EAUTdh
         +AmLck3XTuVo+AVkeqX2zHfd755sbnxfW8G8A=
Received: by 10.236.22.33 with SMTP id s21mr38009295yhs.70.1319499374395;
        Mon, 24 Oct 2011 16:36:14 -0700 (PDT)
Received: from pclouds@gmail.com (dektec3.lnk.telstra.net. [165.228.202.174])
        by mx.google.com with ESMTPS id f47sm18318872yhh.8.2011.10.24.16.36.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 24 Oct 2011 16:36:12 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 25 Oct 2011 10:34:27 +1100
Content-Disposition: inline
In-Reply-To: <4EA5DFB2.3050406@lsrfire.ath.cx>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184193>

On Mon, Oct 24, 2011 at 11:59:14PM +0200, Ren=E9 Scharfe wrote:
> Am 24.10.2011 09:07, schrieb Junio C Hamano:
> > Thanks.
> >=20
> > This approach may be the most appropriate for the maintenance track=
, but
> > for the purpose of going forward, I wonder if we really want to kee=
p the
> > "estimate and allocate a large pool, and carve out individual piece=
s".
> >=20
> > This bulk-allocate dates back to the days when we didn't have ondis=
k vs
> > incore representation differences, IIRC, and as the result we delib=
erately
> > leak cache entries whenever an entry in the index is replaced with =
a new
> > one. Does the overhead to allocate individually really kill us that=
 much
> > for say a tree with 30k files in it?
>=20
> Something like this (applies to master)?  Very basic testing didn't s=
how
> any slowdown of git status in the Linux repo.

"git status" is slow. If your changes causes slowdown, it won't likely
stand out while other fast commands may show (read_cache() is used in
nearly all commands). So I tested using the following patch.

The result on linux-2.6 shows about 10-20 us slowdown per each
read_cache() call (30-40 us on webkit, ~50k files) I think your patch
is good enough :-)

-- 8< --
diff --git a/Makefile b/Makefile
index 3139c19..c8b47bc 100644
--- a/Makefile
+++ b/Makefile
@@ -444,6 +444,7 @@ TEST_PROGRAMS_NEED_X +=3D test-string-pool
 TEST_PROGRAMS_NEED_X +=3D test-subprocess
 TEST_PROGRAMS_NEED_X +=3D test-svn-fe
 TEST_PROGRAMS_NEED_X +=3D test-treap
+TEST_PROGRAMS_NEED_X +=3D test-read-cache
=20
 TEST_PROGRAMS =3D $(patsubst %,%$X,$(TEST_PROGRAMS_NEED_X))
=20
diff --git a/test-read-cache.c b/test-read-cache.c
index e69de29..1ad80a0 100644
--- a/test-read-cache.c
+++ b/test-read-cache.c
@@ -0,0 +1,14 @@
+#include "cache.h"
+
+int main(int argc, char **argv)
+{
+	struct timeval tv1, tv2;
+	int i;
+
+	gettimeofday(&tv1, NULL);
+	for (i =3D 0; i < 100; i++)
+		read_cache();
+	gettimeofday(&tv2, NULL);
+	printf("%lu\n", (unsigned long)(tv2.tv_usec - tv1.tv_usec));
+	return 0;
+}
-- 8< --
