From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] refs.c: use a stringlist for repack_without_refs
Date: Thu, 20 Nov 2014 08:47:06 -0800
Message-ID: <xmqqr3wx4y5x.fsf@gitster.dls.corp.google.com>
References: <1416434088-1472-1-git-send-email-sbeller@google.com>
	<1416434399-2303-1-git-send-email-sbeller@google.com>
	<20141120021540.GF6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, sahlberg@google.com,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 17:47:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrUt1-0006Cs-L5
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 17:47:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756334AbaKTQrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 11:47:11 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61326 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754559AbaKTQrK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 11:47:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0AC681D825;
	Thu, 20 Nov 2014 11:47:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RaeIYmNGaTiGrnGmeo+gF5Pm9uY=; b=FkR1Y4
	paQGOXtN+G5wLPCHJs30xFrKXEMEVOGU4Q8G6qXEgTSZFCYHXAZsNWeC/2itnpmd
	MfGaB02SgcTUs9fKTegg4VKlwyxS9FkfauG2XQN+jFEG/Za4L9AQLFgW8nbgmRtR
	WibZaY3IFMOuBLhVQVJqvJClolDzCoK1mJlu8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KWj9XIY8DQPfG66ZfOwB96WLvwJZKkze
	sHGou8D777YrOFV9Zm0Tv8hcGgSFbQG5ISVNl2HLnb52nf0uSzQzocIaOrLPv6FO
	5iSACi3RerG0bVMsHhhCQWqLzn5IZNvzz50ZS5UuL/rfmiK3nOyDpo0rdoAhpp+h
	0kWzFG2sus8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F26F21D824;
	Thu, 20 Nov 2014 11:47:08 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6F3ED1D823;
	Thu, 20 Nov 2014 11:47:08 -0500 (EST)
In-Reply-To: <20141120021540.GF6527@google.com> (Jonathan Nieder's message of
	"Wed, 19 Nov 2014 18:15:40 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DDCF649A-70D4-11E4-8715-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> [...]
>> +++ b/builtin/remote.c
> [...]
>> @@ -1361,8 +1352,9 @@ static int prune_remote(const char *remote, int dry_run)
>>  			       abbrev_ref(refname, "refs/remotes/"));
>>  	}
>>  
>> -	warn_dangling_symrefs(stdout, dangling_msg, &delete_refs_list);
>> -	string_list_clear(&delete_refs_list, 0);
>> +	sort_string_list(&delete_refs);
>> +	warn_dangling_symrefs(stdout, dangling_msg, &delete_refs);
>> +	string_list_clear(&delete_refs, 0);
>>  
>>  	free_remote_ref_states(&states);
>>  	return result;
>
> Micronit: it would be clearer (and easier to remember to free the list
> in other code paths if this function gains more 'return' statements)
> with the string_list_clear in the same block as other code that frees
> resources (i.e., if the blank line moved one line up).

Thanks for a careful reading.  This kind of attention to detail
helps the longer term health of the codebase.

> The function has to be able to write to 'err' on error, so I think the
> comment doesn't have to mention that err must be non-NULL.  Any caller
> that tries to pass NULL will get an assertion error quickly.

That invites a bit of question, though.

An equally plausible alternative definition for set of API functions
that take strbuf *err is to pass it only when you care about the
explanation of the error (i.e. it is valid for "git cmd --quiet" to
pass NULL there) [*1*] (do we already have such a function?).  And
the comment may help clarifying which is which.  I however think we
shouldn't have mixtures (formatting into "strbuf *err" may be costly
when we know we are asked to fail silently, but an error path is not
usually performance sensitive).


[Footnote]

*1* With yet another one, a function may call error() on its own
when a NULL is passed to strbuf *err, but let's not go there.
