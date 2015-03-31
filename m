From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 6/6] entry.c: fix a memleak
Date: Tue, 31 Mar 2015 12:12:51 -0700
Message-ID: <xmqqmw2tq8uk.fsf@gitster.dls.corp.google.com>
References: <1427764931-27745-1-git-send-email-sbeller@google.com>
	<1427764931-27745-7-git-send-email-sbeller@google.com>
	<20150331083647.GA2248@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	sunshine@sunshineco.com
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Mar 31 21:13:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yd1at-00061k-7D
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 21:12:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751991AbbCaTMz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 15:12:55 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52488 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751072AbbCaTMy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 15:12:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7AE4043CEF;
	Tue, 31 Mar 2015 15:12:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xVljnQak6aea5edOIYZiG2g8jh4=; b=gnY4lX
	WCc36H5J845aEdoztXG01OAe6ebggoddZtfeX9ui2y5H1p3qP99qP+IRdDmuJ2Eg
	1dRheyxQ4i1MJoSG4Tpp2ziRG3LdAjTZOmRqYGocrfzhh7I2urp0RDK48OXbt26h
	GPqv3EQSOJi8l44qgidO5soNM7l7Q7bqQdqeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qKZYkI2RZvImhzKNTz6BIPxq+Dt00li0
	2qdfpMKE6eRE1xs5aPK4sRQe9A4TfQ8TxzoftJhiy5QwqmoBRXJVzb9uJZxw0Lw2
	ASC/M4YEUDnpZ/i4BZcGXu279chLvV2+ZCYtlBPmXwRHeBMfAAhVLKmnXebgfQz4
	4goLx+TsOFM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 71E8043CED;
	Tue, 31 Mar 2015 15:12:53 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ECA1743CEB;
	Tue, 31 Mar 2015 15:12:52 -0400 (EDT)
In-Reply-To: <20150331083647.GA2248@serenity.lan> (John Keeping's message of
	"Tue, 31 Mar 2015 09:36:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EE100E2E-D7D9-11E4-87B5-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266548>

John Keeping <john@keeping.me.uk> writes:

> On Mon, Mar 30, 2015 at 06:22:11PM -0700, Stefan Beller wrote:
>> From: John Keeping <john@keeping.me.uk>
>> 
>> stream_blob_to_fd() always frees the filter now, so there is no memory
>> leak in entry.c:152 just before the `goto finish`.
>> 
>> Signed-off-by: John Keeping <john@keeping.me.uk>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  
>>  I added Johns signoff here tentatively, John can you confirm the sign off?
>
> Signed-off-by: John Keeping <john@keeping.me.uk>

Thanks. I'll queue with a retitle, as this no longer is about
entry.c at all.

>
>>  streaming.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>> 
>> diff --git a/streaming.c b/streaming.c
>> index 2ff036a..811fcc2 100644
>> --- a/streaming.c
>> +++ b/streaming.c
>> @@ -507,8 +507,11 @@ int stream_blob_to_fd(int fd, unsigned const char *sha1, struct stream_filter *f
>>  	int result = -1;
>>  
>>  	st = open_istream(sha1, &type, &sz, filter);
>> -	if (!st)
>> +	if (!st) {
>> +		if (filter)
>> +			free_stream_filter(filter);
>>  		return result;
>> +	}
>>  	if (type != OBJ_BLOB)
>>  		goto close_and_exit;
>>  	for (;;) {
>> -- 
>> 2.3.0.81.gc37f363
>> 
