From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Introduce the GIT_HOME environment variable
Date: Sat, 19 Dec 2009 11:21:57 -0800
Message-ID: <7vhbrmahwq.fsf@alter.siamese.dyndns.org>
References: <4B2C0828.4010505@signalbeam.net>
 <20091219013246.GD25474@genesis.frugalware.org>
 <7vhbrnodd9.fsf@alter.siamese.dyndns.org> <4B2C5A1A.8000201@signalbeam.net>
 <7vzl5fik3o.fsf@alter.siamese.dyndns.org>
 <20091219153046.GG25474@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Moe <moe@signalbeam.net>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Dec 19 20:22:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NM4sZ-0000hR-OU
	for gcvg-git-2@lo.gmane.org; Sat, 19 Dec 2009 20:22:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753234AbZLSTWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2009 14:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753188AbZLSTWK
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Dec 2009 14:22:10 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64883 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752992AbZLSTWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2009 14:22:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A9387893B6;
	Sat, 19 Dec 2009 14:22:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=VkzdxlggK1ZBV1vUi0minjFRtoQ=; b=LHV0ogFfeRYofzBfK6aSxXh
	b3Gc2GJyqy1XL3EQeTXc5LgxvQDwucS7Cr0ncQnD7PUVTWkFAkibpKaBZfzPN/Wo
	ipu5pW0ncrXR+bEtxpJmWmS+OVrLhQqLWPlnhhkShRa1ji6dX6WhImA8beH9s90G
	5yPcN69sca0ubkpotUvw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=yiGqELeKYBecyG7Zv5QzpSsUEz7KEiAVZmI2UEtgkqCZ+k00I
	0lEa3IWba6sxxLsebvmgHGSieNmJBAXeXFhvKIY/4ma+TCtBZmdQImZ5Poc69/EO
	Ktn/TobMlvK4pWZjhs3/8N0ZO3ZV3iFJ/4UQkcHXal02sybMa5UHyMhiGQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 74045893B5;
	Sat, 19 Dec 2009 14:22:03 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A1EE6893B1; Sat, 19 Dec
 2009 14:21:59 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C9BAACEC-ECD3-11DE-807E-DC0DEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135497>

Miklos Vajna <vmiklos@frugalware.org> writes:

> diff --git a/builtin-config.c b/builtin-config.c
> index a2d656e..da9ebd4 100644
> --- a/builtin-config.c
> +++ b/builtin-config.c
> @@ -146,7 +146,9 @@ static int get_value(const char *key_, const char *regex_)
>  
>  	local = config_exclusive_filename;
>  	if (!local) {
> -		const char *home = getenv("HOME");
> +		const char *home = getenv("GIT_HOME");
> +		if (!home)
> +			home = getenv("HOME");

If you introduce a helper like this:

	const char *git_custom_home(void)
        {
        	const char *val = getenv("GIT_HOME");
                if (!val)
                	val = getenv("HOME");
		return val;
	}

then a mechanical s/getenv("GIT_HOME")/gitcustom_home()/; will make the
resulting code a lot simpler and a new callsite somebody may add in the
future would not have to duplicate three lines.

But I sense that Moe is retracting his claim that the unmodified git
doesn't do what he needs to do, after Dscho suggested to use more specific
environment variables to the task at hand?
