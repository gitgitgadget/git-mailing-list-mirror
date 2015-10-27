From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 9/9] fetching submodules: Respect `submodule.jobs` config option
Date: Tue, 27 Oct 2015 14:00:24 -0700
Message-ID: <xmqqio5sni1j.fsf@gitster.mtv.corp.google.com>
References: <1445969753-418-1-git-send-email-sbeller@google.com>
	<1445969753-418-10-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jacob.keller@gmail.com, peff@peff.net,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 22:00:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrBMI-0001cH-W5
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 22:00:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965748AbbJ0VAa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 17:00:30 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63617 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965767AbbJ0VA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 17:00:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9B654262B2;
	Tue, 27 Oct 2015 17:00:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ip/xcDhNR8ToT1I1c+UKcNEWivY=; b=pQOaV8
	CbnWG4Kx5tZwDbUf+n6K9CszTiPi8A4Q/5zEtS1qeWwIZidtUPhcohz5EqYBq/Ku
	p5G87KyT6aKX8zvONIP2M2Ioz2toiopWwlWwENy9S3W1aAV0k/rFT+6T3f+O4gN1
	gC7uuVvd+eInmN2yEvC8uOYsL4YCtdCRuZkfE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Tn0R9ouItuACsF9zpySVv3T2aJQc+vkN
	4sOJZHtV3A7ML8XJd46lXHhoaQ4ZCect9IB4S9Cv6/ayNpwtTYmX2DEpv7/qpud+
	zV6rAcEdnkLCltds07a74jRDHfBIrmwfgo9dbGYYM4LvJU8lZQR6TgJB9ITLFg6G
	fdj+BPZQZEk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9326A262AC;
	Tue, 27 Oct 2015 17:00:25 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0C4AC2629E;
	Tue, 27 Oct 2015 17:00:25 -0400 (EDT)
In-Reply-To: <1445969753-418-10-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 27 Oct 2015 11:15:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BE9679B2-7CED-11E5-A229-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280297>

Stefan Beller <sbeller@google.com> writes:

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 315f271..0b733d7 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2575,6 +2575,13 @@ submodule.<name>.ignore::
>  	"--ignore-submodules" option. The 'git submodule' commands are not
>  	affected by this setting.
>  
> +submodule::jobs

Did you mean this?

    submodule.jobs::

> +	This is used to determine how many submodules can be operated on in
> +	parallel. Specifying a positive integer allows up to that number
> +	of submodules being fetched in parallel. Specifying 0 the number
> +	of cpus will be taken as the maximum number. Currently this is
> +	used in fetch and clone operations only.
> +

You probably do not want to say "Currently this is" (you may still
want "only", though).  Whoever teaches other codepaths to pay
attention to the variable would update this as long as the
documentation stays current.

By the way, I doubt that "0 means num-CPUs" is a useful default for
parallelism that is used to help anything that is not CPU bound;
"clone", "submodule update", etc. are dominantly network bound, and
then disk I/O bound (especially if you are cloning from local disk).
I'd rather see "-j 0" to error out as "reserved for future use",
until we figure out what the useful default is, and then "-j 0" can
start using that default that is more useful than num_cpu.
