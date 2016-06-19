Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 861EC20189
	for <e@80x24.org>; Sun, 19 Jun 2016 18:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751676AbcFSSAb (ORCPT <rfc822;e@80x24.org>);
	Sun, 19 Jun 2016 14:00:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55327 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751454AbcFSSAa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2016 14:00:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6F1DF24B23;
	Sun, 19 Jun 2016 13:59:32 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C1395NG3LiXDOdeW0fQsiUz9biM=; b=b7Xlhd
	SxjHQAfOs3itMEPoKwe/O0mFenJ7fMWH0CFhC8GfjRxL7Icx4KZ0GjmYIv+o5SEf
	GrwZGLpbAZ67XYJ85/zMY6v7amsBXJxCup01wZfsi4i4G1HyGK4kKMeWJLsdAGBt
	RloGs8ihZH6//ft1NU3PU5p1QH/O33oQp8HFs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eKJDjC8S1AHqBVQvjcqD6SAeTkfhBHB/
	BDqzbd7IcU386o2AZAVTfhPBwfHUDfb+uQoA47snuboPj43zuFZGZKv3aVaVfaMZ
	AIxQYz2ewmKy4GAEzMWtQOEfGdoaDa+OVrDPVMOnwTDXSiO0b2YDPvYdNW10veIw
	+IsvpF/GKHo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5B6ED24B22;
	Sun, 19 Jun 2016 13:59:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C887D24B21;
	Sun, 19 Jun 2016 13:59:31 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	LE Manh Cuong <cuong.manhle.vn@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH] git-sh-setup.sh: fix missing double quotes variables
References: <xmqqshwax8ah.fsf@gitster.mtv.corp.google.com>
	<20160619024554.2983-1-cuong.manhle.vn@gmail.com>
	<xmqqinx5yijm.fsf@gitster.mtv.corp.google.com>
Date:	Sun, 19 Jun 2016 10:59:29 -0700
In-Reply-To: <xmqqinx5yijm.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Sat, 18 Jun 2016 20:16:45 -0700")
Message-ID: <xmqqvb15vz3y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 93017874-3647-11E6-9B33-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> LE Manh Cuong <cuong.manhle.vn@gmail.com> writes:
>
>> It's not only people shooting their foot, but also from malicious user.
>> Given that `curl url | sudo sh/bash` is often found in many instructions,
>> an end user may not be noticed about the environment variable injection
>> from their side.
>>
>> IMHO, it's better if  git can protect the end users in this situation.
>
> Huh?  For those who run `curl url | sudo sh`, I do not think the
> incoming script setting and exporting LV to an arbitrary value and
> runing Git is not the top thing they need worry about.
>
> While I think enclosing the string in dq is an improvement (as I
> said already), I still do think your use of the v-word is making a
> mountain out of an anthill.

I failed to say why I found the dq is an improvement, but that
should be in the log message of this commit.  Off the top of my
head, something like:

	We often make sure an environment variable is set to
	something, either set by the user (in which case we do not
	molest it) or set it to our default value (otherwise), with

		: ${VAR=default value}

	i.e. running the no-op command ":" with ${VAR} as its
	parameters (or the default value we supply), relying on that
	":" is a no-op.

	This pattern, even though it is no-op from correctness point
	of view, still can be expensive if the existing value in VAR
	has shell glob (because they will be expanded against
	filesystem entities) and IFS whitespaces (because the value
	need to be split into multiple parameters).  Our invocation
	of ":" command does not care if the parameter given to it is
	after the value in VAR goes through these processing.

	Enclosing the whole thing in double-quote, i.e.

		: "${VAR=default value}"

	avoids paying the unnecessary cost, so let's do so.

