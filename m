From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 07/17] gettext.c: work around us not using setlocale(LC_CTYPE, "")
Date: Mon, 30 Aug 2010 21:28:13 +0000
Message-ID: <1283203703-26923-8-git-send-email-avarab@gmail.com>
References: <1283203703-26923-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Marcin Cieslak <saper@saper.info>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 30 23:30:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqBvd-0000N5-9V
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 23:30:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756032Ab0H3V3c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Aug 2010 17:29:32 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39875 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755872Ab0H3V3a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 17:29:30 -0400
Received: by wwb28 with SMTP id 28so136927wwb.1
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 14:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Fpu72MFMy3dv4zE3Sy4fUwLpjOT41Fp3uq80LFkjCTg=;
        b=b42UYeZCPmYVt52Gz9LDAg0CCuP24LIYRVlUzk6vLMfXWLKD8mgzUS2e4ZjG0EHf7F
         +bstQSoXBdutL0C0xayhs5IIWiczkDkubca1bZnYDhgUe72qPS9owZRQ3BeoxIpdjA3p
         NyJtS1/GjFPs9VdmNoDgB5siSF9clqHwRQ2+U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=HOmOXiLmP9Q9S088Oeg2rFs81RL/yStoQQgYhT7bEYwRej3C/YELU8CUqPAOLPFQU9
         xkVLVjWosaY8/guzX/v0gh6OhfOGd7qXcMDibJNUlGzQSsKlZp11e51eaPB/QPgMYqQX
         asRxL08m52FjMsymm9Qd5JCsK4FH4maP2C5yQ=
Received: by 10.227.156.66 with SMTP id v2mr5254509wbw.136.1283203738529;
        Mon, 30 Aug 2010 14:28:58 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id b23sm6923116wbb.22.2010.08.30.14.28.56
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 30 Aug 2010 14:28:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.536.g3f548
In-Reply-To: <1283203703-26923-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154858>

Change the gettext setup code to arrange for messages to be emitted in
the user's requested encoding, but avoid setting LC_CTYPE from the
environment for the whole program.

In 107880a I removed our use of setlocale(LC_CTYPE, "") because of a
bug in the GNU C Library [1]. Even if it wasn't for that bug we
wouldn't want to use LC_CTYPE at this point, because it'd require
auditing all the code that uses C functions whose semantics are
modified by LC_CTYPE.

But only setting LC_MESSAGES as we do creates a problem, since we
declare the encoding of our PO files[2] the gettext implementation
will try to recode it to the user's locale, but without LC_CTYPE it'll
emit something like this on 'git init'

    Bj? til t?ma Git lind ? /hl/agh/.git/

Gettext knows about the encoding of our PO file, but we haven't told
it about the user's encoding, so all the non-US-ASCII characters get
encoded to question marks.

But we're in luck! We can set LC_CTYPE from the environment only while
we call nl_langinfo and bind_textdomain_codeset. That suffices to tell
gettext what encoding it should emit in, so it'll now say:

    Bj=C3=B3 til t=C3=B3ma Git lind =C3=AD /hl/agh/.git/

And the equivalent ISO-8859-1 string will be emitted under a
ISO-8859-1 locale.

With this change way we get the advantages of setting LC_CTYPE (talk
to the user in his language/encoding), without the drawbacks (changed
semantics for C functions we rely on).

In the long term we should probably see about getting that bug in
glibc fixed, and audit our code so it won't fall apart under a non-C
locale.

1. http://sourceware.org/bugzilla/show_bug.cgi?id=3D6530
2. E.g. "Content-Type: text/plain; charset=3DUTF-8\n" in po/is.po

Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 gettext.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/gettext.c b/gettext.c
index db99742..8644098 100644
--- a/gettext.c
+++ b/gettext.c
@@ -1,11 +1,13 @@
 #include "exec_cmd.h"
 #include <locale.h>
 #include <libintl.h>
+#include <langinfo.h>
 #include <stdlib.h>
=20
 extern void git_setup_gettext(void) {
 	char *podir;
 	char *envdir =3D getenv("GIT_TEXTDOMAINDIR");
+	char *charset;
=20
 	if (envdir) {
 		(void)bindtextdomain("git", envdir);
@@ -17,5 +19,9 @@ extern void git_setup_gettext(void) {
 	}
=20
 	(void)setlocale(LC_MESSAGES, "");
+	(void)setlocale(LC_CTYPE, "");
+	charset =3D nl_langinfo(CODESET);
+	(void)bind_textdomain_codeset("git", charset);
+	(void)setlocale(LC_CTYPE, "C");
 	(void)textdomain("git");
 }
--=20
1.7.2.2.536.g3f548
