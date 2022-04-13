Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4258BC433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 17:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237466AbiDMRvQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 13:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235764AbiDMRvP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 13:51:15 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03786D3A2
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 10:48:53 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 406BC19AE85;
        Wed, 13 Apr 2022 13:48:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6If3YB0B/jb81MM+UoOpA8NZGtYBNgx0yG4+ar
        /bqtI=; b=bGe0EPl41oYcoDO1zsuj1SDFJfOIUtsGrydgRqpPcx4WsxdeeJBFD+
        KCdA41s1C+9RvX8GI4nehKnEoRutMp49kVSAMrq9B6w4PIajD7NrwZs5k9h3DehE
        4RahdcSr9xtZQWxhrIgNeejOZ3U4c3S3iyp8gVSrDoFmZH82m7gPs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 392F419AE84;
        Wed, 13 Apr 2022 13:48:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 438EB19AE83;
        Wed, 13 Apr 2022 13:48:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] introducing git replay
References: <20220413164336.101390-1-eantoranz@gmail.com>
Date:   Wed, 13 Apr 2022 10:48:48 -0700
In-Reply-To: <20220413164336.101390-1-eantoranz@gmail.com> (Edmundo Carmona
        Antoranz's message of "Wed, 13 Apr 2022 18:43:35 +0200")
Message-ID: <xmqqlew898n3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F96AE4FC-BB51-11EC-B9BA-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Edmundo Carmona Antoranz <eantoranz@gmail.com> writes:

I've already gave my take on "is this interesting?" question with a
"not really", but let's look at the code, as the expertise will
translate to your future contributions easily, even if this
particular code may turn out not to be used in the project.

> +static unsigned int replay_indexof(struct commit *commit,
> +				   struct commit_list *list)
> +{
> +	int res;
> +	if (list == NULL)
> +		return -1;

We encourage to have a blank line between the end of the decls and
the beginning of the statements.  Add one after the line that
declares the variable "res".  

In an existing code that consistently uses the abbreviation, it is a
different story, but "result" is not too long to spell out, and
because you do not use the variable that often anyway, you would
avoid unnecessary friction on the readers not to abbreviate it to
"res" here.

> +	if (!oidcmp(&list->item->object.oid,
> +		    &commit->object.oid))

	if (!oidcmp(&list->item->object.oid, &commit->object.oid))

is 66 columns wide and this line is wrapped too short, without an
apparent upside to make the result any easier to read.

> +		return 0;
> +	res = replay_indexof(commit, list->next);

Do we need to go recursive here?  It feels wasteful, compared to
iteratively doing this.  FWIW, is the singly chained commit_list the
best data structure if you have "a collection of commits, among
which you'd need to find an existing one, if any"?  You may want to
consider using a hashset, perhaps, as the only thing you seem to be
getting out of the data structure is "is this among the old_commits
set?"  Another possibility, if you do not call APIs that use the
object flags, may be to allocate a flag bit and mark these commits
in the original history you discover via get_revision(), instead of
placing them in a singly chained commit_list structure.  Then the
loop in replay_commit() can just see if parent->object.flags has
that "in the original history?" bit set to decide.

> +	return res < 0 ? res : res + 1;
> +}
> +
> +static struct commit *replay_find_commit(const char *name)
> +{
> +	struct commit *commit = lookup_commit_reference_by_name(name);
> +	if (!commit)
> +		die(_("no such branch/commit '%s'"), name);
> +	return commit;
> +}
> +
> +static struct commit* replay_commit(struct commit * orig_commit)

In our codebase, an asterisk sticks to the identifier, not the type.

> +{
> +	struct pretty_print_context ctx = {0};
> +	struct strbuf body = STRBUF_INIT;
> +	struct strbuf author = STRBUF_INIT;
> +	struct strbuf committer = STRBUF_INIT;
> +	struct object_id new_commit_oid;
> +	struct commit *new_commit;
> +
> +	struct commit_list *new_parents_head = NULL;
> +	struct commit_list **new_parents = &new_parents_head;
> +	struct commit_list *parents = orig_commit->parents;
> +	while (parents) {

It is not _wrong_ to have a blank line inside the decl block if
there is a logical separation between the groups.  I am not sure if
the one in the above after "struct commit *new_commit" qualifies as
one.

Regardless, after such a large decl block, we want a blank line
before the first statement.

> +		struct commit *parent = parents->item;
> +		int commit_index;
> +		struct commit *new_parent;
> +
> +		commit_index = replay_indexof(parent, old_commits);
> +
> +		if (commit_index < 0)
> +			 // won't be replayed, use the original parent

We still frown upon // comments in this codebase.

> +			new_parent = parent;
> +		else {
> +			// it might have been translated already
> +			if (!new_commits[commit_index])
> +				new_commits[commit_index] = replay_commit(parent);
> +			new_parent = new_commits[commit_index];
> +		}
> +		new_parents = commit_list_append(new_parent, new_parents);
> +		parents = parents->next;
> +	}
> +
> +	format_commit_message(orig_commit, "%B", &body, &ctx);
> +	// TODO timezones
> +	format_commit_message(orig_commit, "%an <%ae> %at +0000", &author, &ctx);
> +	// TODO consider committer (control with an option)
> +	format_commit_message(orig_commit, "%cn <%ce> %ct +0000", &committer, &ctx);

Yuck.  Shouldn't this code, whose purpose is to replay the messages
and metadata of the commit as faithfully as possible while
reparenting them, be just reusing the original commit object?

Perhaps turning save_commit_buffer on, reading the original commit
object in the raw format, rewriting the parent pointers (and nothing
else) and finally calling write_object_file() to create the new
commit object is what this code should be doing instead.

And that would be another reason why this is probably better done as
fast-export piped to fast-import, but this message is not about the
design of the "feature" itself, so let me stop talking about that.
