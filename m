From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: The behaviour of git bisect skip
Date: Wed, 15 Oct 2008 08:54:49 +0200
Message-ID: <200810150854.49830.chriscool@tuxfamily.org>
References: <48F3DCEB.1060803@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 08:53:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kq0Fq-0002s2-4k
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 08:53:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751534AbYJOGv4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Oct 2008 02:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbYJOGv4
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 02:51:56 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:49319 "EHLO smtp6-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751479AbYJOGvz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Oct 2008 02:51:55 -0400
Received: from smtp6-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 1B999196F2;
	Wed, 15 Oct 2008 08:51:53 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 306B71975E;
	Wed, 15 Oct 2008 08:51:52 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <48F3DCEB.1060803@zytor.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98239>

Le mardi 14 octobre 2008, H. Peter Anvin a =C3=A9crit :
> I recently had the unhappy experience of trying to bisect a tree with=
 a
> large region of the history obscured by auxilliary bugs.  "git bisect
> skip" will stay in the central region, thus being largely useless.

Yeah, it tries to find the first non skipped commit among the best poss=
ible=20
bisection points. And if you have a linear history the best bisection=20
points are in the middle of the good and bad commits.

> I was thinking about how to possibly do it better.  This is something=
 I
> came up with, and thought it might be interesing.
>
> a. we obviously cannot move the start and end (good and bad) markers,
> since they have not been shown one way or the other.
>
> b. however, the practice of testing the centermost point is merely th=
e
> *optimal*, corresponding to 1 bit of information per iteration.  An
> off-center test is also possible (as long as the value depends on bot=
h
> endpoints, and isn't fixed from one of the endpoints; in that case we
> have a linear search), corresponding to a smaller amount of informati=
on
> - for example, sampling at the one-quarter point corresponds to
> 3/4*log2(3/4) + 1/4*log2(1/4) =3D~ 0.811 bits of information.
>
> I would suggest something based on the following algorithm:
>
> Given an interval with a certain number of skip points, subdivide the
> interval into subintervals each separated by a skip point.  Pick the
> centermost point of the *largest* of these intervals.  If there is mo=
re
> than one largest interval, choose the one centermost point that ends =
up
> being centermost in the overall interval.
>
> This algorithm obviously needs some adjustment (as does plain binary
> search) in order to deal with a branched history, but I thought it mi=
ght
> be an interesting starting point.  It has the desirable property that=
 it
> can make forward progress even in the presence of skip points, and th=
at
> it avoids needlessly searching close to skip points.

It looks like a great alternative algorithm but as the current bisect s=
kip=20
is implemented in shell, I think that it might be too difficult or=20
inefficient to implement something like that in shell.

I think it might be better to try a more simple alternative algorithm f=
irst=20
like removing all skipped commits from the sorted list of possible=20
bisection point (the list is sorted because best commits from a bisecti=
on=20
point are first) and trying the commit at one third (or another fixed=20
ration) of the best commit.

Regards,
Christian.
=20

> 	-hpa
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
