From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3] refs: Use binary search to lookup refs faster
Date: Sun, 02 Oct 2011 07:15:47 +0200
Message-ID: <4E87F383.1050403@alum.mit.edu>
References: <4DF6A8B6.9030301@op5.se> <CAP8UFD3TWQHU0wLPuxMDnc3bRSz90Yd+yDMBe03kofeo-nr7yA@mail.gmail.com> <201109281338.04378.mfick@codeaurora.org> <201109281610.49322.mfick@codeaurora.org> <c76d7f65203c0fc2c6e4e14fe2f33274@quantumfyre.co.uk> <960aacbf-8d4d-4b2a-8902-f6380ff9febd@email.android.com> <7c0105c6cca7dd0aa336522f90617fe4@quantumfyre.co.uk> <4E84B89F.4060304@lsrfire.ath.cx> <7vy5x7rwq9.fsf@alter.siamese.dyndns.org> <20110929041811.5363.33396.julian@quantumfyre.co.uk> <7vvcsbqa0k.fsf@alter.siamese.dyndns.org> <20110929221143.23806.25666.julian@quantumfyre.co.uk> <7v62karjv3.fsf@alter.siamese.dyndns.org> <4E85E07C.5070402@alum.mit.edu> <7vk48qouht.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Julian Phillips <julian@quantumfyre.co.uk>,
	Martin Fick <mfick@codeaurora.org>,
	Christian Couder <christian.couder@gmail.com>,
	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 02 07:16:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAEPU-0003of-Nb
	for gcvg-git-2@lo.gmane.org; Sun, 02 Oct 2011 07:16:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132Ab1JBFQF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Oct 2011 01:16:05 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:60881 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877Ab1JBFQC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Oct 2011 01:16:02 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.134] (p54BEC733.dip.t-dialin.net [84.190.199.51])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p925FmLA018079
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 2 Oct 2011 07:15:48 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <7vk48qouht.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182593>

On 09/30/2011 06:38 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>=20
>> On 09/30/2011 01:48 AM, Junio C Hamano wrote:
>>> This version looks sane, although I have a suspicion that it may ha=
ve
>>> some interaction with what Michael may be working on.
>>
>> Indeed, I have almost equivalent changes in the giant patch series t=
hat
>> I am working on [1].
>=20
> Good; that was the primary thing I wanted to know.  I want to take
> Julian's patch early but if the approach and data structures were
> drastically different from what you are cooking, that would force
> unnecessary reroll on your part, which I wanted to avoid.

Um, well, my patch series includes the same changes that Julian's wants
to introduce, but following lots of other changes, cleanups,
documentation improvements, etc.  Moreover, my patch series builds on
mh/iterate-refs, with which Julian's patch conflicts.  In other words,
it would be a real mess to reroll my series on top of Julian's patch.
(That is of course not to imply that I hold a mutex on refs.c.)  Becaus=
e
it changes a data structure that is used throughout refs.c, changes a
lot of lines of code.

I think that the switch from linked list + linear sort to array plus
binary sort is a pretty obvious win in terms of code complexity and
*potential* performance improvement, but empirically I haven't seen any
claims that it brings performance improvements beyond "Ren=E9's patch".
(Though, honestly, I've lost track of which "Ren=E9's patch" is being
discussed and I don't see anything relevant in Junio's tree.)

Intuitively, given that populating the reference cache involves O(N)
I/O, speeding up lookups can only help if there are very many ref
lookups within a single git invocation.  I think we will get a better
improvement by avoiding the reading of unneeded loose refs by reading
them one subdirectory at a time instead of always reading them en masse=
=2E
 I wanted to reach that milestone before submitting my changes.

My preference would be:

1. Merge jp/get-ref-dir-unsorted, perhaps even into maint.  It is a
simple, noninvasive, and obvious improvement and helps performance a lo=
t
in an important use case.

2. Hold off on merging jp/get-ref-dir-unsorted for a while to give me a
chance to avoid conflict hell.

3. Evaluate Ren=E9's patch on its own merits; if it makes sense regardl=
ess
of the binary search speedups, then it can be accepted independently to
give most of the performance benefit already.

Are there any other patches in this area that I've forgotten?

Michael

--=20
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
