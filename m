From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 2/3] compat/regex: hacks to get the gawk regex engine to compile within git
Date: Tue, 17 Aug 2010 03:25:47 +0000
Message-ID: <1282015548-19074-3-git-send-email-avarab@gmail.com>
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
X-From: git-owner@vger.kernel.org Tue Aug 17 05:26:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlCp1-0001sx-Sg
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 05:26:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755578Ab0HQD02 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Aug 2010 23:26:28 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57394 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148Ab0HQD01 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Aug 2010 23:26:27 -0400
Received: by mail-wy0-f174.google.com with SMTP id 32so6487016wyb.19
        for <git@vger.kernel.org>; Mon, 16 Aug 2010 20:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=XEX4kju7Lgn6n426DOuTMsi5vku7unLo4sB3lHXb978=;
        b=S8R2IkoeOvOOgK2ZL5MgYLBudcc37qPvG/J/3WGuKKGDyQFW1MPez+VLKLLZ8GTPQA
         znDxwcYqF4jSFeFuuTMk6Ook/JpJVMO+RiDW44JrKYzR/J2Te3dUpRRh0yQdZ9k70kHa
         qOLVPzB2oaoQzJMn6fn2J0HU5ntWPFdk8/H+A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=uyqZF328Oi/8ZqncDbILpV0YjQqXtldk5FvAvxQ77ObOydaQsG4okGtBlrSzG6Xdlt
         HwtNbwi74DqTCZqN1YCpbEZCHvkWwI1m1Pb/NBc5By+a+UH39Sv7BQgBwyPLIop9QRU0
         4QfJ3kL07C9kkvWwZKCweg2SfkHXVcNQI8+P4=
Received: by 10.227.127.65 with SMTP id f1mr5247492wbs.118.1282015587328;
        Mon, 16 Aug 2010 20:26:27 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id r10sm6060786wbe.0.2010.08.16.20.26.25
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 16 Aug 2010 20:26:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.389.gc3d0b
In-Reply-To: <AANLkTik4FL56EM4HdpfZ7ha8GNkbLsJeb415WFWUh+O_@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153688>

The gawk regex engine didn't include stdio.h, and only include
stddef.h if HAVE_STDDEF_H is set.

Adding -DHAVE_STDDEF_H caused some internal errors in by /usr/include
headers, so change the regex.h code to include it unconditionally.

We also need to define -DGAWK so that e.g. "bool", "MAX" and other
similar things used inside gawk get defined.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 Makefile             |    4 ++++
 compat/regex/regex.h |    7 +++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index b4745a5..6704780 100644
--- a/Makefile
+++ b/Makefile
@@ -1443,6 +1443,10 @@ ifdef UNRELIABLE_FSTAT
 	BASIC_CFLAGS +=3D -DUNRELIABLE_FSTAT
 endif
 ifdef NO_REGEX
+	# TODO: How do I compile just regex.o with this flag, not the
+	# whole of Git?
+	BASIC_CFLAGS +=3D -DGAWK
+
 	COMPAT_CFLAGS +=3D -Icompat/regex
 	COMPAT_OBJS +=3D compat/regex/regex.o
 endif
diff --git a/compat/regex/regex.h b/compat/regex/regex.h
index de93327..508bc80 100644
--- a/compat/regex/regex.h
+++ b/compat/regex/regex.h
@@ -22,9 +22,12 @@
 #ifndef _REGEX_H
 #define _REGEX_H 1
=20
-#ifdef HAVE_STDDEF_H
+#include <stdio.h>
+/*
+  Git: Was in `#ifdef HAVE_STDDEF_H` in gawk, adding -DHAVE_STDDEF_H m=
akes a
+  *lot* of other things break
+*/
 #include <stddef.h>
-#endif
=20
 #ifdef HAVE_SYS_TYPES_H
 #include <sys/types.h>
--=20
1.7.2.1.389.gc3d0b
