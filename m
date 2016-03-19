From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: GSoC Project | Improvise git bisect
Date: Sat, 19 Mar 2016 13:48:33 +0100
Message-ID: <vpqoaaahbvi.fsf@anie.imag.fr>
References: <CAFZEwPN-oUDNnc_PBeP2Q4msJAHenkiLtE+Oo75R+uTTwUKpYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Christian Couder <christian.couder@gmail.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Jeff King <peff@peff.net>, troy.moure@gmail.com,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>, me@ikke.info,
	Philip Oakley <philipoakley@iee.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 13:52:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahGMl-0003zD-3i
	for gcvg-git-2@plane.gmane.org; Sat, 19 Mar 2016 13:52:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbcCSMwH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2016 08:52:07 -0400
Received: from mx1.imag.fr ([129.88.30.5]:40925 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932226AbcCSMwC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2016 08:52:02 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u2JCmWwP023575
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sat, 19 Mar 2016 13:48:32 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u2JCmXQU032478;
	Sat, 19 Mar 2016 13:48:33 +0100
In-Reply-To: <CAFZEwPN-oUDNnc_PBeP2Q4msJAHenkiLtE+Oo75R+uTTwUKpYQ@mail.gmail.com>
	(Pranit Bauva's message of "Sat, 19 Mar 2016 15:03:19 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Sat, 19 Mar 2016 13:48:33 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u2JCmWwP023575
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1458996517.62713@qDSrDliysEVavRQGoOAmDg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289305>

> Subject: Re: GSoC Project | Improvise git bisect
                                   ^^^^

"Improve" I guess.

Pranit Bauva <pranit.bauva@gmail.com> writes:

> Hey everyone!

Hi,

> What I understood is that let's say the repository is like :
>
>          C13
>            |
>          C12
>            |
>          C11 (merge commit)
>        /   |
>      |   C10
>      |     |
>      |   C9
>      |     |
>      |   C6 (merge commit)
>    C8    |   \
>      |   C3    |
>    C7    |     |
>        \   |     C5
>          C2    |
>            |     C4
>            |    /
>           C1
>  (master branch)

When drawing ascii-art diagrams like this, try to use a fixed-width
font. It looks ugly in my mailer.

> The commits numbers ie. C1...C13 are according to the time stamp, C1
> being the first.

One information is missing: which is the first parent.

> On starting to debug with git bisect, given that C12 is bad and C1 is
> good, it starts a binary search from C1...C13. ie. It first goes to
> C7,

I don't think so. It tries to find a commit which cuts the graph into 2
sub-graphs with roughly the same number of commits. If you pick C7, then
C7 is bad, the regression may be anywhere except C1, C2, C7. This does
not reduce the scope much.

I guess you picked C7 because of the timestamps. "bisect" picks the
commit according to the graph topology.

> if its all good, it goes to C10 and so on an so forth. If C7 is not
> good, it goes to C4 and so on and so forth. This just makes the job of
> debugging a bit difficult for a repo which has only 1 mainstream
> repository and it just has some short-term branches to instantly get
> stuff done.

Why?

> It can be simplified by using --first-parent. Given C1 is good and C12
> is bad, it will find the mean between {C1, C2, C3, C6, C9, C10, C11,
> C12, C13} which is C9, see if its good.

Do you mean that C10 is the first parent of C11, and C3 the first parent
of C6? That's an un-usual graphical convention: usually we represent
first parent as leftmost parent.

> If not then it will go to C3
> and then C2, if good then it will go to C6, if not good then it will
> go to C5 and then C4. This will greatly simplify the job of debugging.

Again, why?

The missing part in your explanation is probably:

Some projects do not enforce the policy "each commit must be compilable
and correct", but instead consider that only commits on the mainline
should have this property. This typically allows history like

 A Merge feature A
 |\
 | B fix bug in feature A
 | |
 | C fix compilation error in previous commit
 | |
 | D implement feature A
 |/
 E Merge feature B
 ...

When bisecting through such history, testing commits B and C is
meaningless, but it still makes sense to bisect through the mainling
commits A and E. In this case, we can consider that if E is good and A
is bad, then the regression was introduced in A.

Once we know that, we can actually continue the bisection: "OK, the
regression was introduced in mainline at merge commit A, let's see if
the branch being merged is bisectable", which could be recursive if the
topic branch contains merge commits.

>  - Rewrite git-bisect.sh as bisect.c and bisect.h
>
>  For this I plan to go along the guidelines of Paul Tan's previous
> year work. I have followed his work and his way seems nice to go about
> with rewriting.

Please elaborate. Your proposal needs to be convincing enough that
mentors accept to commit to mentoring the project. "I'll do like Paul
Tan" is by far not sufficient.

I'm actually not sure the same plan applies here: there's already a C
helper for bisect, so an incremental rewrite may be more appropriate:
port functions one by one from shell to C untill the shell part is
empty.

I don't know the bisect code well enough to know which approach would
work best.

Cheers,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
