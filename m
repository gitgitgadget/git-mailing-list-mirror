From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [SECURITY PATCH] git-prompt.sh: don't put unsanitized branch names in $PS1
Date: Mon, 21 Apr 2014 15:33:30 -0700
Message-ID: <xmqq1twq8g91.fsf@gitster.dls.corp.google.com>
References: <1398107248-32140-1-git-send-email-rhansen@bbn.com>
	<xmqq61m28gqj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sitaramc@gmail.com,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Simon Oosthoek <s.oosthoek@xs4all.nl>
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 00:33:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcMmQ-0006BA-P8
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 00:33:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754617AbaDUWdf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 18:33:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34411 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754027AbaDUWdd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 18:33:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85B837F607;
	Mon, 21 Apr 2014 18:33:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1ELPXO6V/m2Cl3hiN+t3A1trhsQ=; b=HXJ44t
	LEpmN2CbwoPsnLdo1MD5ZdHAOTvRoKYT7rLZ1IuHuOVnfVS85Mf9AewqK45FZZHE
	MVdYbz2HwzfyPRoQJnz8d17AknF4lSbUlynjDeGQ79ZmHzRQnHATMGb8c8P+6YjJ
	mGsJsIPk9UPX+6egZkENYA8LB4t4iDhfTVt94=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aqK42jpSpe6s9GJvhPxGrIPekApiHQ5e
	x9Bvi3uWELPxY1GGflQ3e5qsGrHwsKXt3aGiCClupUXkpOlNwCjRAZsEP0+SVRcd
	K9Zv/5U8fWnwKt/CGtjD+d3TXim/qmJFyELYrAIVueetXK+bqPNr8gx//7bN4kIB
	Xt4P88p8Q3g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7189E7F606;
	Mon, 21 Apr 2014 18:33:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C5B4D7F601;
	Mon, 21 Apr 2014 18:33:31 -0400 (EDT)
In-Reply-To: <xmqq61m28gqj.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 21 Apr 2014 15:23:00 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F7AFFFD2-C9A4-11E3-B7C6-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246659>

Junio C Hamano <gitster@pobox.com> writes:

> Richard Hansen <rhansen@bbn.com> writes:
>
>> Both bash and zsh subject the value of PS1 to parameter expansion,
>> command substitution, and arithmetic expansion.  Rather than include
>> the raw, unescaped branch name in PS1 when running in two- or
>> three-argument mode, construct PS1 to reference a variable that holds
>> the branch name.  Because the shells do not recursively expand, this
>> avoids arbitrary code execution by specially-crafted branch names such
>> as '$(IFS=_;cmd=sudo_rm_-rf_/;$cmd)'.
>>
>> Signed-off-by: Richard Hansen <rhansen@bbn.com>
>
> I'd like to see this patch eyeballed by those who have been involved
> in the script (shortlog and blame tells me they are SZEDER and
> Simon, CC'ed), so that we can hopefully merge it by the time -rc1 is
> tagged.
>
> Will queue so that I won't lose it in the meantime.
>
> Thanks.

Sadly, this does not seem to pass t9903.41 for me.

    $ bash t9903-*.sh -i -v

ends with this: 

    --- expected    2014-04-21 22:31:46.000000000 +0000
    +++ .../t/trash directory.t9903-bash-prompt/actual  ...
    @@ -1 +1 @@
    -BEFORE: (master):AFTER
    \ No newline at end of file
    +BEFORE: (${__git_ps1_branch_name}):AFTER
    \ No newline at end of file
    not ok 41 - prompt - pc mode
