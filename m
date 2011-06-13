From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i -p: doesn't pick certain merge commits that
 are children of "upstream"
Date: Mon, 13 Jun 2011 09:01:40 -0700
Message-ID: <7vmxhlpvob.fsf@alter.siamese.dyndns.org>
References: <4DEB495F.9080900@kdbg.org>
 <1307419725-4470-1-git-send-email-andrew.kw.w@gmail.com>
 <1307419725-4470-2-git-send-email-andrew.kw.w@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stephen Haberman <stephen@exigencecorp.com>
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 13 18:01:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QW9aO-0003P8-3e
	for gcvg-git-2@lo.gmane.org; Mon, 13 Jun 2011 18:01:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752158Ab1FMQBv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2011 12:01:51 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54719 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285Ab1FMQBu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2011 12:01:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8FF624E07;
	Mon, 13 Jun 2011 12:03:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BEefybzE+BZSr/xivcTVsQ6sI2M=; b=yZzzqM
	OcTCPhM1ccfp4iqFg1fUBhoDIx9dn3iH7RltfFP0uZY2njF1+vIMkepk6S2zSgH+
	p1HqTVxuIP5sj6U/msYdwA4gn0IBnlUiO7InX7Yz+nVJHFsuQw2gda2TxxWMdh/H
	Ttdb54DXpeCeiZdIhwSBk66/3Y1GjNIJ/WevI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T8vZ9XSZRoR2IVFWu20ubYox0SZEw6d6
	Q2eMICKLSxkan6U+DO6qbSSu0L/8a2oNB6GP3U+AowEJlLGnnrc0v1hwb4HiNXFj
	0s45GiMMSMNt1roCzSD/5yPY0Dn64C2iUQj7G428yqWPmGWXbtaRgH0cF+9TdOKe
	+y9gCYJpgbM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5E3854E05;
	Mon, 13 Jun 2011 12:03:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3CDCD4E04; Mon, 13 Jun 2011
 12:03:51 -0400 (EDT)
In-Reply-To: <1307419725-4470-2-git-send-email-andrew.kw.w@gmail.com> (Andrew
 Wong's message of "Tue, 7 Jun 2011 00:08:45 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BDEA900A-95D6-11E0-BADD-C8CFB7AE1C3C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175717>

Andrew Wong <andrew.kw.w@gmail.com> writes:

> This patch fixes the inconsistency and bug by ensuring that all children
> of upstream are always picked.  This essentially reverts the commit:
>
>   d80d6bc (rebase-i-p: do not include non-first-parent commits touching UPSTREAM, 2008-10-15)

... whose commit log message mumbles about somebody's script but came with
no tests, so we will not know if this is breaking the other guy's workflow
while adding support to yours (Cc'ed Stephen Haberman who wrote the
previous one).

>  
> +test_expect_success '' '

There is no title to this test?

> +	(
> +	cd clone4 &&
> +	git fetch &&
> +	git rebase -p HEAD^2 &&
> +	test 1 = $(git rev-list --all --pretty=oneline | grep "Modify A" | wc -l) &&
> +	test 1 = $(git rev-list --all --pretty=oneline | grep "Modify B" | wc -l) &&
> +	test 1 = $(git rev-list --all --pretty=oneline | grep "Merge remote-tracking branch " | wc -l)
> +	)
> +'
> +
>  test_done

In general I think it is wrong to change behaviour depending on which
parent of a merge we are looking at (unless of course the user tells us
to, like "git log --first-parent"), so in that sense philosophically I
think the patch is going in the right direction, but I do worry about
potential regressions.
