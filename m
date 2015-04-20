From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What happen if show_http_message fails to reencode?
Date: Mon, 20 Apr 2015 09:46:43 -0700
Message-ID: <xmqqk2x6n3ws.fsf@gitster.dls.corp.google.com>
References: <CAFT+Tg9x3QfS4c93Bs_Oq0zc7bXvZdFZQAKJFPtqbp6M=Q-P0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: semtlenori@gmail.com
X-From: git-owner@vger.kernel.org Mon Apr 20 18:47:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkEqZ-0001bl-MC
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 18:47:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753539AbbDTQqz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 12:46:55 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62387 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753501AbbDTQqx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 12:46:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6BC6C4892A;
	Mon, 20 Apr 2015 12:46:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XuMtK3BL7MFE+k3Ao/zIBFRtN60=; b=A/nbvz
	dn4/Wk0biQvI3ixSZQqpyNQ9bgSy2IsMPz0GITEDwieIMXSlXihtif9kzCWisZMP
	9QC46+MZLaEmtcCFTy+ZtZ5BQFysWN3MwzVX1X7kF3VREf4WArBNAkj7BRJ1/la6
	q+QuiYSzoKO/H7V6w8dBzHyKnVpZc2ZSLgocE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OoTYmERtB6omHJtprm+HDbPol2jQsxVC
	eI3CVtz9I8KOaiQGSjpSUl7ZLAoUJURYgaaiIHIyvAZNUHnc7OukYmotLEprvzU5
	5dUybkAHhWoKTBe7oOC4c1mDzcJcKBOnPdCQjJg7l5f3PPQYZJ1LlF13Uhy0CioC
	1Y3mdvC1zGM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 65FD948929;
	Mon, 20 Apr 2015 12:46:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7363C48917;
	Mon, 20 Apr 2015 12:46:44 -0400 (EDT)
In-Reply-To: <CAFT+Tg9x3QfS4c93Bs_Oq0zc7bXvZdFZQAKJFPtqbp6M=Q-P0g@mail.gmail.com>
	(EungJun Yi's message of "Mon, 20 Apr 2015 15:29:41 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D3E3E856-E77C-11E4-A8B6-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267477>

"Yi, EungJun" <semtlenori@gmail.com> writes:

> I'm trying to make my git server sends http messages in non-ASCII
> encoding. And I have a question.
>
> At 206-218 in remote-curl.c:
>
>> static int show_http_message(struct strbuf *type, struct strbuf *charset,
>>                  struct strbuf *msg)
>> {
>>     const char *p, *eol;
>>
>>     /*
>>      * We only show text/plain parts, as other types are likely
>>      * to be ugly to look at on the user's terminal.
>>      */
>>     if (strcmp(type->buf, "text/plain"))
>>         return -1;
>>     if (charset->len)
>>         strbuf_reencode(msg, charset->buf, get_log_output_encoding());
>
> What happen if the message has a character which cannot be encoded by
> the encoding defined by i18n.logoutputencoding? Drops only the
> character or brakes the whole message?

I think the implementation of strbuf_reencode() should tell you
quickly, but otherwise it may warrant a sentence or two of
commenting there.  It leaves the msg intact when underlying iconv()
reports that it couldn't reencode, so you should get the original
message literally.
