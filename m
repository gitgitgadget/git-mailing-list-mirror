From: David Barr <david.barr@cordelta.com>
Subject: Re: [PATCH] RFC: help.autocorrect prompt
Date: Mon, 6 Sep 2010 17:16:22 +1000
Organization: Cordelta Pty Ltd
Message-ID: <201009061716.22468.david.barr@cordelta.com>
References: <1283740106-11411-1-git-send-email-david.barr@cordelta.com> <20100906025949.GA23594@burratino>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 09:15:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsVvI-0003Q7-Sf
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 09:15:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265Ab0IFHPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 03:15:19 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:52108 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101Ab0IFHPT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 03:15:19 -0400
Received: by pwi3 with SMTP id 3so1012111pwi.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 00:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:organization:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:message-id;
        bh=usLUQU1q1/YqJ1VjspF6EatnRwSkA8UZowLkW/InNXE=;
        b=ch7Cno234Z2+nzQA5lVBHrVYH86OSC0ov50tqOFb4l6g7sAIs6NJVKhxUXW0NsH7U2
         Oev19M40ZyLG8qRgGnXzJ1XjS6XzrO02tCp5qEYJAIZviDt89HVNebuz7lWLnAJIzHGh
         9c5UukfdXKRJS6fYbN5VIdOq3dnHjXny2srDs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=RrkwfXElYJeLzT+3526WhfwhFo5szFws0DfP2WEhntvKkicSSzMyzGnwoEZe+Eijsf
         s0uOPJFAJHE9ytwGOLe4jL/rkceX0wuEZZ8PIVUJqCCK8/6CQW9aB+JXHogZZf3kYJu0
         CEU36fPDUFfSLjNbLM9H2PdAymBghQiQTyd0o=
Received: by 10.114.103.8 with SMTP id a8mr3356326wac.159.1283757318766;
        Mon, 06 Sep 2010 00:15:18 -0700 (PDT)
Received: from dba.localnet ([202.78.40.185])
        by mx.google.com with ESMTPS id q6sm10655423waj.22.2010.09.06.00.15.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 00:15:17 -0700 (PDT)
User-Agent: KMail/1.13.2 (Linux/2.6.32-24-generic; KDE/4.4.2; x86_64; ; )
In-Reply-To: <20100906025949.GA23594@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155540>

 
> Any particular significance to INT_MAX rather than, e.g., -1 here?
> (Just curious; it seems unlikely someone would use INT_MAX and
> accidentally trip on this.)

> Not a problem introduced by your patch: should we be checking for
> out-of-range (e.g., negative) values?

The existing docs say that negative values correspond to immediate execution,
zero to never, and positive to a delay in deciseconds.

As noted, I chose INT_MAX as a rather unlikely conscious choice (~7 years).

> > @@ -342,7 +346,10 @@ const char *help_unknown_cmd(const char *cmd)
> >                       "which does not exist.\n"
> >                       "Continuing under the assumption that you meant 
'%s'\n",
> >                       cmd, assumed);
> > -             if (autocorrect > 0) {
> > +             if (autocorrect == INT_MAX) {
> > +                     if (strcmp("y", git_getpass("Continue? (y/n) ")))
> > +                             exit(1);
> 
> Funny. :)
> 
> It might be better to actually always write this prompt to the
> terminal, rather than popping up a gui $GIT_ASKPASS if the user has
> set that up.  Maybe something like Heiko Voigt's "mingw: make failures
> to unlike or move raise a question" (9229029, 2010-02-21 from
> 4msysgit.git):
> 
>         if (!isatty(STDIN_FILENO) || !isatty(STDERR_FILENO))
>                 exit(1);
>         fprintf(stderr, "Continue? (y/n) ");
>         if (!fgets(answer, sizeof(answer), stdin))
>                 exit(1)
>         if (*answer != 'y' && *answer != 'Y')
>                 exit(1);
> 
> > +             } else if (autocorrect > 0) {
> >                       fprintf(stderr, "in %0.1f seconds automatically...
\n",
> >                               (float)autocorrect/10.0);
> >                       poll(NULL, 0, autocorrect * 100);

That looks much nicer, I was hoping for such a suggestion.

--
David Barr.
