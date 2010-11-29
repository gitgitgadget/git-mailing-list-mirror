From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH updated] Fallback on _NSGetExecutablePath to get the
 executable path if using argv[0] fails
Date: Mon, 29 Nov 2010 12:24:28 -0800
Message-ID: <7veia32803.fsf@alter.siamese.dyndns.org>
References: <051964C9-0507-4CCB-A111-55CA36652F00@apple.com>
 <AANLkTimwRJqje1-HhzKj-L-5-2CvhTC0+Pr0Cvj7d_kc@mail.gmail.com>
 <20101129171211.GL8037@burratino>
 <DD9829B7-8851-41CF-BCC6-2676B6015028@apple.com>
 <20101129184929.GA9441@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeremy Huddleston <jeremyhu@apple.com>,
	Thiago Farina <tfransosi@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 29 21:24:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNAHJ-0001ur-H2
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 21:24:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753491Ab0K2UYk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 15:24:40 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48883 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939Ab0K2UYk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 15:24:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6A614379E;
	Mon, 29 Nov 2010 15:24:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=DRolwG81yL7yZ8dYR9XYBgyrHRY=; b=e1k0wdfogTCyctlVaY90BHZ
	81KAevEZCoH79QRxokxnlO4/EprlV0U0W22BBs6jcUWwyMHm6Y53ZXzr3W5qVV9t
	bZrjSh1cahd65B47FtSA4o4c9G0ivicAMAWdqXrp/12FhvazkW0lnsSRNwYla78M
	09TVHZjyevJEFr6G5u8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=r3xTJJ2vCac1kJEbA6lsc17Lq04LMtZFOW5sBuECWCr2w/lMx
	UheJgfXUY6EY6P1PWbdGhTEqJ5os6LqFYR1gpSXkXKUlhAmtTpBLcs4V+HOO+App
	1exUlFXoF8PeXLwOt8jeJTqCxXTU/03qUOp7hsrzuEj7ziGBU9tlYdITOo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1FAC9379A;
	Mon, 29 Nov 2010 15:24:53 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5A5253798; Mon, 29 Nov 2010
 15:24:47 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B920A5F2-FBF6-11DF-8191-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162428>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> --- a/exec_cmd.c
>> +++ b/exec_cmd.c
> [...]
>> @@ -53,6 +57,19 @@ const char *git_extract_argv0_path(const char *argv0)
>>  	if (slash >= argv0) {
>>  		argv0_path = xstrndup(argv0, slash - argv0);
>>  		return slash + 1;
>> +#if defined(__APPLE__)
>> +	} else {
>> +		char new_argv0[PATH_MAX];
>> +		uint32_t new_argv0_s = PATH_MAX;
>> +		if(_NSGetExecutablePath(new_argv0, &new_argv0_s) == 0) {
>> +			slash = new_argv0 + strlen(new_argv0);
>> +			while (new_argv0 <= slash && !is_dir_sep(*slash))
>> +		                slash--;
>> +
>> +			if (slash >= new_argv0)
>> +				argv0_path = xstrndup(new_argv0, slash - new_argv0);
>> +		}
>> +#endif
>
> Can't this ifdef be avoided?  The ideal is for such code to be
> abstracted away into helper functions in git-compat-util.h and compat/*.c.

I had exactly the same reaction.  Also doesn't the above need to be
protected by defined(RUNTIME_PREFIX), too?
