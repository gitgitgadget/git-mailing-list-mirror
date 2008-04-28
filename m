From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] Use perl instead of tac
Date: Mon, 28 Apr 2008 15:13:19 -0400
Message-ID: <04EB077D-CB35-4253-A9EA-2085890C3639@silverinsanity.com>
References: <8D73338C-4EC3-4078-8A34-51DAC1842C2B@silverinsanity.com> <20080427064250.GA5455@sigill.intra.peff.net> <739FA851-F7F5-4CF9-B384-25AA7022B0C2@silverinsanity.com> <slrng1be8l.25r.joerg@alea.gnuu.de> <86k5iib0g9.fsf@blue.stonehenge.com> <slrng1bqhb.25r.joerg@alea.gnuu.de>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=WINDOWS-1252;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?J=F6rg_Sommer?= <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Mon Apr 28 21:14:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqYnl-00053s-0A
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 21:14:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934119AbYD1TNY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2008 15:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934072AbYD1TNX
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 15:13:23 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:42896 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933493AbYD1TNX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Apr 2008 15:13:23 -0400
Received: from [192.168.1.7] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 589B01FFD6C5;
	Mon, 28 Apr 2008 19:13:15 +0000 (UTC)
In-Reply-To: <slrng1bqhb.25r.joerg@alea.gnuu.de>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80590>


On Apr 28, 2008, at 11:15 AM, J=F6rg Sommer wrote:

> Nothing. My intention was not the speed, but the dependency on Perl. =
=20
> But
> your are right. Except from the point that my suggestion is broken, =20
> it's
> *much* slower:

[snip]

> And what about something like this: 'tac || rev || perl =85'

This would actually be spelled something like:

----- 8< -----
tac=3D""

tac < /dev/null > /dev/null 2>&1
if test $? !=3D 127; then
    tac=3Dtac
fi

if test -z "$tac"; then
    perl < /dev/null > /dev/null 2>&1
    if test $? !=3D 127; then
       tac=3D"perl -e 'print reverse <>'"
    fi
fi

if test -z "$tac"; then
    die "Couldn't find tac or perl."
fi

(subshell) | $tac | while loop
----- 8< -----

Ugly, no?  Plus it adds a dependency on tac OR doesn't solve the perl =20
dependency.  I personally think using perl is better than this =20
approach.  Even if we're trying to reduce the perl dependency in core, =
=20
it's there right now so this has zero impact now.  The ideal solution =20
is to re-write the loop so that it doesn't need to be reversed in the =20
first place.  We can use perl until that rewrite is done.

This loop-reverse-loop construct is _extremely_ ugly, and I'm having =20
problems following it.  None of what this function is doing is =20
immediately obvious.  It's a good candidate for a comment or two.

Looking over it, we should be able to do this with one loop over the =20
list of commits, doing this for each of them:

if more than one parent
   other_parents=3Dall but first, comma separated
   print merge command (without marks)
else
   print pick command
fi

if commit is tagged
   print tag command
fi

I also dislike the large lists this is carrying around in shell =20
variables.  If I'm reading it correctly, the tag list could be =20
replaced by invocations of "git describe --exact-match".  The mark =20
list appears to be unavoidable, but significantly smaller than the tag =
=20
list.

Now that I think about it, the generation of marks could be done by a =20
second loop over the list.  Notice what commits need to be marked in =20
loop 1, then add the mark commands in loop 2.  Both of these loops =20
would function in the same direction, removing the need for either tac =
=20
or perl.

~~ Brian