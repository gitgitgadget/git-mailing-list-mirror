From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] fetch/pull: Don't recurse into a submodule when
 commits are already present
Date: Wed, 23 Feb 2011 15:21:53 -0800
Message-ID: <7vaahm5oby.fsf@alter.siamese.dyndns.org>
References: <4D656F25.5090007@web.de> <4D656FC7.2060201@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Kevin Ballard <kevin@sb.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Feb 24 00:22:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsO2D-0002vv-1B
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 00:22:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754544Ab1BWXWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 18:22:11 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46721 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753982Ab1BWXWK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 18:22:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BBCDB4420;
	Wed, 23 Feb 2011 18:23:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hTPQn+EvAvdz/IVp/NNG/PoqD1o=; b=ku+lfz
	zpGBeoosAwzedBnwmUDPNQ0MRrb0fHZKPcJThOb9ovhdMvzemYqvRrc2EDaQMakP
	KZ15NfJZOcmF4vxBafUI483+90vDYwaD3ykR1jhEV2QNqXmtUbYusQBMlvrpSOWB
	9n7YErXx1bkCMji7zjVREn9ppmWSXY8ZqBLtg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CHiFS3BM4+MA6uMbqQbljh0XniU755au
	wLZhNKFu9LlV54v8MEWCNwa9M5Fq/6IS/13olq5ltn2hhRA3H0g4nREtiOCncFBQ
	qhWHeIfYPOWB0aWiVJsGRv3koJkSUEoWTXPIGPKTEgSi1I4OJW3RzFT/MW30fRUX
	Ont6lN7IzVU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5858B441C;
	Wed, 23 Feb 2011 18:23:15 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8D5724417; Wed, 23 Feb 2011
 18:23:07 -0500 (EST)
In-Reply-To: <4D656FC7.2060201@web.de> (Jens Lehmann's message of "Wed\, 23
 Feb 2011 21\:36\:23 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E3AF14C0-3FA3-11E0-9412-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167740>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> diff --git a/submodule.c b/submodule.c
> index b477c3c..ddb0a29 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -263,6 +263,13 @@ void set_config_fetch_recurse_submodules(int value)
>  	config_fetch_recurse_submodules = value;
>  }
>
> +static int is_submodule_commit_present(const char *path, unsigned char sha1[20])
> +{
> +	if (!add_submodule_odb(path))
> +		return lookup_commit_reference(sha1) != 0;
> +	return 0;
> +}

Don't you need to prove the usual "reachabile from the refs" here, instead
of just the presense of a commit object?

If not, why not?
