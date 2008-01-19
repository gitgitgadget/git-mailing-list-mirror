From: =?UTF-8?B?R3LDqWdvaXJlIEJhcmJpZXI=?= <gb@gbarbier.org>
Subject: Re: [PATCH] http-push: making HTTP push more robust and more user-friendly
Date: Sat, 19 Jan 2008 16:21:38 +0100
Message-ID: <47921582.4040708@gbarbier.org>
References: <1200250979-19604-1-git-send-email-gb@gbarbier.org> <7vbq7ppbyh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Mike Hommey <mh@glandium.org>
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 19 16:22:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGFWe-0007AY-DQ
	for gcvg-git-2@gmane.org; Sat, 19 Jan 2008 16:22:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757675AbYASPVl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Jan 2008 10:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758922AbYASPVl
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 10:21:41 -0500
Received: from relay1-v.mail.gandi.net ([217.70.178.75]:48307 "EHLO
	relay1-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757636AbYASPVj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 10:21:39 -0500
Received: from localhost (mfilter5-v.gandi.net [217.70.178.39])
	by relay1-v.mail.gandi.net (Postfix) with ESMTP id 49CFA362AA;
	Sat, 19 Jan 2008 16:21:38 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter5-v.mgt.gandi.net
Received: from relay1-v.mail.gandi.net ([217.70.178.75])
	by localhost (mfilter5-v.gandi.net [217.70.178.39]) (amavisd-new, port 10024)
	with ESMTP id LZZIff2ytp5X; Sat, 19 Jan 2008 16:13:41 +0100 (CET)
Received: from [192.168.79.1] (soy95-1-82-229-96-169.fbx.proxad.net [82.229.96.169])
	by relay1-v.mail.gandi.net (Postfix) with ESMTP id 43D3B362AF;
	Sat, 19 Jan 2008 16:21:35 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <7vbq7ppbyh.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71110>

Hi Junio, Hi Johannes,

I recently sent three patches about http-push:
>  $gmane/70406 <1200250979-19604-1-git-send-email-gb@gbarbier.org>
>  $gmane/70407 <1200250979-19604-2-git-send-email-gb@gbarbier.org>
>  $gmane/70405 <1200250979-19604-3-git-send-email-gb@gbarbier.org>

I saw that Junio has already applied one of them (the one that disable=20
http-push without USE_CURL_MULTI).

I wont talk about the second one "fix webdav lock leak" in the present=20
mail but in another one, since Johannes has found severe bugs in it. I=20
prefer to make them separate subjects.

As for the third patch ("making HTTP push more robust and more=20
user-friendly"), I recall the commit message here:

>  Gr=C3=A9goire Barbier <gb@gbarbier.org> writes:
> > Fail when info/refs exists and is already locked (avoiding strange
> > behaviour and errors, and maybe avoiding some repository
> > corruption).
> >
> > Warn if the URL does not end with '/' (since 302 is not yet
> > handled)
> >
> > More explicit error message when the URL or password is not set
> > correctly (instead of "no DAV locking support").
> >
> > DAV locking time of 1 minute instead of 10 minutes (avoid waiting
> > 10 minutes for a orphan lock to expire before anyone can do a push
> > on the repo).

I agree that it should be improved seriously in several ways. I will=20
submit the patch again with following improvements.

1) I will split the patch into several ones, to enable Junio to apply i=
t=20
partially.

Junio C Hamano a =C3=A9crit :
>  there is no correct timeout that is good for everybody, the last ite=
m
>  might be contentious.

2) I won't change the timeout to avoid possible side effects for other=20
things I don't know about since I'm rather new to git.

Johannes Schindelin a =C3=A9crit :
>  This patch makes http-push Warn if URL does not end if "/", but it
>  would be even better to just handle it... we know exactly that HTTP
>  URLs _must_ end in a slash.

3) Rather than warning if the URL does not end with a slash, I will add=
=20
the slash, so that this will work, even without having to handle=20
HTTP/302 in curl calls. BTW I will do the same for http-fetch either.

Johannes Schindelin a =C3=A9crit :
>  It gives a better warning if the URL cannot be accessed, alright. Bu=
t
>  I hate the fact that it introduces yet another function which does a
>  bunch of curl_easy_setopt()s only to start an active slot and check
>  for errors.
>
>  Currently, I am not familiar enough with http-push.c to suggest a
>  proper alternative, but I suspect that the return values of the
>  _existing_ calls to curl should know precisely why the requests
>  failed, and _this_ should be reported.

Mike Hommey a =C3=A9crit :
 > FWIW, I have a work in progress refactoring the http code, avoiding =
a
 > great amount of curl_easy_setopt()s and simplifying the whole thing.
 > It's been sitting on my hard drive during my (quite long) vacation. =
I
 > will probably start working again on this soonish.

4) I agree with Johannes. However I am not familiar enough with curl to=
=20
write the proper alternative. I create the new function by copy/paste o=
f=20
an existing one. I'm not 100% sure that it  has no resource leaks or=20
other bugs, but it's called only once at http-push start, and thus is=20
likely not to do heavy damage...

As a rationale: I've tried to make several developers use git over http=
,=20
including push, and they made all the same beginner mistakes on the=20
command line, all leading to that stupid error message about locking no=
t=20
available, and I think that making a clearer error message is an=20
important improvement to make not-so-skilled developers using git when=20
neither ssh nor git protocols are available.

Therefore I think that applying my patch, even if it's far from being=20
perfect, is the lesser of two evils.

Then, for instance during 1.5.5 development cycle, I would be happy to=20
help Mike if I can, to clean my new code that he is likelly not to have=
=20
cleaned up on his hard disk during his vacation...
=46or instance I may look at his patches and take them in example to cl=
ean=20
up my code.


Apart from the discussion on the source code, I would like to reply to=20
Junio about the patch disabling http-push without USE_CURL_MULTI:
Junio C Hamano a =C3=A9crit :
>  Also http-push being unusable without CURL_MULTI was also a news to
>  me.  Is this something that came up on #git perhaps?
>
>  This change means people need curl 7.10 or newer (post May 2003, tha=
t
>  is).  I do not think it is too new a version to require, but then it
>  makes me wonder if it makes much sense for us to keep supporting non
>  CURL_MULTI build these days.  Perhaps we should schedule such a move
>  to drop non MULTI build in the future?

I don't know if USE_CURL_MULTI works well for other git binaries than=20
http-push (although I've used it successfully two or three times with=20
clone and fetch).

If yes, I think that the release notes, or whatever information channel=
=20
you can have with the various distribution maintainers, should advice t=
o=20
compile with USE_CURL_MULTI. Or we can make it the default compilation=20
option in a future release (> 1.5.4 I think).

If USE_CURL_MULTI is not safe for other binaries than http-push, I thin=
k=20
I should manage to make a new patch, let's say for git-1.5.5, that woul=
d=20
change the makefile to use CURL_MULTI by default on http-push (for=20
example without -DNEVER_USE_CURL_MULTI) and leave alone other binaries=20
as they are (CURL_MULTI disabled without -DUSE_CURL_MULTI).

I want to insist that the present patch for 1.5.4 (which you've already=
=20
applied to git.git), does not introduce by itself a dependence or a=20
regression, it only disables unwarned users to call a function that doe=
s=20
not work, but pretends to work and by the way corrupts the remote=20
repository.

I thank you very much for the time you spent reviewing my patches and=20
more generally for the work you do. I'll try to improve the way I submi=
t=20
patches to make them take you less time to review.

--=20
Gr=C3=A9goire Barbier - gb =C3=A0 gbarbier.org - +33 6 21 35 73 49
