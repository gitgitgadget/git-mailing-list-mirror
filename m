From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git show and the --quiet option
Date: Sat, 28 May 2011 11:27:25 -0700
Message-ID: <7vtycepto2.fsf@alter.siamese.dyndns.org>
References: <4DE12888.1040506@isy.liu.se>
 <7vy61qpv59.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gustaf Hendeby <hendeby@isy.liu.se>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Sat May 28 20:27:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQOEh-0007OA-7L
	for gcvg-git-2@lo.gmane.org; Sat, 28 May 2011 20:27:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755300Ab1E1S1i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 May 2011 14:27:38 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43887 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755298Ab1E1S1h (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2011 14:27:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 58BD44731;
	Sat, 28 May 2011 14:29:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jAbpBPV+POAZWETbABU4GO9H080=; b=aAWMds
	uboFzirvcBjTVYpkY7HT2ecQOpGIaNcPvqJo6g4XxpHd4dXnuaem7TWAL3DzeYcn
	JLjJzW6xo0Yx5KYLEEwEjekCdZwXSX31YgfUZcgEnhax1YiLoe0VSD8duWkIiufh
	k2ILicIcnUKNKTmvdnqZCrevINcMVGJuVHLAA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TcrrxOihJO1Unb7iFCaV02ANOIU4XPvN
	St+8HNn/aiHdyrHH2y2llnXH26yjiT+sgWWLpWsg8BqFwufhZdj1wbVscJ0ZjC2J
	0vMwGTIshrSkEuSspe7SM3cxCaps863zX6AseuRukWEk+EkRSOEEb3b1cNn/tPJE
	eEyXZjULAs8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 195544730;
	Sat, 28 May 2011 14:29:41 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BE466472F; Sat, 28 May 2011
 14:29:35 -0400 (EDT)
In-Reply-To: <7vy61qpv59.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 28 May 2011 10:55:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7392C3F4-8958-11E0-87D5-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174670>

Junio C Hamano <gitster@pobox.com> writes:

>> I was playing around with "git show" lately and realized it has changed
>> its behavior regarding the --quiet option, which no longer suppresses
>> the diff output as it used to.
>
> The official and right way to suppress diff output from "show" has always
> been with the "-s" option, and it should still work. Otherwise please
> report a bug here.

Having said that, I think this is a minor regression.

"git show A B C" has been about showing objects (not commits) A and B and
C. It picks a convenient format for human consumption for each type, and
shows commit as if it were given to "log -1 -p", tree as if it were given
to "ls-tree --name-only", blob as if it were given to "cat-file blob".

But recently, Linus bolted "git show A..B" on to it, and in a way that is
quite wrong. It walks the history by accident, not by design. This makes
fixing this regression somewhat complex, I suspect.

Given the existing machinery to "show" each individual object given from
the command line, one would naturally imagine that we have a routine that
takes one object, tells its object type, and formats the object in the
representation suitable for human consumption, and have a loop over the
command line to call that routine with each object from the command line.
And "git show A..B" would first walk to find individual commit objects
between A and B, and feed the same routine with these commits one by one.

Not so. The current implementation walks the history between A..B as a
side effect of showing a commit (starting from B) and works by pure
accident.

Case in point: "git show master master" shows two copies of the same
commit, as it should. "git show master^..master master" does not. The
reason? Walking between "master^..master" is done as a side effect of
showing "master^..master" and marks commit object "master" already shown,
and makes the command ignore the second argument.

A worse example can be seen by running something silly like "git show
master~10 master^..master", which you would expect to see two commits
(master~10 and master).  Do not do this on anything with a deep history
like the kernel repository---it will walk down to the root commit.

I think the ideal fix would be to fix the "show A..B" support (one
possible solution would be to simply disable it, but I'd see it as the
last resort) so that it first collects the commit objects in a queue by
properly walking (and clean the object flags that were used to control the
walking after we know what commits are in the range), expand A..B into
these commits on the command line arguments list, and then run the
resulting command line arguments through the traditional "git show"
machinery that shows one object at a time.

If we go that route, then we should always use "quiet" during the internal
history walking that expands A..B to the set of commits in the range with
or without command line --quiet. And then make both --quiet and -s from
the command line to control if the patch is shown when showing a commit.
