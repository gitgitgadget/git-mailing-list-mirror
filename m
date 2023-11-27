Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bZQD94lw"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E132DCB
	for <git@vger.kernel.org>; Sun, 26 Nov 2023 17:39:55 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E57891CF5A4;
	Sun, 26 Nov 2023 20:39:54 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=HH7+yTdaWinFE1Ie5fNQbu4gnvDPgw6KVM9/iO
	/pUiU=; b=bZQD94lw9g0yl6Ft8CXOG6xSD32eCh12Ds0rPTm68igw7F0TZfPsMM
	HerIQh4q03WYOnpY7VzsX0KLfo31EDBiKfvztY96NZx+sGMVkH2xPOSmoJI1DLur
	7dAq1lIZREF1FaSVqajggAwUcWy6v8aI5xpibnYB4Ay7GqZCc2eJ0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DDCD11CF5A3;
	Sun, 26 Nov 2023 20:39:54 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 235321CF5A2;
	Sun, 26 Nov 2023 20:39:54 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH 4/4] completion: avoid user confusion in non-cone mode
In-Reply-To: <CABPp-BE73cDq-DBKzsw3R0awiKn5J5LCfdXRULHyPbrS9GEn4Q@mail.gmail.com>
	(Elijah Newren's message of "Fri, 24 Nov 2023 07:28:07 -0800")
References: <pull.1349.git.1700761448.gitgitgadget@gmail.com>
	<fe8669a3f4f05c186e497f870c7e7ba9a94ac63f.1700761448.git.gitgitgadget@gmail.com>
	<xmqqo7fk9cdt.fsf@gitster.g>
	<CABPp-BE73cDq-DBKzsw3R0awiKn5J5LCfdXRULHyPbrS9GEn4Q@mail.gmail.com>
Date: Mon, 27 Nov 2023 10:39:53 +0900
Message-ID: <xmqq34ws3rfa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DD2360E8-8CC5-11EE-AD92-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Elijah Newren <newren@gmail.com> writes:

>> >               if [[ "$using_cone" == "true" ]]; then
>> >                       __gitcomp_directories
>>
>> Hmph, doesn't "Providing the files and directories currently present
>> is thus always wrong." apply equally to cone mode?
>
> Absolutely, it definitely applies to cone mode.  We (mostly) fixed
> that a long time ago, making it not complete on the files &
> directories currently present.  In particular, the
> __gitcomp_directories() function highlighted here completes on the
> output of `git ls-tree -z -d --name-only HEAD`.

Thanks; what I missed was exactly what __gitcomp_directories does
not do you explained above.

>> > +                     #     4. Provides no completions when run from a
>> > +                     #        subdirectory of the repository root.  (If we
>> > +                     #        did provide file/directory completions, the
>> > +                     #        user would just get a "please run from the
>> > +                     #        toplevel directory" error message when they
>> > +                     #        ran it.  *Further*, if the user did rerun
>> > +                     #        the command from the toplevel, the
>> > +                     #        completions we previously provided would
>> > +                     #        likely be wrong as they'd be relative to the
>> > +                     #        subdirectory rather than the repository
>> > +                     #        root.  That could lead to users getting a
>> > +                     #        nasty surprise based on trying to use a
>> > +                     #        command we helped them create.)
>>
>> Hmph, would an obvious alternative to (1) check against the HEAD (or
>> the index) to see if the prefix string matches an entity at the
>> current directory level, and then (2) to prefix the result of the
>> previous step with "/$(git rev-parse --show-prefix)" work?  That is
>> something like this:
>>
>>     $ cd t
>>     $ git sparse-checkout add help<TAB>
>>     ->
>>     $ git sparse-checkout add /t/helper/
>
> I thought bash-completion was only for completions, not for startings
> as well.  Was I mistaken?

To my mind, the completion is what I as an end user get when I type
<TAB> to help me formulate input that is acceptable by the command.
As I said, I consider it a bug (or UI mistake) in the a command if
it pretends to work inside a subdirecctory but complains when it is
given a path relative to the current directory, so I'd rather prefer
the approach to "fix" the underlying command, but if that is too
much work or cannot be done for whatever reason, the second best
would be to turn whatever we can do to help the end-user input into
a form that is accepted by the command without changing what the
input means.  If it takes more than "appending at the end", that is
fine, at least by me as an end user.

If you are saying "completion code can only append at the end
because we can only return strings to be appended, not the entire
strings, to the readline machinery, so mucking with the start of the
string is not doable", then sorry---I accept that what we cannot do
cannot be done, and in that case you are "not mistaken".

But from the existing use of COMPREPLY[], it didn't look that way
(it seems __gitcomp is equipped to take fixed prefix to all
candidates by passing it in $2 and used to complete names of
configuration variables in a section, but it seems to me that it can
be repurposed when prefixing "$(git rev-parse --show-prefix)" to a
given pathname relative to the $cwd).  And if that can be done, then
you are "not mistaken", but merely being dogmatic and limiting what
your code can do yourself.

>> Another more fundamental approach to avoid "confusion" this bullet
>> item tries to side step might be to *fix* the command that gets
>> completed.  As "git sparse-checkout --help" is marked as
>> EXPERIMENTAL in capital letters, we should be able to say "what was
>> traditionally known as 'add' is from now on called 'add-pattern' and
>> command line completion would not get in the way; the 'add'
>> subcommand now takes only literal paths, not patterns, that are
>> relative to the current directory" if we wanted to.
>
> That's interesting...but it opens up a new can of worms:
>   * Would we also need both `set-patterns` and `set`, in addition to
> `add-patterns` and `add`?

If "set" has a similar UI issue that confuses end-users, then sure,
I do not see a reason why we want to leave it confusing---the
experimental labelling is to allow us to fix these warts more
easily, no?

>   * In cone mode, the paths passed are literal directories (and only
> directories; no individual files), but the thing added is a
> telescoping "cone" of leading directories as well.  Does this make it
> potentially confusing to users to say that `add` only takes literal
> paths?

I do not know.

>   * In cone mode (the default), should `add-patterns` just be an
> error, since no pattern specification is allowed?

I do not really care.  "add-patterns" is a potential tool you can
use to reduce friction while fixing the UI warts in an experimental
command.

>   * In the git-sparse-checkout manual, for performance reasons, we
> recommend users _not_ specify individual paths in non-cone mode.
> Would our recommendation then be to just not use `add` or `set` and
> only use `add-patterns` and `set-patterns`?

Very likely.  If the desired behaviour from the command can only be
had by castrating features, then such a recommendation would not
mean much to end-users anyway, though.

> If so, what have we
> accomplished by adding the new names?

It is valuable for those who do need to go against recommendation
(because the recommendation robs usability from them way too much),
will have much less confusing and working completion when they use
'add' or 'set', no?

> Maybe I'm missing something about your suggestion, but this seems much
> more complex than the simple solution we implemented in bb8b5e9a90d
> ("sparse-checkout: pay attention to prefix for {set, add}",
> 2022-02-19) for the !core_sparse_checkout_cone case.

Oh, if we do honor the $(git rev-parse --show-prefix), then that
changes the equation somewhat.  I got an impression from your log
message or cover letter that it wasn't the case, and that was where
the "if the command is so broken, then completion can add it for the
user" and "if the command is so broken, then fix it to take relative
paths" came from.

