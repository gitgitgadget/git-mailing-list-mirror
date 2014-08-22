From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] upload-pack: keep poll(2)'s timeout to -1
Date: Fri, 22 Aug 2014 08:56:12 -0700
Message-ID: <xmqqr408plgj.fsf@gitster.dls.corp.google.com>
References: <20140822151911.GA8531@debian> <20140822154445.GA19135@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Edward Thomson <ethomson@edwardthomson.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 22 17:56:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKrCa-0008UR-VQ
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 17:56:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbaHVP43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2014 11:56:29 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50486 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932293AbaHVP4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2014 11:56:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 87F31323E4;
	Fri, 22 Aug 2014 11:56:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=H5m8KxYD3BUnlDY7MdbHb1DO4ng=; b=mWPCAu
	IzbOTSlT3Q+OWmexEuCl09Oc0+unATTiN87ERYBSi01VkD+MXetuIaPdwpBt4xJU
	09aTbB5RTvXX8w52JfUc+JCv3iHm6VoZAI0Ppu7FDmho+ya1GXbFcMktfjGqqVcO
	Eoqdxiq5PYbLHDhTiM3yNL1irbyfZmFgqG3BA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hRt3c2dqWQfR17I9taUGOFfuNY0AYXS7
	E69e+F6n20JgTT1NDVeTjf8o5OJWfdxHLkjm/5JkDaYAztMXkGw2vhfrC3aHQDl5
	boYYg5iHBJSZE9hqc0c4aZAeFXR4DllQ+fa7u1eV6CSF4JZFLp39mx14XZLtop0k
	mjkgZ1QkuTg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7EC5C323E2;
	Fri, 22 Aug 2014 11:56:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8EADC323CB;
	Fri, 22 Aug 2014 11:56:14 -0400 (EDT)
In-Reply-To: <20140822154445.GA19135@peff.net> (Jeff King's message of "Fri,
	22 Aug 2014 11:44:45 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D861EE4E-2A14-11E4-983E-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255680>

Jeff King <peff@peff.net> writes:

> Since we're now translating the keepalive value, and since there's no
> way to set it to "0" (nor would that really have any meaning), I guess
> we could switch the internal "no keepalive" value to 0, and do:
>
>   ret = poll(pfd, pollsize, keepalive ? 1000 * keepalive : -1);
>
> which would let us avoid setting it to -1 in some other spots.  I dunno
> if that actually makes a real difference to maintainability, though.

Where we parse and set the value of the variable, we do this:

	else if (!strcmp("uploadpack.keepalive", var)) {
		keepalive = git_config_int(var, value);
		if (!keepalive)
			keepalive = -1;
	}

The condition may have to become "if (keepalive <= 0)".

> Either way:
>
>   Acked-by: Jeff King <peff@peff.net>
>
> -Peff

Yeah, either way, the patch as-posted is good.  Thanks.
