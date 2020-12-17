Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F18C4361B
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 22:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A54572376F
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 22:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731769AbgLQWVJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Dec 2020 17:21:09 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54323 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729612AbgLQWVI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Dec 2020 17:21:08 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 27304109075;
        Thu, 17 Dec 2020 17:20:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NfZdjMDrZ63mdZBITGrDDCm4vu8=; b=EPSPzu
        vSPx1lIT86rwxgVuTdNkALgL1F3MiAmWn4ic/VQtkbGL15Rp29wSyydZdZhAuDLA
        iF8DNFpG8ZD1jWBispkMy8C2kc4J89iurz91M1htt1k/3b4tATjeCiI/W0/EvY+j
        WCNKQ2qBWoqvOQeRNafQOzkKHvMkKXdQyMKrc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=i5TBprowlFgu28162FDXqUJWDIgZj5MA
        axKPadS7TMkqG/PJoGKkfmJ+VMKKYURSPTu74YG+8fOyi/RxcWNpdHEq3Niz0oeU
        HDG+NM3PNZlF92zePCK1J1PpTi9g8cfIjHTwplC5oSna46Ee8Y8tyBSTluRTq47b
        yp7wa+axWa4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1DD05109074;
        Thu, 17 Dec 2020 17:20:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 65800109073;
        Thu, 17 Dec 2020 17:20:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <periperidip@gmail.com>
Cc:     git@vger.kernel.org, liu.denton@gmail.com,
        christian.couder@gmail.com, kaartic.sivaraam@gmail.com
Subject: Re: [PATCH v3 0/3] submodule: port subcommand add from shell to C
References: <20201214231939.644175-1-periperidip@gmail.com>
        <xmqqlfdy7niy.fsf@gitster.c.googlers.com>
        <20201217141625.GA7638@konoha>
