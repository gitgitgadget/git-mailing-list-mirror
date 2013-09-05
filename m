From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 05/38] pack v4: add commit object parsing
Date: Thu, 05 Sep 2013 13:30:50 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309051318550.14472@syhkavp.arg>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
 <1378362001-1738-6-git-send-email-nico@fluxnic.net>
 <20130905103011.GA20919@goldbirke>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_Lr+xHWoGsk/KbhFhdzjqQQ)"
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Sep 05 19:30:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHdOS-0006xO-FU
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 19:30:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753604Ab3IERaw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 13:30:52 -0400
Received: from relais.videotron.ca ([24.201.245.36]:40765 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604Ab3IERav (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 13:30:51 -0400
Received: from xanadu.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSN00EX6XZEMN70@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 05 Sep 2013 13:30:50 -0400 (EDT)
In-reply-to: <20130905103011.GA20919@goldbirke>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233973>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_Lr+xHWoGsk/KbhFhdzjqQQ)
Content-type: TEXT/PLAIN; charset=iso-8859-1
Content-transfer-encoding: 8BIT

On Thu, 5 Sep 2013, SZEDER Gábor wrote:

> Hi,
> 
> 
> On Thu, Sep 05, 2013 at 02:19:28AM -0400, Nicolas Pitre wrote:
> > Let's create another dictionary table to hold the author and committer
> > entries.  We use the same table format used for tree entries where the
> > 16 bit data prefix is conveniently used to store the timezone value.
> > 
> > In order to copy straight from a commit object buffer, dict_add_entry()
> > is modified to get the string length as the provided string pointer is
> > not always be null terminated.
> > 
> > Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
> > ---
> >  packv4-create.c | 98 +++++++++++++++++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 89 insertions(+), 9 deletions(-)
> > 
> > diff --git a/packv4-create.c b/packv4-create.c
> > index eccd9fc..5c08871 100644
> > --- a/packv4-create.c
> > +++ b/packv4-create.c
> > @@ -1,5 +1,5 @@
> >  /*
> > - * packv4-create.c: management of dictionary tables used in pack v4
> > + * packv4-create.c: creation of dictionary tables and objects used in pack v4
> >   *
> >   * (C) Nicolas Pitre <nico@fluxnic.net>
> >   *
> > @@ -80,9 +80,9 @@ static void rehash_entries(struct dict_table *t)
> >  	}
> >  }
> >  
> > -int dict_add_entry(struct dict_table *t, int val, const char *str)
> > +int dict_add_entry(struct dict_table *t, int val, const char *str, int str_len)
> >  {
> > -	int i, val_len = 2, str_len = strlen(str) + 1;
> > +	int i, val_len = 2;
> >  
> >  	if (t->ptr + val_len + str_len > t->size) {
> 
> We need a +1 here on the left side, i.e.
> 
>         if (t->ptr + val_len + str_len + 1 > t->size) {

Absolutely, good catch.

> Sidenote: couldn't we call the 'ptr' field something else, like
> end_offset or end_idx?  It took me some headscratching to figure out
> why is it OK to compare a pointer to an integer above, or use a
> pointer without dereferencing as an index into an array below (because
> ptr is, well, not a pointer after all).

Indeed.  This is a remnant of an earlier implementation which didn't use 
realloc() and therefore this used to be a real pointer.

Both issues now addressed in my tree.

Thanks


Nicolas

--Boundary_(ID_Lr+xHWoGsk/KbhFhdzjqQQ)--
