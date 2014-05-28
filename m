From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git diff --(src|dst)-prefix=// causes spurious "(new|deleted) file mode"
Date: Wed, 28 May 2014 10:29:22 -0700
Message-ID: <xmqq38fterrh.fsf@gitster.dls.corp.google.com>
References: <CAM-tV-9vQPPj+TemYnzjRMTjaHqwo3qq=WWJ89VnRMAeYXHZZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Noam Postavsky <npostavs@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Wed May 28 19:29:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WphfR-0001xa-CG
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 19:29:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752561AbaE1R33 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 13:29:29 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55817 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752080AbaE1R32 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 13:29:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B43B41A41F;
	Wed, 28 May 2014 13:29:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mtC33SKsjKBEY64wpX0dV25BMC4=; b=k1EOi1
	Gj8KvTYBh7nk2cnaSEpan0i4GoheSuomMq0GTDcKe/tbo1f5Qt2CtG6zm7N57lyv
	XTuyfNMsE7x3eImLagyi464o1iQPU6KT73IPMq3x6zrXkuYhzHdJmz1Vl/qZG5GB
	+Bs+yfsTsbl4yeskMKnFdR19p6rq17myflIME=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LMcU9Ru4BjM5f4Dyfn7GtYRao2d1IkNH
	jrKJHJsuUjR7/i1ttcr+7dnpvSTWzMUzW6FaPQRxUPqrUy/khXvmP6r2Wp9yU7Ha
	RZvqFW188ZOKHvWK2j/h8CY++DtijGiYGJRC9DmpSFHRH4jR+AtIlyASFwm+xm7P
	3O8QHkDNOy4=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AA4D31A41E;
	Wed, 28 May 2014 13:29:27 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4FC511A41A;
	Wed, 28 May 2014 13:29:24 -0400 (EDT)
In-Reply-To: <CAM-tV-9vQPPj+TemYnzjRMTjaHqwo3qq=WWJ89VnRMAeYXHZZw@mail.gmail.com>
	(Noam Postavsky's message of "Tue, 27 May 2014 21:55:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9C9A0EA2-E68D-11E3-9E28-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250300>

Noam Postavsky <npostavs@users.sourceforge.net> writes:

> % git init
> Initialized empty Git repository in /home/npostavs/tmp/scratch/.git/
> % echo foo > x
> % git add x
> % git commit -m x
> [master (root-commit) 41be1f2] x
>  1 file changed, 1 insertion(+)
>  create mode 100644 x
> % echo bar > x
> % git diff  | head -3
> diff --git i/x w/x
> index 257cc56..5716ca5 100644
> --- i/x
> % git diff --dst-prefix=// | head -3
> diff --git i/x //x

The feature these options implement was never designed to accept
anything other than "foo/bar/" (i.e. a relative path-looking thing
that ends with "/" and no funnies such as duplicated slashes, in
order to replace the standard "a/" and "b/").  I think the command
line parsing code of src/dst-prefix trusts the user too much not to
feed nonsense like the above.  They may want to be tightened.

> Background: trying to find a prefix that can't show up in file names
> in order to make parsing easier.
> https://github.com/magit/magit/pull/1379
> https://github.com/magit/magit/pull/1383

It may be worth studying how "git apply" finds what the paths are
and use the same rule for consistency.  IIRC, the rules are roughly:

 - In a renaming/copying patch, you will have "rename/copy from/to"
   header separately.  There is no need to parse the "diff --git"
   line at all;

 - Otherwise, you will have "a/SOMETHING b/SOMETHING" (SOMETHING are
   repeated because there is no rename involved).
