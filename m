From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] t1500: avoid setting environment variables outside of tests
Date: Tue, 10 May 2016 12:19:54 -0700
Message-ID: <xmqqwpn1oh45.fsf@gitster.mtv.corp.google.com>
References: <20160510052055.32924-1-sunshine@sunshineco.com>
	<20160510052055.32924-6-sunshine@sunshineco.com>
	<20160510183955.GA16211@sigill.intra.peff.net>
	<CAPig+cRR49iJOkaLfynkvch4zUHVkpcJwVah0rvaEOeR7aY2Nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Michael Rappazzo <rappazzo@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue May 10 21:20:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0DCN-0003jG-08
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 21:20:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbcEJTT7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 15:19:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63695 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751227AbcEJTT6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 15:19:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 332B61909C;
	Tue, 10 May 2016 15:19:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4Qr3Is6dRXzcT6J1tBuw5nEA9q8=; b=JsraNM
	bImv3FCvsfeBsVCJROiP+TfoAtZTrBJ/geH77dITtYsU7+9XEEb6F2+agQUfxV8e
	IWZePLGwBS0NJWDFQc2uGn6xmHhNH9XX9fUvjYioFMUIzCGTFRPDXl9h3SHPh0dk
	+a08J+MdwvPeh8xotbsfWQNjVePBtin2h2S0U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MtAHLHzmUK5Gmbe6T0c1KQE7ljw/144b
	756h00DGXgnG8ju6vSQLGqQN9bI00qZ7WsZjjmNV+mHyl6sOyyEV/xP7LCfQwsXJ
	auHAo5hhO/kF2NXiZmcmJ6ySosS3HcAcpEpePCsVcErgEpq/yJY0RzRUFKQzgr04
	OXa/x3YERNY=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2B8311909A;
	Tue, 10 May 2016 15:19:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8E37319099;
	Tue, 10 May 2016 15:19:56 -0400 (EDT)
In-Reply-To: <CAPig+cRR49iJOkaLfynkvch4zUHVkpcJwVah0rvaEOeR7aY2Nw@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 10 May 2016 15:12:23 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2E4F11DE-16E4-11E6-9AB8-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294177>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> I don't know if it's worth worrying about or not. The usual solution is
>> something like:
>>
>>   env_git_dir=$2
>>   env='GIT_DIR=$env_git_dir; export GIT_DIR'
>>   ...
>>   eval "$env"
>
> Makes sense; I wasn't quite happy with having $2 interpolated
> unquoted. Like you, though, I don't know if it's worth worrying
> about...

This is a good change, including the quoting of $env.

> I flip-flopped on this one several times, quoting, and not quoting.
> Documentation for 'eval' says:
>
>     The args are read and concatenated together into a single
>     command.

Which means the two eval's give different results:

    $ e='echo "a  b"'
    $ eval $e
    $ eval "$e"

>> This will set up the sane_unset regardless of whether $env does
>> anything. Would it make more sense to stick the test_when_finished
>> inside $env? You could use regular unset then, too, since you know the
>> variable would be set.
>
> I didn't worry about it too much because the end result is effectively
> the same and, with all the 'case' arms being short one-liners, I think
> the code is a bit easier to read as-is.

Yeah, this is OK.
