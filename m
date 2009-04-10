From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH] Fix buffer overflow in config parser
Date: Fri, 10 Apr 2009 18:10:54 +0200
Message-ID: <200904101810.54774.markus.heidelberg@web.de>
References: <49DD21A0.3040505@intra2net.com> <200904090115.17609.markus.heidelberg@web.de> <200904090959.28646.thomas.jarosch@intra2net.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thomas Jarosch <thomas.jarosch@intra2net.com>
X-From: git-owner@vger.kernel.org Fri Apr 10 18:12:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsJKk-0002iK-HX
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 18:12:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765697AbZDJQK0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Apr 2009 12:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765670AbZDJQKZ
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Apr 2009 12:10:25 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:42469 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759385AbZDJQKY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Apr 2009 12:10:24 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id A404AFCCA29D;
	Fri, 10 Apr 2009 18:10:22 +0200 (CEST)
Received: from [89.59.65.40] (helo=.)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LsJJ8-00015p-00; Fri, 10 Apr 2009 18:10:22 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <200904090959.28646.thomas.jarosch@intra2net.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+Gv7PppDKEhT8W6Qbyfk/sqnprmtgsu9SbAZlt
	pCg/BDA1P814sTAjRfu0f4UzMunyYfAI7iyA+i1zfxTX+L2jMy
	jOi8ozrj31FcB2vEpH0g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116263>

Thomas Jarosch, 09.04.2009:
> On Thursday, 9. April 2009 01:15:17 Markus Heidelberg wrote:
> > > > diff --git a/config.c b/config.c
> > > > index b76fe4c..a9c67e8 100644
> > > > --- a/config.c
> > > > +++ b/config.c
> > > > @@ -72,7 +72,7 @@ static char *parse_value(void)
> > > >                         }
> > > >                 }
> > > >                 if (space) {
> > > > -                       if (len)
> > > > +                       if (len && len < sizeof(value)-1)
> > > >                                 value[len++] = ' ';
> > > >                         space = 0;
> >
> > Eh, or maybe better add a "continue;" here, so that only one char per
> > loop is read.
> 
> Thanks for the review.
> 
> If I understand the intention of the complete code correctly, the idea was
> to read in 1+ spaces and put -one- space in the buffer as soon as the first
> non-space character is encountered (if not inside quotes).
> 
> Adding a "continue" statement would eat up the first non-space character.

Yes, you are right, I judged to quickly.

> I guess it's ok to modify the first size check or keep to problem local and 
> check the size before putting the space in the buffer.

Keeping the problem local would mean to add this check to the end of the
"for" loop before "value[len++] = c;" where the overflow actually
happens.
OTOH this overflow only occurs within a whitespace area, so from this
POV it is local at this place.

I think the cleanest solution would be to decrease the existing check at
the top by 1, even if then the maximum length will be decreased. But
there is no hint in the docs about it anyway.

> Guess that's up to
> the maintainer which method he prefers.

Take what you think is the best solution and convince him :)

Markus
