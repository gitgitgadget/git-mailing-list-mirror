From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/45] parse_pathspec and :(glob) magic
Date: Thu, 21 Mar 2013 10:28:41 -0700
Message-ID: <7v4ng4br1y.fsf@alter.siamese.dyndns.org>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
 <1363781779-14947-1-git-send-email-pclouds@gmail.com>
 <7v1ubaeyph.fsf@alter.siamese.dyndns.org>
 <20130321053326.GA17446@duynguyen-vnpc.dek-tpc.internal>
 <20130321054349.GA18101@duynguyen-vnpc.dek-tpc.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 21 18:29:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIjIe-0002Lv-J6
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 18:29:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362Ab3CUR2p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 13:28:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52017 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751206Ab3CUR2o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 13:28:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B4313A81F;
	Thu, 21 Mar 2013 13:28:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1hqTHZ6LFMjLXNu1fAvCZrkhk5Q=; b=dMwPwC
	TTZedLzTarayaEJ2CJfm+mimbRS2Zqjme+mVZ3K0aDKgyueH0kcqTdzJxBm18PH7
	AiV0CNmSRbgLjlmsFspLYJ6B8Z08CtN7SuAXuJwky9iTEVVSc9ZIAz8B/+ELMljE
	Eze8CUFh1bPGkeluOUmqTVONq9MbponL/zzLA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Piia3mkfScoQjYROEGJsyTSG01iAxDZf
	iiWpYgJ2vU3QFkfDYOWycxaCSYY1LSqMnTqGi8snQa3W1xFac4S/BiJ2qXMJTmYE
	8jWP9eVW93cb5TaBEzRfKyp/efHJUk3B/Zc30BgAZFMryj1ykxVnTR1JSEIIOYlC
	yhxjMF9m/w0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A4DB0A81E;
	Thu, 21 Mar 2013 13:28:43 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 16C03A81C; Thu, 21 Mar 2013
 13:28:43 -0400 (EDT)
In-Reply-To: <20130321054349.GA18101@duynguyen-vnpc.dek-tpc.internal> (Duy
 Nguyen's message of "Thu, 21 Mar 2013 12:43:49 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C728521E-924C-11E2-B4BA-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218744>

Duy Nguyen <pclouds@gmail.com> writes:

>> I still can't reproduce it. But I think I found a bug that
>> miscalculates prefix length from absolute paths. Does this "fix" your
>> test?
>>  ...
> Nope, that one could cause more crashes. Try this
>
> -- 8< --
> diff --git a/setup.c b/setup.c
> index 3584f22..3d8eb97 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -14,6 +14,8 @@ char *prefix_path_gently(const char *prefix, int *p_len, const char *path)
>  		const char *temp = real_path(path);
>  		sanitized = xmalloc(len + strlen(temp) + 1);
>  		strcpy(sanitized, temp);
> +		if (p_len)
> +			*p_len = 0;

Yes, this one seems to. "$(pwd)/../src" was not handled correctly.

The callchain to this locaiton would look like

	parse_pathspec() with prefix="docs/", prefixlen set to 5
        -> prefix_pathspec(), &prefixlen passed down
          -> prefix_path_gently(), p_len points at the above prefixlen
	     your "this should fix" patch sets *p_len to 0,
             original leaves *p_len as 5.
             -> normalize_path_copy_len() with p_len
	        *p_len is used here.

Why could the test pass for you without it?  It doesn't look like a
bug that depended on uninitialized memory or something from the
above observation.
