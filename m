From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/8] rebase: prepare to do generic housekeeping
Date: Fri, 10 May 2013 08:18:39 -0700
Message-ID: <7v8v3m50ds.fsf@alter.siamese.dyndns.org>
References: <1368196005-5354-1-git-send-email-artagnon@gmail.com>
	<1368196005-5354-5-git-send-email-artagnon@gmail.com>
	<CAPig+cTAEwA10JY56Fe7NyVMRfvtupbG7ThML33SNx4zcX2Ebw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 10 17:19:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uap66-0006I0-OE
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 17:19:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757741Ab3EJPSn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 11:18:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56262 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757728Ab3EJPSm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 11:18:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DB6C1C6C1;
	Fri, 10 May 2013 15:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pskXubPWBdA8luTbrMJI6U0bytA=; b=peRQGS
	ebt6t/6HTYwzCnnH9mM94foxS7VNO/1gAqQjxzan09DZ5NWymhRxrAd3gu5HNHnS
	QWOpH3cqwrxMmkl3Qfa8fqldspiBEvrqF7D21I1vxhJC7Fw80Ik96mDSLt77bSje
	q1vczakbwAc1tuBHpiKMPwzV5I3UAf9LcEVSY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GeuDHYK0PkIwFSR+yKXLFI/Qc1KHs7SQ
	moSfSYE5sVsQbTMumNxp10CqKMUo/PV2mmC5V8adCKDWfPMPIAEoWqBtHfuUnHDZ
	Xj0cZR464M+THWGvVD1Ke89PSAfDhKH3Yel2hSrNNZjXASk1JqCu8R3Uok//VNVL
	T2dGFN/dx4s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 415F41C6BC;
	Fri, 10 May 2013 15:18:41 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B57091C6B5;
	Fri, 10 May 2013 15:18:40 +0000 (UTC)
In-Reply-To: <CAPig+cTAEwA10JY56Fe7NyVMRfvtupbG7ThML33SNx4zcX2Ebw@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 10 May 2013 10:33:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E5404F54-B984-11E2-8EEE-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223870>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, May 10, 2013 at 10:26 AM, Ramkumar Ramachandra
> <artagnon@gmail.com> wrote:
>> On successful completion of a rebase in git-rebase--$backend.sh, the
>> $backend script cleans up on its own and exits.  The cleanup routine
>> is however, independent of the $backend, and each $backend script
>> unnecessarily duplicates this work:
>>
>>     rm -rf "$state_dir"
>>     git gc --auto
>>
>> Prepare git-rebase.sh for later patches that return control from each
>> $backend script back to us, for performing this generic cleanup
>> routine.
>>
>> Another advantage is that git-rebase.sh can implement a generic
>> finish_rebase() to possibly do additional tasks in addition to the
>> cleanup.
>>
>> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
>> ---
>>  git-rebase.sh | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/git-rebase.sh b/git-rebase.sh
>> index 2c692c3..84dc7b0 100755
>> --- a/git-rebase.sh
>> +++ b/git-rebase.sh
>> @@ -150,6 +150,13 @@ run_specific_rebase () {
>>                 autosquash=
>>         fi
>>         . git-rebase--$type
>> +       ret=$?
>> +       if test $ret = 0
>
> For numeric comparison, use '-eq' rather than '=', which is for strings.

Do not listen to this.

We know the condition we want is to have $?  with a value that
stringifies to "0" and the above reads much easier.

>
>> +       then
>> +               git gc --auto &&
>> +               rm -rf "$state_dir"
>> +       fi
>> +       exit $ret
>>  }
>>
>>  run_pre_rebase_hook () {
