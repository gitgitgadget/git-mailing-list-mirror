From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fread does not return negative on error
Date: Wed, 24 Jun 2009 18:40:17 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0906241835240.7946@intel-tinevez-2-302>
References: <4A3FB09D.9050903@gmail.com> <20090622153431.GA18466@elte.hu> <25e057c00906220847t15425f38maf486c291d1d2468@mail.gmail.com> <4A3FB479.2090902@lsrfire.ath.cx> <7vhby64i8f.fsf@alter.siamese.dyndns.org> <20090624081819.GA10436@elte.hu>
 <alpine.DEB.1.00.0906241201040.4773@pacific.mpi-cbg.de> <7vws71wquf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1374987934-1245861618=:7946"
Cc: Ingo Molnar <mingo@elte.hu>,
	=?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	roel kluin <roel.kluin@gmail.com>, git@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 24 18:40:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJVWf-0005P4-Ny
	for gcvg-git-2@gmane.org; Wed, 24 Jun 2009 18:40:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760876AbZFXQkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2009 12:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760888AbZFXQkS
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jun 2009 12:40:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:35021 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760993AbZFXQkR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2009 12:40:17 -0400
Received: (qmail invoked by alias); 24 Jun 2009 16:40:18 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp006) with SMTP; 24 Jun 2009 18:40:18 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/vD4pe+VjvU9t7HlBs5UbG0MTRARRWEk2E27Hbvr
	2tl0kPgYkNs6A1
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7vws71wquf.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.48
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122143>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1374987934-1245861618=:7946
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 24 Jun 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > This here script:
> >
> > -- snip --
> > for file in abspath.c alias.c cache.h color.c color.h config.c ctype.c \
> > 	environment.c exec_cmd.c exec_cmd.h help.c help.h levenshtein.c \
> > 	levenshtein.h pager.c parse-options.c parse-options.h path.c \
> > 	quote.c quote.h run-command.c run-command.h sigchain.c sigchain.h \
> > 	strbuf.c strbuf.h string.c string.h symbol.c symbol.h usage.c \
> > 	util.h wrapper.c
> > do
> > 	echo $file
> > 	git shortlog -n -s $file | head -n 2
> > done
> 
> I have thought about suggesting this myself, and your output for many of
> the files matched my intuition, but some were grossly off, so I checked.
> 
> The above procedure counts commits, and a one liner "s/char \*/const &/"
> weighs as heavily as the patch that implemented the whole thing, for a
> file that was done in one commit almost perfectly except that it needed a
> small constness fix.  Summarizing output from "blame" for each file may
> give you a more meaningful results:
> 
>     # timestamp
>     ts='[12][0-9][0-9][0-9]-[0-9][0-9]-[0-3][0-9] ..:..:.. [-+]....'
>     # linenum
>     lno='[1-9][0-9]*'
>     git blame "$file" |
>     sed -e 's/^[^ ]*  *(\([^)]*[^ ]\)  *'"$ts  *$lno"').*/\1/' |
>     sort |
>     uniq -c |
>     sort -r -n
> 
> For example, I do not think it is fair to credit me for abspath.c more
> than Dmitry like this:
> 
> > outputs this (note that a few files you mentioned are not in git.git):
> >
> > abspath.c
> >      2	Junio C Hamano
> >      1	Dmitry Potapov
> 
> Initially Dmitry introduced this file with 5b8e6f8 (shrink git-shell by
> avoiding redundant dependencies, 2008-06-28) at 68 lines.  J6t added 36
> lines for add_path() with 10c4c88 (Allow add_path() to add non-existent
> directories to the path, 2008-07-21), I added 12 lines to add a new
> function with 90b4a71 (is_directory(): a generic helper function,
> 2008-09-09) and then added a two-liner out-of-bounds-then-die check in
> 737e31a (make_absolute_path(): check bounds when seeing an overlong
> symlink, 2008-12-17).

Okay, a script similar to what you propose shows this:

abspath.c
     67 Dmitry Potapov	
     36 Johannes Sixt	
alias.c
     49 Miklos Vajna	
     24  Jeff King	
cache.h
    305 Junio C Hamano	
    263 Linus Torvalds	
color.c
    136  Jeff King	
     29 Johannes Schindelin	
color.h
     10 Matthias Kestenholz	
     10  Jeff King	
config.c
    352 Linus Torvalds	
    284 Johannes Schindelin	
ctype.c
     15 René Scharfe	
     11 Linus Torvalds	
environment.c
     68 Linus Torvalds	
     34 Johannes Schindelin	
exec_cmd.c
     47 Michal Ostrowski	
     40 Steffen Prohaska	
exec_cmd.h
      5 Junio C Hamano	
      2 Steve Haslam	
help.c
     79 Linus Torvalds	
     73 Johannes Schindelin	
help.h
     25 Miklos Vajna	
      3 Alex Riesen	
levenshtein.c
     82 Johannes Schindelin	
      1 Samuel Tardieu	
levenshtein.h
      8 Johannes Schindelin	
pager.c
     34  Jeff King	
     25 Johannes Sixt	
parse-options.c
    386 Pierre Habouzit	
     81 René Scharfe	
parse-options.h
    151 Pierre Habouzit	
     14 René Scharfe	
path.c
    201 Junio C Hamano	
     83 Linus Torvalds	
quote.c
    189 Pierre Habouzit	
    106 Junio C Hamano	
quote.h
     31 Junio C Hamano	
     11 Christian Couder	
run-command.c
    173 Johannes Sixt	
     87 Shawn O. Pearce	
run-command.h
     46 Johannes Sixt	
     20 Shawn O. Pearce	
sigchain.c
     52  Jeff King	
sigchain.h
     11  Jeff King	
strbuf.c
    178 Johannes Schindelin	
    146 Pierre Habouzit	
strbuf.h
     93 Pierre Habouzit	
     16 Junio C Hamano	
string.c
string.h
symbol.c
symbol.h
usage.c
     31 Linus Torvalds	
     28 Petr Baudis	
util.h
wrapper.c
    220 Linus Torvalds	
     69 Junio C Hamano	

Obviously I don't like these results as much, as I do not show up as often 
anymore.

Besides, I think it is not fair to put me on top of the list of authors of 
strbuf.c.

Ciao,
Dscho

--8323329-1374987934-1245861618=:7946--
