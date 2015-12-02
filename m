From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] sh-setup: make require_clean_work_tree() work on orphan branches
Date: Wed, 02 Dec 2015 15:07:05 -0800
Message-ID: <xmqqwpsw4fhi.fsf@gitster.mtv.corp.google.com>
References: <1448376345-27339-1-git-send-email-szeder@ira.uka.de>
	<1448376345-27339-2-git-send-email-szeder@ira.uka.de>
	<20151124205036.GF7174@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 03 00:07:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4GUd-0003uS-Vd
	for gcvg-git-2@plane.gmane.org; Thu, 03 Dec 2015 00:07:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757334AbbLBXHQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Dec 2015 18:07:16 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62479 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757003AbbLBXHN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Dec 2015 18:07:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 862D92F515;
	Wed,  2 Dec 2015 18:07:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=AEPZwHWrt1XO
	HlmQUkowEzx2tdw=; b=WvCkjqnnuqlPeRD/KoDl4o7DMDxjfrQgVdUs03v10vGy
	Kv4Gl8pMrLg+1/0o9knqdQ9LqHMyyhlgFCg4udBpHFPUtqi8jt8BdMESvHFhyS/Z
	kYsc6xx3fi27iDmbARdwCYFutJUsCwJPgHBAUFiN1j72XmiCOlwwil0jUh1JCGg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=eQBpQG
	ZpMsG1qQ22nyTWK/hp4r5hQM5Kdy1n6teZbL5BIY701gCTCsBazBv3+PhNinsYYn
	F/eA+DZKR8QwPTt5KEb6Y5uSI/px9A2BpsNd4NJdQkGekRy+LTBiCOiQiXtz82ym
	DrjdZue/xLUXnyUpnJJSbkHwSDYiIlw3n80tg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7C2B82F514;
	Wed,  2 Dec 2015 18:07:12 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7FC272F510;
	Wed,  2 Dec 2015 18:07:06 -0500 (EST)
In-Reply-To: <20151124205036.GF7174@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 24 Nov 2015 15:50:37 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 68400376-9949-11E5-8780-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281919>

Jeff King <peff@peff.net> writes:

> On Tue, Nov 24, 2015 at 03:45:45PM +0100, SZEDER G=C3=A1bor wrote:
>
>> git-sh-setup's require_clean_work_tree() always exits with error on =
an
>> orphan branch, even when the index and worktree are both clean.  The
>> reason is that require_clean_work_tree() starts off with verifying
>> HEAD, to make sure that it can safely pass HEAD to 'git diff-index'
>> later when it comes to checking the cleanness of the index, and erro=
rs
>> out finding the invalid HEAD of the orphan branch.
>>=20
>> There are scripts requiring a clean worktree that should work on an
>> orphan branch as well, and those should be able to use this function
>> instead of duplicating its functionality and nice error reporting in=
 a
>> way that handles orphan branches.
>>=20
>> Fixing this is easy: the index should be compared to the empty tree
>> while on an orphan branch, and to HEAD otherwise.
>>=20
>> However, just fixing require_clean_work_tree() this way is also
>> dangerous, because scripts must take care to work properly on orphan
>> branches.  Currently a script calling require_clean_work_tree() woul=
d
>> exit on a clean orphan branch, but with the simple fix it would
>> continue executing and who knows what the consequences might be if
>> the script is not prepared for orphan branches.
>
> Hmm. I suspect this is not a big deal in practice. Lots of scripts
> (including some of our own, through history) get the orphan case wron=
g.

The state of the repository this topic wants to deal with better
would be the same as the state you would get after "tar xf ... &&
git init && git add .", no?  In the "orphan" case, unlike such a
plain vanilla "created a new repository" case where the index could
be empty for a long time before the initial 'git add', the index is
almost always populated, so most likely this change will not make
much difference in that require_clean_work_tree() would stop
operation until "rm --cached ." empties the index.

And if the user did "rm --cached ." to empty the index, it is fine
for us to happily consider all these files as untracked, even when
HEAD is not pointing at an existing ref.  So it is likely that the
added ORPHAN_OK knob would be unnecessary for "orphan" case.

However, I suspect that this would affect the users in the "I am a
new user, I just initialized my first Git repository and I haven't
done a 'git add' yet" status much more.  Do we have corner cases
where everyday commands do not work well while on an unborn branch
immediately after 'git init'?  That is the kind of bug that we need
to protect users from, either by keeping the "No HEAD yet, no operation
that requires clean working tree" logic, or by fixing such bugs.

> I'm not sure that require_clean_work_tree is necessarily the place to=
 be
> enforcing it, even though it happened to have done so historically.

It is unclear to me what you meant by "it" in "enforcing it".

> Still, it may be prudent to err on the side of caution. I'm on the
> fence.
