From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] opening files in remote.c should ensure it is opening
 a file
Date: Fri, 8 Feb 2008 20:38:14 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802082035460.11591@racer.site>
References: <20080208174654.2e9e679c@pc09.procura.nl> <7vhcgjjjlh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 21:39:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNa0A-0004aP-Q6
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 21:39:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935500AbYBHUiT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 15:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935115AbYBHUiR
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 15:38:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:35031 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934599AbYBHUiP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 15:38:15 -0500
Received: (qmail invoked by alias); 08 Feb 2008 20:38:12 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp058) with SMTP; 08 Feb 2008 21:38:12 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19a8B45I3ha0MfjmxQoVJ1ExGwpmKAA7uSEPEpbwm
	pP5tMdsj63EN65
X-X-Sender: gene099@racer.site
In-Reply-To: <7vhcgjjjlh.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73139>

Hi,

On Fri, 8 Feb 2008, Junio C Hamano wrote:

> "H.Merijn Brand" <h.m.brand@xs4all.nl> writes:
> 
> > HP-UX allows directories to be opened with fopen (path, "r"), which
> > will cause some translations that expect to read files, read dirs
> > instead. This patch makes sure the two fopen () calls in remote.c
> > only open the file if it is a file.
> 
> > +static FILE *open_file(char *full_path)
> > +{
> > +       struct stat st_buf;
> > +       if (stat(full_path, &st_buf) || !S_ISREG(st_buf.st_mode))
> > +               return NULL;
> > +       return (fopen(full_path, "r"));
> > +}
> 
> Can we make this a platform specific "compat" hack?

You mean something like

#ifdef FOPEN_OPENS_DIRECTORIES
inline static FILE *fopen_compat(const char *path, const char *mode)
{
       struct stat st_buf;
       if (stat(path, &st_buf) || !S_ISREG(st_buf.st_mode))
               return NULL;
       return (fopen(path, mode));
}
#define fopen fopen_compat
#endif

in git-compat-util.h, right?

Yeah, I can see that, even if I think the overhead would not be _that_ 
crucial.  But it is a nice way of fixing _all_ fopen() calls at the same 
time.

Ciao,
Dscho
