From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] difftool: Change prompt to display the number of files in the diff queue
Date: Wed, 04 Dec 2013 12:18:18 -0800
Message-ID: <xmqq61r4l69h.fsf@gitster.dls.corp.google.com>
References: <1386120387-25300-1-git-send-email-zoltan.klinger@gmail.com>
	<CAPig+cTUB=UbY-j8mtz6QsvJKoA2T41u-wiR7Di596pM3t+k=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zoltan Klinger <zoltan.klinger@gmail.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Dec 04 21:18:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoItw-0006X6-48
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 21:18:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933198Ab3LDUSY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 15:18:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35449 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933159Ab3LDUSW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 15:18:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 354F956CE4;
	Wed,  4 Dec 2013 15:18:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/X30rF79G2rCbjX5UMI4aumVyU8=; b=Uz9rw7
	B1cKopePFnZS7LGThdG7FOm4wzZ5XjTID9fe6BWCsrAflLlabvWFHbd3KlTtAeT1
	uVofaKimKbF2Tp8LsJ8EDppjbOAtSygo+26oPPsgad7A9a1mfhiIW8Ltkt0QARZk
	MeNCBayOiUg9wuwynWVL10pR3rRdKBkfjwqkM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jrw52zUgCVaDre2YEktxFrcBo50dvU0W
	2w4r0b6hPiFuKI+whcCAGaScHgSuRi4QtyB+VBrTNjdCKzr+3uT4hc0yNnOcaWpf
	PDZ0+ja0xObR8eFa1Z869ZuRRTcco273wjmv5AiMPOLs3jEp0ECRBNzEJIvDJDPS
	2lUKZyXUQgI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2280A56CE3;
	Wed,  4 Dec 2013 15:18:22 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 64BE256CE1;
	Wed,  4 Dec 2013 15:18:21 -0500 (EST)
In-Reply-To: <CAPig+cTUB=UbY-j8mtz6QsvJKoA2T41u-wiR7Di596pM3t+k=Q@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 3 Dec 2013 23:34:58 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 387C42FA-5D21-11E3-B7EB-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238808>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +       setenv ("GIT_DIFF_PATH_COUNTER", counterstr.buf, 1);
>> +       setenv ("GIT_DIFF_PATH_TOTAL", totalstr.buf, 1);
>> +
>>         retval = run_command_v_opt(spawn_arg, RUN_USING_SHELL);
>
> Would run_command_v_opt_cd_env() be more appropriate than setenv() +
> run_command_v_opt() done here?

Probably (besides, SPs after 'setenv' need to go).

Also, we know total/conter is a decimal integer. On-stack 32-byte
arrays are sufficient and two strbufs are overkill ;-)

>> diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
>> index 8a30979..4935fc4 100755
>> --- a/t/t4020-diff-external.sh
>> +++ b/t/t4020-diff-external.sh
>> @@ -193,6 +193,22 @@ test_expect_success 'GIT_EXTERNAL_DIFF with more than one changed files' '
>>         GIT_EXTERNAL_DIFF=echo git diff
>>  '
>>
>> +echo "#!$SHELL_PATH" >external-diff.sh
>> +cat >> external-diff.sh <<\EOF
>> +echo $GIT_DIFF_PATH_COUNTER of $GIT_DIFF_PATH_TOTAL >>counter.txt
>> +EOF
>> +chmod a+x external-diff.sh
>
> Perhaps write_script()?

Definitely.

Thanks, both.
