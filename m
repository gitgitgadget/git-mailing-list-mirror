From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] compat: add memrchr()
Date: Fri, 15 Oct 2010 01:06:54 -0500
Message-ID: <20101015060654.GD21830@burratino>
References: <1287098999-9244-1-git-send-email-ydirson@altern.org>
 <20101015051750.GA21830@burratino>
 <AANLkTinBuAhLLUMLd6ZWtVFWCjnFAxYwVSo1Pkja7bT4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Yann Dirson <ydirson@altern.org>, git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 15 08:11:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6dW0-0005H3-3N
	for gcvg-git-2@lo.gmane.org; Fri, 15 Oct 2010 08:11:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755997Ab0JOGKW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Oct 2010 02:10:22 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:49955 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755816Ab0JOGKV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Oct 2010 02:10:21 -0400
Received: by yxm8 with SMTP id 8so179964yxm.19
        for <git@vger.kernel.org>; Thu, 14 Oct 2010 23:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=4w8hzAXDE2Zk/mr/xX0kgL9TTvddxFqZx5hiAasr638=;
        b=B9eiTaCX6F7V/uqwM2SRsreokKkXO55m0RVUNZTAjWuKytQxHKTSnvt6nQw3UrrGe7
         xFYMuEr5Unt/vVFWUKP6w0iN5+i9Xpy+UXllTQA8a0mwt+Eli4aqGwBUqXORh2iTR4tN
         osAXWrMYTEXt8r5uFNdqtEkb+0nlv949/IIg8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=u8nqtNSZMGFr8AFd8vHYD/spPTUL+5t73j8WCrUkQ1szt0BQKjKG1xhKN2WB5nQ+Kj
         RF1/wnO8crEJHBIwd1b5lUWjUgQKXzwg+uFRebf5boOcLpGB1w0Ox4YsxpRfdPrvFeDh
         Q58gC8a/JLZvXkl6xQ3WR9+nNaIXuLhbQXHBI=
Received: by 10.150.91.10 with SMTP id o10mr888515ybb.394.1287123020506;
        Thu, 14 Oct 2010 23:10:20 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id n48sm9595461yha.7.2010.10.14.23.10.19
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 14 Oct 2010 23:10:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinBuAhLLUMLd6ZWtVFWCjnFAxYwVSo1Pkja7bT4@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159099>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Maybe something like this for configure.ac:
>=20
>     AC_CHECK_LIB([c], [memchr],
>     [HAVE_MEMRCHR=3DYesPlease],
>     [HAVE_MEMRCHR=3D])
>     AC_SUBST(HAVE_MEMRCHR)
>=20
> And documentation with the other HAVE_* variables at the top of the
> Makefile?

Hmm, the BSDs and plan 9 have an memrchr() apparently.   Any idea for
taking advantage of that (the makefile support part) that's less ugly
than this?

If we miss a platform, that's no big deal.  The 1-char-at-a-time
loop is not so slow, and the "#define memrchr gitmemrchr" ensures
that it would not conflict with the libc version.
---
diff --git a/Makefile b/Makefile
index 1f1ce04..fa91530 100644
--- a/Makefile
+++ b/Makefile
@@ -211,6 +211,8 @@ all::
 #
 # Define NO_REGEX if you have no or inferior regex support in your C l=
ibrary.
 #
+# Define HAVE_MEMRCHR if you have memrchr() in your C library.
+#
 # Define JSMIN to point to JavaScript minifier that functions as
 # a filter to have gitweb.js minified.
 #
@@ -1388,6 +1390,9 @@ endif
 ifdef NO_UINTMAX_T
 	BASIC_CFLAGS +=3D -Duintmax_t=3Duint32_t
 endif
+ifdef HAVE_MEMRCHR
+	BASIC_CFLAGS +=3D -DHAVE_MEMRCHR
+endif
 ifdef NO_SOCKADDR_STORAGE
 ifdef NO_IPV6
 	BASIC_CFLAGS +=3D -Dsockaddr_storage=3Dsockaddr_in
diff --git a/git-compat-util.h b/git-compat-util.h
index 6f1020e..45aaebc 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -366,7 +366,7 @@ extern int git_vsnprintf(char *str, size_t maxsize,
 #define HAVE_STRCHRNUL
 #define HAVE_MEMPCPY
 #endif
-#if __GLIBC_PREREQ(2, 2)
+#if __GLIBC_PREREQ(2, 2) && !defined(HAVE_MEMRCHR)
 #define HAVE_MEMRCHR
 #endif
 #endif
