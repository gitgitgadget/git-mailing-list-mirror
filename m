From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH v2] correct verify_path for Windows
Date: Sun, 12 Oct 2008 17:50:48 +0400
Message-ID: <20081012135048.GC21650@dpotapov.dyndns.org>
References: <c475e2e60810020702q573570dcp31a5dc18bf98ef30@mail.gmail.com> <20081004233945.GM21650@dpotapov.dyndns.org> <B985AE98-F6E2-4C23-8D34-5A22A9F89FA7@gmail.com> <20081007032623.GX21650@dpotapov.dyndns.org> <48EAFF23.1020607@viscovery.net> <20081011163310.GZ21650@dpotapov.dyndns.org> <81b0412b0810111558vb69be00if4842fa91d777c3b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Joshua Juran <jjuran@gmail.com>,
	Giovanni Funchal <gafunchal@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 12 15:53:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kp1Md-0004rC-Ri
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 15:52:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752268AbYJLNuz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 09:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752482AbYJLNuz
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 09:50:55 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:21425 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752245AbYJLNuy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 09:50:54 -0400
Received: by fg-out-1718.google.com with SMTP id 19so912338fgg.17
        for <git@vger.kernel.org>; Sun, 12 Oct 2008 06:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=3UUlRBes+QZb1zDNs3LP8SreWGQW+97Mo5sDpkP5rLc=;
        b=Ya8vqpdLye4xssTMDRVBvL54ayAyvN1pFGzYmDn8nw0KBRXI7tZEBE+3mfxdDbV1xP
         npnvT/Qk4MRusf33bN83mvqm5JpKxwZTFYGglhD+XL8orxKuTxweN6tn0wBtQJB0UsGC
         Q45SJoSCqJVucmjcw5nzexRwzLjkaMoh13mQc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=G+BFYFAphL5RDiWTw2ywMTxDxZohg6la/EVn8jHshDHQZvLUxAwBSXslKuBrs5gTt2
         G4FAeFJ+hJWwr6T8OFjDHmNyFGUoHC2JYcehchJiPFlNXLTqHdz+L/V2/EQVLb22ItNY
         VSn3JpCKhCyoBTarzap/bkp2w0WjA1nd6xTFU=
Received: by 10.86.95.20 with SMTP id s20mr3925297fgb.65.1223819452606;
        Sun, 12 Oct 2008 06:50:52 -0700 (PDT)
Received: from localhost (ppp85-141-237-231.pppoe.mtu-net.ru [85.141.237.231])
        by mx.google.com with ESMTPS id l12sm6304959fgb.6.2008.10.12.06.50.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 12 Oct 2008 06:50:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <81b0412b0810111558vb69be00if4842fa91d777c3b@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98020>

On Sun, Oct 12, 2008 at 12:58:52AM +0200, Alex Riesen wrote:
> 2008/10/11 Dmitry Potapov <dpotapov@gmail.com>:
> >> > +   /* On Windows, file names are case-insensitive */
> >> > +   case 'G':
> >> > +           if ((rest[1]|0x20) != 'i')
> >> > +                   break;
> >> > +           if ((rest[2]|0x20) != 't')
> >> > +                   break;
> >>
> >> We have tolower().
> >
> > I am aware of that, but I am not sure what we gain by using it. It seems
> > it makes only code bigger and slow.
> 
> It does? Care to look into git-compat-util.h?

As a matter of fact, I did, and I see the following:

  #define sane_istest(x,mask) ((sane_ctype[(unsigned char)(x)] & (mask)) != 0)
  #define tolower(x) sane_case((unsigned char)(x), 0x20)

  static inline int sane_case(int x, int high)
  {
  	if (sane_istest(x, GIT_ALPHA))
  		x = (x & ~0x20) | high;
  	return x;
  }

So, it looks like an extra look up and an extra comparison here.

> 
> > ... As to readability, I don't see much
> > improvement... Isn't obvious what this code does, especially with the
> > above comment?
> 
> You want to seriously argue that "a | 0x20" is as readable as "tolower(a)"?
> For the years to come? With a person who does not even know what ASCII is?
> Ok, I'm exaggerating. But the point is: it is not us who will be
> reading the code.

Obviously, for a person who don't know what ASCII is, tolower() will be
much easier to understand, but the question is what I can reasonable to
expect for a person reading this code later. A similar argument can be
made about adding extra parenthesis, i.e. instead of writing
  if (a == b || c == d)
you should always write
  if ((a == b) || (c == d))
because some people do not remember the priority of each operator.
(And I have seen such programmers who claim to have many experience of
writing in C, yet, they do not remember operator priority.)

For me, using tolower() does not make it more readable, but maybe I am
too old-fashion assuming that people are supposed to know at least basic
things about ASCII.

> BTW, is it such a critical path?

I am not sure whether it is critical or not. It is called for each
name in path. So, if you have a long path, it may be called quite a
few times per a single path. Also, some operation such 'git add' can
call verify_path() more than once (IIRC, it was called thrice per each
added file). But I have no numbers to tell whether it is noticeable or
not.

> Can't the code be unified and do without #ifdef?

It will impose a extra restriction on what file names people can use,
and I don't like extra restrictions for those who use sane file systems.


Dmitry
