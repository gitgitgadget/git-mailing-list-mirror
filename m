From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 1/2] sideband.c: Use xmalloc() instead of variable-sized
 arrays.
Date: Tue, 08 Jan 2008 14:59:20 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0801081444360.3054@xanadu.home>
References: <4783A3B2.3060801@viscovery.net>
 <7v4pdotdtl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 20:59:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCKc1-0005rs-J6
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 20:59:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752157AbYAHT7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 14:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751860AbYAHT7W
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 14:59:22 -0500
Received: from relais.videotron.ca ([24.201.245.36]:32237 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751695AbYAHT7V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 14:59:21 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JUC007TLCUWFM40@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 08 Jan 2008 14:59:20 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7v4pdotdtl.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69907>

On Tue, 8 Jan 2008, Junio C Hamano wrote:

> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
> > From: Johannes Sixt <johannes.sixt@telecom.at>
> >
> > How come we got along with this not very portable construct for so long?
> > Probably because the array sizes were computed from the results of
> > strlen() of string constants. Anyway, a follow-up patch will make the
> > lengths really non-constant.
> >
> > Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
> > ---
> >  sideband.c |   14 ++++++++++++--
> >  1 files changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/sideband.c b/sideband.c
> > index 756bbc2..513d7b3 100644
> > --- a/sideband.c
> > +++ b/sideband.c
> > @@ -19,7 +19,10 @@ int recv_sideband(const char *me, int in_stream, int out, int err)
> >  {
> >  	unsigned pf = strlen(PREFIX);
> >  	unsigned sf = strlen(SUFFIX);
> > -	char buf[pf + LARGE_PACKET_MAX + sf + 1];
> > +	char *buf, *save;
> > +
> > +	save = xmalloc(sf);
> > +	buf = xmalloc(pf + LARGE_PACKET_MAX + sf + 1);
> 
> I have to wonder if the malloc() overhead is small enough
> compared to the network bandwidth to make a two malloc-free
> pairs per packet a non-issue...

Eeek.  Overhead might be insignificant, but it still doesn't feel right.

What about using alloca() instead?  This is not like if we are doing 
funky things with the allocated memory anyway.


Nicolas
