From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin/log.c: fix minor memory leak
Date: Thu, 07 Aug 2014 12:28:41 -0700
Message-ID: <xmqq1tssksk6.fsf@gitster.dls.corp.google.com>
References: <1407431617-4156-1-git-send-email-Matthieu.Moy@imag.fr>
	<20140807180435.GD12427@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 07 21:29:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFTMw-0006vI-6q
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 21:28:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbaHGT2v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2014 15:28:51 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53126 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750760AbaHGT2v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2014 15:28:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 665B62EAF0;
	Thu,  7 Aug 2014 15:28:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u5uKaxUBoakaxB5yHdM+XlGhE3s=; b=gPkgCS
	Ui86XxBTbFmEDgZlYJPoyqzFotAAiAuXck3Zpl5YHfM3CKtXXy21ZC321qndRVwU
	cRkKMxlYfcwF8Ftkm1RNKFgWp36m3pYamc+PMaCjBWx8Fovz/EWt3yveLiAkil3W
	j63TgWeUrseeeyeuwqavYllwAb6Ouwws3Cz+c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EfQYMOfvx0o00K73eMWb/Y21iTGZ+9Fm
	DU6b9KyIPa7H0jTeeM09gw2hhK/M98hTgvglRNzGDztAnQY05aCvynLQ16E7q5Ax
	1S9QqrZXUGCHIWv6kl0t5z63ueg2e092le6xyY8m7EE/OQjFgALlBTJZbDc9tIT5
	GRaGbKvQbCA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 58F8B2EAEF;
	Thu,  7 Aug 2014 15:28:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 628912EAEC;
	Thu,  7 Aug 2014 15:28:43 -0400 (EDT)
In-Reply-To: <20140807180435.GD12427@google.com> (Jonathan Nieder's message of
	"Thu, 7 Aug 2014 11:04:35 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0B12ED6E-1E69-11E4-BFA2-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254989>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Matthieu Moy wrote:
>
>> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>> ---
>> Valgrind confirms, one less unreachable block ;-).
>
> This belongs in the commit message.
>
> [...]
>> --- a/builtin/log.c
>> +++ b/builtin/log.c
>> @@ -857,20 +857,21 @@ static void add_branch_description(struct strbuf *buf, const char *branch_name)
>>  {
>>  	struct strbuf desc = STRBUF_INIT;
>>  	if (!branch_name || !*branch_name)
>>  		return;
>>  	read_branch_desc(&desc, branch_name);
>>  	if (desc.len) {
>>  		strbuf_addch(buf, '\n');
>>  		strbuf_addbuf(buf, &desc);
>>  		strbuf_addch(buf, '\n');
>>  	}
>> +	strbuf_release(&desc);
>
> This is an old one.  The leak was introduced by v1.7.9-rc1~1^2~12
> (format-patch: use branch description in cover letter, 2011-09-21).
>
> I was a little scared to see a leak in 'git log' code, since most of
> what log does involves looping over many commits.  Luckily this one is
> only used in make_cover_letter to create a cover letter describing the
> single branch on the command line, making it is a small, one-time
> leak.

Exactly ;-).

>
> Less noise from static and dynamic analysis tools is still worthwhile,
> so for what it's worth,
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
> Thanks.

Thanks.
