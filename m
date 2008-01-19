From: =?ISO-8859-15?Q?Gr=E9goire_Barbier?= <gb@gbarbier.org>
Subject: Re: [PATCH] http-push: fix webdav lock leak.
Date: Sat, 19 Jan 2008 16:21:57 +0100
Message-ID: <47921595.1080100@gbarbier.org>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com> <1200022189-2400-2-git-send-email-mlevedahl@gmail.com> <7v1w8o4ws0.fsf@gitster.siamese.dyndns.org> <30e4a070801111252s4e17b9c4m62adeb9032963e66@mail.gmail.com> <7v63xzzszp.fsf@gitster.siamese.dyndns.org> <478855B5.9070600@gmail.com> <7vbq7ry405.fsf@gitster.siamese.dyndns.org> <47885B2C.8020809@gmail.com> <7v7iify2wm.fsf@gitster.siamese.dyndns.org> <4788BFA8.2030508@gmail.com> <7vwsqeubj8.fsf@gitster.siamese.dyndns.org> <47891658.3090604@gmail.com> <7vbq7qssd7.fsf@gitster.siamese.dyndns.org> <47893E1A.5020702@gmail.com> <7v4pdislrf.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de> <7vir1xmazm.fsf@gitster.siamese.dyndns.org> <7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org> 
 <alpine.LSU.1.00.0801181638500.5731@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 19 16:22:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGFWs-0007FP-7m
	for gcvg-git-2@gmane.org; Sat, 19 Jan 2008 16:22:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759814AbYASPWE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Jan 2008 10:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759338AbYASPWD
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 10:22:03 -0500
Received: from relay1-v.mail.gandi.net ([217.70.178.75]:51717 "EHLO
	relay1-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759264AbYASPWA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 10:22:00 -0500
Received: from localhost (mfilter3-v.gandi.net [217.70.178.37])
	by relay1-v.mail.gandi.net (Postfix) with ESMTP id C3610362B8;
	Sat, 19 Jan 2008 16:21:59 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter3-v.mgt.gandi.net
Received: from relay1-v.mail.gandi.net ([217.70.178.75])
	by localhost (mfilter3-v.mgt.gandi.net [217.70.178.37]) (amavisd-new, port 10024)
	with ESMTP id DIu4sY+GdCXq; Sat, 19 Jan 2008 15:45:47 +0100 (CET)
Received: from [192.168.79.1] (soy95-1-82-229-96-169.fbx.proxad.net [82.229.96.169])
	by relay1-v.mail.gandi.net (Postfix) with ESMTP id 3AF77362AF;
	Sat, 19 Jan 2008 16:21:54 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <alpine.LSU.1.00.0801181638500.5731@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71111>

Johannes Schindelin a =E9crit :
> > $gmane/70407 <1200250979-19604-2-git-send-email-gb@gbarbier.org>
>
>  I first could not reproduce the breakage described in the commit
>  message (bad or no ref given on command line).

It's rather easy anyway:

=46irst, you need a test git repository availlable over http+webdav, le=
t's=20
say at http://myhost/myrepo.git/
Then, you do this:
$ git clone http://myhost/myrepo.git/
$ cd myrepo
$ git push http
=46etching remote heads...
  refs/
  refs/heads/
  refs/tags/
No refs in common and none specified; doing nothing.
$ git push http
=46etching remote heads...
  refs/
  refs/heads/
  refs/tags/
No refs in common and none specified; doing nothing.
$

=46inally, you look at the web server logs, and will find one LOCK quer=
y=20
and no UNLOCK query, of course the second one will be in 423 return cod=
e=20
instead of 200:
1.2.3.4 - gb [19/Jan/2008:14:24:56 +0100] "LOCK /myrepo.git/info/refs=20
HTTP/1.1" 200 465
(...)
1.2.3.4 - gb [19/Jan/2008:14:25:10 +0100] "LOCK /myrepo.git/info/refs=20
HTTP/1.1" 423 363

With my patch, there would have be two UNLOCKs in addition of the LOCKs

 From the user point of view:
- If you realize that you should have typed e.g. "git push http master"=
=20
instead of "git push http", you will have to wait for 10 minutes for th=
e=20
lock to expire by its own.
- Furthermore, if somebody else is dumb enough to type "git push http"=20
while you need to push "master" branch, then you'll need too to wait fo=
r=20
10 minutes too.

>  After playing around for a while, all of a sudden, I got a
>  segmentation fault:
>
>  Waiting for
>=20
http://dscho@127.0.0.1/test.git/objects/56/5e84516c1c6dca168be1715b45ae=
ae70b24d13_36e8d912-4841-455a-bbd9-69e54d00db99
>  Segmentation fault (core dumped)
>
>  Unfortunately, this is with _and_ without this patch.
>
>  In gdb, it looks like this:
(...)
>  The segmentation fault occurs due to check_locks() accessing the
>  remote that was just free()d, due to the new change.
>
>  But now I cannot even reproduce the segmentation fault, it seems.
>  Strange.  Very strange.
>
>  Gr=E9goire, it would help tremendously if you could come up with a t=
est
>  case.  The description you gave did not lead to something
>  reproducible here.

I don't know what's wrong but I can't manage to reproduce the segfault,=
=20
I'm using the master branch on git.git plus my patches, and with CFLAGS=
=20
containing -DUSE_CURL_MULTI, nothing more nothing less.
Is the test case I described above is enough for you to make another te=
st?
What kind of additional information would you need ?

I will resubmit this patch today with a more detailled commit message=20
including the way to reproduce the issue.
BTW you'll be interested to look at one of the "patches" I will repost=20
today, since it's related to this one (the patch subject is "http-push:=
=20
fail when info/refs exists and is already locked").

--=20
Gr=E9goire Barbier - gb =E0 gbarbier.org - +33 6 21 35 73 49
