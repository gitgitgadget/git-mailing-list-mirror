Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D8B188
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 00:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YINRJELz"
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161A892
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 17:08:44 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1ea82246069so155926fac.3
        for <git@vger.kernel.org>; Mon, 16 Oct 2023 17:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697501321; x=1698106121; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a4xw0S6JLM1xLvgWnWuLFq/sTz8sJymq27J9WH5B+uU=;
        b=YINRJELzv4XOY569EAUyV7EW6sHq/asIB4N6HicvBdNjqIV8WrB+mD/b+QLa+GgVU4
         x67UtWWw+0bj1E4ia6BebjfGhf+fgJXLrgGBn0TO+Yt+NcJezGGd424ERCWTtCM2lxXM
         J+pg1riwEdJjvi0xK/ybg6TiYeZApQX5ri4OSq3pLhVXAx8X/R1F/0XXwdUmcuAZpSwd
         Ru5qjcoHln1UhMUQqkrUDqKVRkxSPIHyVZXXUZtZ6PBQsvUFnqmiqQPo7iTb7uhZV49g
         oBnfttXuIoyXnUs95Dws1FgLbJJuPN6BYW1bMIHuC2VSnfv7q9TxpFH4cKA0Ouj5Dfp2
         mvfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697501321; x=1698106121;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a4xw0S6JLM1xLvgWnWuLFq/sTz8sJymq27J9WH5B+uU=;
        b=vxvJ1bcUBNcpRwOFPMjEnA/wFQCMDZ6EUGdbVUGw8VVOatZtINjGoQR71SAv4b8pJt
         8KjEzCLVVVxHkCI2+uJYA+OY7OFrJ4T7o3+77O8Lw4UFLQuXaAneHaDqPZFhmCBl5N6F
         Rx1j4byRb/uLrRevx95uraWCZbWDyUy1xw3X4zkc+vU2lZUY+8j2GMxCyuRl+R67e3U9
         AT8VpEFt3QzwZD9lO0AV6JKqurY6bdMovdFnk4KrC3RDTBI/cgCoSs+m8Yi1zHTvrPDA
         CneTjitDO8BgMBCLjSmxH+fJ3oeg3/MAaonPGlDcsbLjwNnvP1qgvHMgDLv885RO7B0S
         pukw==
X-Gm-Message-State: AOJu0YxpXO/u7btLAV2J9zR5Ufwx9UQOgW0gNYAxTPz7/ZgCVREApnKp
	DEFVkWmYfeLkAzagNuDiY0efDRBL0cfaSoXt731sUJSNLdgo4h2betPiMu84
X-Google-Smtp-Source: AGHT+IFM6nYfNiwk0vdSrqi2XWmHXGDQjXOhCq7YBMJY9ubcQcp/pVp/7dOwafkNbDcp4ZvLGHha/udM2/gVZf2uNAY=
X-Received: by 2002:a05:6870:1019:b0:1e9:badb:acaa with SMTP id
 25-20020a056870101900b001e9badbacaamr681171oai.23.1697501321423; Mon, 16 Oct
 2023 17:08:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Joanna Wang <jojwang@google.com>
Date: Mon, 16 Oct 2023 20:08:30 -0400
Message-ID: <CAMmZTi89Un+bsLXdEdYs44oT8eLNp8y=Pm8ywaurcQ7ccRKGdQ@mail.gmail.com>
Subject: Bug: dir.c traversing the filesystem: unindexed directories do not
 get recursed into when there is a (non-excluding) pathspec
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

What did you do before the bug happened? (Steps to reproduce your issue)
I created a new untracked directory `foo/`.
In .gitattributes i added `bar_yes* text`
and created files `foo/bar_yes` and `foo/bar_no` with content 'chicken'

I tried the following commands:
git grep --no-index chicken -- ':(attr:text)foo/*'
git ls-files --others --exclude-standard ':(attr:text)foo/*'
git status ':(attr:text)foo/*'


What did you expect to happen? (Expected behavior)
For all of the above, I expected `foo/bar_yes` to be returned.

What happened instead? (Actual behavior)
For all three commands, nothing was returned.

Anything else you want to add:
If I change the pathspec to ':(exclude,attr:text)foo/*' it works as expected.
`foo/bar_no` is returned.

(except for git status where the output is just `foo/`, but I think
this is expected.)

This behavior seems due to this section in dir.c:
https://github.com/git/git/blob/master/dir.c#L1893-L1908
for a pathspec like ':(attr:text)foo/*', this section of code will prevent
`foo/` from getting recursed.
It only checks for a pathspec match against the directory name, so any
files under the dir aren't checked.
Commenting that part of the code out, seems to fix this issue.
(for `git status`, `foo/` is returned both with `exclude` in the
pathspec and without)
But I am not sure if simply removing that code is the right fix.

[Enabled Hooks]
commit-msg
pre-commit
prepare-commit-msg
