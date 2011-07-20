From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] grep --no-index: allow to grep without git
 exclusions
Date: Wed, 20 Jul 2011 13:57:16 -0700
Message-ID: <7vzkk86577.fsf@alter.siamese.dyndns.org>
References: <82218b89c89f733dc0759d648b3a60bca6e20f3e.1311165328.git.bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Jul 20 22:57:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qjdpe-0005eo-B4
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jul 2011 22:57:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460Ab1GTU5V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jul 2011 16:57:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43739 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751309Ab1GTU5U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2011 16:57:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9490049AD;
	Wed, 20 Jul 2011 16:57:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tP9L2z/Ez2CTzV5wuFN0Jt16Jl4=; b=KHUeYo
	CPEOdJTDSxSNNq2a5P/FbcopzgpqlcFhwbuPtcbZYG4UZ4ydy9pIw4jZMXJrbeYV
	zB8yA+xezXeGlDKBJ1npg60YoOpP2E+KvMNTo21rjtfLM9tIj0PreLXI1UeGFOOK
	U/0nJEhFswtk3i3iA429/R1IzQ0XjVxMru7+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DWbfJvxQjTOaWloeHJAIqjdoZwNBQ5Kq
	6pwukWUpF0e+JiCAv7hUp+sFRmxY0JQpbYElP6Cv208xG7D5IFYI+FbHWEYcVCmC
	AaLZ11M+fWt3nY3oBbMxYijYMwPnmWK66/rj/8LIBoHW6mNHn1Kb9JnZt5EQZ+aL
	zIyxrGdAzcg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C41249AC;
	Wed, 20 Jul 2011 16:57:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0CE2A49AB; Wed, 20 Jul 2011
 16:57:18 -0400 (EDT)
In-Reply-To: <82218b89c89f733dc0759d648b3a60bca6e20f3e.1311165328.git.bert.wesarg@googlemail.com> (Bert Wesarg's message of "Wed, 20 Jul 2011 14:50:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DB4502EE-B312-11E0-9EED-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177548>

Taken in total isolation, this patch does allow a use case where we did
not allow, but when considered in a larger picture of what "grep" is used
for and how different use cases the command should support, a few random
thoughts come to mind:

 - Like "diff --no-index", "grep --no-index" is about a directory that is
   not managed by git at all with random collection of files. Do we even
   want to be using any "exclude" in such a use case? Wouldn't it actually
   be a bug that we pay attention to standard-exlcludes in the current
   code, as .gitignore files scattered in such a directory should _not_
   mean anything, as it is not a git working tree at all?

 - Even in a git managed directory, you _could_ use "grep --no-index" to
   find hits from both tracked and untracked files. In this particular use
   case, it makes some sense to pay attention to "exclude", as that would
   catch what _could_ be committed, and paths that would be excluded won't
   be part of that set (unless you use "add -f"). But wouldn't that use
   case better be covered by a switch that is different from --no-index
   (which means "These are not managed by git at all")? It is still about
   files in a git working tree, it is just that the user wants us to pay
   attention also to untracked files, e.g. "grep --untracked-too"?

So I think the patch identified a good problem to solve, but it might be a
wrong solution that encourages a use of a wrong option (i.e. --no-index)
only because we do not have the right one (i.e. "I am in the working tree,
but I want untracked ones also considered.").

What do people think if we did this a bit differently?

 - Since 3081623 (grep --no-index: allow use of "git grep" outside a git
   repository, 2010-01-15) and 59332d1 (Resurrect "git grep --no-index",
   2010-02-06), "grep --no-index" incorrectly paid attention to the
   exclude patterns. We shouldn't have, and we'd fix that bug.

 - It might be useful to be able to "git grep" both tracked and untracked
   (i.e. new files you may want to "git add") paths, but there is no good
   way to do so. Introduce a new option --untracked-too (or more suitable
   name --- I am bad at naming and not married to this one) to allow
   this. This mode always takes "exclude" into account.

Opinions?

Regarding the patch:

> +	/* --no-exclude-standard needs --no-index */
> +	if (use_index && !exclude_standard)
> +		die(_("--no-exclude-standard does not make sense without --no-index."));

For that matter,

    $ git grep --no-exclude-standard --exclude-standard --cached -e foo

should be an error, no?
