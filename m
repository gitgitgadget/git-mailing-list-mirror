From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] rebase: guard against missing files in read_basic_state()
Date: Thu, 20 Jun 2013 12:56:52 -0700
Message-ID: <7v1u7wtv23.fsf@alter.siamese.dyndns.org>
References: <1371139573-28047-1-git-send-email-artagnon@gmail.com>
	<1371139573-28047-2-git-send-email-artagnon@gmail.com>
	<7vy5adskz3.fsf@alter.siamese.dyndns.org>
	<CANiSa6hUV-xMMASbJf67j0Zn+Mu25CRcvQThNd1EuemhSBB6Rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 20 21:57:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Upkyc-0005jG-RH
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 21:57:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965975Ab3FTT46 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 15:56:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50052 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965573Ab3FTT45 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 15:56:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 710E2293F3;
	Thu, 20 Jun 2013 19:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+LLDoOUKW5MoacULDgXGOxODeHI=; b=o3AprE
	FwGJlqoaH3Yh1zpNMbC0AqUN/mviG69d9tmJHIaNE7fs8Gk2CxPS84y34N/quxlY
	hdprmPFNLQPxhKaIEBtiSCotAZifk5z+eSelaLLweWWJMAP6fygkLGZZLJzp6ws/
	M3KBa6u9c0NoMAQQSMTsxtFED1kgBzL+sXp4w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HrfEGOPxAA00MGq0xQbBREUb5IH2hv1f
	Sh+nz+oWEH8gLfceHgzUW9aMUVrLsiDZSnuG1kGW+Qfw5Smmbc/Dlmsf7KcwDg91
	UqTKH2ZDUHD0CuMBSUjelI59fnef95sfn5/Nl4VyJVOxAoeSCG/Sm91TY6ETonj0
	g6rmXMYTIxk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 65460293F2;
	Thu, 20 Jun 2013 19:56:54 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C0567293EE;
	Thu, 20 Jun 2013 19:56:53 +0000 (UTC)
In-Reply-To: <CANiSa6hUV-xMMASbJf67j0Zn+Mu25CRcvQThNd1EuemhSBB6Rg@mail.gmail.com>
	(Martin von Zweigbergk's message of "Sat, 15 Jun 2013 22:45:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8E03C85E-D9E3-11E2-B74D-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228528>

Martin von Zweigbergk <martinvonz@gmail.com> writes:

> On Thu, Jun 13, 2013 at 3:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>>
>> A more troublesome is that nobody seems to check the return value of
>> this function.  If head-name, onto or orig-head is missing, is that
>> an error condition that should make the callers of read_basic_state
>> stop and refuse to proceed?
>
> Since we unconditionally write those three (and 'quiet'), it seems
> reasonable to require all of them to be there when continuing, so I
> think you're right that we should fail fast.
>
>> The way the && cascade is used seems to indicate that, but up to the
>> point where it sents $verbose. If and only if head-name, onto, orig-head
>> and quiet can be read in state-dir, verbose in state-dir is checked
>> and only then $verbose is set.
>>
>> Martin, this seems to be from your series around early Feburary
>> 2011.  Do you recall why these checks are cascaded this way?
>> I do not offhand think of a good reason.
>
> Neither do I. I think the cascading after 'quiet' is just a mistake on
> my part. The consequences are probably close to none, since if one of
> earlier commands fail, the other files will probably not be there
> either. (Not defending it; I'm happy if it gets fixed, e.g. by making
> it fail fast.)

I think this is probably the right thing to do, if we want to honor
the original intention of the earlier part of && cascade.  Everything
before this new "|| die" reads from a file that should always exist
(e.g. even when not asked to be quiet, that state is not signaled by
the lack of $state_dir/quiet, but by having an empty string in it),
while everything after check optional state variable files (e.g. if
$state_dir/verbose does not exist, it is not an error, but signals
that the user did not ask us to be verbose).

Note that applying this patch _could_ uncover latent bug that was
masked by the lack of "die" here (maybe later codepath may depended
on not having orig_head at all and the only observable effect was
that in such a case, both quiet and verbose were silently ignored,
because the control did not reach the GIT_QUIET=... and verbose=t
assignments.

 git-rebase.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index d0c11a9..90506ba 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -95,7 +95,9 @@ read_basic_state () {
 	else
 		orig_head=$(cat "$state_dir"/head)
 	fi &&
-	GIT_QUIET=$(cat "$state_dir"/quiet) &&
+	GIT_QUIET=$(cat "$state_dir"/quiet) ||
+	die "failed to read basic rebase state from $state_dir"
+
 	test -f "$state_dir"/verbose && verbose=t
 	test -f "$state_dir"/strategy && strategy="$(cat "$state_dir"/strategy)"
 	test -f "$state_dir"/strategy_opts &&
