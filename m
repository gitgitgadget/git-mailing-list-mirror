From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] submodule: Try harder to fetch needed sha1 by direct fetching sha1
Date: Mon, 22 Feb 2016 22:38:51 -0800
Message-ID: <xmqqmvqs2ao4.fsf@gitster.mtv.corp.google.com>
References: <1456180548-20996-1-git-send-email-sbeller@google.com>
	<1456180548-20996-3-git-send-email-sbeller@google.com>
	<xmqqzius2t31.fsf@gitster.mtv.corp.google.com>
	<CAGZ79ka-iAHvopwp==fTiuL13sJ_KzqotCNoOgQLJzvpNGH2HA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Dave Borowitz <dborowitz@google.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 07:38:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aY6cc-0007zv-H3
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 07:38:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757097AbcBWGiy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 01:38:54 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55248 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756677AbcBWGix (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 01:38:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C25F33DE54;
	Tue, 23 Feb 2016 01:38:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pqJ/vAI1Ao5yAICwWfRJ8/FWTb4=; b=fBKJgs
	Ef7K3UR9sKIYqUtaPAV/Z7U7ClP6eDYPh/6xeuCpu6UiyJoLyQAvHD3EsaVd9ZHS
	oKc1KmzZNwiSZXiC43d0X3nPkHyXCNZCEyL/9HfJINOn158C2GlEx5sCooORWF9Y
	p4SKqt8nkmA8Vht+ce/+5yHTds1lHFirusHbw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qhuiO8zpnHG5aP2DVNLupBTFciqTJ6kX
	S/g1VvqpR9ZVqTq6ab37aPsTE+S7Zcq14xv81Cxum99GtSE5mxAuKcmE+NQTgXUz
	srpjgOYTJgHaAkerNtwVEPmHZdDdke5URgE5bvT3T1UQDn3IlZTeZLsqX0Ubj5rn
	GyfPUWHs9CY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B6D993DE53;
	Tue, 23 Feb 2016 01:38:52 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2FB5A3DE52;
	Tue, 23 Feb 2016 01:38:52 -0500 (EST)
In-Reply-To: <CAGZ79ka-iAHvopwp==fTiuL13sJ_KzqotCNoOgQLJzvpNGH2HA@mail.gmail.com>
	(Stefan Beller's message of "Mon, 22 Feb 2016 16:28:03 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1A5D3C7E-D9F8-11E5-BE9E-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287025>

Stefan Beller <sbeller@google.com> writes:

> On Mon, Feb 22, 2016 at 4:01 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Stefan Beller <sbeller@google.com> writes:
>>
>> > We may want to discuss the error message. It is the same as in the case
>> > before (git-fetch <no args>), this is good for translation, but may be bad
>> > for the user as we may want to give extra information.
>> > ("We fetched for you and it worked, however the sha1 was not included,
>> > so we fetched again the server broke it, so we error out.  You used to
>> > see error message: ....")
>> >
>> > Although this may be too much information?
>>
>> Now the "go to that submodule directory and see if $sha1 is
>> reachable from any of the ref" check is written twice exactly the
>> same way, it deserves to become a small helper function, I think.
>>
>> Perhaps something along this line?
>
> This looks very readable.
>
> Feel free to drop both my patches and just introduce this patch as yours!

Nah, this is not my itch but yours ;-)

Besides, have we agreed what error message we want to give to the
users yet?

>>
>>  git-submodule.sh | 29 ++++++++++++++++++++++++++---
>>  1 file changed, 26 insertions(+), 3 deletions(-)
>>
>> diff --git a/git-submodule.sh b/git-submodule.sh
>> index 9bc5c5f..836348f 100755
>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -591,6 +591,24 @@ cmd_deinit()
>>         done
>>  }
>>
>> +is_tip_reachable () (
>> +       clear_local_git_env
>> +       cd "$1" &&
>> +       rev=$(git rev-list -n 1 "$2" --not --all 2>/dev/null) &&
>> +       test -z "$rev"
>
> While we're talking about this code anyway, I wondered if we can make it
> more cryptic again (just kidding!) and shorten it a bit by using the
>
>     is_tip_reachable () (
>         clear_local_git_env
>         test -z $(git -C $1 rev-list -n 1 "$2" --not --all 2>/dev/null)
>     )
>
>> +)
>> +
>> +fetch_in_submodule () (
>> +       clear_local_git_env
>> +       cd "$1" &&
>> +       case "$2" in
>> +       '')
>> +               git fetch ;;
>> +       *)
>> +               git fetch $(get_default_remote) "$2" ;;
>> +       esac
>> +)
>> +
>>  #
>>  # Update each submodule path to correct revision, using clone and checkout as needed
>>  #
>> @@ -745,9 +763,14 @@ Maybe you want to use 'update --init'?")"
>>                         then
>>                                 # Run fetch only if $sha1 isn't present or it
>>                                 # is not reachable from a ref.
>> -                               (clear_local_git_env; cd "$sm_path" &&
>> -                                       ( (rev=$(git rev-list -n 1 $sha1 --not --all 2>/dev/null) &&
>> -                                        test -z "$rev") || git-fetch)) ||
>> +                               is_tip_reachable "$sm_path" "$sha1" ||
>> +                               fetch_in_submodule "$sm_path" ||
>> +                               die "$(eval_gettext "Unable to fetch in submodule path '\$displaypath'")"
>> +
>> +                               # Now we tried the usual fetch, but $sha1 may
>> +                               # not be reachable from any of the refs
>> +                               is_tip_reachable "$sm_path" "$sha1" ||
>> +                               fetch_in_submodule "$sm_path" "$sha1" ||
>
> For another split second I wondered about the return code of is_tip_reachable,
> if the result is actually negated, but reading the chaining here, makes sense.
>
> Thanks,
> Stefan
>
>>                                 die "$(eval_gettext "Unable to fetch in submodule path '\$displaypath'")"
>>                         fi
>>
