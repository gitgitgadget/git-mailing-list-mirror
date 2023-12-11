Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=apollographql.com header.i=@apollographql.com header.b="LoPkiOcy"
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664D2101
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 07:39:50 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-425c3e14380so10589501cf.3
        for <git@vger.kernel.org>; Mon, 11 Dec 2023 07:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=apollographql.com; s=google; t=1702309189; x=1702913989; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C0Q7k+E0PbjFLtNxbtDXuvJIfwDQfjJfQOhZ501mKAI=;
        b=LoPkiOcy0wc2vJDP1MA79B2AyYHHVjX5pej5rT0wg504ja02v7XbE0DH1tnWh8aVrZ
         A4TH/XoBdiNL1ytndtzZBfXgocUq/HKr7OZm5fs1Y6zYapHhWRtf8ZC/Klym1XH4eylb
         yqc/aJZsZBfeVeVpfG2u5qoPou45vHkt46diU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702309189; x=1702913989;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C0Q7k+E0PbjFLtNxbtDXuvJIfwDQfjJfQOhZ501mKAI=;
        b=AdnqZd4xSsKkQA+lIA4pNco1IowHtlWOepdcxtfuBDFjKc4r4iyPXc9fQhYPfChnaq
         ITkXSxnIFg+5ee2WVxTT2cae3O5TAN6mAvD9j71xo/ZHfmvLvp+hXVKd3qXq1lOmRguI
         rBVoa6a8Gow2qBeOoMki/SEqfqUdIfa1QRbUGufLP88d4hz1LhArye6VX6RCdldLyBYj
         RBwluFzIHdgdZZpVXIdim7KC4Dvd+p80DTTkCNGkABaBJf7e06RFwS+5OjwtGrc4OTFY
         M94MtZozHnOuxC8DtX0WUR6Gg6jTxoDd/NUdJXsVAmyIUrI3VTD+ieV4Yei284ZY7krY
         quLw==
X-Gm-Message-State: AOJu0YyjlVOsLXk+1+EEguNZb8gfuNecNIQ5NoPL06fER0kBNQwp0quJ
	6tEeFecAUh4ngqpuCL+7hG0M2+zjXZB/iWdMOTs3mQ==
X-Google-Smtp-Source: AGHT+IFcBDpMg2eCqm6w222E47iUwHiPXuTErbNM19FkesrZun4Ujw9/cxc2ieQe83rQsYUf84sMt10oJHXNSBCRdHo=
X-Received: by 2002:ac8:5c90:0:b0:425:4043:96e9 with SMTP id
 r16-20020ac85c90000000b00425404396e9mr7208695qta.118.1702309189412; Mon, 11
 Dec 2023 07:39:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1587.v5.git.1701206267300.gitgitgadget@gmail.com>
 <pull.1587.v6.git.1701442494319.gitgitgadget@gmail.com> <CAP8UFD3FzP6QW4dJ9yiG1BAytLcsk+zGE+CBeArRJBJ8gsaDMQ@mail.gmail.com>
In-Reply-To: <CAP8UFD3FzP6QW4dJ9yiG1BAytLcsk+zGE+CBeArRJBJ8gsaDMQ@mail.gmail.com>
From: Zach FettersMoore <zach.fetters@apollographql.com>
Date: Mon, 11 Dec 2023 10:39:38 -0500
Message-ID: <CAEWN6q3RTbVuMb0VyCYz196ZL+OGAAHbJLZ2-MnW1RVVabg7Mw@mail.gmail.com>
Subject: Re: [PATCH v6] subtree: fix split processing with multiple subtrees present
To: Christian Couder <christian.couder@gmail.com>
Cc: Zach FettersMoore via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>>
>> From: Zach FettersMoore <zach.fetters@apollographql.com>
>>
>> When there are multiple subtrees present in a repository and they are
>> all using 'git subtree split', the 'split' command can take a
>> significant (and constantly growing) amount of time to run even when
>> using the '--rejoin' flag. This is due to the fact that when processing
>> commits to determine the last known split to start from when looking
>> for changes, if there has been a split/merge done from another subtree
>> there will be 2 split commits, one mainline and one subtree, for the
>> second subtree that are part of the processing. The non-mainline
>> subtree split commit will cause the processing to always need to search
>> the entire history of the given subtree as part of its processing even
>> though those commits are totally irrelevant to the current subtree
>> split being run.
>>
>> To see this in practice you can use the open source GitHub repo
>> 'apollo-ios-dev' and do the following in order:
>>
>> -Make a changes to a file in 'apollo-ios' and 'apollo-ios-codegen'
>> directories
>> -Create a commit containing these changes
>> -Do a split on apollo-ios-codegen
>> - Do a fetch on the subtree repo
>> - git fetch git@github.com:apollographql/apollo-ios-codegen.git
>> - git subtree split --prefix=apollo-ios-codegen --squash --rejoin

> Now I get the following without your patch at this step:
>
> $ git subtree split --prefix=apollo-ios-codegen --squash --rejoin
> [...]/libexec/git-core/git-subtree: 318: Maximum function recursion
> depth (1000) reached
>
> Line 318 in git-subtree.sh contains the following:
>
> missed=$(cache_miss "$@") || exit $?
>
> With your patch it seems to work:
>
> $ git subtree split --prefix=apollo-ios-codegen --squash --rejoin
> Merge made by the 'ort' strategy.
> e274aed3ba6d0659fb4cc014587cf31c1e8df7f4

Looking into this some it looks like it could be a bash config
difference? My machine always runs it all the way through vs
failing for recursion depth. Although that would also be an issue
which is solved by this fix.

>> - Depending on the current state of the 'apollo-ios-dev' repo
>> you may see the issue at this point if the last split was on
>> apollo-ios

> I guess I see it, but it seems a bit different for me than what you describe.
>
> Otherwise your patch looks good to me now.

Yea I hadn't accounted for/realized that some folks may see a recursion
depth error vs it just taking a long time like it does for me. Also what
I was saying with the apollo-ios-dev repo is you may not need all the steps
to see the issue, because its possible the state of the repo is already
in a position to display the issue just by doing a split on
apollo-ios-codegen.

Great! Thanks again for all the feedback and guidance! Is there anything
else I need to do to get this across the finish line and merged in?
