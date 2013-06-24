From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: Splitting a rev list into 2 sets
Date: Mon, 24 Jun 2013 11:59:24 +0200
Message-ID: <87mwqf3k3n.fsf@linux-k42r.v.cablecom.net>
References: <CAC9WiBi-E+LN4hKGeu0mG7ihJWCaTg-W1Dx_PWmX_vsx-uLOaw@mail.gmail.com>
	<8761x87wc8.fsf@linux-k42r.v.cablecom.net>
	<CAC9WiBgb18ZX0vr8V79tCEUStrDRhRiSh44nH6+3B_Kf8rypYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 11:59:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur3Yf-0003RM-60
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 11:59:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751977Ab3FXJ72 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Jun 2013 05:59:28 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:29703 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751157Ab3FXJ71 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Jun 2013 05:59:27 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 24 Jun
 2013 11:59:24 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 cas10.d.ethz.ch (172.31.38.210) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Mon, 24 Jun 2013 11:59:24 +0200
In-Reply-To: <CAC9WiBgb18ZX0vr8V79tCEUStrDRhRiSh44nH6+3B_Kf8rypYg@mail.gmail.com>
	(Francis Moreau's message of "Thu, 20 Jun 2013 18:24:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228800>

=46rancis Moreau <francis.moro@gmail.com> writes:

> On Thu, Jun 20, 2013 at 3:20 PM, Thomas Rast <trast@inf.ethz.ch> wrot=
e:
>>   positive=3D$(git rev-parse "$@" | grep -v '^\^')
>>   negative=3D$(git rev-parse "$@" | grep '^\^')
>>   boundary=3D$(git rev-list --boundary $positive ^master | sed -n 's=
/^-//p')
>>   # the intersection is
>>   git rev-list $boundary $negative
>
> I think there's a minor issue here, when boundary is empty. Please
> correct me if I'm wrong but I think it can only happen if positive is
> simply master or a subset of master. In that case I think the solutio=
n
> is just make boundary equal to positive:
>
>      # the intersection is
>      git rev-list ${boundary:-$positive} $negative
>
> Now I'm going to see if that solution is faster than the initial one.

Jan "jast" Kr=C3=BCger pointed out on #git that

  git log $(git merge-base --all A B)

is exactly the set of commits reachable from both A and B; so there's
your intersection operator :-)

So it would seem that a much simpler approach is

  git rev-list $(git merge-base --all master $positive) --not $negative

avoiding the boundary handling and special-case.  It relies on the
(weird?) property that $(git merge-base --all A B1 B2 ...) shows the
merge bases of A with a hypothetical merge of B1, B2, ..., which is jus=
t
what you need here.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
