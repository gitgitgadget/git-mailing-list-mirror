From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH v2] find_pack_entry(): do not keep packed_git pointer
 locally
Date: Tue, 31 Jan 2012 14:28:50 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1201311418430.2759@xanadu.home>
References: <1327922750-12106-1-git-send-email-pclouds@gmail.com>
 <1328010239-29669-1-git-send-email-pclouds@gmail.com>
 <7vr4yf92dg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_+K2S4BnI1tFpm9WswLWa1Q)"
Cc: =?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 31 20:29:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsJNx-0001qE-Nw
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jan 2012 20:28:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754951Ab2AaT2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jan 2012 14:28:52 -0500
Received: from relais.videotron.ca ([24.201.245.36]:34473 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753681Ab2AaT2w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2012 14:28:52 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR003.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0LYO00K6RGPYVA40@VL-VM-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 31 Jan 2012 14:27:34 -0500 (EST)
In-reply-to: <7vr4yf92dg.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189466>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_+K2S4BnI1tFpm9WswLWa1Q)
Content-type: TEXT/PLAIN; charset=utf-8
Content-transfer-encoding: 8BIT

On Tue, 31 Jan 2012, Junio C Hamano wrote:

> Nguyễn Thái Ngọc Duy <pclouds@gmail.com> writes:
> 
> > +		/*
> > +		 * p can be NULL from the else clause above, if initial
> > +		 * f_p_e_last_found value (i.e. INVALID_PACK) is NULL, we may
> > +		 * advance p again to an imaginary pack in invalid memory
> > +		 */

Ah!  OK so that's why I initially came up with that (void*)1 value.

> But I think the real issue is that the original loop is written in an
> obscure way.

Can't disagree with that, especially when the original author (myself) 
doesn't see clearly through it anymore.

> The conversion in f7c22cc (always start looking up objects in the last 
> used pack first, 2007-05-30) wanted to turn the traversal that always 
> went from the tip of a linked list to instead first probe the 
> promising one, and then scan the list from the tip like it used to do, 
> except that it did not want to probe the one it thought promising 
> again.

Exact.

> So perhaps restructuring the loop by making the logic to probe into a
> single pack into a helper function, e.g.
> 
> static int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
> {
> 	if (last_found) {
> 		if (find_one(sha1, e, last_found))
> 			return 1;
> 	}
>         for (p = packed_git; p; p = p->next) {
>         	if (p == last_found || !find_one(sha1, e, p))
> 			continue;
> 		last_found = p;
> 		return 1;
> 	}
>         return 0;
> }
> 
> would make the resulting flow far easier to follow, no?

Indeed.


Nicolas

--Boundary_(ID_+K2S4BnI1tFpm9WswLWa1Q)--
