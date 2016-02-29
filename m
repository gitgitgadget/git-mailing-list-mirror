From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/7] quote: remove leading space in sq_dequote_step
Date: Mon, 29 Feb 2016 11:01:40 -0800
Message-ID: <xmqqy4a39w8b.fsf@gitster.mtv.corp.google.com>
References: <56D401C2.8020100@moritzneeb.de> <56D40301.8020007@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Moritz Neeb <lists@moritzneeb.de>
X-From: git-owner@vger.kernel.org Mon Feb 29 20:01:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaT4l-0007Cr-U1
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 20:01:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbcB2TBo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 14:01:44 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53480 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750957AbcB2TBn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 14:01:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3F9F147BC0;
	Mon, 29 Feb 2016 14:01:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9GtnV5XKgjsLktvl7a0mZRK+keg=; b=SSY0Zf
	Y/RrNw3XgASfWUX5pMxVdN4C3hq8a8BSqENbS6lkvw6/mMHJCLwrtR9bYXbEPhMp
	iOeP15BprHuudFkSIT7adEsDmEzX5EJVEodoAWJ2mexNU1QXkpKpGue2UNmLoVHf
	uyDrxAI7lY/S1eS2D/5dj4Zfts2Fcgq+ZKMbw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tjpfEElo/NArNbA1DXzy9X0wOSiu4Pda
	ik2K9hptiJqR0rjbjkHoTwAH26zKMqDDKqBiAq/pfzzwTs8hS6Pb3mYiMShyrW0/
	cbcIsLTBQjMcebPBPT7DnwUUwxj5lLtnrHhkTmj9blLolLB4u9WHUahHHJwrT1SF
	Vvt6wJ8vo+w=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 37F4247BBF;
	Mon, 29 Feb 2016 14:01:42 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9D92F47BB9;
	Mon, 29 Feb 2016 14:01:41 -0500 (EST)
In-Reply-To: <56D40301.8020007@moritzneeb.de> (Moritz Neeb's message of "Mon,
	29 Feb 2016 09:36:17 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DE4E19DC-DF16-11E5-A04A-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287870>

Moritz Neeb <lists@moritzneeb.de> writes:

> Because sq_quote_argv adds a leading space (which is expected in trace.c),
> sq_dequote_step should remove this space again, such that the operations
> of quoting and dequoting are inverse of each other.
>
> This patch is preparing the way to remove some excessive trimming
> operation in bisect in the following commit.
>
> Signed-off-by: Moritz Neeb <lists@moritzneeb.de>
> ---
>  quote.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/quote.c b/quote.c
> index fe884d2..2714f27 100644
> --- a/quote.c
> +++ b/quote.c
> @@ -63,6 +63,8 @@ static char *sq_dequote_step(char *arg, char **next)
>  	char *src = arg;
>  	char c;
>  
> +	if (*src == ' ')
> +		src++;
>  	if (*src != '\'')
>  		return NULL;
>  	for (;;) {

If we look at this "for (;;)" loop, we notice that (1) it accepts as
many spaces as there are between two quoted strings, and (2) it does
not limit it to SP but uses isspace().

I wonder if you would instead want

	while (isspace(*src))
        	src++;

to be consistent?
