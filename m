From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] use write_str_in_full helper to avoid literal string
 lengths
Date: Sat, 12 Sep 2009 16:56:59 -0700
Message-ID: <7veiqbbttg.fsf@alter.siamese.dyndns.org>
References: <87skes35mf.fsf@meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Sun Sep 13 01:57:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmcT3-0002dC-5E
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 01:57:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752422AbZILX5H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 19:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752247AbZILX5G
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 19:57:06 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37918 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393AbZILX5G (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2009 19:57:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 12A5F303F4;
	Sat, 12 Sep 2009 19:57:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=31cUxAO2VDzegL0E5rnwvJzZc7M=; b=bL1QYU
	2C5s1VZJUv0Y/FRhFeyLtxk+I41xEGt44ayhIic0x6Mhwcoo5AQDxzkVI6d9nC3u
	DlJEWcZcYj2Y0vORjk+dmarNjLXV9z2s2tkf4mlsLZC8wujavUJ7hTqlqEN3uDsY
	L5FHCEK8Z85fA6FOAtzqMMSHaeXlODx8y/miU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qAcWfq1QE7/myEusOzkN6XBbsAh8gM8P
	moRcIfvnxBPAph/u1HfXQgIroSTsDsR89iVJsWQEWXvhKEiWYui5mhgOG3dkmZ3r
	aek4rRcEuI5hR3J+aIYvfExUgLFriVYEsoPYG/xDZeEwK1olRo3faC7OfXdaGLDO
	dyMzdCDx1wo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EB19F303EF;
	Sat, 12 Sep 2009 19:57:04 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3FBC9303EB; Sat, 12 Sep
 2009 19:57:01 -0400 (EDT)
In-Reply-To: <87skes35mf.fsf@meyering.net> (Jim Meyering's message of "Sat\,
 12 Sep 2009 10\:54\:32 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F8E7A944-9FF7-11DE-945F-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128315>

Jim Meyering <jim@meyering.net> writes:

>  ...Thus not requiring the added allocation, and still avoiding
> the maintenance risk of literal string lengths.
> These days, compilers are good enough that strlen("literal")
> imposes no run-time cost.
>
> Transformed via this:
>
>     perl -pi -e \
>         's/write_in_full\((.*?), (".*?"), \d+\)/write_str_in_full($1, $2)/'\
>       $(git grep -l 'write_in_full.*"')
>
>
> From fe368f8b3720f04c9dfce952711d2fb412b52e3c Mon Sep 17 00:00:00 2001
> From: Jim Meyering <meyering@redhat.com>
> Date: Sat, 12 Sep 2009 09:56:13 +0200
> Subject: [PATCH] use write_str_in_full helper to avoid literal string lengths
>
> * cache.h (write_str_in_full): Define function.
> * builtin-fetch.c (quickfetch): Use it.
> * builtin-reflog.c (expire_reflog): Likewise.
> * commit.c (write_shallow_commits): Likewise.
> * config.c (git_config_set_multivar): Likewise.
> * rerere.c (write_rr): Likewise.
> * transport-helper.c (get_helper, disconnect_helper): Likewise.
> (get_refs_list): Likewise.
> * upload-pack.c (receive_needs): Likewise.

Thanks.  I agree with the reasoning you wrote outside the proposed log
message.

We usually do not write these bullet points (iow, we are not GNU) in our
log message.  The names of the functions, call sites and files that are
involved are something anybody can see from the patch text,

I think the GNU convention was useful back when we were trapped in a
system with non-atomic commits, where it was very hard to see what files
were affected in a single logical changeset (i.e. CVS).

Luckily, we graduated those dark ages.

Instead, we prefer to have justifications (and methods), like what you
wrote at the beginning of your message.  These are not something people
can find in the patch text and they deserve to be recorded in the commit.
