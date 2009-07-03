From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: what's the current wisdom on git over NFS/CIFS?
Date: Fri, 3 Jul 2009 12:56:08 +0400
Message-ID: <20090703085608.GA18757@dpotapov.dyndns.org>
References: <slrnh4pcf8.484.sitaramc@sitaramc.homelinux.net> <alpine.LFD.2.01.0907021345440.3210@localhost.localdomain> <2e24e5b90907021752t10243468sc07be88cd88ac5c1@mail.gmail.com> <4A4DA1D6.40301@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jul 03 10:56:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMeZl-0008QS-Ou
	for gcvg-git-2@gmane.org; Fri, 03 Jul 2009 10:56:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753121AbZGCI4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2009 04:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752344AbZGCI4p
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jul 2009 04:56:45 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:42571 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149AbZGCI4p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2009 04:56:45 -0400
Received: by fxm18 with SMTP id 18so2014762fxm.37
        for <git@vger.kernel.org>; Fri, 03 Jul 2009 01:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=9dHqyXindV3FMe8GQHgw8wku9+ffSBROea8aI17B2E4=;
        b=D1qfIDYWyTOYIHrSDCkOCBrM02r1HYMfYwIO1sDkd2pZBi240LK7sfv1xQcJCmbGEt
         qfoJszv8hNZEJQGgeTxdGk4WHROTr7S9ZL+muchz74wDSskez2jOlat+Wz2OON74UltI
         Kzb+ga72DH8hhfh993I8zPuvRNs+YV/siPE2M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=lHkF2JUy9TS4ClHhIiGoxyYAWRgA9fBpXg82nnLIqTmrMiFZhCnjFXAtoeI7UiBw1T
         8A/RAUUL9juWWRA4tfDlHz++B8MaKgxXQxahTSSIzlq+QlEGQ9xonuSc7xGOTaxpL6xT
         1rgO82FAbfeEwSsGFA1QwnA63JLFEJC5uc9Og=
Received: by 10.204.55.199 with SMTP id v7mr1032439bkg.141.1246611406310;
        Fri, 03 Jul 2009 01:56:46 -0700 (PDT)
Received: from localhost (ppp91-76-17-68.pppoe.mtu-net.ru [91.76.17.68])
        by mx.google.com with ESMTPS id b17sm5954983fka.6.2009.07.03.01.56.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 03 Jul 2009 01:56:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4A4DA1D6.40301@viscovery.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122689>

On Fri, Jul 03, 2009 at 08:14:46AM +0200, Johannes Sixt wrote:
> (We don't yet have an implementation of fsync() :-( )

Why? It appears rather straightforward to me. Here is a patch that
implements it. Or did I miss something?

Warning: I do not use MinGW/Git, so I have not tested this patch.

-- >8 --
From 0a5e712ff8775e0f27923bedcb3c234288592eaa Mon Sep 17 00:00:00 2001
From: Dmitry Potapov <dpotapov@gmail.com>
Date: Fri, 3 Jul 2009 12:45:30 +0400
Subject: [PATCH] mingw: fsync implementation for Windows

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---
 compat/mingw.c |   16 ++++++++++++++++
 compat/mingw.h |    3 +--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index bed4178..65c9e8e 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1231,3 +1231,19 @@ struct dirent *mingw_readdir(DIR *dir)
 	return (struct dirent*)&dir->dd_dir;
 }
 #endif // !NO_MINGW_REPLACE_READDIR
+
+int fsync(int fd)
+{
+	HANDLE h = (HANDLE) _get_osfhandle(fd);
+	if (h == INVALID_HANDLE_VALUE)
+	{
+		errno = EBADF;
+		return -1;
+	}
+	if (!FlushFileBuffers(h))
+	{
+		errno = err_win_to_posix(GetLastError());
+		return -1;
+	}
+	return 0;
+}
diff --git a/compat/mingw.h b/compat/mingw.h
index 4f7ba4c..14d53c0 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -75,8 +75,7 @@ static inline int fork(void)
 { errno = ENOSYS; return -1; }
 static inline unsigned int alarm(unsigned int seconds)
 { return 0; }
-static inline int fsync(int fd)
-{ return 0; }
+int fsync(int fd);
 static inline int getppid(void)
 { return 1; }
 static inline void sync(void)
-- 
1.6.2.3

-- >8 --
