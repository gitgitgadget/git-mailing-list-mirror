From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Avoid a useless prefix lookup in strbuf_expand()
Date: Thu, 03 Jan 2008 01:08:56 -0800
Message-ID: <7vr6gztgwn.fsf@gitster.siamese.dyndns.org>
References: <e5bfff550712300546o167c460bl4628d87f8a4e14db@mail.gmail.com>
	<477BD3B4.2070708@lsrfire.ath.cx>
	<e5bfff550801021027i6d6a399cob96ae3c840661884@mail.gmail.com>
	<477C301D.7060509@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marco Costalba <mcostalba@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Jan 03 10:09:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAM55-0006W6-7V
	for gcvg-git-2@gmane.org; Thu, 03 Jan 2008 10:09:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754071AbYACJJN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jan 2008 04:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754036AbYACJJN
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jan 2008 04:09:13 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50778 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754055AbYACJJK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jan 2008 04:09:10 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F393ADBB;
	Thu,  3 Jan 2008 04:09:09 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 18B27ADBA;
	Thu,  3 Jan 2008 04:09:03 -0500 (EST)
In-Reply-To: <477C301D.7060509@lsrfire.ath.cx> (=?utf-8?Q?Ren=C3=A9?=
 Scharfe's message of
	"Thu, 03 Jan 2008 01:45:17 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69517>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> The loop makes implementing the callback function a bit easier, since
> you don't need to cover all cases; the input is already checked by
> strbuf_expand().
>
> Anyway, here's your patch again with a few small changes: the
> placeholders array is gone as you suggested, the cases for %Cx, %ax a=
nd
> %cx are check for unknown placeholders and the callback function retu=
rns
> the number of bytes it consumed as size_t.
>
> All in all: less code, slightly more complex callback functions (need=
s
> to return the length of the consumed placeholder or 0 if the input
> doesn't match a placeholder) and increased speed.  I have to admit th=
at
> I start to like it. :-)

I'll let Marco bench it and hopefully Ack with an updated
(final) commit log message.

I think Dscho and Marco's earlier prefixcmp() optimization to
avoid strlen() can stay, but with "inline" removed.  That should
be equivalent to the version before the optimization, both from
the point of view of the code footprint and callchain length,
but still avoid strlen() cost.

Due to lack of better place the patch below moves it to strbuf.c
which probably is the closest collection of "stringy" stuff.

$ size git ;# with the attached patch
   text    data     bss     dec     hex filename
 731144   13456  263464 1008064   f61c0 git
$ size ../git.build/git ;# before Dscho's patch
   text    data     bss     dec     hex filename
 731272   13456  263464 1008192   f6240 ../git.build/git
$ size ~/bin/git ;# with Dscho's patch
   text    data     bss     dec     hex filename
 740736   13456  263464 1017656   f8738 /home/junio/bin/git

You earlier said 2,620,938 vs 2,640,450 and I think you meant
what "ls -l" reports.  I suspect it is not a very good measure,
but the numbers here are:

$ ls -l git ;# with the attached patch
-rwxrwxr-x 83 junio src 3345237 2008-01-03 00:53 git
$ ls -l ../git.build/git ;# before Dscho's patch
-rwxrwxr-x 83 junio src 3364803 2008-01-03 01:01 ../git.build/git
$ ls -l ~/bin/git ;# with Dscho's patch
-rwxr-xr-x 83 junio src 3389299 2008-01-02 15:18 /home/junio/bin/git

-- >8 --
Uninline prefixcmp()

Now the routine is an open-coded loop that avoids an extra
strlen() in the previous implementation, it got a bit too big to
be inlined.  Uninlining it makes code footprint smaller but the
result still retains the avoidance of strlen() cost.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-compat-util.h |   11 ++---------
 strbuf.c          |    9 +++++++++
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 7059cbd..b6ef544 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -122,6 +122,8 @@ extern void set_die_routine(void (*routine)(const c=
har *err, va_list params) NOR
 extern void set_error_routine(void (*routine)(const char *err, va_list=
 params));
 extern void set_warn_routine(void (*routine)(const char *warn, va_list=
 params));
=20
+extern int prefixcmp(const char *str, const char *prefix);
+
 #ifdef NO_MMAP
=20
 #ifndef PROT_READ
@@ -396,15 +398,6 @@ static inline int sane_case(int x, int high)
 	return x;
 }
=20
-static inline int prefixcmp(const char *str, const char *prefix)
-{
-	for (; ; str++, prefix++)
-		if (!*prefix)
-			return 0;
-		else if (*str !=3D *prefix)
-			return (unsigned char)*prefix - (unsigned char)*str;
-}
-
 static inline int strtoul_ui(char const *s, int base, unsigned int *re=
sult)
 {
 	unsigned long ul;
diff --git a/strbuf.c b/strbuf.c
index b9b194b..5efcfc8 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1,5 +1,14 @@
 #include "cache.h"
=20
+int prefixcmp(const char *str, const char *prefix)
+{
+	for (; ; str++, prefix++)
+		if (!*prefix)
+			return 0;
+		else if (*str !=3D *prefix)
+			return (unsigned char)*prefix - (unsigned char)*str;
+}
+
 /*
  * Used as the default ->buf value, so that people can always assume
  * buf is non NULL and ->buf is NUL terminated even for a freshly
