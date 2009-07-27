From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: RE: Question about fixing windows bug reading graft data
Date: Mon, 27 Jul 2009 19:55:09 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907271948130.6883@intel-tinevez-2-302>
References: <63BEA5E623E09F4D92233FB12A9F794303117E06@emailmn.mqsoftware.com> <63BEA5E623E09F4D92233FB12A9F7943033B2744@emailmn.mqsoftware.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Kelly F. Hickel" <kfh@mqsoftware.com>
X-From: git-owner@vger.kernel.org Mon Jul 27 19:55:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVUQ4-0007le-5l
	for gcvg-git-2@gmane.org; Mon, 27 Jul 2009 19:55:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752835AbZG0RzS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2009 13:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752704AbZG0RzS
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jul 2009 13:55:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:42889 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752714AbZG0RzR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2009 13:55:17 -0400
Received: (qmail invoked by alias); 27 Jul 2009 17:55:15 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp002) with SMTP; 27 Jul 2009 19:55:15 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18LcrZ2/s8Lwok9z5u+29J3ddkhZAyZtkXekynsIm
	DfhP3ZfQ1hux2A
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <63BEA5E623E09F4D92233FB12A9F7943033B2744@emailmn.mqsoftware.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124175>

Hi,

On Mon, 27 Jul 2009, Kelly F. Hickel wrote:

> OK, so the 10th copy of the msysGit Herald post has shamed me out of
> hiding!

;-)

> > The bug, is that in in commit.c, the code strips '\n', but not '\r', 
> > so the code says the graft data is bad:
> >
> > struct commit_graft *read_graft_line(char *buf, int len) {
> >         /* The format is just "Commit Parent1 Parent2 ...\n" */
> >         int i;
> >         struct commit_graft *graft = NULL;
> > 
> >         if (buf[len-1] == '\n')
> >                 buf[--len] = 0;
> >         if (buf[0] == '#' || buf[0] == '\0')
> >                 return NULL;
> >         if ((len + 1) % 41) {
> >         bad_graft_data:
> >                 error("bad graft data: %s", buf);
> >                 free(graft);
> >                 return NULL;
> >         }
> > 
> > My first plan was to fix it the way that xdiff-interface.c handles it,
> > assuming that was "the Git way" to deal with CRLF:
> >         /* Exclude terminating newline (and cr) from matching */
> >         if (len > 0 && line[len-1] == '\n') {
> >                 if (len > 1 && line[len-2] == '\r')
> >                         len -= 2;
> >                 else
> >                         len--;
> >         }
> > 
> > But I noticed that there seemed to be several checks for '\n' in 
> > commit.c that didn't check for '\r', and wondered if there was a 
> > reason, or if there'd be a better way to handle it.....

I think that you really only have to handle text files read from the file 
system.  That is not the case for commit object parsers: commit _objects_ 
are required to have LF line endings.

But a few files come to mind which might have CR/LF line endings and need 
to be interpreted correctly by Git: "grafts", as you pointed out, but also 
the refs and of course the config.

It would probably be a good idea to have something like

	static inline fix_line_ending(char *line, int len)
	{
		if (len > 0 && line[len-1] == '\n')
			line[len-1 - (len > 1 && line[len-2] == '\r')] = '\0';
	}

in cache.h, and use it in said places.

Of course, the hassle is to find all those places ;-)

Thanks,
Dscho
