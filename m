From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] add GIT_FAST_STAT mode for Cygwin
Date: Tue, 23 Sep 2008 16:37:14 +0200
Message-ID: <81b0412b0809230737s7498e214w4c58991e79f76507@mail.gmail.com>
References: <20080923140144.GN21650@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Johannes Sixt" <johannes.sixt@telecom.at>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Steffen Prohaska" <prohaska@zib.de>
To: "Dmitry Potapov" <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 16:38:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ki921-0001ZQ-QU
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 16:38:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766AbYIWOhR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 10:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751524AbYIWOhR
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 10:37:17 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:20046 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166AbYIWOhP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 10:37:15 -0400
Received: by yx-out-2324.google.com with SMTP id 8so317112yxm.1
        for <git@vger.kernel.org>; Tue, 23 Sep 2008 07:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=FPxd0ONPzwW+HYdy4sCaeKoT2Zq0MbwuN1GYxJaNjvU=;
        b=KHnCA0kAUWO2eNjBoS+7wGMpERkiuI9JdBbFuLQBzs+Vnh/J7jQsaDooUmRBo1s6nn
         B3AKDc9Xod59lORY7CcXCTHSkrYtipxHtBP+DOHuUdQFHE4+kNJN5d4aJ/QXcC/GlvPG
         YohptzSEjq5ogIgSE8DbZPcc7Fyl4tFyo3aFg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=JPoMJYKUnEykF9q+NEJI2JkYTrsvcrIvcakSh8R6UJVlLYNcvnRdG9YDOO1XJ2TObE
         /W5Wn0SOkllikpbQ1gC5HffE2yDaztUWtcqKOJghsGQxWfeBZ12zHS8vDKHVYVB2Ixx3
         zJEAu/4IWXKplYz4B28vF4q92RJ/ccYUNxZVo=
Received: by 10.151.156.1 with SMTP id i1mr6363452ybo.238.1222180634731;
        Tue, 23 Sep 2008 07:37:14 -0700 (PDT)
Received: by 10.151.107.13 with HTTP; Tue, 23 Sep 2008 07:37:14 -0700 (PDT)
In-Reply-To: <20080923140144.GN21650@dpotapov.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96571>

2008/9/23 Dmitry Potapov <dpotapov@gmail.com>:
> This patch introduces the GIT_FAST_STAT environment variable. If this
> variable is not set then Git will work as before. However, if it is set
> then the Cygwin version of Git will try to use a Win32 API function if
> it is possible to speed up stat/lstat.
>
> This fast mode works only for relative paths. It is assumed that the
> whole repository is located inside one directory without using Cygwin
> mount to bind external paths inside of the current tree.

Why runtime conditional? Why conditional at all? Why not fallback
to cygwin's slow stat on absolute pathnames like you do for symlinks?

> +/*
> + * This are startup stubs, which choose what implementation of lstat/stat

why do you need two of them? Isn't one not enough?

> +stat_fn_t cygwin_stat_fn = cygwin_stat_choice;
> +stat_fn_t cygwin_lstat_fn = cygwin_lstat_choice;
...
> +typedef int (*stat_fn_t)(const char*, struct stat*);
> +extern stat_fn_t cygwin_stat_fn;
> +extern stat_fn_t cygwin_lstat_fn;

    extern int (*cygwin_stat_fn)(const char *, struct stat *);

Is shorter, easier to read and easier to understand (for a C person).
You don't even use the type anywhere else, it is just for the declaration sake!
