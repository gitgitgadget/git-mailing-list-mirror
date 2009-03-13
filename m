From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/7] strbuf: add "include_delim" parameter to "strbuf_split"
Date: Fri, 13 Mar 2009 07:02:00 +0100
Message-ID: <200903130702.01039.chriscool@tuxfamily.org>
References: <20090312085103.e83b34a5.chriscool@tuxfamily.org> <200903130548.30370.chriscool@tuxfamily.org> <7v1vt2j91x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org,
	Ingo Molnar <mingo@elte.hu>, John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 07:10:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Li0XE-0006ID-0T
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 07:06:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbZCMGC7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Mar 2009 02:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbZCMGC7
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 02:02:59 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:44088 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750923AbZCMGC6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Mar 2009 02:02:58 -0400
Received: from smtp4-g21.free.fr (localhost [127.0.0.1])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 7E1F34C80DB;
	Fri, 13 Mar 2009 07:02:47 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 8C7144C8076;
	Fri, 13 Mar 2009 07:02:45 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <7v1vt2j91x.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113146>

Le vendredi 13 mars 2009, Junio C Hamano a =E9crit :
> Christian Couder <chriscool@tuxfamily.org> writes:
> > Yes, my patch does not do that, because I think including the delim=
iter
> > is a special case of the more general and useful behavior of not
> > including it.
>
> You got it backwards.
>
> With the way the returned string is used by the single caller that yo=
ur
> patch adds (which splits at ","), I would agree that lack of delimite=
r
> allows the result to get used directly in the further processing.
>
> But even in that codepath, I have to say that it is just lazy program=
ming
> that the caller does not postprocess the returned value from the spli=
tter
> function.  If it wants not just accept input such as "a,b,c" but also
> wants to tolerate things like "a, b, c", it will have to look at the
> resulting string, and ignoring the delimiter at the end becomes just =
a
> small part of the general clean-up process [*1*].

I think talking about "lazy programming" in this case is a bit strong,=20
because first "git rev-list --bisect-skip" is plumbing and will be used=
=20
mostly by porcelain and second because there are much more common shell=
=20
utilities that don't tolerate things like "a, b, c". Try using "cut"=20
with -f'1, 2' (instead of -f1,2) for example.

> Once you start allowing "split at one of these characters" and/or "sp=
lit
> at delimiter that matches this pattern", you cannot just discard the
> delimiter if you want to support non-simplistic callers, because they
> would want to know what the delimiter was.

But I let non simplistic callers use "1" as the last parameter if they =
want=20
the delimiter. I just give one more way to use strbuf_split. I don't re=
move=20
anything.

> Stripping out the delimiter is the special case for simplistic caller=
s
> (think "gets()" that strips, and "fgets()" that doesn't). =20

Aren't gets and fgets an example that having the choice to strip out th=
e=20
delimiter or not is good?

> A more general=20
> solution should be by default not to strip it, and I do not think you=
r
> new caller, if it were written correctly, needs stripping behaviour
> either. That means there is no need for the "optionally strip" flag t=
o
> the function in order to support the rest of the series [*2*].

I think my patch 8/7, that I just sent, is a good solution and it still=
 uses=20
the new behavior of strbuf_split introduced in 1/7.

> Also comparing this with Perl/Python split() forgets that you are wor=
king
> in C, where truncating an existing string is quite cheap (just assign
> '\0'). There is a different trade-off to be made in these language
> environments.

Sorry but I think the goal of the strbuf API is to be quite high level,=
 so I=20
think comparing this with Perl/Python is ok.

Best regards,
Christian.
