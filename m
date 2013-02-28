From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v8 4/5] Implement line-history search (git log -L)
Date: Thu, 28 Feb 2013 22:41:17 +0100
Message-ID: <87hakw3yma.fsf@pctrast.inf.ethz.ch>
References: <cover.1362069310.git.trast@student.ethz.ch>
	<9af548b2a7e4a4da9eb30e99b0223f20788b4fc1.1362069310.git.trast@student.ethz.ch>
	<7vbob4iaxh.fsf@alter.siamese.dyndns.org>
	<87fw0g6xp4.fsf@pctrast.inf.ethz.ch>
	<7v38wgi38z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Rast <trast@student.ethz.ch>, <git@vger.kernel.org>,
	Bo Yang <struggleyb.nku@gmail.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Will Palmer <wmpalmer@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 22:41:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBBEZ-0000WL-Q3
	for gcvg-git-2@plane.gmane.org; Thu, 28 Feb 2013 22:41:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759750Ab3B1VlW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2013 16:41:22 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:32453 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759545Ab3B1VlV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2013 16:41:21 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 28 Feb
 2013 22:41:16 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (46.126.8.85) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 28 Feb
 2013 22:41:18 +0100
In-Reply-To: <7v38wgi38z.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 28 Feb 2013 12:37:32 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217256>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@student.ethz.ch> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>>> +/*
>>>> + * NEEDSWORK: manually building a diff here is not the Right
>>>> + * Thing(tm).  log -L should be built into the diff pipeline.
>>>
>>> I am not sure about this design, and do not necessarily agree that
>>> wedging this to the diff pipeline is the right future direction.
>>>
>>> I have a feeling that "log -L" should actually be built around
>>> "blame".  You let blame to hit the first parent to take the blame,
>>> and then turn around to show a single "diff-tree" between the child
>>> and the parent with whatever other diff pipeline gizmo the user can
>>> give you from the command line.  The blame also tells you what the
>>> "interesting" line range were at the first parent commit you found,
>>> so you can re-run the same thing with an updated range.
>>
>> Hrm, now that you mention it, this is actually a brilliant idea.
>
> I don't know.  That is just me handwaving without giving a serious
> end-to-end thought.

Having thought about it for some time, I think we need to figure out
if/what can be shared.  I can't shake off the feeling that *something*
should be common between blame and log -L, but I can't exactly say what
so far.

Your suggestion of looking at the first blame hit is almost there.  (And
in fact if it did work, it should be rather easy to prototype from blame
--incremental.)  However, it works only for additions, not removals.
Lines that were removed do not show up in blame at all, and since a
patch can also _only_ remove lines, blame would not find it even if we
adjust the blamed range at every found commit.

It may be possible to fix that by doing a reverse blame, but I suspect
that runs into yet more trouble when trying to reverse-blame from two
different sides of history.


Then there's a different issue if the order of code flips.  Suppose you
have

  A1
  A2
  B1
  B2

and later change to

  B1
  B2
  A1
  A2

Diffs can fundamentally not express this; they'll only see one side as
unchanged, and the other as completely new.  Ideally we'd be able to
track this case correctly -- as blame does? -- no matter which part is
within our tracked range.


Anyway, I believe this should be booked under "future improvements".
I've had it in my own tree for ages and it already does the right thing
most of the time :-)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
