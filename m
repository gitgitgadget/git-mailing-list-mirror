From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] transport-helper: do not request symbolic refs to remote helpers
Date: Wed, 21 Jan 2015 22:46:48 -0800
Message-ID: <xmqqwq4fuxbb.fsf@gitster.dls.corp.google.com>
References: <1421631307-20669-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, srabbelier@gmail.com
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Jan 22 07:47:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEBY4-000849-0Q
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 07:47:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbbAVGq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 01:46:57 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51954 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750951AbbAVGqz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 01:46:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D9A0B276A0;
	Thu, 22 Jan 2015 01:46:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Rf2o1Fbtx2/vH5THVf4JmpzzxHI=; b=PAETqy
	zATnBf3Ke7nzmJmY7pv/yRQyt0RGJhUIPa1X+4URNqkLQT0sIfJ/W8rq0D00P1L1
	2KOybeLy8lv/rutK9fuhxrRU4Mtid0+c10cUEpRyi69HQx5ACXq3ekyuiggx+UuU
	Sx4bqFAjfz9j/T5+e9Wrxcvi2M4+yt8AlGX9I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UTqz188emTwd7Y8OjVhuUo67PsOw/FRw
	iumJDO5GnVBgCX2NG0KOMTH31WJ7r6Q87DlVHieAg6kp/TEm9/qnjVSntGCGSngP
	5e/+AQlKklcvOhyRyYn9glPRl0xK2glpSzsEX5BC5Y+mAM9Afzo65a+/l3emUIi4
	4a48NSodREw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CFB072769F;
	Thu, 22 Jan 2015 01:46:49 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 570A32769E;
	Thu, 22 Jan 2015 01:46:49 -0500 (EST)
In-Reply-To: <1421631307-20669-1-git-send-email-mh@glandium.org> (Mike
	Hommey's message of "Mon, 19 Jan 2015 10:35:07 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 70C6AA5C-A202-11E4-B72E-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262798>

Mike Hommey <mh@glandium.org> writes:

> A typical remote helper will return a `list` of refs containing a symbolic
> ref HEAD, pointing to, e.g. refs/heads/master. In the case of a clone, all
> the refs are being requested through `fetch` or `import`, including the
> symbolic ref.
>
> While this works properly, in some cases of a fetch, like `git fetch url`
> or `git fetch origin HEAD`, or any fetch command involving a symbolic ref
> without also fetching the corresponding ref it points to, the fetch command
> fails with:
>
>   fatal: bad object 0000000000000000000000000000000000000000
>   error: <remote> did not send all necessary objects
>
> (in the case the remote helper returned '?' values to the `list` command).

Hmph.

Since the most "typical remote helper" I immediately think of is
remote-curl and "git fetch https://code.googlesource.com/git HEAD"
does not seem to fail that way, I am not sure what to make of the
above.  It is unclear if you meant that the above is inherent due to
the way how remote helper protocol works (e.g. there is only one
thing we can associate with a ref and we cannot say "HEAD points at
this commit" at the same time we say "HEAD points at
refs/heads/master"), or just due to broken or lazy implementation of
the remote helpers that are invoked by transport-helper.c interface.

> This is because there is only one ref given to fetch(), and it's not
> further resolved to something at the end of fetch_with_import().

There is no get_refs_list() or something similar involved?
