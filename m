Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MyuCr7SB"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4FAAD
	for <git@vger.kernel.org>; Thu, 23 Nov 2023 17:19:15 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7584F1AD0E8;
	Thu, 23 Nov 2023 20:19:12 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Abqz6gsyGa0pVXfz8w45r8k1Ufswir5I0XTk9m
	xYTTE=; b=MyuCr7SBbD1oCbY9IPMPVjEeGfc51t/ZuGOaHcHu0d9ey3cmXEoCcI
	IeYxP/Omirri32q0J6kfias7pfJfFDDd90kAhe8QzjPmWD9Tj/TVj/OtsGYIc4jB
	tJe3QwsPjtbHTWzowya6qW2qMsrseSXJOaR7HAiBI6kuRQafae+h4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6D5EF1AD0E6;
	Thu, 23 Nov 2023 20:19:12 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CD38D1AD0E5;
	Thu, 23 Nov 2023 20:19:11 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 4/4] completion: avoid user confusion in non-cone mode
In-Reply-To: <fe8669a3f4f05c186e497f870c7e7ba9a94ac63f.1700761448.git.gitgitgadget@gmail.com>
	(Elijah Newren via GitGitGadget's message of "Thu, 23 Nov 2023
	17:44:08 +0000")
References: <pull.1349.git.1700761448.gitgitgadget@gmail.com>
	<fe8669a3f4f05c186e497f870c7e7ba9a94ac63f.1700761448.git.gitgitgadget@gmail.com>
Date: Fri, 24 Nov 2023 10:19:10 +0900
Message-ID: <xmqqo7fk9cdt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 796DC198-8A67-11EE-A600-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  		if [[ "$using_cone" == "true" ]]; then
>  			__gitcomp_directories

Hmph, doesn't "Providing the files and directories currently present
is thus always wrong." apply equally to cone mode?

> +		else
> +			# NEEDSWORK: It might be useful to provide a
> +			# completion function which:
> +			#
> +			#     1. Provides completions based on
> +			#        files/directories that exist in HEAD, not
> +			#        just those currently present in the working
> +			#        tree.

This makes a lot of sense.  May make even more sense with
s/HEAD/index/, though.

> +			#     4. Provides no completions when run from a
> +			#        subdirectory of the repository root.  (If we
> +			#        did provide file/directory completions, the
> +			#        user would just get a "please run from the
> +			#        toplevel directory" error message when they
> +			#        ran it.  *Further*, if the user did rerun
> +			#        the command from the toplevel, the
> +			#        completions we previously provided would
> +			#        likely be wrong as they'd be relative to the
> +			#        subdirectory rather than the repository
> +			#        root.  That could lead to users getting a
> +			#        nasty surprise based on trying to use a
> +			#        command we helped them create.)

Hmph, would an obvious alternative to (1) check against the HEAD (or
the index) to see if the prefix string matches an entity at the
current directory level, and then (2) to prefix the result of the
previous step with "/$(git rev-parse --show-prefix)" work?  That is
something like this:

    $ cd t
    $ git sparse-checkout add help<TAB>
    ->
    $ git sparse-checkout add /t/helper/

and when the user gave the full path from the root level, do the
obvious:

    $ cd t
    $ git sparse-checkout add /t/help<TAB>
    ->
    $ git sparse-checkout add /t/helper/

Another more fundamental approach to avoid "confusion" this bullet
item tries to side step might be to *fix* the command that gets
completed.  As "git sparse-checkout --help" is marked as
EXPERIMENTAL in capital letters, we should be able to say "what was
traditionally known as 'add' is from now on called 'add-pattern' and
command line completion would not get in the way; the 'add'
subcommand now takes only literal paths, not patterns, that are
relative to the current directory" if we wanted to.

> +			#     5. Provides escaped completions for any paths
> +			#        containing a '*', '?', '\', '[', ']', or
> +			#        leading '#' or '!'.  (These characters might
> +			#        already be escaped to protect from the
> +			#        shell, but they need an *extra* layer of
> +			#        escaping to prevent the pattern parsing in
> +			#        Git from seeing them as special characters.)
> +			#
> +			# Of course, this would be a lot of work, so for now,
> +			# just avoid the many forms of user confusion that
> +			# could be caused by providing bad completions by
> +			# providing a fake completion to avoid falling back to
> +			# bash's normal file and directory completion.

> +			COMPREPLY=( "" )
>  		fi
>  	esac
>  }
