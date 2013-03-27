From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] log: make "show --show-signature" use gpg.program
 setting
Date: Wed, 27 Mar 2013 08:59:15 -0700
Message-ID: <7vzjxoomuk.fsf@alter.siamese.dyndns.org>
References: <8C726954D36902459248B0627BF2E66F45D7029930@AUSP01VMBX10.collaborationhost.net> <20130325213453.GB19303@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Hans Brigman <hbrigman@openspan.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 27 16:59:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKslR-0005sR-Gt
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 16:59:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752926Ab3C0P7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 11:59:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37880 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752433Ab3C0P7S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 11:59:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C572696E9;
	Wed, 27 Mar 2013 11:59:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SDOvd9SqXy4T1Mya+C1u+TpmNmE=; b=fXI689
	vpxY3dQVvHP6Sx5rIRe2BJrS35ex/QqS4kTirFNtFbP4pPbs59VbbdldEMh54GmS
	TxwvgkPzbSHK/sI0Dg+aorD2l8KpG9FdhBhU5RbtFv+jWoHPOTx2uqneY5NuhAAn
	MHTgzUB/KTJf5pvahl3RUYhsJDiG/gCxqGMrQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D9dKSJ9I0jdaeTaRtrkTwTRcbWkvJEWm
	aSv+ReLi1g19jPER289tbP3g6yAJlyc9fJV/67kmZM+Po26qJdKae7fAOYgt6E5J
	WDwfx4bbzSQ+Pr0Bc1vz6oLgUVFjgMwZPt5uxtRRYUQDjHBMNfVUOumF2R9zSdj/
	ZD1Eqadu+5A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA3C496E8;
	Wed, 27 Mar 2013 11:59:17 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3B90496E6; Wed, 27 Mar 2013
 11:59:17 -0400 (EDT)
In-Reply-To: <20130325213453.GB19303@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 25 Mar 2013 17:34:53 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 47573096-96F7-11E2-BD53-B1692E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219262>

Jeff King <peff@peff.net> writes:

> On Mon, Mar 25, 2013 at 01:03:52PM -0500, Hans Brigman wrote:
>
>> "show --show-signature" doesn't currently use the gpg.program setting.  Commit signing, tag signing, and tag verification currently use this setting properly, so the logic has been added to handle it here as well.
>
> Please wrap your commit messages at something reasonable (70 is probably
> as high as you want to go, given that log output is often shown
> indented).

Thanks for pointing out Documentation/SubmittingPatches.

Also please do not send multipart/mixed (or alternative).  Send
patches in text/plain.

>> @@ -364,7 +365,8 @@ static int git_log_config(const char *var, const char *value, void *cb)
>>  		use_mailmap_config = git_config_bool(var, value);
>>  		return 0;
>>  	}
>> -
>> +	if (!prefixcmp(var, "gpg."))
>> +		return git_gpg_config(var, value, NULL); 
>>  	if (grep_config(var, value, cb) < 0)
>>  		return -1;
>
> The gpg config can also be other places than "gpg.*". Right now it is
> just user.signingkey, which log would not care about, but it feels like
> we are depending an unnecessary detail here. We also don't know whether
> it would care about the callback data. Is there a reason not to do:
>
>   if (git_gpg_config(var, value, cb) < 0)
>           return -1;
>
> just like the grep_config call below?
>
> -Peff
