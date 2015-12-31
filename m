From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] reflog-walk: don't segfault on non-commit sha1's in the reflog
Date: Wed, 30 Dec 2015 16:02:41 -0800
Message-ID: <xmqq37ujcwny.fsf@gitster.mtv.corp.google.com>
References: <xmqqk2nvd0cz.fsf@gitster.mtv.corp.google.com>
	<20151230233301.GA9194@spirit>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Thu Dec 31 01:02:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEQhc-00018R-6L
	for gcvg-git-2@plane.gmane.org; Thu, 31 Dec 2015 01:02:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846AbbLaACp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2015 19:02:45 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61511 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751126AbbLaACo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2015 19:02:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3336F373FC;
	Wed, 30 Dec 2015 19:02:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eGLoEZMLZJRw3/SrdSSXA4G8mB8=; b=rnYWMU
	fPHwTq3FZWCK1hoqt7M94/zlrKssH0MN2cHOnxTWoYXadiccJgq9tQdvwiEQKYko
	e2Hwcra32/3AmeiR6saC2o1ZqYsgkZZ0rOQ33iVBqdHLp3X+No96OH+0+lQ4yFAH
	m6BzuH3ePO0VgEghSn2Dg9JshE/qGvXYIT0vQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vmj/nF+do7W9jyeb8HXDsn2lWqn8n97X
	oV4vhNaakVcsNu4CsgUhvbH8MT6HNT2cQvBvToghUvv4c7h7lp5FYrlxKcxT+jau
	nGBtB1Z//6MmMct4HAw+OJ0Aglo2bUGLSMF1arBqoDusXGoKCQGUrU3wpNFO7Ciw
	MG16rH31XMg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2A404373FB;
	Wed, 30 Dec 2015 19:02:43 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9D352373F7;
	Wed, 30 Dec 2015 19:02:42 -0500 (EST)
In-Reply-To: <20151230233301.GA9194@spirit> (Dennis Kaarsemaker's message of
	"Thu, 31 Dec 2015 00:33:03 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D04CEC04-AF51-11E5-B7D5-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283219>

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

> This turned out to be doable in the same code segment: just keep on
> processing reflog entries until you hit a commit or run out of entries.
> That (and the updated foremerly-failing test) are the only changes
> between v2 and v3.
>
> I'll try to actually implement the proper solution, but that'll take a
> while. Until then, this at least stops a segfault :)

Yeah, that would be an ambitious project.

> diff --git a/reflog-walk.c b/reflog-walk.c
> index 85b8a54..0ebd1da 100644
> --- a/reflog-walk.c
> +++ b/reflog-walk.c
> @@ -221,6 +221,7 @@ void fake_reflog_parent(struct reflog_walk_info *info, struct commit *commit)
>  	struct commit_info *commit_info =
>  		get_commit_info(commit, &info->reflogs, 0);
>  	struct commit_reflog *commit_reflog;
> +	struct object *logobj;

This thing is not initialized...

>  	struct reflog_info *reflog;
>  
>  	info->last_commit_reflog = NULL;
> @@ -232,15 +233,20 @@ void fake_reflog_parent(struct reflog_walk_info *info, struct commit *commit)
>  		commit->parents = NULL;
>  		return;
>  	}
> -
> -	reflog = &commit_reflog->reflogs->items[commit_reflog->recno];
>  	info->last_commit_reflog = commit_reflog;
> -	commit_reflog->recno--;
> -	commit_info->commit = (struct commit *)parse_object(reflog->osha1);
> -	if (!commit_info->commit) {
> +
> +	do {
> +		reflog = &commit_reflog->reflogs->items[commit_reflog->recno];
> +		commit_reflog->recno--;
> +		logobj = parse_object(reflog->osha1);
> +	} while (commit_reflog->recno && (logobj && logobj->type != OBJ_COMMIT));

But this loop runs at least once, so logobj will always have some
sane value when the loop exits.

> +	if (!logobj || logobj->type != OBJ_COMMIT) {

And the only case where this should trigger is when we ran out of
recno.  Am I reading the updated code correctly?

With the updated code, the number of times we return from this
function is different from the number initially set to recno.  I had
to wonder if the caller cares and misbehaves, but the caller does
not know how long the reflog is before starting to call
get_revision() in a loop anyway, so it already has to deal with a
case where it did .recno=20 and get_revision() did not return that
many times.  So this probably is safe.

> +		commit_info->commit = NULL;
>  		commit->parents = NULL;
>  		return;
>  	}

> +	commit_info->commit = (struct commit *)logobj;
>  
>  	commit->parents = xcalloc(1, sizeof(struct commit_list));
>  	commit->parents->item = commit_info->commit;
> diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
> index b79049f..f97513c 100755
> --- a/t/t1410-reflog.sh
> +++ b/t/t1410-reflog.sh
> @@ -325,4 +325,17 @@ test_expect_success 'parsing reverse reflogs at BUFSIZ boundaries' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'no segfaults for reflog containing non-commit sha1s' '
> +	git update-ref --create-reflog -m "Creating ref" \
> +		refs/tests/tree-in-reflog HEAD &&
> +	git update-ref -m "Forcing tree" refs/tests/tree-in-reflog HEAD^{tree} &&
> +	git update-ref -m "Restoring to commit" refs/tests/tree-in-reflog HEAD &&
> +	git reflog refs/tests/tree-in-reflog
> +'
> +
> +test_expect_success 'reflog containing non-commit sha1s displays properly' '

In general, "properly" is a poor word to use in test description (or
a commit log message or a bug report, for that matter), as the whole
point of a test is to precisely define what is "proper".

And the code change declares that a proper thing to do is to omit
non-commit entries without segfaulting, so something like

    s/displays properly/omits them/

perhaps?

> +	git reflog refs/tests/tree-in-reflog >actual &&
> +	test_line_count = 2 actual
> +'
> +
>  test_done
> -- 
> 2.7.0-rc1-207-ga35084c
