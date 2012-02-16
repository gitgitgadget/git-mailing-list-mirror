From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: git status: small difference between stating whole repository and small subdirectory
Date: Thu, 16 Feb 2012 15:05:02 +0100
Message-ID: <87d39eswkx.fsf@thomas.inf.ethz.ch>
References: <CAA01Csr8FbvQ8uFvxX8_6i-hysin6JuaifVVC-yoLyoT0N5F4Q@mail.gmail.com>
	<CAA01Csp6_9fP2rg4104UWUXwOxZmUVdQNDAaBe6fRou6agBz6g@mail.gmail.com>
	<8762f9k5sg.fsf@thomas.inf.ethz.ch>
	<CAA01Cso_8=159UDMFUHiYz1X=gYtpbqRO4h3TMw7N=4YMV8YNg@mail.gmail.com>
	<20120215190318.GA5992@sigill.intra.peff.net>
	<CAA01Cso5y23UMguEe0vwOc6kR3-DjuC8-LTMDsMeeOKU4rVGvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 16 15:05:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ry1xQ-0004ib-OC
	for gcvg-git-2@plane.gmane.org; Thu, 16 Feb 2012 15:05:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257Ab2BPOFG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Feb 2012 09:05:06 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:19759 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750906Ab2BPOFF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Feb 2012 09:05:05 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 16 Feb
 2012 15:05:00 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 16 Feb
 2012 15:05:02 +0100
In-Reply-To: <CAA01Cso5y23UMguEe0vwOc6kR3-DjuC8-LTMDsMeeOKU4rVGvg@mail.gmail.com>
	(Piotr Krukowiecki's message of "Thu, 16 Feb 2012 14:37:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190895>

Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:

> On Wed, Feb 15, 2012 at 8:03 PM, Jeff King <peff@peff.net> wrote:
>> On Wed, Feb 15, 2012 at 09:57:29AM +0100, Piotr Krukowiecki wrote:
>>>
>> I notice that you're still I/O bound even after the repack:
>>
>>> $ time git status =C2=A0-- .
>>> real =C2=A0 =C2=A00m2.503s
>>> user =C2=A0 =C2=A00m0.160s
>>> sys =C2=A0 =C2=A0 0m0.096s
>>>
>>> $ time git status
>>> real =C2=A0 =C2=A00m9.663s
>>> user =C2=A0 =C2=A00m0.232s
>>> sys =C2=A0 =C2=A0 0m0.556s
>>
>> Did you drop caches here, too?
>
> Yes I did - with cache the status takes something like 0.1-0.3s on wh=
ole repo.

So umm, I'm not sure that leaves anything to be improved.

I looked at some strace dumps, and limiting the status to a subdirector=
y
(in my case, '-- t' in git.git) does omit the lstat()s on uninteresting
parts of the index-listed files, as well as the getdents() (i.e.,
readdir()) for parts of the tree that are not interesting.

BTW, some other parts of git-status's display may be responsible for th=
e
amount of data it pulls from disk.  In particular, the "Your branch is
ahead" display requires computing the merge-base between HEAD and
@{upstream}.  If your @{upstream} is way ahead/behind, or points at a
disjoint chunk of history, this may mean essentially pulling all of the
involved history from disk.  If my memory of pack organization serves
right, the commit objects involved would essentially be spread across
the whole pack (corresponding to "time") and thus this operation would
more or less load the entire pack from disk.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
