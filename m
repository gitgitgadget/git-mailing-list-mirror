From: Thomas Rast <tr@thomasrast.ch>
Subject: [PATCH] commit-slab: sizeof() the right type in xrealloc
Date: Sun, 01 Dec 2013 21:41:55 +0100
Message-ID: <87siucpalo.fsf_-_@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098>
References: <cover.1385405977.git.tr@thomasrast.ch>
	<f4d1ff9f487f797da35faa86c72d11832903a50d.1385405977.git.tr@thomasrast.ch>
	<CACsJy8CnxvPRwC_xXgBNF_JEmkpfnk=faMwOWtkJOFU-18aHgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 01 21:42:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnDqj-0004fq-Bs
	for gcvg-git-2@plane.gmane.org; Sun, 01 Dec 2013 21:42:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752300Ab3LAUmi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Dec 2013 15:42:38 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:39313 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751945Ab3LAUmg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Dec 2013 15:42:36 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 3BEC94D64FC;
	Sun,  1 Dec 2013 21:42:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id FWZ18imjQ3nw; Sun,  1 Dec 2013 21:42:18 +0100 (CET)
Received: from linux-1gf2.Speedport_W723_V_Typ_A_1_00_098.thomasrast.ch (unknown [89.204.130.6])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 4F78E4D64C4;
	Sun,  1 Dec 2013 21:42:10 +0100 (CET)
In-Reply-To: <CACsJy8CnxvPRwC_xXgBNF_JEmkpfnk=faMwOWtkJOFU-18aHgA@mail.gmail.com>
	(Duy Nguyen's message of "Sun, 1 Dec 2013 17:36:31 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238596>

When allocating the slab, the code accidentally computed the array
size from s->slab (an elemtype**).  The slab is an array of elemtype*,
however, so we should take the size of *s->slab.

Noticed-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.co=
m>
Signed-off-by: Thomas Rast <tr@thomasrast.ch>
---
[I hope this comes through clean.  git-send-email is currently broken
for me, and I'm still investigating, so I have to kludge around it.]

I browsed around for a while, and couldn't find out whether any
architecture actually has any hope of running git (i.e. is at least
mostly POSIX conformant) but still violates the assumption that all
pointers[*] are the same size.

The comp.lang.c FAQ has some interesting examples of wildly different
pointer representations at:

  http://c-faq.com/null/machexamp.html

Consider the cases mentioned there where void* and char* have
different representations from, e.g., int*.  Then if elemtype is char,
the slab will be too small before this patch.

But I have no idea if any of those are POSIXish.

One interesting, though orthogonal, tidbit is that POSIX actually
requires _function_ pointers to have the same representation as void*.
=46rom the specification of dlsym(), which depends on this to be able t=
o
return function pointers:

RATIONALE
  [...] Indeed, the ISO C standard does not require that an object of
  type void * can hold a pointer to a function. Implementations
  supporting the XSI extension, however, do require that an object of
  type void * can hold a pointer to a function.

Thank god for POSIX.  So much craziness averted.


[*] Note that C++ method pointers are yet another story.  This only
applies to the kinds of pointers that C supports.


 commit-slab.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/commit-slab.h b/commit-slab.h
index d068e2d..cc114b5 100644
--- a/commit-slab.h
+++ b/commit-slab.h
@@ -91,7 +91,7 @@ struct slabname {							\
 	if (s->slab_count <=3D nth_slab) {				\
 		int i;							\
 		s->slab =3D xrealloc(s->slab,				\
-				   (nth_slab + 1) * sizeof(s->slab));	\
+				   (nth_slab + 1) * sizeof(*s->slab));	\
 		stat_ ##slabname## realloc++;				\
 		for (i =3D s->slab_count; i <=3D nth_slab; i++)		\
 			s->slab[i] =3D NULL;				\
--=20
1.8.5.427.g6d3141d
