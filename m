From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] fetch/push: readd rsync support
Date: Fri, 28 Sep 2007 13:53:48 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709281350140.28395@racer.site>
References: <Pine.LNX.4.64.0709280602580.28395@racer.site>
 <Pine.LNX.4.64.0709280606530.28395@racer.site> <7v3awzqgqc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 28 14:55:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbFN3-00076t-68
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 14:55:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752409AbXI1My5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 08:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752406AbXI1My5
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 08:54:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:39493 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752403AbXI1My4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 08:54:56 -0400
Received: (qmail invoked by alias); 28 Sep 2007 12:54:55 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp050) with SMTP; 28 Sep 2007 14:54:55 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/UmeFbSmnUAfAYARqygv865I/C7lHMD64ESYBro1
	mj1wXwY8Cn7qYC
X-X-Sender: gene099@racer.site
In-Reply-To: <7v3awzqgqc.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59391>

Hi,

On Fri, 28 Sep 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > +/*
> > + * path is assumed to point to a buffer of PATH_MAX bytes, and
> > + * path + name_offset is expected to point to "refs/".
> > + */
> > +
> > +static int read_loose_refs(char *path, int name_offset, struct ref **tail)
> > +{
> > +	DIR *dir = opendir(path);
> > +	struct dirent *de;
> > +	struct {
> > +		struct dirent *entries;
> > +		int nr, alloc;
> > +	} list;
> > +	int i, pathlen;
> > +
> > +	if (!dir)
> > +		return -1;
> > +
> > +	memset (&list, 0, sizeof(list));
> > +
> > +	while ((de = readdir(dir))) {
> > +		if (de->d_name[0] == '.' && (de->d_name[1] == '\0' ||
> > +				(de->d_name[1] == '.' &&
> > +				 de->d_name[2] == '\0')))
> > +			continue;
> > +		if (list.nr >= list.alloc) {
> > +			list.alloc = alloc_nr(list.nr);
> > +			list.entries = xrealloc(list.entries,
> > +				list.alloc * sizeof(*de));
> > +		}
> 
> ALLOC_GROW() not applicable here?
> 
> > +		list.entries[list.nr++] = *de;
> 
> Are you sure about this?
> 
> The last paragraph in Rationale section, in
> 
>     http://www.opengroup.org/onlinepubs/000095399/basedefs/dirent.h.html
> 
> suggests that the d_name[] member in struct dirent could be
> declared at the very end of the structure as length of 1 (the
> traditional trick to implement a flex-array); your assignment
> >from *de into entries[] would not work as expected on such an
> implementation.
> 
> On Linux with glibc it appears bits/dirent.h defines dirent with
> "char d_name[256]", so you may not see a breakage there, though.

D'oh!  You're completely right.

> You only use a list of strings (char **), don't you?

Originally, I wanted to use the d_type, too, but as I mentioned on IRC, it 
is not reliable enough (shows DT_UNKNOWN _all_ the time here).

But yes, I'll redo it, using ALLOC_GROW.

> > ...
> > +			if (fd < 0)
> > +				continue;
> > +			next = alloc_ref(strlen(path + name_offset));
> 
> And as we discussed earlier you would need one more byte here ;-).

Well, not after my patch, which I thought of as (1/3), but then decided it 
is good enough to be (1/1) until you shot it down...

Will fix.

Ciao,
Dscho
