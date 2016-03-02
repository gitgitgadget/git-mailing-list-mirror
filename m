From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Resumable git clone?
Date: Tue, 01 Mar 2016 22:31:30 -0800
Message-ID: <xmqq8u215r25.fsf@gitster.mtv.corp.google.com>
References: <20160302012922.GA17114@jtriplet-mobl2.jf.intel.com>
	<CAGZ79kYjuaOiTCC-NnZDQs=XGbgXWhJe7gk576jod4QnV57eEg@mail.gmail.com>
	<20160302023024.GG17997@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Duy Nguyen <pclouds@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>, sarah@thesharps.us
To: Al Viro <viro@ZenIV.linux.org.uk>
X-From: git-owner@vger.kernel.org Wed Mar 02 07:31:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ab0Jx-0001RF-01
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 07:31:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbcCBGbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2016 01:31:35 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59946 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750738AbcCBGbe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 01:31:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8A45A42615;
	Wed,  2 Mar 2016 01:31:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Opuih1kfwRnrQCfy/STMII0d9tE=; b=qqIKfE
	WuIwM1hf9UJRg4dzJ3yOs15OaeA/jAgHGtyi/xrmYs5x/dD4xC/PqHCnLLIHUzqq
	9vcUAbV5D8k8p32CJMZxmReuf8aNaE9MO4snom0XLpK3R1SZEJzjYhFOEU+ybh6P
	KFqpJP/UmGiYcQBfbU8UlcJwTcBR/9s+W66+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Vsmci5tCVRpQSwgQXJmNgqSFnB6l0+kD
	mLnMXVyorVEOi5GkfW04iIBvsJzOeUQ4ll84Bm7ninYaeAqr0xValxx3auDv6cLm
	hwlPM0KOwSQkRfrGfTd/ehVbDHUUo8DkwOKDhdyHWPxwQO/kjCgqK3k0Ke53RyHp
	HZIlGjoBF+A=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 81FF642614;
	Wed,  2 Mar 2016 01:31:32 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 01B4142612;
	Wed,  2 Mar 2016 01:31:31 -0500 (EST)
In-Reply-To: <20160302023024.GG17997@ZenIV.linux.org.uk> (Al Viro's message of
	"Wed, 2 Mar 2016 02:30:24 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 674BA5D6-E040-11E5-B05A-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288097>

Al Viro <viro@ZenIV.linux.org.uk> writes:

> FWIW, I wasn't proposing to recreate the remaining bits of that _pack_;
> just do the normal pull with one addition: start with sending the list
> of sha1 of objects you are about to send and let the recepient reply
> with "I already have <set of sha1>, don't bother with those".  And exclude
> those from the transfer.

I did a quick-and-dirty unscientific experiment.

I had a clone of Linus's repository that was about a week old, whose
tip was at 4de8ebef (Merge tag 'trace-fixes-v4.5-rc5' of
git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace,
2016-02-22).  To bring it up to date (i.e. a pull about a week's
worth of progress) to f691b77b (Merge branch 'for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs, 2016-03-01):

    $ git rev-list --objects 4de8ebef..f691b77b1fc | wc -l
    1396
    $ git rev-parse 4de8ebef..f691b77b1fc |
      git pack-objects --revs --delta-base-offset --stdout |
      wc -c
    2444127

So in order to salvage some transfer out of 2.4MB, the hypothetical
Al protocol would first have the upload-pack give 20*1396 = 28kB
object names to fetch-pack; no matter how fetch-pack encodes its
preference, its answer would be less than 28kB.  We would likely to
design this part of the new protocol in line with the existing part
and use textual object names, so let's round them up to 100kB.

That is quite small, even if you are on a crappy connection that you
need to retry 5 times, the additional overhead to negotiate the list
of objects alone would be 0.5MB (or less than 20% of the real
transfer).

That is quite interesting [*1*].

For the approach to be practical, you would have to write a program
that reads from a truncated packfile and writes a new packfile,
excising deltas that lack their bases, to salvage objects from a
half-transferred packfile; it is however unclear how involved the
code would get.

It is probably OK for a tiny pack that has only 1400 objects--we
could just pass the early part through unpack-objects and let it die
when it hits EOF, but for a "resumable clone", I do not think you
can afford to unpack 4.6M objects in the kernel repository into
loose objects.

The approach of course requires the server end to spend 5 times as
many cycles as usual in order to help a client that retries 5 times.

On the other hand, the resumable "clone" we were discussing by
allowing the server to respond with a slightly older bundle or a
pack and then asking the client to fill the latest bits by a
follow-up fetch targets to reduce the load of the server side (the
"slightly older" part can be offloaded to CDN).  It is a happy side
effect that material offloaded to CDN can more easily obtained via
HTTPS that is trivially resumable ;-)

I think your "I've got these already" extention may be worth trying,
and it is definitely better than the "let's make sure the server end
creates byte-for-byte identical pack stream, and discard the early
part without sending it to the network", and it may help resuming a
small incremental fetch, but I do not think it is advisable to use
it for a full clone, given that it is very likely that we would be
adding the "offload 'clone' to CDN" kind.  Even though I can foresee
both kinds to co-exist, I do not think it is practical to offer it
for resuming multi-hour cloning of the kernel repository (or worse,
Android repositories) over a trans-Pacific link, for example.


[Footnote]

*1* To update v4.5-rc1 to today's HEAD involves 10809 objects, and
    the pack data takes 14955728 bytes.  That translates to ~440kB
    needed to advertise a list of textual object names to salvage
    object transfer of 15MB.
