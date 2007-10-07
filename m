From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Make strbuf_cmp inline, constify its arguments and  optimize it a bit
Date: Sun, 7 Oct 2007 23:54:32 +0200
Message-ID: <20071007215432.GC2765@steel.home>
References: <1190625904-22808-1-git-send-email-madcoder@debian.org> <1190625904-22808-2-git-send-email-madcoder@debian.org> <20071007140052.GA3260@steel.home> <20071007172425.bb691da9.tihirvon@gmail.com> <20071007143912.GB10024@artemis.corp> <87sl4nlyg0.fsf@catnip.gol.com> <857ilylxhm.fsf@lola.goethe.zz>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miles Bader <miles@gnu.org>, Pierre Habouzit <madcoder@debian.org>,
	Timo Hirvonen <tihirvon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Oct 07 23:54:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iee5H-0000Jn-0w
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 23:54:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753336AbXJGVyf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 17:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753225AbXJGVyf
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 17:54:35 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:36090 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752673AbXJGVye (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 17:54:34 -0400
Received: from tigra.home (Fc872.f.strato-dslnet.de [195.4.200.114])
	by post.webmailer.de (mrclete mo23) (RZmta 13.4)
	with ESMTP id I00bb0j97Gjgoa ; Sun, 7 Oct 2007 23:54:32 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id BC088277AE;
	Sun,  7 Oct 2007 23:54:32 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 95531C502; Sun,  7 Oct 2007 23:54:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <857ilylxhm.fsf@lola.goethe.zz>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWo+ecrQ=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60226>

David Kastrup, Sun, Oct 07, 2007 18:07:17 +0200:
> Miles Bader <miles@gnu.org> writes:
> 
> > Pierre Habouzit <madcoder@debian.org> writes:
> >>> strbuf->buf is always non-NULL and NUL-terminated so you could just do
> >>> 
> >>> static inline int strbuf_cmp(const struct strbuf *a, const struct strbuf *b)
> >>> {
> >>> 	int len = a->len < b->len ? a->len : b->len;
> >>> 	return memcmp(a->buf, b->buf, len + 1);
> >>> }
> >>
> >>   doesn't work, because a buffer can have (in some very specific cases)
> >> an embeded NUL.
> >
> > Couldn't you then just do:
> >
> >    int len = a->len < b->len ? a->len : b->len;
> >    int cmp = memcmp(a->buf, b->buf, len);
> >    if (cmp == 0)
> >       cmp = b->len - a->len;
> >    return cmp;
> >
> > [In the case where one string is a prefix of the other, then the longer
> > one is "greater".]
> >
> > ?
> 
> I fail to see where this variant is simpler than what we started the
> journey of simplification from.
> 
> The only change I consider worth checking from the whole series in
> this thread is making the function inline. 

It also makes arguments const (which admittedly wont make it faster).

> ... All the rest pretty much
> was worse than what we started from in that it needed to reevaluate
> more conditions and turned out more complicated and obfuscate even to
> the human reader.

it _is_ smaller. And it is _measurably_ faster on that thing I have at
home (and old p4).
