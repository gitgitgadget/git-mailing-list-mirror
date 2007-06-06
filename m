From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] Show html help with git-help --html
Date: Wed, 6 Jun 2007 07:07:35 -0400
Message-ID: <fcaeb9bf0706060407k26bfc0baw91c08f907384949b@mail.gmail.com>
References: <20070605183420.GA8450@localhost>
	 <7vzm3e9lui.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 06 13:07:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvtMg-00013R-87
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 13:07:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbXFFLHh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 07:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751813AbXFFLHh
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 07:07:37 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:33074 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019AbXFFLHh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 07:07:37 -0400
Received: by an-out-0708.google.com with SMTP id d31so24361and
        for <git@vger.kernel.org>; Wed, 06 Jun 2007 04:07:36 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e/QOIFHCM5DOOQj2oWrZZ3HsWyolOnbkOfShe3z4663V199zrK5BBeoslL9qonJrwLngm83GeJWDGcVzYb/WK4E/59WWYlD75nBfE+wRTSk3CMvaRyev//gdm0CKJmx+5XkOc8oOm2/K4oLdHKa5Mr22WiFzGGkTSySYliLV44s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RESy8cywFBSfA2jX4JtL+miiqisUPD8Yj9+HC6veP/5PQu+InMDSYDwCcuzQ3aXt2bq7Z+I3AkHkO+kX70JF67XzMuiDHa7vcqz9RAK1jjTS99UA77DF4fh4UT0/IYLv+4/eM7m0WDIx7jk/6O8Oqha4xLcSCdyq1CY6yxGPXf4=
Received: by 10.100.121.12 with SMTP id t12mr185764anc.1181128056063;
        Wed, 06 Jun 2007 04:07:36 -0700 (PDT)
Received: by 10.100.198.17 with HTTP; Wed, 6 Jun 2007 04:07:35 -0700 (PDT)
In-Reply-To: <7vzm3e9lui.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49282>

On 6/5/07, Junio C Hamano <gitster@pobox.com> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
> > This patch was inspired by ClearCase command 'ct man',...
>
> > diff --git a/help.c b/help.c
> > index 6a9af4d..78b1023 100644
> > --- a/help.c
> > +++ b/help.c
> > @@ -9,6 +9,14 @@
> >  #include "common-cmds.h"
> >  #include <sys/ioctl.h>
> >
> > +#ifndef HTML_DIR
> > +#define HTML_DIR "/usr/share/html/"
> > +#endif
> > +
> > +#ifndef HTML_PROGRAM
> > +#define HTML_PROGRAM "xdg-open"
> > +#endif
> > +
> >  /* most GUI terminals set COLUMNS (although some don't export it) */
> >  static int term_columns(void)
> >  {
> > @@ -183,6 +191,145 @@ static void show_man_page(const char *git_cmd)
> >       execlp("man", "man", page, NULL);
> >  }
> >
> > +static void show_html_page(const char *git_cmd)
> > +{
> > +     const char *html_dir;
> > +     int len, ret, nr_quotes;
> > +     char *p, *p2;
> > +     const char *cp, *cp2;
> > +     struct stat st;
> > +     char *quoted_git_cmd;
> > +     char *default_command = NULL;
> > +     const char *command;
> >...
> > +     /* append %p if there is not any %x */
> > +     if (!strchr(command, '%')) {
> > +             len = strlen(command);
> > +             default_command = xmalloc(len + 3 + 1); /* space %p */
> > +             strcpy(default_command, command);
> > +             strcat(default_command, " %p");
> > +             command = default_command;
> > +     }
> > +
> > +     /* first pass, calculate command length */
> > ...
>
> Hmmm.  Makes one wonder why interpolate is not used....

Sorry for my ignorant. I have no idea where to use interpolate :( Did
you mean to pretend adding %p to command without alloc new buffer
(default_command) ?
-- 
Duy
