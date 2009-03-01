From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] import memmem() with linear complexity from Gnulib
Date: Sun, 01 Mar 2009 19:55:05 +0100
Message-ID: <49AADA09.6020305@lsrfire.ath.cx>
References: <cover.1235629933.git.gitster@pobox.com> <cd73512d11e63554396983ed4e9556b2d18b3e4a.1235629933.git.gitster@pobox.com> <49A88FA7.1020402@lsrfire.ath.cx> <7vy6vrgxnn.fsf@gitster.siamese.dyndns.org> <7v8wnrgkjw.fsf@gitster.siamese.dyndns.org> <49A937B8.1030205@lsrfire.ath.cx> <7vmyc6foj3.fsf@gitster.siamese.dyndns.org> <1235848615.7043.30.camel@ubuntu.ubuntu-domain> <20090228224401.GA27262@glandium.org> <20090301034123.GC30384@coredump.intra.peff.net> <49AA6E35.40205@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mike Hommey <mh@glandium.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 01 19:58:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdqqP-0007AK-JU
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 19:56:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754292AbZCASzV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Mar 2009 13:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754252AbZCASzV
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 13:55:21 -0500
Received: from india601.server4you.de ([85.25.151.105]:44663 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753634AbZCASzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2009 13:55:16 -0500
Received: from [10.0.1.101] (p57B7E150.dip.t-dialin.net [87.183.225.80])
	by india601.server4you.de (Postfix) with ESMTPSA id B743A2F8037;
	Sun,  1 Mar 2009 19:55:12 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <49AA6E35.40205@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111868>

Ren=C3=A9 Scharfe schrieb:
> I was going to say that with a fast memmem() we could convert some
> strstr() calls, especially those where we know the lengths of the
> strings anyway -- intuitively, memmem() should be faster than strstr(=
)
> in that case.  However, the following patch on top of the Gnulib impo=
rt
> makes "git grep grep v1.6.1" take 10% *more* time for me (on Windows)=
=2E
> I wonder why.

More numbers.  "memmem" is the patch I'm replying to which converts
grep's fixed string search from strstr() to memmem().  "quadratic" mean=
s
the current version of compat/memmem.c was used (NO_MEMMEM=3Dyes),
"linear" is the same, but with the newer memmem() from Gnulib imported.
 The numbers are elapsed seconds for the following command, run in a
Linux kernel repo:

   git grep grep v2.6.28 >/dev/null

                                   Ubuntu Fedora
   [1] v1.6.2-rc2                    2.99   3.52
   [2] v1.6.2-rc2+memmem             3.09   3.28
   [3] v1.6.2-rc2+memmem+quadratic   8.42   8.50
   [4] v1.6.2-rc2+memmem+linear      3.17   3.25

So, we should be careful when using memmem() as long as we have the
current implementation in compat/, as the quadratic complexity can
result in a significant slowdown ([3]).

The new memmem() indeed is faster than the new strstr(), as expected
(Fedora [2] and [4] vs. Fedora [1]).  Remember, Fedora 10 already
includes the glibc version with the linear implementations while Ubuntu
8.10 doesn't.

I'm not sure if the difference between the old and new memmem() is
significant or in the noise (Ubuntu [2] and [4]).

In any case, and this surprised me, the fastest of them all is the old
strstr() (Ubuntu [1]).  This is consistent with the slowdown observed o=
n
Windows.

What's even more surprising is the difference between Ubuntu [2] and
[3], which use basically the same memmem().  Or so I thought.  Wrong.
The old memmem() in glibc has a small but effective optimization, that
our version lacks.  I don't remember if I cut it out during the initial
import for increased simplicity or if the version the import was based
on didn't have it.  Anyway, with the following patch, case [3] runs as
fast as case [2] on both Fedora and Ubuntu.

Next step would be to check if pickaxe simply needs this short patch or
really the full-blown linear reimplementation.  I'm off to an
appointment, though, so I'll look into this again tomorrow.

Ren=C3=A9


diff --git a/compat/memmem.c b/compat/memmem.c
index cd0d877..fed5a77 100644
--- a/compat/memmem.c
+++ b/compat/memmem.c
@@ -5,6 +5,7 @@ void *gitmemmem(const void *haystack, size_t haystack_l=
en,
 {
 	const char *begin =3D haystack;
 	const char *last_possible =3D begin + haystack_len - needle_len;
+	char tip;
=20
 	/*
 	 * The first occurrence of the empty string is deemed to occur at
@@ -20,8 +21,10 @@ void *gitmemmem(const void *haystack, size_t haystac=
k_len,
 	if (haystack_len < needle_len)
 		return NULL;
=20
+	tip =3D *((const char *)needle);
+
 	for (; begin <=3D last_possible; begin++) {
-		if (!memcmp(begin, needle, needle_len))
+		if (*begin =3D=3D tip && !memcmp(begin, needle, needle_len))
 			return (void *)begin;
 	}
=20
