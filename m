From: Xin Wang <dram.wang@gmail.com>
Subject: Re: [PATCH] git_getpass: fix ssh-askpass behaviour
Date: Mon, 13 Dec 2010 12:09:57 +0800
Message-ID: <AANLkTi=V-KrwU97-KFJHd2+i05e6qsZsyMHkwpRLhCHx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 13 05:10:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRzjl-0008VX-75
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 05:10:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754923Ab0LMEKA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Dec 2010 23:10:00 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57968 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754610Ab0LMEKA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Dec 2010 23:10:00 -0500
Received: by wyb28 with SMTP id 28so5482855wyb.19
        for <git@vger.kernel.org>; Sun, 12 Dec 2010 20:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=NMfZSc/Zh2O8ZEwDd7myttckKF8QGqsoxv7iNYpS+uw=;
        b=n/a5UNmNtPM4Ah8Lr8UecAywnPjvIx0tMn92AnR8M0Yl0Xe/DeLZrBkB8ifd5CiiOw
         846lzGLLDTt9PJpn6/3Jm4mlYFJ5FTREWN1eEDVc0uOZti+nsoOtqy7GxDD6pFmT0SMD
         AW8VUwN6+peSXU7EQP06xshwpZbSMzsS78qLo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=q8Lp3QkRPJZkyvWeLFd00vWGs+YJfD7feq36oYiY7kcc51cdE51PHU14ZqECGgciBH
         e9ApIm6rLFwjNHhm3HqmKncr8U4iqKMo2W9Uwni5ysVDSwTxhLv+7oLQSmYpjT2LDs4w
         F5Zj3m35gx/YknOCJJWBbuS/QpgwxEhQbdJgE=
Received: by 10.216.187.71 with SMTP id x49mr4310984wem.111.1292213397102;
 Sun, 12 Dec 2010 20:09:57 -0800 (PST)
Received: by 10.216.180.129 with HTTP; Sun, 12 Dec 2010 20:09:57 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163512>

Junio C Hamano <gitster <at> pobox.com> writes:

>
> Alexander Sulfrian <alexander <at> sulfrian.net> writes:
>
> > call ssh-askpass only if the display environment variable is also set
> > ---
>
> I do not use it at all so I don't know for sure, but doesn't this break
> OSX?
>
>   20f3490 (web--browse: fix Mac OS X GUI detection for 10.6, 2009-09-14)
>
> is an example that you can be fully graphical without having DISPLAY set
> in some environment.  MinGW folks may want to chime in as well.
>

How about test whether git is associated with a terminal or not?

> >  connect.c |    7 +++++--
> >  1 files changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/connect.c b/connect.c
> > index 57dc20c..2810e3b 100644
> > --- a/connect.c
> > +++ b/connect.c
> > @@ -621,7 +621,7 @@ int finish_connect(struct child_process *conn)
> >
> >  char *git_getpass(const char *prompt)
> >  {
> > -	const char *askpass;
> > +	const char *askpass, *display;
> >  	struct child_process pass;
> >  	const char *args[3];
> >  	static struct strbuf buffer = STRBUF_INIT;
> > @@ -631,7 +631,10 @@ char *git_getpass(const char *prompt)
> >  		askpass = askpass_program;
> >  	if (!askpass)
> >  		askpass = getenv("SSH_ASKPASS");
> > -	if (!askpass || !(*askpass)) {
> > +
> > +	/* only call askpass if display is set */
> > +	display = getenv("DISPLAY");
> > +	if (!display || !(*display) || !askpass || !(*askpass))
> >  		char *result = getpass(prompt);
> >  		if (!result)
> >  			die_errno("Could not read password");
>
>

Xin Wang
