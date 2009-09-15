From: Alexey Borzenkov <snaury@gmail.com>
Subject: Re: [PATCH 04/14] Set _O_BINARY as default fmode for both MinGW and 
	MSVC
Date: Tue, 15 Sep 2009 22:40:33 +0400
Message-ID: <e2480c70909151140i26a8e748wf978145724d3fd55@mail.gmail.com>
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
X-From: git-owner@vger.kernel.org Tue Sep 15 20:40:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MncxH-0004hQ-C4
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 20:40:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758280AbZIOSkc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2009 14:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758274AbZIOSkb
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 14:40:31 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:56522 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758248AbZIOSkb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2009 14:40:31 -0400
Received: by fxm17 with SMTP id 17so1785874fxm.37
        for <git@vger.kernel.org>; Tue, 15 Sep 2009 11:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=ItohrWV7UWCobdjQGUnZy4/Zd6ioRfQsP2Rnj0s2mno=;
        b=DZaH5q0DdaE3Y7cfYlA1UnJ1kMCnPjCxfLJj2xv1ixFYdf4t2YFuJMn8uUWSkjP2uT
         v90IbT5RIJHufhtD55z5TluFN3Uh2LgAZ059l0Uq0FSU5ANbBd4Qx6s90xi5LkQoKNuK
         culmCzKXQKJ8GwFVVkdIJuCromxyge4D9UpKw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=adiHvI7b1pJ7EoWY3umxafTzfNpWYXfW6Gh/sWtIknLu77id2WuXkY6sWI2CBZNEQB
         b+NuWWtvVXq8g05w4ll2nq+mw7bCORhlx5D6Y7JwaieVg/DsMlxJmGutyM+Yaq5Mtzrn
         dTL5V9Ff1+Pt3QY3tCzwxF7JejaGw15egyA4k=
Received: by 10.223.58.139 with SMTP id g11mr2837677fah.43.1253040033551; Tue, 
	15 Sep 2009 11:40:33 -0700 (PDT)
In-Reply-To: <badc5d24387c28c752a45f75e8aec6bce64f81fe.1253021728.git.mstormo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128578>

On Tue, Sep 15, 2009 at 5:44 PM, Marius Storm-Olsen <mstormo@gmail.com> wrote:
> +extern int _fmode;

Is it really needed? I might be wrong, but I thought _fmode needed a
more complex declaration, at least on mingw, for which you are
supposed to include stdlib.h. For example, for mingw, in stdlib.h, it
is declared this way:

#if !defined (__DECLSPEC_SUPPORTED) || defined (__IN_MINGW_RUNTIME)

#ifdef __MSVCRT__
extern int* _imp___fmode;
#define	_fmode	(*_imp___fmode)
#else
/* CRTDLL */
extern int* _imp___fmode_dll;
#define	_fmode	(*_imp___fmode_dll)
#endif

#else /* __DECLSPEC_SUPPORTED */

#ifdef __MSVCRT__
__MINGW_IMPORT  int _fmode;
#else /* ! __MSVCRT__ */
__MINGW_IMPORT  int _fmode_dll;
#define	_fmode	_fmode_dll
#endif /* ! __MSVCRT__ */

#endif /* __DECLSPEC_SUPPORTED */

As you can see it is a little more complex than a simple extern (e.g.
it uses __declspec(dllimport) when it is supported, and a bit of
manual dereferencing otherwise). So maybe you would just include
stdlib.h and use definition from there?
