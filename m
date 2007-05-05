From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Documentation: "bisect run" can be given bangs before the run script.
Date: Sat, 5 May 2007 14:57:03 +0200
Message-ID: <200705051457.03277.chriscool@tuxfamily.org>
References: <20070503070607.fa2ffe92.chriscool@tuxfamily.org> <7vmz0m3261.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Uwe =?iso-8859-1?q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 05 18:56:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkNYB-0007x9-9T
	for gcvg-git@gmane.org; Sat, 05 May 2007 18:56:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933971AbXEEQ4A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 5 May 2007 12:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934011AbXEEQ4A
	(ORCPT <rfc822;git-outgoing>); Sat, 5 May 2007 12:56:00 -0400
Received: from postfix2-g20.free.fr ([212.27.60.43]:45651 "EHLO
	postfix2-g20.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933971AbXEEQz7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 May 2007 12:55:59 -0400
Received: from smtp1-g19.free.fr (smtp1-g19.free.fr [212.27.42.27])
	by postfix2-g20.free.fr (Postfix) with ESMTP id C1733FA8977
	for <git@vger.kernel.org>; Sat,  5 May 2007 13:50:32 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 0BE02B93F3;
	Sat,  5 May 2007 14:49:06 +0200 (CEST)
User-Agent: KMail/1.9.5
In-Reply-To: <7vmz0m3261.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46265>

Hi Junio and Uwe,

Le jeudi 3 mai 2007 07:29, Junio C Hamano a =E9crit :
> I am not convinced that '!' is a good extension for two and half
> reasons.
>
>  * The expected use is not quite clear.  If it is not used to
>    run a custom test script but something stock as "make", by
>    the nature of UNIX exit status convention, you are looking
>    for the commit that _fixed_ some breakage (i.e. "which commit
>    fixed the compilation error?").  While sometimes that is a
>    useful thing to do, it feels somewhat of limited value.

Well, of course the main expected use is for something like "make" or "=
grep"=20
or "./test_something.sh" where "test_something.sh" is an already existi=
ng=20
script.

Especially because "git bisect run ! grep foo bar.txt" seems to me like=
 a=20
nice way to find the commit that introduced "foo" in "bar.txt" and I ha=
ve=20
been frustrated that it does not work. (Perhaps "git blame" can do it t=
oo,=20
but I think "git bisect run" should be faster and more specific.)

>    On the other hand, if you are running a custom test script, I
>    do not think it is unreasonable to always require that a test
>    script to signal "bad" with small non-zero, "good" with zero,
>    and error with high non-zero status, as we already do.

I agree this is probably the most usefull use of "git bisect run". But=20
sometimes, perhaps for a one shot use, you already have something that=20
could work if only you could revert the exist status. I think it is a g=
ood=20
idea to give user some rope for this case.

>  * How should this interact with the "high non-zero status means
>    an error and we cannot bisect" return convention?

If you use a bare "! grep foobar /*/*" on the command line for example =
and=20
you kill it before it's finished, you will still get a 0 exit code. Thi=
s=20
means that, with the bash "!" keyword, any error gives a "good" result.=
 I=20
think it's better to keep this behavior.

If we still wants something that keeps the "high non-zero status means =
an=20
error and we cannot bisect" return convention, then let's call it a "--=
not"=20
option or something like that. I will implement that if you prefer. I c=
an=20
even implement both "!" and "--not" if you want.

By the way I think that sometimes it could happens that any exit code o=
ther=20
than 0 means a "bad" revision and not "we cannot bisect". In this case=20
using "git bisect run ! ! my_script" can be usefull.=20

>  * I was hoping that we can officially support "don't know,
>    cannot test this one, please give me another" for interactive
>    use, and at the same time allow the run-script used by
>    "git bisect run" to signal such with a special exit value
>    (perhaps "exit 42").  Taken together with the previous point,
>    it is not clear how '!' should interact with such an
>    enhancement.

My bang patch does not in any way prevents from adding such a "don't kn=
ow,=20
cannot test this one, please give me another" improvement. It's just=20
another option to make "git bisect run" more convenient in some cases.

Christian (a give them rope proponent).
