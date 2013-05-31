From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: Poor performance of git describe in big repos
Date: Fri, 31 May 2013 10:24:44 +0200
Message-ID: <87obbr5zg3.fsf@linux-k42r.v.cablecom.net>
References: <CAJ-05NPQLVFhtb9KMLNLc5MqguBYM1=gKEVrrtT3kSMiZKma_g@mail.gmail.com>
	<CALkWK0ndKMZRuWgdg6djqPUGxbDAqZPcv2q0qPrv_2b=1NEM5g@mail.gmail.com>
	<CAJ-05NNAeLUfyk8+NU8PmjKqfTcZ1NT_NPAk3M1QROtzsQKJ8g@mail.gmail.com>
	<87ehcoeb3t.fsf@linux-k42r.v.cablecom.net>
	<CAJ-05NOjVhb+3Cab7uQE8K3VE0Q2GhqR3FE=WzJZvSn8Djt6tw@mail.gmail.com>
	<87ip20bfq4.fsf@linux-k42r.v.cablecom.net>
	<20130530193046.GG17475@serenity.lan>
	<CAJ-05NOEuxOVy7LFp_XRa_08G-Mj0x7q+RiR=u71-iyfOXpHow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Keeping <john@keeping.me.uk>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <kernel-hacker@bennee.com>
X-From: git-owner@vger.kernel.org Fri May 31 10:24:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiKdq-0007xo-8q
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 10:24:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753860Ab3EaIYu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 May 2013 04:24:50 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:22335 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751997Ab3EaIYq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 May 2013 04:24:46 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 31 May
 2013 10:24:42 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS20.d.ethz.ch (172.31.51.110) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Fri, 31 May 2013 10:24:44 +0200
In-Reply-To: <CAJ-05NOEuxOVy7LFp_XRa_08G-Mj0x7q+RiR=u71-iyfOXpHow@mail.gmail.com>
	("Alex \=\?utf-8\?Q\?Benn\=C3\=A9e\=22's\?\= message of "Fri, 31 May 2013 09:14:49
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226078>

Alex Benn=C3=A9e <kernel-hacker@bennee.com> writes:

> On 30 May 2013 20:30, John Keeping <john@keeping.me.uk> wrote:
>> On Thu, May 30, 2013 at 06:21:55PM +0200, Thomas Rast wrote:
>>> Alex Benn=C3=A9e <kernel-hacker@bennee.com> writes:
>>>
>>> > On 30 May 2013 16:33, Thomas Rast <trast@inf.ethz.ch> wrote:
>>> >> Alex Benn=C3=A9e <kernel-hacker@bennee.com> writes:
>> <snip>
>>> > Will it be loading the blob for every commit it traverses or just=
 ones that hit
>>> > a tag? Why does it need to load the blob at all? Surely the commi=
t
>>> > tree state doesn't
>>> > need to be walked down?
>>>
>>> No, my theory is that you tagged *the blobs*.  Git supports this.
>
> Wait is this the difference between annotated and non-annotated tags?
> I thought a non-annotated just acted like references to a particular
> tree state?

A tag is just a ref.  It can point at anything, in particular also a
blob (=3D some file *contents*).

An annotated tag is just a tag pointing at a "tag object".  A tag objec=
t
contains tagger name/email/date, a reference to an object, and a tag
message.

The slowness I found relates to having tags that point at blobs directl=
y
(unannotated).

>> You can see if that is the case by doing something like this:
>>
>>     eval $(git for-each-ref --shell --format '
>>         test $(git cat-file -t %(objectname)^{}) =3D commit ||
>>         echo %(refname);')
>>
>> That will print out the name of any ref that doesn't point at a
>> commit.
>
> Hmm that didn't seem to work. But looking at the output by hand I
> certainly have a mix of tags that are commits vs tags:
>
>
> 09:08 ajb@sloy/x86_64 [work.git] >git for-each-ref | grep "refs/tags"
> | grep "commit" | wc -l
> 1345
> 09:12 ajb@sloy/x86_64 [work.git] >git for-each-ref | grep "refs/tags"
> | grep -v "commit" | wc -l
> 66
>
> Unfortunately I can't just delete those tags as they do refer to know=
n
> releases which we obviously care about. If I delete the tags on my
> local repo and test for a speed increase can I re-create them as
> annotated tag objects?

I would be more interested in this:

  git for-each-ref | grep ' blob'

and

  (git for-each-ref | grep ' blob' | cut -d\  -f1 | xargs -n1 git cat-f=
ile blob) | wc -c

The first tells you if you have any refs pointing at blobs.  The second
computes their total unpacked size.  My theory is that the second yield=
s
some large number (hundreds of megabytes at least).

It would be nice if you checked, because if there turn out to be big
blobs, we have all the pieces and just need to assemble the best
solution.  Otherwise, there's something else going on and the problem
remains open.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
