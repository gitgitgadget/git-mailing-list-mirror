From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH v2] correct verify_path for Windows
Date: Sun, 12 Oct 2008 20:18:36 +0200
Message-ID: <20081012181836.GA10626@steel.home>
References: <c475e2e60810020702q573570dcp31a5dc18bf98ef30@mail.gmail.com> <20081004233945.GM21650@dpotapov.dyndns.org> <B985AE98-F6E2-4C23-8D34-5A22A9F89FA7@gmail.com> <20081007032623.GX21650@dpotapov.dyndns.org> <48EAFF23.1020607@viscovery.net> <20081011163310.GZ21650@dpotapov.dyndns.org> <81b0412b0810111558vb69be00if4842fa91d777c3b@mail.gmail.com> <20081012135048.GC21650@dpotapov.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Joshua Juran <jjuran@gmail.com>,
	Giovanni Funchal <gafunchal@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 12 20:20:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kp5YD-0005KG-Fw
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 20:20:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754655AbYJLSSu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 14:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754520AbYJLSSu
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 14:18:50 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:23042 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754625AbYJLSSt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 14:18:49 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :Pm0FVUW6aauhRGJJc5OfA4AU8DM8ZlijdmJYxKn/UQvEQQx9CE8wrTU=
Received: from tigra.home (Fa930.f.strato-dslnet.de [195.4.169.48])
	by post.webmailer.de (klopstock mo3) (RZmta 17.10)
	with ESMTP id g06f32k9CGMLVZ ; Sun, 12 Oct 2008 20:18:36 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 73054277D5;
	Sun, 12 Oct 2008 20:18:36 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 2D67856D27; Sun, 12 Oct 2008 20:18:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20081012135048.GC21650@dpotapov.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98043>

Dmitry Potapov, Sun, Oct 12, 2008 15:50:48 +0200:
> On Sun, Oct 12, 2008 at 12:58:52AM +0200, Alex Riesen wrote:
> > 2008/10/11 Dmitry Potapov <dpotapov@gmail.com>:
> > >> > +   /* On Windows, file names are case-insensitive */
> > >> > +   case 'G':
> > >> > +           if ((rest[1]|0x20) != 'i')
> > >> > +                   break;
> > >> > +           if ((rest[2]|0x20) != 't')
> > >> > +                   break;
> > >>
> > >> We have tolower().
> > >
> > > I am aware of that, but I am not sure what we gain by using it. It seems
> > > it makes only code bigger and slow.
> > 
> > It does? Care to look into git-compat-util.h?
> 
> As a matter of fact, I did, and I see the following:
> 
>   #define sane_istest(x,mask) ((sane_ctype[(unsigned char)(x)] & (mask)) != 0)
>   #define tolower(x) sane_case((unsigned char)(x), 0x20)
> 
>   static inline int sane_case(int x, int high)
>   {
>   	if (sane_istest(x, GIT_ALPHA))
>   		x = (x & ~0x20) | high;
>   	return x;
>   }
> 
> So, it looks like an extra look up and an extra comparison here.

Does not look like much more code. But:

> > BTW, is it such a critical path?
> 
> I am not sure whether it is critical or not. It is called for each
> name in path. So, if you have a long path, it may be called quite a
> few times per a single path. Also, some operation such 'git add' can
> call verify_path() more than once (IIRC, it was called thrice per each
> added file). But I have no numbers to tell whether it is noticeable or
> not.

I looked at the callers (briefly). Performance could be a problem: add
and checkout can work with real big file lists and long pathnames.
So ok, than. It is critical.
