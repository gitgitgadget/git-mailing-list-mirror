Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="buA8Nmwv"
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369E7BB
	for <git@vger.kernel.org>; Mon,  4 Dec 2023 03:08:17 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a18b0f69b33so766415866b.0
        for <git@vger.kernel.org>; Mon, 04 Dec 2023 03:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701688095; x=1702292895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zoyyZwgqH7hkMBy1A0bBfGGfHPzyNqCB67kGouJ3jqU=;
        b=buA8Nmwv2cig9s2bR+kCTuEpVXD2LY3BGG7nDAdk9spSgBnRNjJLg1yrLU71vGjceP
         tV4lg5qFrWqcpwkFelOTvk5Jg5+V5ikgQIPX8BJaMLdq2pekMSsE1G3TC85egQOU8B7P
         eDbfggKsgsYF0ib+tlydB6m0OxyioKCQEG+1iejdSiPVMYZQbFw2N0LdL4qrhFV60wmo
         r8IMiu9PD5W+NWLolwe+dlirQLCA8gf6e6QuGjmyTjhpsz4cHiH/6952Y894C9sgJILX
         uJpDA3dSIvXkHsH8jrn3l0OV/0EWWKDT8Pa6UPaw9tKmabv4fuILgyaQClwKQu/b7XfW
         006A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701688095; x=1702292895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zoyyZwgqH7hkMBy1A0bBfGGfHPzyNqCB67kGouJ3jqU=;
        b=poi926b5aXNLSzGY0Y9cO9kEuBmbExHVvbAU5ji1SuK86Ji2kwOXogHPGWRMd/JEjN
         Pd3/I0AmIzM2RvQfGNjePydww7BuoXY2wejYtZggEASYmkETJruIy2d/AEZpkXsCHzwH
         8nbLTZAmD5Kp/0pI0Y0EwfWNL13EtVx62fLfnxaED/JgSOQZctIhyPzlKxNSkOadRXZK
         /pjNLWWBiGVxgY146ETJ+luyu6LnyfniSylGNDNBAV9N1sDDHRF4D/U+tKpZbH9Xv11S
         pbxQ3Q7Vn1X9lYqKGyNW+citmaiSniM6xvjYVoGSHvKCM7dR8DRQBurMIAxQANpS3fWk
         eD2Q==
X-Gm-Message-State: AOJu0YwCl8zxLy9mihyKTCMlC6eQEt++ifWZA/y3MjFaOwjP9KOqCucc
	hxpfgm19SFe1tXpqYP2acgysh+6VvvdKWQCYyRg=
X-Google-Smtp-Source: AGHT+IEydnIlUUVwFfgNJsDAH5+fLi3QkwYAM/8Y0fIBTZXpPxdfeMtNiFU10h6mPI9k62cF2NKh/3tPb6+LXhzmfg4=
X-Received: by 2002:a17:906:5357:b0:9a9:f0e6:904e with SMTP id
 j23-20020a170906535700b009a9f0e6904emr5356222ejo.16.1701688095451; Mon, 04
 Dec 2023 03:08:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1587.v5.git.1701206267300.gitgitgadget@gmail.com> <pull.1587.v6.git.1701442494319.gitgitgadget@gmail.com>
In-Reply-To: <pull.1587.v6.git.1701442494319.gitgitgadget@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 4 Dec 2023 12:08:03 +0100
Message-ID: <CAP8UFD3FzP6QW4dJ9yiG1BAytLcsk+zGE+CBeArRJBJ8gsaDMQ@mail.gmail.com>
Subject: Re: [PATCH v6] subtree: fix split processing with multiple subtrees present
To: Zach FettersMoore via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Zach FettersMoore <zach.fetters@apollographql.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 1, 2023 at 3:54=E2=80=AFPM Zach FettersMoore via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Zach FettersMoore <zach.fetters@apollographql.com>
>
> When there are multiple subtrees present in a repository and they are
> all using 'git subtree split', the 'split' command can take a
> significant (and constantly growing) amount of time to run even when
> using the '--rejoin' flag. This is due to the fact that when processing
> commits to determine the last known split to start from when looking
> for changes, if there has been a split/merge done from another subtree
> there will be 2 split commits, one mainline and one subtree, for the
> second subtree that are part of the processing. The non-mainline
> subtree split commit will cause the processing to always need to search
> the entire history of the given subtree as part of its processing even
> though those commits are totally irrelevant to the current subtree
> split being run.
>
> To see this in practice you can use the open source GitHub repo
> 'apollo-ios-dev' and do the following in order:
>
> -Make a changes to a file in 'apollo-ios' and 'apollo-ios-codegen'
>  directories
> -Create a commit containing these changes
> -Do a split on apollo-ios-codegen
>    - Do a fetch on the subtree repo
>       - git fetch git@github.com:apollographql/apollo-ios-codegen.git
>    - git subtree split --prefix=3Dapollo-ios-codegen --squash --rejoin

Now I get the following without your patch at this step:

$ git subtree split --prefix=3Dapollo-ios-codegen --squash --rejoin
[...]/libexec/git-core/git-subtree: 318: Maximum function recursion
depth (1000) reached

Line 318 in git-subtree.sh contains the following:

missed=3D$(cache_miss "$@") || exit $?

With your patch it seems to work:

$ git subtree split --prefix=3Dapollo-ios-codegen --squash --rejoin
Merge made by the 'ort' strategy.
e274aed3ba6d0659fb4cc014587cf31c1e8df7f4

>    - Depending on the current state of the 'apollo-ios-dev' repo
>      you may see the issue at this point if the last split was on
>      apollo-ios

I guess I see it, but it seems a bit different for me than what you describ=
e.

Otherwise your patch looks good to me now.

Thanks,
Christian.
