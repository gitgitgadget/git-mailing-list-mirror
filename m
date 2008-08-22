From: "Jonas Fonseca" <jonas.fonseca@gmail.com>
Subject: Re: [tig PATCH] continue updates when pipe read has errno "Success"
Date: Fri, 22 Aug 2008 12:10:35 +0200
Message-ID: <2c6b72b30808220310v1083e860tef9fd6efa57767e3@mail.gmail.com>
References: <20080821014043.GA14452@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 22 12:11:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWTcK-0006ZK-L8
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 12:11:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754490AbYHVKKg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 06:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753746AbYHVKKg
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 06:10:36 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:62392 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753339AbYHVKKf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 06:10:35 -0400
Received: by wf-out-1314.google.com with SMTP id 27so546238wfd.4
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 03:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=SUYXLlk/iJ4pP4dkWvuPtSEbCzaQDIdpezIwaG0JicY=;
        b=xg2wB1V6iGZcNx8SoV+6JKanJ1nPvqKEKKs7l76Hs80xEGYW6ACv5SGVGhugEJmwgh
         lKLf7QPRTrGry9VkS4GSMjRDHnBNp1RwknGQYcPrDFWZ5R1P5saPJn5zkT28ER+liIWn
         dtMRvUajTqQ2ta1q5k2GIQqQ+I7hUDz6FwMeA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Y8jJRn9bkauQ5ecqeSBg2s2+5frTBTQEGvbFgQXRreoyHvGBTaerhUOlwqBUNOXiMs
         txVk8OEhemBpT+6GlBlLyKKbl9OdVc4eKii8CzBsuE45+o7Pqz1rEgyFKMZBxf/gnyvH
         fvAAk9l10bpFcNeW0eIrkzpm9rKQD8maxbuIo=
Received: by 10.142.232.20 with SMTP id e20mr343696wfh.85.1219399835145;
        Fri, 22 Aug 2008 03:10:35 -0700 (PDT)
Received: by 10.142.153.19 with HTTP; Fri, 22 Aug 2008 03:10:35 -0700 (PDT)
In-Reply-To: <20080821014043.GA14452@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93280>

On Thu, Aug 21, 2008 at 03:40, Jeff King <peff@peff.net> wrote:
> When we are reading from a pipe and receive a signal, our
> read call fails and ferror() returns true. The current
> behavior is to call end_update and report failure. However,
> we can detect this situation by checking that errno is set
> to success and continue the reading process.

Thanks for the fix/workaround!

> I am not convinced this is the right solution. Specifically:
>
>  - there are a few other calls to ferror. Maybe they should be
>    converted, too, which implies that perhaps there is a better idiom
>    for checking this.

Well, perhaps something like this can work around the issue for tig-0.12:

bool check_ferror(FILE *file) { return ferror(file) && errno != 0; }

For a possible "better" fix, I have been working on moving tig to use
the run-command.[ch] code from git, which means that ferror() will no
longer be needed. It is still not ready but looks promising.

>  - I have no idea how portable this is. Do all stdio implementations
>    fail to restart on signal? Do they all set ferror and have errno ==
>    0 (I would have expected EINTR, or at the very least a 0-read
>    without ferror set)?
>
> But it works for me (Linux, glibc 2.7).

I have tested it on FreeBSD which doesn't seem to have this problem
with ferror(). Anyway, the workaround doesn't break anything so
applied.

-- 
Jonas Fonseca
