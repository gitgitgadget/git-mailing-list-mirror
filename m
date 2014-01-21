From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 0/2] Two janitorial patches for builtin/blame.c
Date: Tue, 21 Jan 2014 23:56:37 +0100
Message-ID: <87iotdosey.fsf@fencepost.gnu.org>
References: <1390157870-29795-1-git-send-email-dak@gnu.org>
	<87d2jlqp7x.fsf@fencepost.gnu.org> <20140121165546.GE18964@google.com>
	<874n4xqlly.fsf@fencepost.gnu.org> <20140121174448.GG18964@google.com>
	<xmqqa9epulwq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 21 23:56:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5kFP-0002ci-Ep
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jan 2014 23:56:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752819AbaAUW4j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jan 2014 17:56:39 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:46968 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752553AbaAUW4j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 17:56:39 -0500
Received: from localhost ([127.0.0.1]:46008 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1W5kFK-0006k2-1T; Tue, 21 Jan 2014 17:56:38 -0500
Received: by lola (Postfix, from userid 1000)
	id 054E2E051D; Tue, 21 Jan 2014 23:56:37 +0100 (CET)
In-Reply-To: <xmqqa9epulwq.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 21 Jan 2014 12:20:37 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240787>

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> David Kastrup wrote:
>>
>>> So my understanding is that when we are talking about _significant_
>>> additions to builtin/blame.c (the current patches don't qualify as such
>>> really) that
>>>
>>> a) builtin/blame.c is licensed under GPLv2
>>> b) significant contributions to it will not be relicensed under
>>> different licenses without the respective contributors' explicit
>>> consent.
>>
>> Yep, that's how it works.
>>
>> [...]
>>> The combination of the SubmittingPatches text with the file notices in
>>> builtin/blame.c is not really painting a full picture of the situation.
>>
>> Any idea how this could be made more clear?  E.g., maybe we should
>> bite the bullet and add a line to all source files that don't already
>> state a license:
>>
>> 	/*
>> 	 * License: GPLv2.  See COPYING for details.
>> 	 */
>
> I vaguely recall that jgit folks at one point wanted to lift this
> implementation and were interested in seeing it to be dual licensed
> to BSD but that was a long time ago.
>
>   http://git.661346.n2.nabble.com/JGIT-Blame-functionality-for-jgit-td2142726.html

Ok, let me state quite clearly before we waste time, energy and
goodwill:

a) I am reworking the core logic of blame.c to make it produce the same
results while being orders of magnitude faster.  Git's current
implementation is a roadblock for serious use.  Keeping its current core
algorithms and data flow, it would have been reasonably easy to speed
the current code up by a factor of 2 or more by doing local
optimizations.  But I've chosen _not_ to keep the current logic and data
flow.  That means quite a bit more work, and it means completely
understanding the existing code before being able to replace it.

The core part of blame.c spends literally billions of iterations in
real-life situations leafing through one large linear list for tiny bits
of information.  One could use a better searchable data structure and
speed up the access in that manner, but better than a fast search is no
search at all.  I am separating the data so that at any given time I am
only accessing actually relevant data.  O(n) beats O(n lg n), and the
code remains almost as readable as the current O(n^2).

b) This will require thoroughly reworking the core parts of the
algorithm which will then be about 50/50 old and new code that cannot
sensibly be separated since significant parts of the previous code will
be gone completely as the data flow is fundamentally different.

c) The "fine points" of blame.c, in particular all the various command
line options and the implementation of their exact meaning would stay
the same.  I hope I can avoid touching more than 50% of the code.

d) I am fine with distributing my work under the GPLv2 or later, but no
other license will be implied.  While this does not affect the core Git
distribution itself: for distribution under more permissive licenses for
the purpose of making inclusion in proprietary software possible, I'd
probably attach a big price tag that reflects the amount of work and
quality of code going in and the fact that I have no other source of
income.

e) No idea whether this would affect JGIT: it depends on how much JGIT
would be a literal translation of blame.c into Java (?) or a
functionally equivalent rewrite employing different and/or native data
structures to achieve the same effect.  To me it's irritating that
something like the fine but boring points of option parsing might be
more susceptible to copyright protection than doing a careful
algorithmic design, but that's the way the world is wired.

At any rate: JGIT or not, I'll be contributing work with the
understanding that it will be licensed under the _current_ licensing
scheme of Git.  And I think that's a reasonable expectation.

-- 
David Kastrup
