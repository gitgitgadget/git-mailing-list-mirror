From: Alexey Borzenkov <snaury@gmail.com>
Subject: Re: [PATCH 04/14] Set _O_BINARY as default fmode for both MinGW and 
	MSVC
Date: Tue, 15 Sep 2009 23:07:47 +0400
Message-ID: <e2480c70909151207v4d89d302m27aecff0d4a11d45@mail.gmail.com>
References: <cover.1253021221.git.mstormo@gmail.com>
	 <213f3c7799721c3f42ffa689498175f0495048eb.1253021728.git.mstormo@gmail.com>
	 <26c067500d8adf17a2d75e2956e4d4a6cef27fc1.1253021728.git.mstormo@gmail.com>
	 <cover.1253021728.git.mstormo@gmail.com>
	 <6e6345fb3fbc19b1a2467e33e1633fe9025e547b.1253021728.git.mstormo@gmail.com>
	 <badc5d24387c28c752a45f75e8aec6bce64f81fe.1253021728.git.mstormo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes.Schindelin@gmx.de, msysgit@googlegroups.com,
	git@vger.kernel.org, lznuaa@gmail.com, raa.lkml@gmail.com
To: Marius Storm-Olsen <mstormo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 15 21:11:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MndQX-0005FG-9h
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 21:10:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758482AbZIOTIe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2009 15:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758477AbZIOTId
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 15:08:33 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:51424 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758403AbZIOTHo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2009 15:07:44 -0400
Received: by fxm17 with SMTP id 17so1803784fxm.37
        for <git@vger.kernel.org>; Tue, 15 Sep 2009 12:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=8/sXhc05PuGq/EVnSty9WpViktGh5dBosP6i90j2+HA=;
        b=IP1uyQM68594GnsO4soZuHwzHa6+oJy2DPJoTxXZsqkvXMvrvVyDVs43awATwSnJ/l
         RZpgXo6zILAA31BcA2NW79oUPQYCH7LMVFCStD7+t7tfypk9c3ZA2Eg6qA8w/TQF60Nt
         1ipbqkUm9G9P0vFCqdCf2vO1pd2137Ej1iNik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=ps5MEEuTz9NedaMGJXI0UmXYHKPpnbnI8/SiViQ41hSnIfFJKOkH04+UFHIHdi5KBQ
         gGvEhXvzud/+g8tb8Zs54jKktkpSzo443sNB7bWYSvA0icB5teqlLyocDNpq4flMeB14
         piEk2/bwrWm4qtd87hN/UjAVGMxyzQMsf4mZ0=
Received: by 10.223.143.79 with SMTP id t15mr3003403fau.13.1253041667406; Tue, 
	15 Sep 2009 12:07:47 -0700 (PDT)
In-Reply-To: <badc5d24387c28c752a45f75e8aec6bce64f81fe.1253021728.git.mstormo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128581>

GMail ate the bottom half of my message... again. :( Seems like
there's a strange bug in copy/pasting, I better compose long emails in
TextMate from now on. Here's a "reconstruction":

On Tue, Sep 15, 2009 at 5:44 PM, Marius Storm-Olsen <mstormo@gmail.com> wrote:
> +extern int _fmode;

And indeed. I just ported this patch to my custom msysgit branch
(based on v1.6.4.3) and it didn't compile:

   CC git.o
cc1.exe: warnings being treated as errors
In file included from git-compat-util.h:116,
                from builtin.h:4,
                from git.c:1:
compat/mingw.h:243: error: '_fmode' redeclared without dllimport
attribute: previous dllimport ignored
git.c: In function 'main':
git.c:456: error: the address of '_iob' will always evaluate as 'true'
make: *** [git.o] Error 1

> +       if (stdin) \
> +               _setmode(_fileno(stdin), _O_BINARY); \
> +       if (stdout) \
> +               _setmode(_fileno(stdout), _O_BINARY); \
> +       if (stderr) \
> +               _setmode(_fileno(stderr), _O_BINARY); \

Also, at least mingw/gcc that is coming with msysgit thinks that
stdin/stdout/stderr always evaluate to true, and this check causes
problems as well. In the end, your patch should become something like
this:

diff --git a/compat/mingw.c b/compat/mingw.c
index fd642e4..807996c 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -5,7 +5,6 @@
 #include "../strbuf.h"

 extern int hide_dotfiles;
-unsigned int _CRT_fmode = _O_BINARY;

 static int err_win_to_posix(DWORD winerr)
 {
diff --git a/compat/mingw.h b/compat/mingw.h
index cfbcc0e..46473c5 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -244,6 +244,10 @@ char **env_setenv(char **env, const char *name);
 static int mingw_main(); \
 int main(int argc, const char **argv) \
 { \
+	_fmode = _O_BINARY; \
+	_setmode(_fileno(stdin), _O_BINARY); \
+	_setmode(_fileno(stdout), _O_BINARY); \
+	_setmode(_fileno(stderr), _O_BINARY); \
 	argv[0] = xstrdup(_pgmptr); \
 	return mingw_main(argc, argv); \
 } \

I can't check if it compiles with MSVC, but with msysgit it compiles
fine. Tests pass at least up to 3400 (haven't finished the rest).
