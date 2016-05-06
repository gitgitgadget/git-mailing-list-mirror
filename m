From: Junio C Hamano <gitster@pobox.com>
Subject: Re: /* compiler workaround */ - what was the issue?
Date: Fri, 06 May 2016 11:54:21 -0700
Message-ID: <xmqq60ur3tlu.fsf@gitster.mtv.corp.google.com>
References: <AA5B2B1715BAF7438221293187A417A7BDE9D11D@desmdswms002.des.grplnk.net>
	<17E04501C9474282B87758C7998A1F5B@PhilipOakley>
	<xmqqtwic9o88.fsf@gitster.mtv.corp.google.com>
	<CACsJy8CBuU8H8r_f4KsnLkhLtfRv0nDo4hGS31LVn0e1Y_3OAQ@mail.gmail.com>
	<51C902B1F7464CF2B58EB0E495F86BB5@PhilipOakley>
	<572CDCFF.9050607@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Philip Oakley <philipoakley@iee.org>,
	Duy Nguyen <pclouds@gmail.com>, Git List <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Fri May 06 20:54:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayktS-0001IB-B8
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 20:54:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758432AbcEFSy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 14:54:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60790 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758144AbcEFSyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 14:54:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2DBFA17196;
	Fri,  6 May 2016 14:54:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mtuBMAleXwlymE4pYa5lZ+g815M=; b=bxysP5
	yTJlNd5aLBgE/5nBJ6MGM4Na+TCQ2wS8QlxlyokAngVKunTphwQD2g0vLPCMYvm3
	m/UD1fr5r0xFZwZa7hfQ0ZWapFcWopbLYktlqMT5IoI3digQJoBkFZe++/7zzEEn
	pyYuVhEyZUUrNAzfZDGgAekI+pimDf4y904U8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IAZ1CRbX0rmK1ajkOKtObzg9hlM0x7GR
	MLOLTtAqVSDNGpmYMYOFG7r4wctlGlX2kn8E1IJisi57WyNvLjGGcJ16jK99KHYM
	fIKrTC4qZfo/R1r953Xg6AY/QjYHDgBsXMgglsQeGY2qZm5RT2a3qxvd7SB8seOR
	pSjlJJDpO74=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 248D017195;
	Fri,  6 May 2016 14:54:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9A83C17192;
	Fri,  6 May 2016 14:54:23 -0400 (EDT)
In-Reply-To: <572CDCFF.9050607@ramsayjones.plus.com> (Ramsay Jones's message
	of "Fri, 6 May 2016 19:05:51 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F2E79D94-13BB-11E6-B3CE-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293847>

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> The patch below applies to master (I haven't checked for any more
> additions).
>
>  	if (bisect_list) {
> -		int reaches = reaches, all = all;
> +		int reaches = 0, all = 0;

One thing that is somewhat sad is that this makes future readers
wonder if these values '0' are sensible initial values.

Having to wonder "is it sensible to initialize this variable to 0?
Shouldn't it be initialized to INT_MAX instead?" is wasting their
time exactly because we _know_ these are not even "initial values".
We know these do not have to be initialized, because some more
appropriate values will get assigned to them before they are used,
and have these only because some compilers get it wrong.

The original "reaches = reaches" had the documentation value (at
least for those who knew the convention) to save the readers from
wasting their time that way.  Now these 0 are indistinguishable from
the other initializations that require to be zero.

> diff --git a/read-cache.c b/read-cache.c
> index d9fb78b..978d6b6 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1870,7 +1870,7 @@ static int ce_write_entry(git_SHA_CTX *c, int fd, struct cache_entry *ce,
>  {
>  	int size;
>  	struct ondisk_cache_entry *ondisk;
> -	int saved_namelen = saved_namelen; /* compiler workaround */
> +	int saved_namelen = 0;

I wonder if can we come up with a short and sweet notation to remind
futhre readers that this "initialization" is not initializing but
merely squelching warnings from stupid compilers, and agree to use
it consistently?
