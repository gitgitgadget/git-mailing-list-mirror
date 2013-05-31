From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: Poor performance of git describe in big repos
Date: Fri, 31 May 2013 10:46:24 +0200
Message-ID: <87y5av4jvj.fsf@linux-k42r.v.cablecom.net>
References: <CAJ-05NPQLVFhtb9KMLNLc5MqguBYM1=gKEVrrtT3kSMiZKma_g@mail.gmail.com>
	<CALkWK0ndKMZRuWgdg6djqPUGxbDAqZPcv2q0qPrv_2b=1NEM5g@mail.gmail.com>
	<CAJ-05NNAeLUfyk8+NU8PmjKqfTcZ1NT_NPAk3M1QROtzsQKJ8g@mail.gmail.com>
	<87ehcoeb3t.fsf@linux-k42r.v.cablecom.net>
	<CAJ-05NOjVhb+3Cab7uQE8K3VE0Q2GhqR3FE=WzJZvSn8Djt6tw@mail.gmail.com>
	<87ip20bfq4.fsf@linux-k42r.v.cablecom.net>
	<20130530193046.GG17475@serenity.lan>
	<CAJ-05NOEuxOVy7LFp_XRa_08G-Mj0x7q+RiR=u71-iyfOXpHow@mail.gmail.com>
	<87obbr5zg3.fsf@linux-k42r.v.cablecom.net>
	<CAJ-05NOdg5TvjzEMrXaPgogU5z5W6kywZhD-82eTUmvE9Hp=Lw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Keeping <john@keeping.me.uk>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <kernel-hacker@bennee.com>
X-From: git-owner@vger.kernel.org Fri May 31 10:46:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiKyz-0002nx-PW
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 10:46:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753379Ab3EaIqj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 May 2013 04:46:39 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:27871 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751489Ab3EaIq1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 May 2013 04:46:27 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 31 May
 2013 10:46:22 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS21.d.ethz.ch (172.31.51.111) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Fri, 31 May 2013 10:46:24 +0200
In-Reply-To: <CAJ-05NOdg5TvjzEMrXaPgogU5z5W6kywZhD-82eTUmvE9Hp=Lw@mail.gmail.com>
	("Alex \=\?utf-8\?Q\?Benn\=C3\=A9e\=22's\?\= message of "Fri, 31 May 2013 09:40:01
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226083>

Alex Benn=C3=A9e <kernel-hacker@bennee.com> writes:

> I think you are right. I was brave (well I assumed the tags would com=
e
> back from the upstream repo) and ran:
>
> git for-each-ref | grep "refs/tags" | grep "commit" | cut -d '/' -f 3
> | xargs git tag -d

So that deleted all unannotated tags pointing at commits, and then it
was fast.  Curious.

> However I have some big commits it seems:
>
> 09:37 ajb@sloy/x86_64 [work.git] >(git for-each-ref | grep ' commit' =
|
> cut -d\  -f1 | xargs -n1 git cat-file commit) | wc -c
> 1147231984

How many unique entries are there in that list, i.e., what does

  git for-each-ref | grep ' commit' | cut -d\  -f1 | sort -u | wc -l

say?  Perhaps you can also find the biggest commit, e.g. like so:

  git for-each-ref | grep ' commit' | cut -d\  -f1 |
  while read sha; do git cat-file commit $sha | wc -c; done |
  sort -n

However, if that turns out to be the culprit, it's not fixable
currently[1].  Having commits with insanely long messages is just, well=
,
insane.


[1]  unless we do a major rework of the loading infrastructure, so that
we can teach it to load only the beginning of a commit as long as we ar=
e
only interested in parents and such

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
