From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revision: add --except option
Date: Thu, 29 Aug 2013 23:32:26 -0700
Message-ID: <7vhae7k7t1.fsf@alter.siamese.dyndns.org>
References: <1377838805-7693-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 30 08:32:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFIG3-0000Qt-MG
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 08:32:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753588Ab3H3Gcb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 02:32:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56167 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752577Ab3H3Gca (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 02:32:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85B0738DC5;
	Fri, 30 Aug 2013 06:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mSgrFGh03on70no6xRohefO1DoU=; b=J+UWAl
	tFmt1R0HWjk1nZtwPo9za+f/qxl5u0R9ibw9BWwm/fVMO2AawWMdIMzTCeATaonK
	UomhrPb6dipjiNNNJOJ5H/Gz4MWJYf1J4YUBKXwkdy/OGjgLkzblpp618O4eLnAk
	+8KMCKP9ubz1drs23awBc/uBXURyRWzT/pj0U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RwTWE8eO7m5VlwDEzQ0I0aa+fFhjifEe
	2VZdlzr0otI+DCbWzggz1Qnq6KkpfcWvGVBU8nlYaABRFWTlUcoJim07Whnm2g/w
	2RfdLidGbXrZ9aFOjwlDMaiI26pz4x35Bh/uca1BYtUG/QyF0X99K801DaBrbCFk
	UoB3di6hGnI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C1F538DC4;
	Fri, 30 Aug 2013 06:32:29 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 88BAA38DC0;
	Fri, 30 Aug 2013 06:32:28 +0000 (UTC)
In-Reply-To: <1377838805-7693-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Fri, 30 Aug 2013 00:00:05 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F106D34C-113D-11E3-8E04-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233425>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> So that it's possible to remove certain refs from the list without
> removing the objects that are referenced by other refs.
>
> For example this repository:
>
>   * 374e8dd (crap) crap
>   * 4cbbf7b (test) two
>   * d025ae0 (HEAD, master) one

Can we make it more clear that your assumption is "crap" is a child
of "test" which is a child of "master"?  Without that, the "nothing
will come out" will not follow.

> When using '--branches --except crap':
>
>   * 4cbbf7b (test) two
>   * d025ae0 (HEAD, master) one
>
> But when using '--branches --not crap' nothing will come out.

If you have a history where

 - branches "master" and "maint" point at commit A;
 - branch "next" points at commit B that is a descendant of A; and
 - there are tags X and Y pointing at commits that are ahead of B
   or behind A

i.e.

	----X----A----B----Y

what are the desired semantics for these?

 (1) --branches --except maint

 (2) --all --not --branches --except maint

 (3) ^master next --except maint

"--branches" wants to include "master", "next", and "maint", and the
"--except" tells us we do not want to take "maint" into account, but
should that affect what "master" wants to do (either include or
exclude what are reachable from it)?

As the way we parse the revisions from the command line is to mark
"objects", not "refs", as we go, it looks like that the flag SKIP in
this patch is placed conceptually at a wrong level.

I agree "--branches --except maint" is a good concept, but to
implement what this patch wants to do properly, I suspect that the
revision parser may need to be extended to be a two-phase process;
the first phase will collect list of objects involved in the range
expression without marking them with UNINTERESTING mark (that would
also involve expanding things like --all or --branches), while
remembering those given with --except, exclude the "except" set from
the first set, and then finally marking the objects using the
remainder, or something like that.

> @@ -2585,12 +2588,19 @@ int prepare_revision_walk(struct rev_info *revs)
>  	revs->pending.objects = NULL;
>  	while (--nr >= 0) {
>  		struct commit *commit = handle_commit(revs, e->item, e->name);
> +		for (i = 0; i < revs->cmdline.nr; i++) {
> +			struct rev_cmdline_entry *ce;

"ce" will have a strong association with "cache entry"; avoid using
that variable name for anything else to avoid confusion.

> +			ce = &revs->cmdline.rev[i];
> +			if ((ce->flags & SKIP) && !strcmp(ce->name, e->name))
> +				goto next;

I think this SKIP will not help an object that is already tainted by
UNINTERESTING; if it is discovered during a traversal from another
object that will remain in the rev->commits, the travesal will stop
there, even if a ref that is marked with SKIP will "goto next" here.

> +		}
>  		if (commit) {
>  			if (!(commit->object.flags & SEEN)) {
>  				commit->object.flags |= SEEN;
>  				next = commit_list_append(commit, next);
>  			}
>  		}
> +next:
>  		e++;
>  	}
>  	if (!revs->leak_pending)

> diff --git a/t/t6112-rev-list-except.sh b/t/t6112-rev-list-except.sh
> new file mode 100755
> index 0000000..b8f9a61
> --- /dev/null
> +++ b/t/t6112-rev-list-except.sh
> @@ -0,0 +1,35 @@
> +#!/bin/sh
> +
> +test_description='test for rev-list --except'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +
> +	echo one > content &&

Style.
