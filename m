From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] builtin-blame.c: Use utf8_strwidth for author's names
Date: Mon, 2 Feb 2009 13:40:11 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902021326420.3586@pacific.mpi-cbg.de>
References: <1233308489-2656-1-git-send-email-geofft@mit.edu> <1233308489-2656-2-git-send-email-geofft@mit.edu> <alpine.DEB.1.00.0901301811180.3586@pacific.mpi-cbg.de> <alpine.DEB.2.00.0901301710130.1984@vinegar-pot.mit.edu> <alpine.DEB.1.00.0902012333060.3586@pacific.mpi-cbg.de>
 <7v8wopmizw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1012680076-1233578416=:3586"
Cc: Geoffrey Thomas <geofft@MIT.EDU>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 13:41:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTy73-0008Om-3M
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 13:41:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154AbZBBMjw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 07:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753140AbZBBMjv
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 07:39:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:57152 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752879AbZBBMju (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 07:39:50 -0500
Received: (qmail invoked by alias); 02 Feb 2009 12:39:44 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp019) with SMTP; 02 Feb 2009 13:39:44 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX189Srdvrwo9wvVTdY7W9GXfs/YPEkPgwPYN5VYWmN
	Kwhdn1qDvttlAk
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7v8wopmizw.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108078>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1012680076-1233578416=:3586
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Hi,

On Sun, 1 Feb 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Fri, 30 Jan 2009, Geoffrey Thomas wrote:
> >
> >> Currently, however, printf("%*.*s", width, width, author) is simply 
> >> wrong, because printf only cares about bytes, not screen columns. Do 
> >> you think I should fall back on the old behavior if 
> >> i18n.commitencoding is set, or if at least one of the author names 
> >> isn't parseable as UTF-8, or something? Or should I be doing this 
> >> with iconv and assuming all commits are encoded in the current 
> >> encoding specified via $LANG or $LC_whatever?
> >
> > I do not know what encoding the author is at that point, but if you 
> > cannot be sure that it is UTF-8, using utf8_strwidth() is just as 
> > wrong as the current code, IMHO.
> 
> That is true, but then we are not losing anything.
> 
> This codepath is not about the payload (the contents of the files) but 
> the author name part of the commit log message, and UTF-8 would probably 
> be the only sensible encoding to standardize on.

Almost agree, except for shops where you have an enforced encoding that 
you cannot easily change.

And last time I checked, many more encodings used 1 character/byte (or for 
that matter, 1 column / byte) than not; utf8_width would be "more wrong" 
than strlen() here, because strlen() would "happen to work" here.

> If your project uses UTF-8 for everybody, great, we will align them 
> better than we did before.  If not, sorry, you will get a different 
> misaligned names.

There _has_ to be a way to check if the current author string is encoded 
in UTF-8.  All I am asking is that the original poster would put just a 
_little_ more effort into the issue and make the thing dependent on the 
knowledge -- as opposed to the assumption -- that the author is encoded in 
UTF-8.

> That assumes utf8_width() does not barf when fed an invalid byte 
> sequence, but I did not think it is that fragile (I didn't actually 
> audit the codepath, though).

That is the code that barfs in wcwidth:

        if (ch < 32 || (ch >= 0x7f && ch < 0xa0))
                return -1;

That is not a big problem, but Geoff's code does not handle that case 
correctly.  For example, in Code-page 437, a name like "£ïñûç" would 
result in a negative width.

But hey, it is definitely not my itch, I will never suffer from the 
fallout of this patch, as I am safely within US-ASCII.  I just thought I 
saw a potential problem and a possible way out.  That's it.

Ciao,
Dscho

--8323328-1012680076-1233578416=:3586--
