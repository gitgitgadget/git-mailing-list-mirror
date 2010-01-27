From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 11/12] Makefile: list standalone program object files in
 PROGRAM_OBJS
Date: Wed, 27 Jan 2010 03:07:21 -0600
Message-ID: <20100127090423.GA28252@progeny.tock>
References: <20100123144201.GA11903@progeny.tock>
 <7v3a1u6bfz.fsf@alter.siamese.dyndns.org>
 <20100126154357.GA4895@progeny.tock>
 <20100126155423.GL4895@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 27 10:07:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Na3s1-0003gA-5Z
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 10:07:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752709Ab0A0JHX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Jan 2010 04:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752576Ab0A0JHX
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 04:07:23 -0500
Received: from mail-iw0-f186.google.com ([209.85.223.186]:46046 "EHLO
	mail-iw0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846Ab0A0JHU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 04:07:20 -0500
Received: by iwn16 with SMTP id 16so911710iwn.5
        for <git@vger.kernel.org>; Wed, 27 Jan 2010 01:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=4SQmaMmuAHKpvMZlOZm2POhqm59pbTAttaXw3vTByZ0=;
        b=LeLjUaXu0zm7sLbzEv76OzxOIW956VCjOi1DlUWdbJmk7GJuKW5YTFchn3EwUQNwwM
         4fMLNlKae3PyLILn2LmzBmUTzo0N1cJ/6HjhWVU11vYW7kwAUokO9mp1l4aNqMbNzGuX
         NU7lpitdThyS4D99pob274WM/8C3XSH1MJqXA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=omyUF/lEDrlu1GPJUWrkwJ4lg5XFzGuDMqjsQQwJt0w2qQ3zUAd2IdbWMgnA9Z4a90
         a9ClrU45yrB6GNBGqX6VdJ1UbedcwEFYNYPDfwWJJTtecIcO4qzT3zP9gmpv9QicGr/b
         UzzAV3yRY5dImQmrVlWzCXTYtfpfGW95+ctbM=
Received: by 10.231.149.10 with SMTP id r10mr7158036ibv.63.1264583239657;
        Wed, 27 Jan 2010 01:07:19 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm658787iwn.1.2010.01.27.01.07.15
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 27 Jan 2010 01:07:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100126155423.GL4895@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138119>

Because of new commands like git-remote-http, the OBJECTS list
contains fictitious objects such as remote-http.o.  Thus any
out-of-tree rules that require all $(OBJECTS) to be buildable
are broken.  Add a list of real program objects to avoid this
problem.

To avoid duplication of effort, calculate the command list in
the PROGRAMS variable using the expansion of PROGRAM_OBJS.
This calculation occurs at the time $(PROGRAMS) is expanded,
so later additions to PROGRAM_OBJS will be reflected in it,
provided they occur before the build rules begin on line 1489.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
The previous version of this patch had a bug: I assumed that

	PROGRAMS +=3D $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))

would add to PROGRAMS a list of command names derived from the value
of PROGRAM_OBJS at the time that line is first read; but in fact, what
matters is the value of PROGRAM_OBJS at expansion time.

More importantly, my process had a bug: I didn=E2=80=99t try 'make inst=
all'
before sending.  Sorry about that.  Here=E2=80=99s a fixed patch, at le=
ast.

I have pushed out this fix to

  git://repo.or.cz/git/jrn.git autodep-rebased
  git://repo.or.cz/git/jrn.git autodep

The former has been rerolled to include the fixed patch 11; the
latter includes a fixup commit at the end.

Thanks to Junio for the report.

 Makefile |   28 ++++++++++++++++------------
 1 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/Makefile b/Makefile
index df36173..630687f 100644
--- a/Makefile
+++ b/Makefile
@@ -341,6 +341,7 @@ COMPAT_CFLAGS =3D
 COMPAT_OBJS =3D
 LIB_H =3D
 LIB_OBJS =3D
+PROGRAM_OBJS =3D
 PROGRAMS =3D
 SCRIPT_PERL =3D
 SCRIPT_PYTHON =3D
@@ -390,12 +391,15 @@ EXTRA_PROGRAMS =3D
=20
 # ... and all the rest that could be moved out of bindir to gitexecdir
 PROGRAMS +=3D $(EXTRA_PROGRAMS)
-PROGRAMS +=3D git-fast-import$X
-PROGRAMS +=3D git-imap-send$X
-PROGRAMS +=3D git-shell$X
-PROGRAMS +=3D git-show-index$X
-PROGRAMS +=3D git-upload-pack$X
-PROGRAMS +=3D git-http-backend$X
+
+PROGRAM_OBJS +=3D fast-import.o
+PROGRAM_OBJS +=3D imap-send.o
+PROGRAM_OBJS +=3D shell.o
+PROGRAM_OBJS +=3D show-index.o
+PROGRAM_OBJS +=3D upload-pack.o
+PROGRAM_OBJS +=3D http-backend.o
+
+PROGRAMS +=3D $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
=20
 TEST_PROGRAMS_NEED_X +=3D test-chmtime
 TEST_PROGRAMS_NEED_X +=3D test-ctype
@@ -1139,11 +1143,12 @@ else
 	REMOTE_CURL_PRIMARY =3D git-remote-http$X
 	REMOTE_CURL_ALIASES =3D git-remote-https$X git-remote-ftp$X git-remot=
e-ftps$X
 	REMOTE_CURL_NAMES =3D $(REMOTE_CURL_PRIMARY) $(REMOTE_CURL_ALIASES)
-	PROGRAMS +=3D $(REMOTE_CURL_NAMES) git-http-fetch$X
+	PROGRAM_OBJS +=3D http-fetch.o
+	PROGRAMS +=3D $(REMOTE_CURL_NAMES)
 	curl_check :=3D $(shell (echo 070908; curl-config --vernum) | sort -r=
 | sed -ne 2p)
 	ifeq "$(curl_check)" "070908"
 		ifndef NO_EXPAT
-			PROGRAMS +=3D git-http-push$X
+			PROGRAM_OBJS +=3D http-push.o
 		endif
 	endif
 	ifndef NO_EXPAT
@@ -1163,7 +1168,7 @@ endif
 EXTLIBS +=3D -lz
=20
 ifndef NO_POSIX_ONLY_PROGRAMS
-	PROGRAMS +=3D git-daemon$X
+	PROGRAM_OBJS +=3D daemon.o
 endif
 ifndef NO_OPENSSL
 	OPENSSL_LIBSSL =3D -lssl
@@ -1670,9 +1675,8 @@ git.o git.spec \
 	$(patsubst %.perl,%,$(SCRIPT_PERL)) \
 	: GIT-VERSION-FILE
=20
-GIT_OBJS :=3D $(LIB_OBJS) $(BUILTIN_OBJS) $(TEST_OBJS) \
-	git.o http.o http-walker.o remote-curl.o \
-	$(patsubst git-%$X,%.o,$(PROGRAMS))
+GIT_OBJS :=3D $(LIB_OBJS) $(BUILTIN_OBJS) $(PROGRAM_OBJS) $(TEST_OBJS)=
 \
+	git.o http.o http-walker.o remote-curl.o
 XDIFF_OBJS =3D xdiff/xdiffi.o xdiff/xprepare.o xdiff/xutils.o xdiff/xe=
mit.o \
 	xdiff/xmerge.o xdiff/xpatience.o
 OBJECTS :=3D $(GIT_OBJS) $(XDIFF_OBJS)
--=20
1.6.6
