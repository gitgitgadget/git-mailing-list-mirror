From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3] submodule deinit: require '--all' instead of '.' for all submodules
Date: Wed, 04 May 2016 14:49:16 -0700
Message-ID: <xmqqshxxeboj.fsf@gitster.mtv.corp.google.com>
References: <1462321992-15153-1-git-send-email-sbeller@google.com>
	<1462324785-26389-1-git-send-email-sbeller@google.com>
	<xmqqlh3pft91.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: jrnieder@gmail.com, git@vger.kernel.org, Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 04 23:49:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay4fd-0006xH-C3
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 23:49:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754196AbcEDVtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 17:49:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61541 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754171AbcEDVtU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 17:49:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DD54E18713;
	Wed,  4 May 2016 17:49:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SkK8e1Fcqdbo7P+MjC7EdXU3UDY=; b=qBrxrs
	5KilfKXLpv8wtKrG6dm+zbNoBdxXi8TzXUrbL19LBIbiugSYq8GSZhaoeH4FKOUd
	/VUpViXOPLqIg2WPhwttkh/8iI13J9eKm85iUTl16swL9Xl9TSlc9QwKk0JQ2x71
	s4lX32SAPaARyOWXVuhNKjMDE7K05hJpmZUjc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BrErZWUc0K9KOth33pygDkB+qrBFSwxu
	OzyemvLz9L7jsLMulGaajZ3PdoB9Uj+VFGSL6cF8alx7h1rPzsDYLeOF+SoAKqg0
	y1ES1T8eIg1T91c4WJkXDE6XPjljG0Z16ZLpzO3fFgErAXQH7xGfZhrEhFfe3THw
	5P5+zt+K/s8=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D4A8118712;
	Wed,  4 May 2016 17:49:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5EF9E18711;
	Wed,  4 May 2016 17:49:18 -0400 (EDT)
In-Reply-To: <xmqqlh3pft91.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 04 May 2016 13:44:26 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0D713092-1242-11E6-BE0A-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293601>

Junio C Hamano <gitster@pobox.com> writes:

>> +	if test -n "$deinit_all" && test "$#" -ne 0
>> +	then
>> +		die "$(eval_gettext "usage: $dashless [--quiet] deinit [-f|--force] (--all | [--] <path>...)")"
>
> I doubt that "usage:" wants to go thru l10n.
>
> I suspect that it is more friendly to the user to say that in prose,
> i.e.e.g. "--all and pathspec cannot be given at the same time", than
> forcing them to grok the (alternative|possibilities).
>
>> +	fi
>> +	if test $# = 0 && test -z "$deinit_all"
>>  	then
>> -		die "$(eval_gettext "Use '.' if you really want to deinitialize all submodules")"
>> +		die "$(eval_gettext "Use '--all' if you really want to deinitialize all submodules")"
>>  	fi
>
> This is good.

By the way, while it is a very good idea to die upon

	$ git submodule deinit --all no-only-this-one

it may not be too bad if we demoted the output to "info" with clean
no-op exit when the user said

	$ git submodule deinit

IOW, the latter part _might_ be better if it were

	if test $# = 0 && test -z "$deinit_all"
	then
		echo >&2 "info: not deinitializing anything."
                echo >&2 "info: Use --all to deinitialize all submodules."
                exit 0
	fi

given that this is really about preventing mistakes from doing mass
destruction.
