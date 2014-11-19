From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] refs.c: use a stringlist for repack_without_refs
Date: Wed, 19 Nov 2014 10:00:00 -0800
Message-ID: <xmqq4mtvt6jj.fsf@gitster.dls.corp.google.com>
References: <20141118234500.GO6527@google.com>
	<1416359308-14831-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 19:00:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xr9Y6-0005sw-6N
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 19:00:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756480AbaKSSAG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2014 13:00:06 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59910 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756320AbaKSSAF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2014 13:00:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 96AA91EEB6;
	Wed, 19 Nov 2014 13:00:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Iu1NyEEggPACgizic2opipqX/0g=; b=vbhqiA
	T0wkMcX46hRc9OpICUCxLcrAnM3u9CDJu0N8VE51o6R9gRAfDLCAD0l/QNDgYBBi
	NeO1Ju9qeUEzWnQO9KYwcdQ4LQT4vojd5JyPZUYdupOeAEqWbYE5/8YBVWWAeMDt
	TqYF0XkFpbNXtNkUVpAZbu19k2nWwy90fLW0E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Aa1/0wE43EgqqXPu1AOMQo4+YrlAPkDc
	WYrZgZ87Vb9/jVmAvtqIHNoKMKWjV2U4qahLjtrte+wvK6I7K7QhuW9Hcrl3LdIU
	v7hJyKzU0kJz3L8PZAkXPhJblOzlgC1G2SME7HPCFPKOB7Cxg1/yh2uOfuGLdLIG
	srfz+qBfWII=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8866D1EEB5;
	Wed, 19 Nov 2014 13:00:03 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B264C1EEB4;
	Wed, 19 Nov 2014 13:00:02 -0500 (EST)
In-Reply-To: <1416359308-14831-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 18 Nov 2014 17:08:28 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E2AC3BA6-7015-11E4-B225-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> This patch doesn't intend any functional changes. It is just
> a refactoring, which replaces a char** array by a stringlist
> in the function repack_without_refs.
> This is easier to read and maintain as it delivers the same
> functionality with less lines of code less pointers.
>
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
>
> -

Have three of them, not just one, here. (no need to resend to fix
only this).  Or...

>
> This patch was heavily inspired by a part of the ref-transactions-rename
> series[1], but people tend to dislike large series and this part is
> relatively easy to take out and unrelated, so I'll send it as a single
> patch.
>
> [1] https://www.mail-archive.com/git@vger.kernel.org/msg60604.html
>
> ---

... next time, write the comments here, where Git already gives you
three dashes.

Also mention what you updated and why relative to your earlier round
here, if not covered in the log message already.

For example, renaming of delete_refs_list (in v1) to delete_refs
(this version) is a sensible change because readers know it is a
list from its type being string_list already, but that change is new
relative to the codebase, so it could go to the log message ("Having
array delete_refs[] and string_list delete_refs_list is redundant;
drop the array and give the string_list variable the shorter name",
or something like that) if you wanted to.

> @@ -1316,8 +1311,8 @@ static int prune_remote(const char *remote, int dry_run)
>  {
>  	int result = 0, i;
>  	struct ref_states states;
> -	struct string_list delete_refs_list = STRING_LIST_INIT_NODUP;
> -	const char **delete_refs;
> +	struct string_list delete_refs = STRING_LIST_INIT_NODUP;
> +	struct string_list_item *ref;
>  	const char *dangling_msg = dry_run
>  		? _(" %s will become dangling!")
>  		: _(" %s has become dangling!");
> @@ -1325,6 +1320,9 @@ static int prune_remote(const char *remote, int dry_run)
>  	memset(&states, 0, sizeof(states));
>  	get_remote_ref_states(remote, &states, GET_REF_STATES);
>  
> +	for_each_string_list_item(ref, &delete_refs)
> +		string_list_append(&delete_refs, ref->string);

What are you trying to do here?

Initialise delete_refs to an empty string list, and then iterate
over its elements and append them into the same string list???

It looks like a "currently noop, waiting for somebody to throw an
item to the list before this code, at which time it turns into an
infinite memory eater".

Curious...
