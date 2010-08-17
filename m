From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC v2 2/3] compat/regex: get the gawk regex engine to compile within git
Date: Tue, 17 Aug 2010 05:17:12 +0000
Message-ID: <1282022233-32692-3-git-send-email-avarab@gmail.com>
References: <AANLkTik4FL56EM4HdpfZ7ha8GNkbLsJeb415WFWUh+O_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paolo Bonzini <paolo.bonzini@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 17 07:18:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlEYj-0002kb-1H
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 07:18:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754372Ab0HQFRf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Aug 2010 01:17:35 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:57701 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753296Ab0HQFRb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 01:17:31 -0400
Received: by wwi17 with SMTP id 17so567082wwi.1
        for <git@vger.kernel.org>; Mon, 16 Aug 2010 22:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=qhMUM/ZDg0bx1BcA1h2dlAaX8z7TLYhu1xlvcaRXi6Q=;
        b=iGpGDwA7EPscX+07mvXmbrTUINlAdLI5DLN9yips8/XTM78GBz+7a/+QKjvujlvcxJ
         CazeUazn5aJmLVsbYv6tKXanDVsr/d6+vs4OK4BojH53lfV3zljvYshXBavAt4ziBTg8
         M6KgzbrtIpqYXQa64Ru1Df2hkVdSNTydWTycU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=CDVwWb3FaRP0QeaZaoxn37fMaCE8/jkWGZivfrqzNQmePCsMmaYBUHwIlWifbTHY8m
         FZDb7LGVu58fbqhT9y9m4Xjdmk2gpchZhnQcTRxoZKJueH+u/QV1o1nifKYPnst8Qlpa
         axuBsSls13vrcmSmmW0O9ZU8YQ/Lvo6n+/oc0=
Received: by 10.227.136.69 with SMTP id q5mr5211798wbt.202.1282022250516;
        Mon, 16 Aug 2010 22:17:30 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id w32sm5362564wbd.1.2010.08.16.22.17.29
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 16 Aug 2010 22:17:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.389.gc3d0b
In-Reply-To: <AANLkTik4FL56EM4HdpfZ7ha8GNkbLsJeb415WFWUh+O_@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153698>

We need to define -DGAWK -DNO_MBSUPPORT so that the gawk regex engine
will compile, and include stdio.h and stddef.h in regex.h. Gawk itself
includes these headers before it includes the regex.h header.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 Makefile             |    4 ++++
 compat/regex/regex.h |    3 +++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index b4745a5..23a9f0d 100644
--- a/Makefile
+++ b/Makefile
@@ -1879,6 +1879,10 @@ ifdef NO_EXPAT
 http-walker.s http-walker.o: EXTRA_CPPFLAGS =3D -DNO_EXPAT
 endif
=20
+ifdef NO_REGEX
+compat/regex/regex.o: EXTRA_CPPFLAGS =3D -DGAWK -DNO_MBSUPPORT
+endif
+
 git-%$X: %.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^=
) $(LIBS)
=20
diff --git a/compat/regex/regex.h b/compat/regex/regex.h
index de93327..61c9683 100644
--- a/compat/regex/regex.h
+++ b/compat/regex/regex.h
@@ -1,3 +1,6 @@
+#include <stdio.h>
+#include <stddef.h>
+
 /* Definitions for data structures and routines for the regular
    expression library.
    Copyright (C) 1985,1989-93,1995-98,2000,2001,2002,2003,2005,2006,20=
08
--=20
1.7.2.1.389.gc3d0b
