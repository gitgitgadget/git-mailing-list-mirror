From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] trailer: display a trailer without its trailing newline
Date: Fri, 07 Nov 2014 11:26:04 -0800
Message-ID: <xmqqd28yg6cz.fsf@gitster.dls.corp.google.com>
References: <20141107184148.16854.63825.chriscool@tuxfamily.org>
	<20141107185053.16854.84253.chriscool@tuxfamily.org>
	<20141107192239.GC5695@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 07 20:26:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XmpAi-0007c6-KQ
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 20:26:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752182AbaKGT0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 14:26:08 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55487 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751459AbaKGT0G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 14:26:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E8FB81C881;
	Fri,  7 Nov 2014 14:26:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=++mJUUpspHN6o097JcRl1ZwFqyc=; b=tr2xLV
	LCc+R5rlYeiC0BmkM/MSeRBU5Z3CROUg64yHljFXyn4feFGulFF4FlC4jIoe0ceh
	OhD/WiSzIvgOcwkR4epjLl9XCrxgb/OkWjUVzA/Cvd0Os048ddvk+6fA8ny0cwXc
	37X0GgKo3gtICy77815boBRnz3XNxL0dhDldk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sdB3HjGTfjH+aosrkUrhjJncU70Z80mD
	lpWC5g0OaF08EEUwx2Rm4Dtz+1qzYbbFtBrr707ebxYIbhNW1xi648OBILvTVUK+
	cQs6o/FWUEgoc7GY3Cok5p3KhfGqsPzY6qAL/Wnbg1C4nNdEuOu+phfGI69jb/Wz
	hGJbePw2JsM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DE1741C880;
	Fri,  7 Nov 2014 14:26:05 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 49B7E1C87F;
	Fri,  7 Nov 2014 14:26:05 -0500 (EST)
In-Reply-To: <20141107192239.GC5695@peff.net> (Jeff King's message of "Fri, 7
	Nov 2014 14:22:39 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EAE2A578-66B3-11E4-8BE8-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Nov 07, 2014 at 07:50:49PM +0100, Christian Couder wrote:
>
>> diff --git a/trailer.c b/trailer.c
>> index 761b763..f4d51ba 100644
>> --- a/trailer.c
>> +++ b/trailer.c
>> @@ -583,8 +583,12 @@ static int parse_trailer(struct strbuf *tok,
>> struct strbuf *val, const char *tra
>>  	strbuf_addch(&seps, '=');
>>  	len = strcspn(trailer, seps.buf);
>>  	strbuf_release(&seps);
>> -	if (len == 0)
>> -		return error(_("empty trailer token in trailer '%s'"), trailer);
>> +	if (len == 0) {
>> +		struct strbuf sb = STRBUF_INIT;
>> +		strbuf_addstr(&sb, trailer);
>> +		strbuf_rtrim(&sb);
>> +		return error(_("empty trailer token in trailer '%s'"), sb.buf);
>> +	}
>
> Doesn't this leak sb.buf?

Yes.  "%.*s" might be your friend.
