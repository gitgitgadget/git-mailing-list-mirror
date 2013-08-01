From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 6/6] config: "git config --get-urlmatch" parses section.<url>.key
Date: Thu, 01 Aug 2013 10:25:13 -0700
Message-ID: <7vob9hs4qu.fsf@alter.siamese.dyndns.org>
References: <1375298768-7740-1-git-send-email-gitster@pobox.com>
	<1375298768-7740-7-git-send-email-gitster@pobox.com>
	<20130731224511.GA25882@sigill.intra.peff.net>
	<62E17EDB-B24D-4F37-95F8-E2E26118E5E9@gmail.com>
	<20130731234448.GA8764@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Kyle J. McKay" <mackyle@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 01 19:25:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4wct-0004l6-OR
	for gcvg-git-2@plane.gmane.org; Thu, 01 Aug 2013 19:25:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305Ab3HARZS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Aug 2013 13:25:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43641 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751194Ab3HARZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Aug 2013 13:25:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2183B352C1;
	Thu,  1 Aug 2013 17:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eUHhgOR+pFD4TecVSGegEM3ObXc=; b=dKNEur
	adjEq880h5oqtuh5TTEM0X44G0oQT/XxN48yP6J/fSSYiRMbTDwtT7phhzq+u6+2
	CMkX0G9jVpz4hGvsMyC8hts02jqbiRmplGkWk8njgx0jD01RI0SVeCe/u7jVbSiU
	BxTbRTlnb34750Pq4UjCirO90aLe+7DIX/Zww=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kGraxIw8le7GGC1dhadnDG4Kqp6TOD5/
	C8ScAE2HU5GNUjO+CXSPSNuJckRxLBiwL3ZzLgA7btaAMAt1M79oju6sgBIR2m25
	IL/fSq6RJvQ9AZb/loVGdUMpxu468lp52elVjME/jw9RpqClAlyuQPmfEJ2e3r9m
	1v+qUGpKAxs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 118A0352C0;
	Thu,  1 Aug 2013 17:25:16 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 54194352BE;
	Thu,  1 Aug 2013 17:25:15 +0000 (UTC)
In-Reply-To: <20130731234448.GA8764@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 31 Jul 2013 16:44:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 54453190-FACF-11E2-BB52-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231492>

Jeff King <peff@peff.net> writes:

> That being said, git-config _should_ be lowercasing to match the normal
> --get code path. I think the fix (squashable on top of 6/6 + my earlier
> patch) is just:
>
> diff --git a/builtin/config.c b/builtin/config.c
> index c35c5be..9328a90 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -589,7 +589,9 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>  	}
>  	else if (actions == ACTION_GET_URLMATCH) {
>  		check_argc(argc, 2, 2);
> -		return get_urlmatch(argv[0], argv[1]);
> +		if (git_config_parse_key(argv[0], &key, NULL))
> +			return CONFIG_INVALID_KEY;
> +		return get_urlmatch(key, argv[1]);
>  	}
>  	else if (actions == ACTION_UNSET) {
>  		check_argc(argc, 1, 2);

If we drop the "list every key in section.*" mode, the above should
be sufficient, I think.

I do not know how useful it would be to be for a scripted Porcelain
to be able to ask

    $ git config --get-urlmatch http https://weak.example.com/path/to/git.git

and get all the "http.*" variables that will apply to the given URL.
