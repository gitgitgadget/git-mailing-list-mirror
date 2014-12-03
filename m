From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] rerere: error out on autoupdate failure
Date: Wed, 03 Dec 2014 09:34:33 -0800
Message-ID: <xmqqy4qoiqmu.fsf@gitster.dls.corp.google.com>
References: <20141203042049.GI6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 18:34:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwDp4-0007BD-FW
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 18:34:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbaLCRei (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 12:34:38 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50845 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751173AbaLCReg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 12:34:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0852721EBE;
	Wed,  3 Dec 2014 12:34:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=piB2ZHSz89WaIgD8s9QQz+OUKyg=; b=SDwYD8
	3Rrb3OxSsozkeEYvo2Kn1abOvXmFbrPy0OP5fAKtcpJBZ086V5r26RgUsgCSpt8l
	pM1r5IfM2G6MwrXLEq1gcQaJ5Nlqwb7kYNLu2A+LS0gD9StHwp5cdjAm0Udruje3
	5RXbvNyPczzU+BfzBYcy/1AfxIbMjxXx6f6Ok=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OkjVa2mxQ9GO5aFn5TBtGpnsE7+CXRqC
	6omgVG0xx4H+4JHxJu1a3IFLYRumJOrzOGZIGwtcGTumCG2tIUwKMszHFhTkJxY7
	Ad4vY3+4Rt3DTfRg7DrNlowLPnUfedjnUbz9qvT0kUeUQQbpfMibvZEPb/KUPcpy
	6zfCA7S/LYc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F06BA21EBD;
	Wed,  3 Dec 2014 12:34:35 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 821D721EBC;
	Wed,  3 Dec 2014 12:34:35 -0500 (EST)
In-Reply-To: <20141203042049.GI6527@google.com> (Jonathan Nieder's message of
	"Tue, 2 Dec 2014 20:20:49 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A62B0D9E-7B12-11E4-BE98-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260668>

Jonathan Nieder <jrnieder@gmail.com> writes:

> We have been silently tolerating errors by returning early with an
> error that the caller ignores since rerere.autoupdate was introduced
> in v1.6.0-rc0~120^2 (2008-06-22).  So on error (for example if the
> index is already locked), rerere can return success silently without
> updating the index or with only some items in the index updated.
>
> Better to treat such failures as a fatal error so the operator can
> figure out what is wrong and fix it.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> I ran into this while auditing hold_locked_index callers.  Tests
> still pass after this change.  Sensible?

I think what the change wants to do is sensible, but "tests still
pass" probably does not tell us very much.  You'd need a competing
writers (e.g. in real life a human user may open two terminals and
try to do things in the same repository from both terminals without
realizing that she is stomping on herself), which is expected to
break in unexpected ways ;-), which is not something the existing
tests would try to catch anyway.

>  rerere.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/rerere.c b/rerere.c
> index 1b0555f..195f663 100644
> --- a/rerere.c
> +++ b/rerere.c
> @@ -477,27 +477,23 @@ out:
>  
>  static struct lock_file index_lock;
>  
> -static int update_paths(struct string_list *update)
> +static void update_paths(struct string_list *update)
>  {
>  	int i;
> -	int fd = hold_locked_index(&index_lock, 0);
> -	int status = 0;
>  
> -	if (fd < 0)
> -		return -1;
> +	hold_locked_index(&index_lock, 1);
>  
>  	for (i = 0; i < update->nr; i++) {
>  		struct string_list_item *item = &update->items[i];
>  		if (add_file_to_cache(item->string, ADD_CACHE_IGNORE_ERRORS))
> -			status = -1;
> +			die("staging updated %s failed", item->string);

Instead of crafting a new message, why not just stop passing IGNORE_ERRORS
and have add_file_to_cache() report the failure?  That is:

	if (add_file_to_cache(item->string, 0))
        	return -1;

That way, the user will get more useful diagnosis because there are
different reasons why an "add" may fail and we give different error
messages to them.
