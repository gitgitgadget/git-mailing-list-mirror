From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] rerere forget: grok files containing NUL
Date: Tue, 02 Apr 2013 21:03:09 +0200
Message-ID: <515B2B6D.4050801@kdbg.org>
References: <5159FDE4.2090409@kdbg.org> <7vhajpj294.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 21:03:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN6Uh-000692-V7
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 21:03:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761831Ab3DBTDP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 15:03:15 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:14108 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1761551Ab3DBTDO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 15:03:14 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 32C53CDF8D;
	Tue,  2 Apr 2013 21:03:10 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 99C7419F312;
	Tue,  2 Apr 2013 21:03:09 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <7vhajpj294.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219830>

Am 02.04.2013 00:48, schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>> Using 'git rerere forget .' after a merge that involved binary files
>> runs into an infinite loop if the binary file contains a zero byte.
>> Replace a strchrnul by memchr because the former does not make progress
>> as soon as the NUL is encountered.
> 
> Hmph, thanks.
> 
> Is it the right behaviour for rerere to even attempt to interfere
> with a merge that involves binary files in the first place?

Why not? And how could rerere tell the difference? It would have to do
the same check for binary-ness as the merge driver before it even starts
looking closer at the files.

> Does the three-way merge machinery replay recorded resolution for
> such a binary file correctly (after your fix, that is)?

Yes, it does. It recognizes the binary-ness and picks 'our' side. Only
then comes rerere_mem_getline into play.

>> diff --git a/rerere.c b/rerere.c
>> index a6a5cd5..4d940cd 100644
>> --- a/rerere.c
>> +++ b/rerere.c
>> @@ -284,8 +284,10 @@ static int rerere_mem_getline(struct strbuf *sb, struct rerere_io *io_)
>>  	strbuf_release(sb);
>>  	if (!io->input.len)
>>  		return -1;
>> -	ep = strchrnul(io->input.buf, '\n');
>> -	if (*ep == '\n')
>> +	ep = memchr(io->input.buf, '\n', io->input.len);
>> +	if (!ep)
>> +		ep = io->input.buf + io->input.len;
>> +	else if (*ep == '\n')
>>  		ep++;
>>  	len = ep - io->input.buf;
>>  	strbuf_add(sb, io->input.buf, len);
