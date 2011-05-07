From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach checkout the -n|--dry-run option
Date: Sat, 07 May 2011 12:24:50 -0700
Message-ID: <7vfwoqwby5.fsf@alter.siamese.dyndns.org>
References: <4DC47242.6060205@web.de>
 <7vhb97xx5g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sat May 07 21:25:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIn7f-0007O2-V7
	for gcvg-git-2@lo.gmane.org; Sat, 07 May 2011 21:25:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756049Ab1EGTY6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 May 2011 15:24:58 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48659 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756016Ab1EGTY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2011 15:24:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7DCED44CE;
	Sat,  7 May 2011 15:27:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DdPAjcvbQ2azweLqiCGWFwgk7gE=; b=I91Vht
	8IOb6I9AQIpal12m/eO4rQ7+RTOYhUayoDv1lTMGsMuGAvckSmkAADrfJRrWmwQR
	Btep7sW+ua9Vo43tf9GYQkRwcw8F6XvluKkDrMY2pGmaxJfPrNUN8NgLKjRa/C6I
	CZQOtJmp0wieqTfMUf8Di6ha/XAgJKIETfATw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ODeKBEDCV7yzIx18nRvbeS9C2nDppCQ7
	yFp7nexPMszoPoBaC8K1wDIMEl7zxs5WjPYg+EPhlpGoKnn8d0GDoDrfQ3PuK0E5
	+aN9FjRmC85LJYJjkYVk3poK3IV0CVIIF6F5y3G+wNyg+iSXax0R6ULeDOS5p7XV
	WnoDm5tGVo4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 57F7E44CB;
	Sat,  7 May 2011 15:27:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 51E0D44C8; Sat,  7 May 2011
 15:26:57 -0400 (EDT)
In-Reply-To: <7vhb97xx5g.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 06 May 2011 15:49:15 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FAD5202A-78DF-11E0-98D5-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173064>

Junio C Hamano <gitster@pobox.com> writes:

> In other words, can't the check you need in submodule be scripted around
> the specific plumbing responsible for the branch switching, which is:
>
>     $ git read-tree -m HEAD $other_branch
>
>> @@ -397,7 +400,7 @@ static int merge_working_tree(struct checkout_opts *opts,
>>
>>  		/* 2-way merge to the new branch */
>>  		topts.initial_checkout = is_cache_unborn();
>> -		topts.update = 1;
>> +		topts.update = !opts->dry_run;
>>  		topts.merge = 1;
>>  		topts.gently = opts->merge && old->commit;
>>  		topts.verbose_update = !opts->quiet;
>
> What you are doing in this part of your patch is exactly that two-tree
> form of the "read-tree -m", no?

That is, this would succeed:

	$ git reset --hard master
        $ git read-tree --index-output=rubbish -m master next
        
and these would fail:

	$ git reset --hard master
	$ echo >>Makefile
        $ git read-tree --index-output=rubbish -m master next
        error: Entry 'Makefile' not uptodate. Cannot merge.

	$ git reset --hard master
	$ echo >>Makefile
	$ git add Makefile
        $ git read-tree --index-output=rubbish -m master next
        error: Entry 'Makefile' would be overwritten by merge. Cannot merge.

Having said that, please do not discard your patch.  After sleeping on
this, I started to think that "checkout -n" might be a better interface
than using the plumbing read-tree in the longer term, especially if you
can enhance it to handle "checkout -m -n" to check if the local change can
be merged without conflicts.

But if the only question you are interested in is "can I switch to that
branch from the current state of the index and the working tree?", I would
prefer to see if the script can use "read-tree -m" approach first.

We may also want to add "read-tree -n" so that you do not have to specify
a dummy index output only to prevent from writing the real index over,
though.
