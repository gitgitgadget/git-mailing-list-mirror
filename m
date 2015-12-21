From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] mingw: emulate write(2) that fails with a EPIPE
Date: Mon, 21 Dec 2015 08:59:56 -0800
Message-ID: <xmqqr3ifhh4j.fsf@gitster.mtv.corp.google.com>
References: <01da36219c18373f8507e19035e141d7e56b2d18.1450267413.git.johannes.schindelin@gmx.de>
	<ca357ac83a9990d6c88b637b76c6cc7f30d3f7be.1450372051.git.johannes.schindelin@gmx.de>
	<5674732A.3050104@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Dec 21 18:00:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aB3oa-00087s-FB
	for gcvg-git-2@plane.gmane.org; Mon, 21 Dec 2015 18:00:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbbLUQ77 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2015 11:59:59 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62573 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751299AbbLUQ76 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2015 11:59:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E031631D7B;
	Mon, 21 Dec 2015 11:59:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Td7vQs+7Lis30fXtAwJ7WOkVA/s=; b=WAXXpq
	g44T3UJHomz9msdB58sJqNjjD7enrQ4M8cdRQtd9bxLJh2clHFSjyNcR3XghyWp0
	s62XtQvPzpciFe/T8lssCrm/ZKNKXwICNTETZnjVmEn+jZnvqKwS5xYvN08ykmMU
	H8lIZ7Hz4CEx49lbAN6kZR7SexFaWMhGoNOdY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MnsqeqQrhbjxuwQIzjPV6+/mSUJ61oOG
	GxSiW6V4ODC7+uj1yEW38HrKOOGuZLUhB3BrhS5L/q8pwCkHnkGwby7voNEXaY4y
	aLWGMKE6UYUKDppg9EDjIH9YhWTAzarJyUGMdOTCzdUpXvei58goYlyGdi5kK5JC
	iYuethhScPc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D851031D79;
	Mon, 21 Dec 2015 11:59:57 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 56CCE31D77;
	Mon, 21 Dec 2015 11:59:57 -0500 (EST)
In-Reply-To: <5674732A.3050104@kdbg.org> (Johannes Sixt's message of "Fri, 18
	Dec 2015 21:57:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 43B16ED6-A804-11E5-966A-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282798>

Johannes Sixt <j6t@kdbg.org> writes:

>> +#undef write
>> +ssize_t mingw_write(int fd, const void *buf, size_t len)
>> +{
>> +	ssize_t result = write(fd, buf, len);
>> +
>> +	if (result < 0 && errno == EINVAL && buf) {
>> +		/* check if fd is a pipe */
>> +		HANDLE h = (HANDLE) _get_osfhandle(fd);
>> +		if (GetFileType(h) == FILE_TYPE_PIPE)
>> +			errno = EPIPE;
>> +		else
>> +			errno = EINVAL;
>> +	}
>> +
>> +	return result;
>> +}
>> +
>>   int mingw_access(const char *filename, int mode)
>>   {
>>   	wchar_t wfilename[MAX_PATH];
>
> Looks good. I tested the patch, and it fixes the failure exposed by
> t5571.11.
>
> Acked-by: Johannes Sixt <j6t@kdbg.org>
>
> Thanks!

Thanks, both.
