From: Nicolas Pitre <nico@cam.org>
Subject: Re: pack-objects: Fix segfault when object count is less than thread
 count
Date: Mon, 21 Jan 2008 11:08:34 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0801211107500.20753@xanadu.home>
References: <1200926145-14625-1-git-send-email-vsu@altlinux.ru>
 <4794B65E.5000502@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Sergey Vlasov <vsu@altlinux.ru>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Jan 21 17:09:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGzCs-0002Q4-UR
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 17:09:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758243AbYAUQIg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 11:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758237AbYAUQIg
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 11:08:36 -0500
Received: from relais.videotron.ca ([24.201.245.36]:59538 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755355AbYAUQIg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 11:08:36 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JV000JSC4UAM930@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 21 Jan 2008 11:08:35 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <4794B65E.5000502@viscovery.net>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71289>

On Mon, 21 Jan 2008, Johannes Sixt wrote:

> Sergey Vlasov schrieb:
> > When partitioning the work amongst threads, dividing the number of
> > objects by the number of threads may return 0 when there are less
> > objects than threads; this will cause the subsequent code to segfault
> > when accessing list[sub_size-1].  Fix this by ensuring that sub_size
> > is not zero if there is at least one object to process.
> > 
> > Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>
> > ---
> >  builtin-pack-objects.c |    3 +++
> >  1 files changed, 3 insertions(+), 0 deletions(-)
> > 
> > diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
> > index ec10238..cdf8aae 100644
> > --- a/builtin-pack-objects.c
> > +++ b/builtin-pack-objects.c
> > @@ -1665,6 +1665,9 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
> >  	for (i = 0; i < delta_search_threads; i++) {
> >  		unsigned sub_size = list_size / (delta_search_threads - i);
> >  
> > +		if (sub_size == 0 && list_size >= 1)
> > +			sub_size = 1;
> > +
> >  		p[i].window = window;
> >  		p[i].depth = depth;
> >  		p[i].processed = processed;
> 
> I think it fits the logic better to include sub_size > 0 in the while loop
> that follows, like so:
> 
> 		/* try to split chunks on "path" boundaries */
> 		while (0 < sub_size && sub_size < list_size &&
> 		       list[sub_size]->hash &&
> 		       list[sub_size]->hash == list[sub_size-1]->hash)
> 			sub_size++;
> 
> because we explicitly want to allow threads to "work" on zero objects
> (i.e. do nothing at all), but if a thread does get assigned some work,
> then its chunk is extended past the next path boundary. This way you
> collapse two special cases - "zero-sized chunk" and "path boundary" - into
> one.

Exact.


Nicolas
