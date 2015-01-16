From: "Jason Pyeron" <jpyeron@pdinc.us>
Subject: RE: RFC: update hook for GPG signed submission on secured branches
Date: Fri, 16 Jan 2015 14:47:25 -0500
Organization: PD Inc
Message-ID: <BD3DE7B299FE458287DC8C829CEADEC2@black>
References: <BBE88A3EA44D47159C483F1046AC747E@black> <xmqqsifa1px6.fsf@gitster.dls.corp.google.com>
Reply-To: "Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
To: "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 16 20:47:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YCCrm-0006pu-9x
	for gcvg-git-2@plane.gmane.org; Fri, 16 Jan 2015 20:47:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754953AbbAPTr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2015 14:47:29 -0500
Received: from mail.pdinc.us ([67.90.184.27]:56435 "EHLO mail.pdinc.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753782AbbAPTr3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jan 2015 14:47:29 -0500
Received: from black (nsa1.pdinc.us [67.90.184.2])
	(authenticated bits=0)
	by mail.pdinc.us (8.12.11.20060308/8.12.11) with ESMTP id t0GJlPqL021846;
	Fri, 16 Jan 2015 14:47:25 -0500
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <xmqqsifa1px6.fsf@gitster.dls.corp.google.com>
Thread-Index: AdAxw1ngMvVr2EDVTwmEFmQi1PSlKgAAPCtg
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262567>

> -----Original Message-----
> From: Junio C Hamano
> Sent: Friday, January 16, 2015 14:33
> 
> "Jason Pyeron" <jpyeron@pdinc.us> writes:
> 
> > What would you change? Any bugs that you see?
> 
> > sigkey=$(\
> >  git cat-file $newrev -p |\
> 
> "-p" being a command line option should come before revision, but
> more importantly, because you accept pushes only to refs/heads/, you
> would want to explicitly require commit objects, no?  i.e.
> 
> 	git cat-file commit "$newrev" |

True.

> 
> I am not sure if you need these unsightly backslashes.  When you
> stop talking to it after saying "$(", or "$( git cat-file ... |",
> the shell _knows_ that you haven't stopped what you want to tell
> it.
> 
> >  sed -e '/^ /{H;$!d;}; x;/^gpgsig /!d; s/^gpgsig//;' |\
> >  cut -c 2- |\
> 
> It always makes me feel nervous to see people pipe sed output to
> another filter that is a mere s/.//;

It was a very quick Lego block build.

> 
> Is this complex pipeline the same as this (I didn't understand the
> trailing I at the end)?

Case insensitive, could have used [0-9a-fA-F].

> 
> 	git cat-file commit "$newrev" |
>         sed -ne '/^gpgsig /,/^ -----END/{
>         	s/^gpgsig //
>                 s/^ //p
> 	}' |

Will all future signature values end with a "^ -----END"? I was only going on the assumption that continuation lines start with a single space.

> 	gpg --list-packets --textmode |
>         sed -ne '/^:signature packet:/s/.*keyid \([0-9A-F]*\).*/\1/p'
> 
> >  gpg --list-packets --textmode |\
> >  sed '/keyid/!d; s/.*keyid \([0-9A-F]\{16\}\).*/\1/I' \
> > )
> 
> > if [ -z "$sigkey" ]; then
> >         echo no GPG signature on commit $newrev
> >         exit 1
> > fi
> 
> I am not sure if the design of this, to require signature only on
> the tip commit, is sound.  That is not a -bug- in the script,
> though.

It is to handle the "all my devs worked on this, they do ________ GPG", so as long as the tip os signed, it is an implicit I am responsible for what is submitted.

> 
> > if [[ $refname != refs/heads/* ]]; then
> >         echo only heads may be pushed, illegal ref: $refname
> >         exit 1;
> > fi
> >
> > head="${refname:11}"
> 
> It is hard to tell where the magic number 11 comes from.  Perhaps
> 
>     head="${refname#refs/heads/}"
> 
> reads easier?

Much.

Thanks!

-Jason

--
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
This message is copyright PD Inc, subject to license 20080407P00. 
