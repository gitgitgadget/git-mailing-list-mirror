From: "Nicolas Mailhot" <nicolas.mailhot@laposte.net>
Subject: Re: Handle HTTP error 511 Network Authentication Required (standard
 secure proxy authentification/captive portal detection)
Date: Mon, 20 Feb 2012 06:38:54 +0100
Message-ID: <9cd657a3c4960a8c496515a03bbf623e.squirrel@arekh.dyndns.org>
References: <4b8f33ba4c870528a82ab85d6dad68bd.squirrel@arekh.dyndns.org>
    <20120220010617.GB4140@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Nicolas Mailhot" <nicolas.mailhot@laposte.net>,
	git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 20 06:39:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzLyI-0004Yt-KE
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 06:39:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752028Ab2BTFjS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Feb 2012 00:39:18 -0500
Received: from smtpout4.laposte.net ([193.253.67.229]:54366 "EHLO
	smtpout.laposte.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751932Ab2BTFjH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 00:39:07 -0500
Received: from arekh.dyndns.org ([88.174.226.208])
	by mwinf8508-out with ME
	id c5f11i0044WQcrc035f1di; Mon, 20 Feb 2012 06:39:02 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by arekh.dyndns.org (Postfix) with ESMTP id 82D1F6C9;
	Mon, 20 Feb 2012 06:39:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at arekh.dyndns.org
Received: from arekh.dyndns.org ([127.0.0.1])
	by localhost (arekh.okg [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iXUHm1dQyx0W; Mon, 20 Feb 2012 06:38:54 +0100 (CET)
Received: from arekh.dyndns.org (localhost.localdomain [127.0.0.1])
	by arekh.dyndns.org (Postfix) with ESMTP;
	Mon, 20 Feb 2012 06:38:54 +0100 (CET)
Received: from 192.168.0.4
        (SquirrelMail authenticated user nim)
        by arekh.dyndns.org with HTTP;
        Mon, 20 Feb 2012 06:38:54 +0100
In-Reply-To: <20120220010617.GB4140@sigill.intra.peff.net>
User-Agent: SquirrelMail/1.4.22-4.fc17
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191045>


Le Lun 20 f=C3=A9vrier 2012 02:06, Jeff King a =C3=A9crit :
> On Sun, Feb 19, 2012 at 10:03:37PM +0100, Nicolas Mailhot wrote:
>
>> The IETF finally set up to fix this problem and defined a standard H=
TTP
>> error
>> that lets access control equipments tell the web client authenticati=
on or
>> re-authentication is needed and where the authentication form is loc=
ated.
>>
>> http://tools.ietf.org/id/draft-nottingham-http-new-status-04.txt
>>
>> =E2=86=92 <http://www.rfc-editor.org/queue2.html#draft-nottingham-ht=
tp-new-status>
>> (the
>> spec is approved and in the queue for publication as RFC)
>>
>> Please add error 511 handling in git, so git users that try to acces=
s
>> external
>> git repositories over http can authenticate on the corporate proxy
>
> If I'm reading this right, the process works something like this:
>
>   1. Git wants to make a request to http://example.com
>
>   2. We make our request to a proxy server which is transparently
>      proxying our traffic (i.e, a "captive portal").
>
>   3. The proxy returns 511 along with some URL (e.g.,
>      "http://login.corporatenetwork"), indicating that we need
>      to go to that URL to complete some authentication.
>
> As a non-browser client, what should git do? We can't make sense of t=
he
> content at http://login.corporatenetwork, which is most likely an HTM=
L
> form asking for credentials (or even money, if the captive portal is
> something like a public wireless provider). The best we can probably =
do
> is die and say "apparently you need to go http://login.corporatenetwo=
rk
> in a browser before making your request".

Actually, the best would be to launch something capable of interpreting=
 html
forms on the url given by the error. But short of that, that depends on=
 how
good git is at resuming work later. Error 511 can occur at any time, no=
t just
on initial connection (because credentials can expire at any time). So =
pausing
may be better than dying.

However without going there: the portal page will usually be pretty sim=
ple, a
standard basic auth form, can't git handle this? If simple web clients =
such as
git have specific constrains on what can appear or not on this page, ca=
n you
not define them and send them ietf-side so they can document them in a =
later
rfc revision?

> Reading that rfc draft, the man impetus for non-browser clients seems
> not to get them to do anything useful, but rather to return them a co=
de
> that is clearly not from the actual site (if it were a redirect, for
> example, then we would think that example.com is redirecting is, whic=
h
> is simply not true).

The main impetus from my point of view is that captive portal/proxy aut=
h is a
mess, because they try to trick web clients into displaying something t=
hey are
not prepared to and don't want to do, and this spec is replacing trick =
with
explicit request, which is nice.

Best regards,

--=20
Nicolas Mailhot
