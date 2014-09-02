From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 19/19] signed push: fortify against replay attacks
Date: Tue, 02 Sep 2014 10:40:53 -0700
Message-ID: <xmqq8um13opm.fsf@gitster.dls.corp.google.com>
References: <1408739424-31429-1-git-send-email-gitster@pobox.com>
	<1408739424-31429-20-git-send-email-gitster@pobox.com>
	<5401BCA5.70502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 19:41:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOs4u-0006nj-Ey
	for gcvg-git-2@plane.gmane.org; Tue, 02 Sep 2014 19:41:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754183AbaIBRlH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2014 13:41:07 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58240 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751739AbaIBRlF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2014 13:41:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0C7DD36794;
	Tue,  2 Sep 2014 13:41:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DHgNKCaNd/YKfNZRajL/ZSOu/XI=; b=JoA7X/
	0xncKRBUhmrhiGBCczmnJTGgHjb7HLyVEmIKwcJEXPBWZXwr0gL45zAOfzJt0QXC
	foU+q2DuYcBrXViushc3esGdoVxCqRP8yPQDOXCbgG+iztN3p3o2WIf5uBwYgCw+
	JbN00HSfOBpF68/shAK77jSADJbWjgTMo6tpI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ObQHtT6o+Syrw6vZcyiKKXPetJj7zCcK
	IkGqkl51bLAYatG3crlyCsIWCaKEsQGyIGNukfGkxtd9RDBDnZaMRB3yYONazdGY
	aj9NhniVh94ZeG9dgJM1HXsUqExYDz2UMxW1aghgSsjgrp66bH3l25Y4itDX/QbM
	vEdmbXt3kWo=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F3F5436793;
	Tue,  2 Sep 2014 13:41:04 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3C59F3677E;
	Tue,  2 Sep 2014 13:40:55 -0400 (EDT)
In-Reply-To: <5401BCA5.70502@gmail.com> (Stefan Beller's message of "Sat, 30
	Aug 2014 13:59:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4A7DCD3E-32C8-11E4-9981-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256328>

Stefan Beller <stefanbeller@gmail.com> writes:

> On 22.08.2014 22:30, Junio C Hamano wrote:
>> @@ -1226,12 +1232,28 @@ static int delete_only(struct command *commands)
>>  	return 1;
>>  }
>>  
>> +static char *prepare_push_cert_nonce(const char *sitename, const char *dir)
>> +{
>> +	struct strbuf buf = STRBUF_INIT;
>> +	unsigned char sha1[20];
>> +
>> +	if (!sitename) {
>> +		static char buf[1024];
>> +		gethostname(buf, sizeof(buf));
>> +		sitename = buf;
>> +	}
>> +	strbuf_addf(&buf, "%s:%s:%lu", sitename, dir, time(NULL));
>> +	hash_sha1_file(buf.buf, buf.len, "blob", sha1);
>> +	return xstrdup(sha1_to_hex(sha1));
>> +}
>> +
>
> On every other use of gethostname within git.git we're
> checking the return code. And if gethostname fails, we're
> either copying in 'localhost' or 'unknown' instead.
>
> Does that make sense here as well?

It does, but I think this code will have to change quite a lot
before it gets ready even for 'next'.

Thanks.
