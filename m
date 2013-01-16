From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clean.c, ls-files.c: respect encapsulation of
 exclude_list_groups
Date: Wed, 16 Jan 2013 14:20:12 -0800
Message-ID: <7v1udkwz1f.fsf@alter.siamese.dyndns.org>
References: <CAOkDyE-p9WLrsFZjPb9sY+YEypkF2wDxMybBkCT-76jBbKOmCA@mail.gmail.com>
 <1358342758-30503-1-git-send-email-git@adamspiers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Wed Jan 16 23:20:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvbLb-0003DH-M1
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 23:20:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756556Ab3APWUQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 17:20:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46451 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756028Ab3APWUP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 17:20:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B1DABF56;
	Wed, 16 Jan 2013 17:20:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1FhL+/f/TEdSKWviAnDFHiEQESI=; b=bfc36h
	inh8Z5TTtM1XqWtQFDwHJtHR4SkhFHgqH1c13mOodJvtLpd06xGp3SSm16gAiNs2
	yyOrK1L6/29E6L4nKvC6iX6VHfF9zLzKsO/Xh611PU7B5h2v8IOT1ftsQjYP7s/U
	FXw472rx3LS9SvHSUvXOQ4RAC+FzasyATPGdU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a3c6OPcppidCWzTHIRRm76crUrwoBOl/
	paHKyIYU/0ZxGEN3DADzH+EeuQ4PpPWCOP9ytL628i5dehgLHeR9356C17Nfq9DA
	PxrpyZXY47CEGxKtHae9qVFHcVKGLwnIUtcTMJ7rhO1NymF4dlW49wmUcjeFKGqB
	hMJ9DWOzqy8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 90144BF55;
	Wed, 16 Jan 2013 17:20:14 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EBC8BBF51; Wed, 16 Jan 2013
 17:20:13 -0500 (EST)
In-Reply-To: <1358342758-30503-1-git-send-email-git@adamspiers.org> (Adam
 Spiers's message of "Wed, 16 Jan 2013 13:25:58 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E618F678-602A-11E2-9565-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213816>

Adam Spiers <git@adamspiers.org> writes:

> Consumers of the dir.c traversal API should avoid assuming knowledge
> of the internal implementation of exclude_list_groups.  Therefore
> when adding items to an exclude list, it should be accessed via the
> pointer returned from add_exclude_list(), rather than by referencing
> a location within dir.exclude_list_groups[EXC_CMDL].
>
> Signed-off-by: Adam Spiers <git@adamspiers.org>
> ---
>  builtin/clean.c    |  6 +++---
>  builtin/ls-files.c | 15 ++++++++++-----
>  2 files changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/clean.c b/builtin/clean.c
> index b098288..b9cb7ad 100644
> --- a/builtin/clean.c
> +++ b/builtin/clean.c
> @@ -45,6 +45,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>  	static const char **pathspec;
>  	struct strbuf buf = STRBUF_INIT;
>  	struct string_list exclude_list = STRING_LIST_INIT_NODUP;
> +	struct exclude_list *el;

When a type "exclude_list" exists and used in the same function,
having a local variable of the same name but of a different type
becomes a bit awkward.

builtin/ls-files.c shares the same structure.  Does the file-scope
"exclude_args" variable need to be a file-scope static over there?
It seems that it is closely tied to the elements of the string list,
so it may make sense to:

    * remove the file-scope static "exclude_args";

    * rename "exclude_list" string list variable to "exclude_args";
      and

    * replace "--exclude_args" in the loop that iterates over
      exclude_list (now exclude_args) with "-(i+1)" or something,
      just like you do in "builtin/clean.c" below.

> -	add_exclude_list(&dir, EXC_CMDL, "--exclude option");
> +	el = add_exclude_list(&dir, EXC_CMDL, "--exclude option");
>  	for (i = 0; i < exclude_list.nr; i++)
> -		add_exclude(exclude_list.items[i].string, "", 0,
> -			    &dir.exclude_list_group[EXC_CMDL].el[0], -(i+1));
> +		add_exclude(exclude_list.items[i].string, "", 0, el, -(i+1));

We may want to use for_each_string_list_item() here and in the
corresponding loop in builtin/ls-files.c, but because we do need to
give the -(i + 1) label to each element, I think the code is OK
as-is.
