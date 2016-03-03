From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] index-pack: --clone-bundle option
Date: Thu, 03 Mar 2016 15:20:20 -0800
Message-ID: <xmqqbn6v174b.fsf@gitster.mtv.corp.google.com>
References: <xmqq1t7r2x21.fsf@gitster.mtv.corp.google.com>
	<xmqqsi071bw1.fsf@gitster.mtv.corp.google.com>
	<20160303222902.GB26712@sigill.intra.peff.net>
	<xmqqfuw7186z.fsf_-_@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 04 00:20:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abcXl-00081Q-9b
	for gcvg-git-2@plane.gmane.org; Fri, 04 Mar 2016 00:20:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758365AbcCCXUZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2016 18:20:25 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58855 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757954AbcCCXUY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2016 18:20:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1F2E34A2FC;
	Thu,  3 Mar 2016 18:20:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HX/o/m0tpayemw3LR5qYdCPa0Y0=; b=LIu1q8
	4hM2NIZ/wJ1u1VZhb9ib7b5zvoR8xAJN/vDzdyhNN9GE0zR5ntPuQnaIRCd9U6Wd
	IMvfsQeCGEv5aoWf/GDt+RPSbWIQ8kL4U/C+hg8NcvVi3PTjBXiOOBsveImFakN8
	Ud8d1ik/lqDr2Ne57ofUPmvIZiKpw6/+Nn34w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OxdW4JQBcWAFeHrFa6ch6GXesq+IUcOG
	btLAtb4tY1w8ee29xP2OA0WskRVh5igNRgoFQpsbgSevKrR5khmwcddo9mB3PBxX
	GIoXlXBQ58J4XZg4LndIa3ooN7Ve96JauZt/cnGJ2h6ksIhZ8o7gTKpdbbnFrxpq
	OycET/fiiTA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0F9C24A2FB;
	Thu,  3 Mar 2016 18:20:23 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6D2AE4A2F9;
	Thu,  3 Mar 2016 18:20:21 -0500 (EST)
In-Reply-To: <xmqqfuw7186z.fsf_-_@gitster.mtv.corp.google.com> (Junio
	C. Hamano's message of "Thu, 03 Mar 2016 14:57:08 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8010A196-E196-11E5-A763-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288224>

Junio C Hamano <gitster@pobox.com> writes:

> Note that this name choice does not matter very much in the larger
> picture.  As an initial clone that bootstraps from a clone-bundle is
> expected to do a rough equivalent of:
>
>     # create a new repository
>     git init new-repository &&
>     git remote add origin $URL &&
>
>     # prime the object store and anchor the history to temporary
>     # references
>     git fetch $bundle 'refs/*:refs/temporary/*' &&
>
>     # fetch the more recent history from the true origin
>     git fetch origin &&
>     git checkout -f &&
>
>     # remove the temporary refs
>     git for-each-ref -z --format=%(refname) refs/temporary/ |
>     xargs -0 git update-ref -d
>
> the names recorded in the bundle will not really matter to the end
> result.

Actually, the real implementation of "bootstrap with clone-bundle"
is more likely to go like this:

    * The client gets redirected to $name.bndl file, and obtains a
      fairly full $name.pack file by downloading them as static
      files;

    * The client initializes an empty repository;

    * The pack file is stored at .git/objects/pack/pack-$sha1.pack;

    * When the client does a "git fetch origin" to fill the more
      recent part, fetch-pack.c::find_common() would read from the
      "git bundle list-heads $name.bndl" to learn the "reference"
      objects.  These are thrown at rev_list_insert_ref() and are
      advertised as "have"s, just like we advertise objects at the
      tip of refs in alternate repository.

So there will be no refs/temporary/* hierarchy we would need to
worry about cleaning up.

Another possible variant is to redirect the client directly to
download pack-$sha1.pack; "index-pack" needs to be run on the client
side anyway to create pack-$sha1.idx, so at that time it could do
the equivalent of "--clone-bundle" processing (it is not strictly
necessary to create a split bundle) to find the tips of histories,
and use that information when running "git fetch origin".

So, even though I started working from "split bundle", we may not
have to have such a feature after all to support CDN offloadable and
resumable clone.
