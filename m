From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3] submodule deinit: require '--all' instead of '.' for all submodules
Date: Wed, 04 May 2016 15:06:01 -0700
Message-ID: <xmqqfutxeawm.fsf@gitster.mtv.corp.google.com>
References: <1462321992-15153-1-git-send-email-sbeller@google.com>
	<1462324785-26389-1-git-send-email-sbeller@google.com>
	<xmqqlh3pft91.fsf@gitster.mtv.corp.google.com>
	<xmqqshxxeboj.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbUJjqYbY3hC1W0Aw=gR49i4Q0BjY+qM9aiWG5ME89Ruw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu May 05 00:06:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay4vq-0008RA-TV
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 00:06:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754194AbcEDWGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 18:06:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54649 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753288AbcEDWGF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 18:06:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D01A518926;
	Wed,  4 May 2016 18:06:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vg9tw8yg3pJaJpDvpvX6wQaB51o=; b=sUU31d
	RO28jgnQ+QTNOHSjwstncjuQnREFMbctQRtLmxAh9acGFoXAgf6rH3ShcZmvnIBN
	HCs/qpd/Fkbz1WBCGKO95UKtduRU3TgmIJcnJJ+3o/o6fWqGXU5K3x+V2FiliO1p
	Z+XGOZVxj5fOyn+aJT2tqlvzpks7j7H6uSu9w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IEOtcu8f730pIczlKgU5CUKw6O6mPxgT
	UKTxZsjpOV9WPeLVZsSDAcui+AkIbxVM8iOzQ6GwAfEYps1hsMJ0yPnADNuen5ci
	AjQW9fkrQy5x+Nbg2YnRtAk91VwsIufACfLH/1Kh5gxfjZdZXc03AkEiR6r5KDeC
	dDriw15o8Ew=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C6CDF18925;
	Wed,  4 May 2016 18:06:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 50BA318923;
	Wed,  4 May 2016 18:06:03 -0400 (EDT)
In-Reply-To: <CAGZ79kbUJjqYbY3hC1W0Aw=gR49i4Q0BjY+qM9aiWG5ME89Ruw@mail.gmail.com>
	(Stefan Beller's message of "Wed, 4 May 2016 14:57:59 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 646E8230-1244-11E6-8F8D-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293606>

Stefan Beller <sbeller@google.com> writes:

>> IOW, the latter part _might_ be better if it were
>>
>>         if test $# = 0 && test -z "$deinit_all"
>>         then
>>                 echo >&2 "info: not deinitializing anything."
>>                 echo >&2 "info: Use --all to deinitialize all submodules."
>>                 exit 0
>>         fi
>>
>> given that this is really about preventing mistakes from doing mass
>> destruction.
>  ...
> Maybe:
>
>> -             die "$(eval_gettext "Use '.' if you really want to deinitialize all submodules")"
>> +            usage()
>
> instead?

I was primarily concerned about die giving a non-zero exit status
when "git submodule deinit" did not find anything worthwhile to do
(because we specified nothing on the command line to deinit).  IOW,
it was an attempt to do "You asked me a no-op, so I am doing a
no-op, but if I stayed silent, you wouldn't even notice it, and you
might have meant to deinit all, so I am telling you I didn't do
anything, and advising how to say 'deinit all' to me."

But what we see in the patch under discussion is perfectly fine; it
behaves just like "$ rm<RET>" and "$ git add<RET>" that give an
error message and exit with a non-zero status.
