From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] rebase: fix cherry-pick invocations
Date: Tue, 28 May 2013 15:51:41 -0700
Message-ID: <7vvc62wwea.fsf@alter.siamese.dyndns.org>
References: <1369747757-10192-1-git-send-email-felipe.contreras@gmail.com>
	<1369747757-10192-6-git-send-email-felipe.contreras@gmail.com>
	<7vzjvewwne.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin von Zweigbergk <martinvonz@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 00:51:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhSk9-0003VA-2j
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 00:51:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757861Ab3E1Wvp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 18:51:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63307 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757092Ab3E1Wvo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 18:51:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 05FA7238A9;
	Tue, 28 May 2013 22:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5F7ZJo4tSbKp/orJWdz+hDFVn14=; b=c+qKdi
	9y9xe4c5aBFdFvT/chN3EsHixQXYyJ0YOHwfjWYt9zuR35quBOStUVkRDRf2xIzm
	bk+DwICuJTkbB9Hg66ui1gNEU65F+ZA/laIxcD3kA/n3VV3cl51giP86uepIsWBB
	3AWq24yCXK3ZjvbCPap1t1EvelltPPo/opt5c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gR+DuYCcur722SECbZ+WA1AHecJxNgm8
	z+v0w+46HsHJvrTyqWDLYfwnJAtkNLgW9BTlgRMjnVDvKckhc3hXgEZGhC68VbBK
	cuiSdguRTIKjyxSDFtkDVPp2OvNzPqCh36ksE7fVlpoguGiIkLG8IyT+BRlYdeH6
	4FPE2FWu160=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F1112238A8;
	Tue, 28 May 2013 22:51:43 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5CE85238A7;
	Tue, 28 May 2013 22:51:43 +0000 (UTC)
In-Reply-To: <7vzjvewwne.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 28 May 2013 15:46:13 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2ACD0892-C7E9-11E2-8CEF-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225695>

Junio C Hamano <gitster@pobox.com> writes:

> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> So that all the tests pass.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>  git-rebase--cherry.sh | 17 ++++++++++++++++-
>>  1 file changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/git-rebase--cherry.sh b/git-rebase--cherry.sh
>> index ca78b1b..c3a2ac9 100644
>> --- a/git-rebase--cherry.sh
>> +++ b/git-rebase--cherry.sh
>> @@ -23,11 +23,26 @@ test -n "$rebase_root" && root_flag=--root
>>  mkdir "$state_dir" || die "Could not create temporary $state_dir"
>>  : > "$state_dir"/cherry || die "Could not mark as cherry"
>>  
>> +if test -n "$rebase_root"
>> +then
>> +	revisions="$onto...$orig_head"
>> +else
>> +	revisions="$upstream...$orig_head"
>> +fi
>
> "So that all the tests pass" needs a bit more explanation to say for
> cherry-pick codepath why and how two-dot range fails and why and how
> three-dot variant with --right-only fixes it.  What are the problematic
> cases?

Yikes, sorry, this was me being slow.  Walking A...B range with
right-only and --cherry applied will filter the duplicates, which is
wat you want, I think, and walking A..B range will not do the
filtering for you.


>>  # we have to do this the hard way.  git format-patch completely squashes
>>  # empty commits and even if it didn't the format doesn't really lend
>>  # itself well to recording empty patches.  fortunately, cherry-pick
>>  # makes this easy
>> -git cherry-pick --allow-empty "$revisions"
>> +if test -n "$keep_empty"
>> +then
>> +	extra="--allow-empty"
>> +else
>> +	extra="--skip-empty --cherry-pick"
>> +fi
>> +test -n "$GIT_QUIET" && extra="$extra -q"
>> +test -z "$force_rebase" && extra="$extra --ff"
>> +git cherry-pick --no-merges --right-only --topo-order --do-walk --copy-notes $extra "$revisions"
>>  ret=$?
>>  
>>  if test 0 != $ret
