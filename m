Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB870C54EE9
	for <git@archiver.kernel.org>; Tue, 13 Sep 2022 17:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbiIMR7o (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Sep 2022 13:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbiIMR7M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2022 13:59:12 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA45B8B9A5
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 10:01:33 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3373E15CBF9;
        Tue, 13 Sep 2022 13:01:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0eAqPknyESubR8m/XPnYmITTvrksX0urRrKFu9
        a6pzU=; b=n1bOTKb0XzAPwy79mWWCLx4I/dG485dPYXw11rUWIvUfmVjREv0EPk
        n8LXQJ/WV+ZRuAw7YXTzRlkrrkYWwZqiDqfmf/98QQrdxqKexzHIZ6iE/pN8Ps7T
        lJneEo9FTGMMKtalD2bv8ANXfBnPDsOYI3W+vE8qqTn+f7K9+5RM0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2938D15CBF8;
        Tue, 13 Sep 2022 13:01:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7276D15CBF7;
        Tue, 13 Sep 2022 13:01:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Sun Chao via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Sun Chao <16657101987@163.com>,
        Sun Chao <sunchao9@huawei.com>
Subject: Re: [PATCH v5 1/5] hiderefs: add hide-refs hook to hide refs
 dynamically
References: <pull.1301.v4.git.git.1660575688.gitgitgadget@gmail.com>
        <pull.1301.v5.git.git.1662735985.gitgitgadget@gmail.com>
        <278bd185aec26285f8c00aca838f89e5f3877748.1662735985.git.gitgitgadget@gmail.com>
Date:   Tue, 13 Sep 2022 10:01:28 -0700
In-Reply-To: <278bd185aec26285f8c00aca838f89e5f3877748.1662735985.git.gitgitgadget@gmail.com>
        (Sun Chao via GitGitGadget's message of "Fri, 09 Sep 2022 15:06:21
        +0000")
Message-ID: <xmqqedwf9pjr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B5F72DF0-3385-11ED-86D3-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Sun Chao via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Sun Chao <sunchao9@huawei.com>
>
> Gerrit is implemented by JGit and is known as a centralized workflow system
> which supports reference-level access control for repository. If we choose
> to work in centralized workflow like what Gerrit provided, reference-level
> access control is needed and we might add a reference filter hook
> `hide-refs` to hide the private data.

Please rewrite the above so that it does not sound like "Gerrit
supports it, there are tons of users of Gerrit, we must support it,
too".  If this feature is meaningful for us, even if Gerrit folks
were deprecating and planning to remove the support of it, we would
add it.  If it is not, even if Gerrit folks support it, we wouldn't.

> +
> +		/*
> +		 * the prefix 'hook:' means that the matched refs will be
> +		 * checked by the hide-refs hook dynamically, we need to put
> +		 * the 'ref' string to the hook_hide_refs list
> +		 */

I am not sure if this deserves a five-line comment.  We didn't need
to have a comment that says "value without hook: means the matched
refs will be hidden and we need to remember them in the hide_refs
string_list" for over 10 years after all.

> +		if (skip_prefix(value, "hook:", &value)) {
> +			if (!strlen(value))
> +				return error(_("missing value for '%s' after hook option"), var);

I am not sure it is a good idea to special case an empty string,
especially here at this point in the code flow.  There would be
strings that cannot be a refname prefix (e.g. "foo..bar") and such a
check is better done at the place where the accumuldated list of ref
patterns are actually used.  If you are using prefix match, a value
of an empty string here would be a very natural way to say "we pass
all the refs through our hook".

By the way, how does the negated entry work with this new one?  For
static ones,

	[transfer] hiderefs = !refs/heads/

would hide everything other than refs/heads/ hierarchy, I suppose.
Would we spell

	[transfer] hiderefs = hook:!refs/heads/

or

	[transfer] hiderefs = !hook:refs/heads/

to say "send everything outside the branches to hook"?  If the
former, you'd also need to special case "!" the same way as you
special case an empty string (in short, I am saying that the special
case only for an empty string does not make much sense).

How does this mechanism work with gitnamespaces (see "git config --help"
and read on transfer.hideRerfs)?

> +			hook = 1;
> +		}
> +
>  		ref = xstrdup(value);
>  		len = strlen(ref);
>  		while (len && ref[len - 1] == '/')
>  			ref[--len] = '\0';
> -		if (!hide_refs) {
> -			CALLOC_ARRAY(hide_refs, 1);
> -			hide_refs->strdup_strings = 1;
> +
> +		if (hook) {
> +			if (!hook_hide_refs) {
> +				CALLOC_ARRAY(hook_hide_refs, 1);
> +				hook_hide_refs->strdup_strings = 1;
> +			}
> +			string_list_append(hook_hide_refs, ref);
> +		} else {
> +			if (!hide_refs) {
> +				CALLOC_ARRAY(hide_refs, 1);
> +				hide_refs->strdup_strings = 1;
> +			}
> +			string_list_append(hide_refs, ref);
>  		}
> -		string_list_append(hide_refs, ref);
>  	}

That's a somewhat duplicated code.  I wonder

	/* no need for "hook" variable anymore */
	struct string_list **refs_list= &hide_refs;

	if (strip "hook:" prefix from value)
		refs_list = &hook_hide_refs;
		...
	if (!*refs_list) {
        	*refs_list = xcalloc(1, sizeof(*refs_list));
		(*refs_list)->strdup_strings = 1;
	}
	string_list_append(*refs_list, ref);
		
would be a better organization.  I dunno.

> +
> +	/*
> +	 * Once hide-refs hook is invoked, Git need to do version negotiation,
> +	 * with it, version number and process name ('uploadpack' or 'receive')
> +	 * will send to it in pkt-line format, the proccess name is recorded
> +	 * by hide_refs_section
> +	 */

Grammar.

> +	if (hook && hide_refs_section.len == 0)
> +		strbuf_addstr(&hide_refs_section, section);
> +

I am not sure if this is correct at all, but because the 1/N patch
has only code without documentation I cannot guess the intention.

The first conditional to parse the configuration variable name var
tries to handle both generic transfer.hideRefs and direction
specific {receive,uploadpack}.hideRefs and "section" at this point
has "transfer", "receive" or "uploadpack", doesn't it?

As this is a git_config() callback, when we have

	[receive] hiderefs = hook:refs/foo
	[uploadpack] hiderefs = hook:refs/bar
	[transfer] hiderefs = hook:refs/baz

we would want to send refs/bar and refs/baz to the hook if we are a
"uploadpack" process.  But because the above code records the first
section we happen to see (which is "receive"), hide_refs_section has
that value.  I am not sure how a code that later user that piece of
information can behave any sensibly.  Does it say "We are a
'uploadpack', but hide_refs_section says 'receive', so we should
ignore what is in hook_hide_refs string list"?

I'll stop reading at this point for now, as it is not a good use of
our time to review the implementation until we know the basic design
is sound, which I do not quite see from what we saw up to this
point.  It might have made sense if each string list element had the
ref pattern to match as its value and stored extra info, like "is
this negated?", "is this hook pattern or static?", "is this
transfer, receive, or uploadpack?" in its .util member, for example.

Thanks.
