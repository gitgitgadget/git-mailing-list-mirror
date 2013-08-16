From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] create_delta_index: simplify condition always evaluating
 to true
Date: Thu, 15 Aug 2013 22:34:06 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1308152231230.14472@syhkavp.arg>
References: <1376595460-6546-1-git-send-email-stefanbeller@googlemail.com>
 <7vzjsipr3s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Stefan Beller <stefanbeller@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 16 04:34:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VA9rl-0001e1-2S
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 04:34:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754156Ab3HPCeK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 22:34:10 -0400
Received: from relais.videotron.ca ([24.201.245.36]:54900 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751767Ab3HPCeI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 22:34:08 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MRL00JEKR4VQ9A0@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 15 Aug 2013 22:34:07 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id 5E9172DA0203; Thu, 15 Aug 2013 22:34:07 -0400 (EDT)
In-reply-to: <7vzjsipr3s.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232396>

On Thu, 15 Aug 2013, Junio C Hamano wrote:

> Forwarding to the area expert...
> 
> Stefan Beller <stefanbeller@googlemail.com> writes:
> 
> > When checking the previous lines in that function, we can deduct that
> > hsize must always be smaller than (1u<<31), since 506049c7df2c6
> > (fix >4GiB source delta assertion failure), because the entries is
> > capped at an upper bound of 0xfffffffeU, so hsize contains a maximum
> > value of 0x3fffffff, which is smaller than (1u<<31), so i will never
> > be larger than 31.
> >
> > Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>

Acked-by: Nicolas Pitre <nico@fluxnic.net>

You probably could dispense with the comment.  The code is obvious 
enough and the commit log has the rationale already.

> > ---
> >  diff-delta.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/diff-delta.c b/diff-delta.c
> > index 93385e1..54da95b 100644
> > --- a/diff-delta.c
> > +++ b/diff-delta.c
> > @@ -154,8 +154,15 @@ struct delta_index * create_delta_index(const void *buf, unsigned long bufsize)
> >  		 */
> >  		entries = 0xfffffffeU / RABIN_WINDOW;
> >  	}
> > +
> > +	/*
> > +	 * Do not check i < 31 in the loop, because the assignement
> > +	 * previous to the loop makes sure, hsize is definitely
> > +	 * smaller than 1<<31, hence the loop will always stop
> > +	 * before i exceeds 31 resulting in an infinite loop.
> > +	 */
> >  	hsize = entries / 4;
> > -	for (i = 4; (1u << i) < hsize && i < 31; i++);
> > +	for (i = 4; (1u << i) < hsize; i++);
> >  	hsize = 1 << i;
> >  	hmask = hsize - 1;
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