Date:   Thu, 17 Dec 2020 14:20:16 -0800
In-Reply-To: <20201217141625.GA7638@konoha> (Shourya Shukla's message of "Thu,
        17 Dec 2020 19:46:25 +0530")
Message-ID: <xmqqo8isxefz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0B6500BA-40B6-11EB-BFD5-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <periperidip@gmail.com> writes:

> On 15/12 01:44, Junio C Hamano wrote:
>> Shourya Shukla <periperidip@gmail.com> writes:
>> 
>> >     3. In the following segment:
>> >         /*
>> >          * NEEDSWORK: In a multi-working-tree world, this needs to be
>> >          * set in the per-worktree config.
>> >          */
>> >         if (!git_config_get_string("submodule.active", &var) && var) {
>> >
>> >         There was a comment: "What if this were a valueless true
>> >         ("[submodule] active\n" without "= true")?  Wouldn't get_string()
>> >         fail?"
>> >
>> >         I was under the impression that even if the above failed, it
>> >         will not really affect the big picture since at the we will set
>> >         'submodule.name.active" as true irrespective of the above value.
>> >         Is this correct?
>> 
>> Let's see what kind of value the "submodule.active" variable is
>> meant to be set to.  Documentation/config/submodule.txt has this:
>> 
>>     submodule.active::
>>             A repeated field which contains a pathspec used to match against a
>>             submodule's path to determine if the submodule is of interest to git
>>             commands. See linkgit:gitsubmodules[7] for details.
>> 
>> It definitely is a string value, and making it a valueless true is
>> an error in the configuration.
>
> I think that we did not _make_ it a valueless true. It was already there
> and we somehow managed to check it. If you mean that we should ensure
> that we set it to "true" so that any such errors don't happen later on,
> then that is a different thing.

Let me rephrase.  When a user has "[submodule] active" in his or her
configuration file, it is a configuration error.  When Git reads
"submodule.active" configuration variable to make a decision (like
the above code) and finds that the user has such an error, the user
would appreciate if the error is pointed out, so that it can be
corrected, rather than silently ignored.

>> Also the "var" (one of the values set for this multi-valued
>> variable) is never used in the body of the "if" statement.  The
>> other user of "submodule.active" in module_init() seems to use
>> config_get_value_multi() on it.  The new code may deserve a comment
>> to explain why that is OK to (1) grab just a single value out of the
>> multi-valued variable, and (2) not even look at its value.
>
> Understood. So a comment along the lines of:
>
> 	/*
> 	 * Since we are fetching information only about one submodule,
> 	 * we need not fetch a  list of submodules to check the activity
> 	 * status of a single submodule.

Makes me wonder if I am getting the semantics of submodule.active
variable right.

From the three-line description in the documentation (see above), I
would have guessed that if we have three values for
submodule.active, e.g.

	[submodule]
		active = $a
		active = $b
		active = $c

then when deciding if we want to see if a submodule at a $sm_path,
we'd see if $path matches any one of $a, $b, or $c and if it does,
it is determined that the submodule is "of interest to git
commands".

Yes, we may be fetching information only about one submodule at
$sm_path, but given the explanation of how the configuration
variable is designed to work, how can we _not_ fetch the list and
check all of them?

So the comment above (for that matter, the one below that talks
about valuless true) does not make any sense to me, sorry.

> 	 * In case of a valueless true, i.e, '[submodule] active\n'
> 	 * without '= true', we need not worry about any errors since
> 	 * irrespective of the above value, we will set
> 	 * 'submodule.<name>.active' as true.
> 	 */
>
> will work? 

The real reason why it is OK to just check existence of submodule.active
variable without seeing any value of them is because the check is done
to see if this call is needed at all:

	git submodule--helper is-active "$sm_path"

This "helper" eventually calls submodule.c::is_submodule_active()
that does the real check---it gets the multi-valued submodule.active
and checks them against the path to determine if the submodule is
"of interest".

On the other hand, when we know submodule.active does not exist, all
submodules are of interest when it comes to "submodule add".  That
is how

-	if git config --get submodule.active >/dev/null
-	then
-		# If the submodule being adding isn't already covered by the
-		# current configured pathspec, set the submodule's active flag
-		if ! git submodule--helper is-active "$sm_path"
-		then
-			git config submodule."$sm_name".active "true"
-		fi
-	else
-		git config submodule."$sm_name".active "true"
-	fi

taken from your [2/3] that ignored the values of submodule.active is
"correct"; we know that the real work is done elsewhere--we are only
learning if the is-active check is necessary.

I think explaining why it works correctly to show future readers
that the code was written by folks who knew what they were doing
would be worth the effort to help future code evolution.

This, from your [1/3], is a faithful translation of the above,
but ...

+	if (!git_config_get_string("submodule.active", &var) && var) {
+
+		/*
+		 * If the submodule being adding isn't already covered by the
+		 * current configured pathspec, set the submodule's active flag
+		 */
+		if (!is_submodule_active(the_repository, info->sm_path)) {
+			key = xstrfmt("submodule.%s.active", info->sm_name);
+			git_config_set_gently(key, "true");
+			free(key);
+		}
+	} else {
+		key = xstrfmt("submodule.%s.active", info->sm_name);
+		git_config_set_gently(key, "true");
+		free(key);
+	}

... by knowing why we check submodule.active but discard its value,
future developers (read: I think this is outside the scope of this
series) can rewrite it like so to make it more readable and reduce
the repeated code to set submodule.$sm_name.active to true.

        /*
	 * If submodule.active does not exist, we will activate this
	 * module unconditionally.
	 *
         * Otherwise, is_submodule_active() is asked to determine if
         * the path currently is of interest; because it will obtain
         * and iterate over this multi-valued variable by itself, we
         * do not need its values we obtain from git_config_get_string()
         * call here.  We are only checking if we need to ask the
         * is_submodule_active() helper function.  We explicitly set
	 * the submodule.$sm_name.active if submodule.active patterns
	 * do not cover the path (i.e. is_submodule_active() says "no".
         */
	if (git_config_get_string("submodule.active", &var) ||
	    !is_submodule_active(the_repository, info->sm_path)) {
		key = xstrfmt(...);
		git_config_set_gently(key, "true");
		free(key);
	}

and a comment like this would help such readers, for example.

By the way, as you might have noticed, your [1/3] contains a lot of
material that ought to be part of [2/3], doesn't it?  [1/3] was
supposed to be just borrowing helper from dir.c but has the new
"add" code implemented in the same patch.

> Also, could you please comment on the other two issues I
> mentioned in the cover letter so I might as well start work on v4 of
> this patch?

I'll leave the other two to other reviewers and mentors for now, but
may come back to them if I beat them.

Thanks.
