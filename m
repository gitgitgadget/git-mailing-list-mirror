Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=apollographql.com header.i=@apollographql.com header.b="vq3iynbG"
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEB1198D
	for <git@vger.kernel.org>; Tue, 28 Nov 2023 13:04:40 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-42033328ad0so33353451cf.0
        for <git@vger.kernel.org>; Tue, 28 Nov 2023 13:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=apollographql.com; s=google; t=1701205480; x=1701810280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FphPD3XJwosnq+1cz6vgcHTlHB+GVfnwV4k4yngua/g=;
        b=vq3iynbGcnXkEkPEnZV55d7L6YZN/lRhfsw72VY6UjNmKEQyP17n+7hgI4qT/lK56/
         od00xR2W+TZi5MeeCrxiNc0HEHR6IpCB/JYH0ytZ8tt/cq+okvkXzKUnZnQZ+0G2ma89
         npA18cMwXNGYAtnLHwUU03FNkvSZ6GRbKz4OE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701205480; x=1701810280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FphPD3XJwosnq+1cz6vgcHTlHB+GVfnwV4k4yngua/g=;
        b=V6u6l0KZsN8cVAy32EJFOVG4WfYWAHczf4iN5i2OWsROdMQbkOdJ6Rppl2vbvrNFHO
         9AeKelq/iyDWU5+WcDVDcsVfnyzWs4ghtriJPxrTUxFePCnkbSBOvsTCSKiHME6JFa1w
         vspdJALidwQ6sj4mrrQKX77p7pM9hKJ0a12pNrwxSj1ZJRCdBstLYoCbFrRPYJHLUNd4
         ylHciiB/E/XbwAoHH5GGpyLL1m4cow5Z5T6w8eT36ofE5sEEo+A9PMufeetJUsieTMgT
         G/XUD6UDoIfJnggYx4FfNoZCO6Yyq+XmNqcs2zVU4ZGBayCmlKjmro4KkY7c6DEgInA0
         YEsQ==
X-Gm-Message-State: AOJu0Yy2KcIaLDvnDTXsT0O0gdeP6AdvUVKVuQ28M7zRxJafmcjhMM7X
	J5QiGJcwnvG7kdGo7tTRLsUdeKkV/Enw7KtroFN7qA==
X-Google-Smtp-Source: AGHT+IH9JFr+L/WySVzOwP0CiBc1kceNCwyzqRLAzlvkp7qX8wl/7ED7QwFt1loF5RSyblp0j1X8g0d3OiRKe99kUpI=
X-Received: by 2002:a05:622a:1808:b0:423:6f8e:8973 with SMTP id
 t8-20020a05622a180800b004236f8e8973mr23575735qtc.0.1701205479580; Tue, 28 Nov
 2023 13:04:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1587.v3.git.1696019580.gitgitgadget@gmail.com>
 <pull.1587.v4.git.1698347871200.gitgitgadget@gmail.com> <CAP8UFD18Hh=m8HQibAgZW1KNAn6zg_rxe9asg0ViC5z27W=Smw@mail.gmail.com>
In-Reply-To: <CAP8UFD18Hh=m8HQibAgZW1KNAn6zg_rxe9asg0ViC5z27W=Smw@mail.gmail.com>
From: Zach FettersMoore <zach.fetters@apollographql.com>
Date: Tue, 28 Nov 2023 16:04:28 -0500
Message-ID: <CAEWN6q3BHECpJtfr-ZiGoJtpt8n65h2r+DKsu8Yg2ZWb8_SgKQ@mail.gmail.com>
Subject: Re: [PATCH v4] subtree: fix split processing with multiple subtrees present
To: Christian Couder <christian.couder@gmail.com>
Cc: Zach FettersMoore via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>> In the diagram below, 'M' represents the mainline repo branch, 'A'
>> represents one subtree, and 'B' represents another. M3 and B1 represent
>> a split commit for subtree B that was created from commit M4. M2 and A1
>> represent a split commit made from subtree A that was also created
>> based on changes back to and including M4. M1 represents new changes to
>> the repo, in this scenario if you try to run a 'git subtree split
>> --rejoin' for subtree B, commits M1, M2, and A1, will be included in
>> the processing of changes for the new split commit since the last
>> split/rejoin for subtree B was at M3. The issue is that by having A1
>> included in this processing the command ends up needing to processing
>> every commit down tree A even though none of that is needed or relevant
>> to the current command and result.
>>
>> M1
>>  |        \       \
>> M2         |       |
>>  |        A1       |
>> M3         |       |
>>  |         |      B1
>> M4         |       |

> About the above, Junio already commented the following:
>
> -> The above paragraph explains which different things you drew in the
> -> diagram are representing, but it is not clear how they relate to
> -> each other.  Do they for example depict parent-child commit
> -> relationship?  What are the wide gaps between these three tracks and
> -> what are the short angled lines leaning to the left near the tip?
> -> Is the time/topology flowing from bottom to top?
>
> and it doesn't look like you have addressed that comment.
>
> When you say "M3 and B1 represent a split commit for subtree B that
> was created from commit M4." I am not sure what it means exactly.
> Could you give example commands that could have created the M3 and B1
> commits?

I removed the diagram from the commit message since it seems a little
unclear, and in its place I added an example of an open source repo
(which I am currently using the fix in) and the commands to replicate
the issue. Hopefully that better illustrates how I came across the issue
and what it is.

>> So this commit makes a change to the processing of commits for the split
>> command in order to ignore non-mainline commits from other subtrees such
>> as A1 in the diagram by adding a new function
>> 'should_ignore_subtree_commit' which is called during
>> 'process_split_commit'. This allows the split/rejoin processing to still
>> function as expected but removes all of the unnecessary processing that
>> takes place currently which greatly inflates the processing time.

> Could you tell a bit more what kind of processing time reduction is or
> would be possible on what kind of repo? Have you benchmark-ed or just
> timed this somehow on one of your repos or better on an open source
> repo (so that we could reproduce if we wanted)?

I added some extra info for this to the commit message as well, but to
answer your question yes I discovered and benchmarked this issue in a
repo I help maintain. I was seeing splits take upwards of 12 minutes
before the fix, and after they were taking only seconds. Also provided
infor on the repo and how to reproduce in the updated commit message.

>> Added a test to validate that the proposed fix
>> solves the issue.
>>
>> The test accomplishes this by checking the output
>> of the split command to ensure the output from
>> the progress of 'process_split_commit' function
>> that represents the 'extracount' of commits
>> processed does not increment.

> Does not increment compared to what?

I reworded this to say the 'extracount' remains at 0 since
there should be no extra processed commits from the second subtree
in the test.

>> This was tested against the original functionality
>> to show the test failed, and then with this fix
>> to show the test passes.
>>
>> This illustrated that when using multiple subtrees,
>> A and B, when doing a split on subtree B, the
>> processing does not traverse the entire history
>> of subtree A which is unnecessary and would cause
>> the 'extracount' of processed commits to climb
>> based on the number of commits in the history of
>> subtree A.

> Does this mean that the test checks that the extracount is the same
> when subtree A exists as when it doesn't exist?

This means the test is checking that the 'extracount' remains at
0, because anything above 0 would mean commits from subtree A were
being processed, which is where the issue stems from.

>>  contrib/subtree/git-subtree.sh     | 29 ++++++++++++++++++++-
>>  contrib/subtree/t/t7900-subtree.sh | 42 ++++++++++++++++++++++++++++++
>>  2 files changed, 70 insertions(+), 1 deletion(-)
>>
>> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtre=
e=3D
>.sh
>> index e0c5d3b0de6..e69991a9d80 100755
>> --- a/contrib/subtree/git-subtree.sh
>> +++ b/contrib/subtree/git-subtree.sh
>> @@ -778,6 +778,20 @@ ensure_valid_ref_format () {
>>                 die "fatal: '$1' does not look like a ref"
>>  }
>>
>> +# Usage: check if a commit from another subtree should be
>> +# ignored from processing for splits
>> +should_ignore_subtree_split_commit () {

> Maybe adding:
>
>     assert test $# =3D3D 1
>     local rev=3D3D"$1"
>
> here, and using $rev instead of $1 in this function could make things
> a bit clearer and similar to what is done in other functions.

Updated.

>> +  if test -n "$(git log -1 --grep=3D3D"git-subtree-dir:" $1)"
>> +  then
>> +    if test -z "$(git log -1 --grep=3D3D"git-subtree-mainline:" $1)" &&
>> +                       test -z "$(git log -1 --grep=3D3D"git-subtree-di=
r: =3D
>>  $arg_prefix$" $1)"
>> +    then
>> +      return 0
>> +    fi
>> +  fi
>> +  return 1
>> +}

> The above doesn't seem to be properly indented. We use tabs not spaces.

Fixed.

>>  # Usage: process_split_commit REV PARENTS
>>  process_split_commit () {
>>         assert test $# =3D3D 2
>> @@ -963,7 +977,20 @@ cmd_split () {
>>         eval "$grl" |
>>         while read rev parents
>>         do
>> -               process_split_commit "$rev" "$parents"
>> +               if should_ignore_subtree_split_commit "$rev"
>> +               then
>> +                       continue
>> +               fi
>> +               parsedParents=3D3D''

> It seems to me that we name variables "parsed_parents" (or sometimes
> "parsedparents") rather than "parsedParents".

Fixed.

>> +               for parent in $parents
>> +               do
>> +                       should_ignore_subtree_split_commit "$parent"
>> +                       if test $? -eq 1

> I think the 2 lines above could be replaced by:
>
> +                       if ! should_ignore_subtree_split_commit "$parent"

Updated.

>> +                       then
>> +                               parsedParents+=3D3D"$parent "

> It doesn't seem to me that we use "+=3D3D" much in our shell scripts.
> https://www.shellcheck.net/ emits the following:
>
> (warning): In POSIX sh, +=3D3D is undefined.
>
> so I guess we don't use it because it's not available in some usual shell=
s.
>
> (I haven't checked the script with https://www.shellcheck.net/ before
> and after your patch, but it might help avoid bash-isms and such
> issues.)

Updated this to remove the '+=3D' usage.

>> +                       fi
>> +               done
>> +               process_split_commit "$rev" "$parsedParents"
>>         done || exit $?

> It looks like we use "exit $?" a lot in git-subtree.sh while we use
> just "exit" most often elsewhere. Not sure why.

Yea I am unsure of the reasoning of that, I was just trying to follow the
what the existing script was already doing.

>>         latest_new=3D3D$(cache_get latest_new) || exit $?
>> diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t790=
0=3D
>> -subtree.sh
>> index 49a21dd7c9c..87d59afd761 100755
>> --- a/contrib/subtree/t/t7900-subtree.sh
>> +++ b/contrib/subtree/t/t7900-subtree.sh
>> @@ -385,6 +385,48 @@ test_expect_success 'split sub dir/ with --rejoin' =
'
>>         )
>>  '
>>
>> +test_expect_success 'split with multiple subtrees' '
>> +       subtree_test_create_repo "$test_count" &&
>> +       subtree_test_create_repo "$test_count/subA" &&
>> +       subtree_test_create_repo "$test_count/subB" &&
>> +       test_create_commit "$test_count" main1 &&
>> +       test_create_commit "$test_count/subA" subA1 &&
>> +       test_create_commit "$test_count/subA" subA2 &&
>> +       test_create_commit "$test_count/subA" subA3 &&
>> +       test_create_commit "$test_count/subB" subB1 &&
>> +       (
>> +               cd "$test_count" &&
>> +               git fetch ./subA HEAD &&
>> +               git subtree add --prefix=3D3DsubADir FETCH_HEAD
>> +       ) &&
>> +       (
>> +               cd "$test_count" &&
>> +               git fetch ./subB HEAD &&
>> +               git subtree add --prefix=3D3DsubBDir FETCH_HEAD
>> +       ) &&
>> +       test_create_commit "$test_count" subADir/main-subA1 &&
>> +       test_create_commit "$test_count" subBDir/main-subB1 &&
>> +       (
>> +               cd "$test_count" &&
>> +               git subtree split --prefix=3D3DsubADir --squash --rejoin=
 -m=3D
>> "Sub A Split 1"
>> +       ) &&

> Not sure why there are so many sub-shells used, and why the -C option
> is not used instead to tell Git to work in a subdirectory. I guess you
> copied what most existing (old) tests in this test script do.
>
> For example perhaps the 4 line above could be replaced by just:
>
> +               git -C "$test_count" subtree split --prefix=3D3DsubADir
> --squash --rejoin -m "Sub A Split 1" &&

Yea I was following what was being done in other existing tests, although
this seems like a better way to do this so I updated the test to remove
the extra sub-shells.

>> +       (
>> +               cd "$test_count" &&
>> +               git subtree split --prefix=3D3DsubBDir --squash --rejoin=
 -m=3D
>> "Sub B Split 1"
>> +       ) &&
>> +       test_create_commit "$test_count" subADir/main-subA2 &&
>> +       test_create_commit "$test_count" subBDir/main-subB2 &&
>> +       (
>> +               cd "$test_count" &&
>> +               git subtree split --prefix=3D3DsubADir --squash --rejoin=
 -m=3D
>> "Sub A Split 2"
>> +       ) &&
>> +       (
>> +               cd "$test_count" &&
>> +               test "$(git subtree split --prefix=3D3DsubBDir --squash =
--r=3D
>> ejoin \
>> +                -d -m "Sub B Split 1" 2>&1 | grep -w "\[1\]")" =3D3D ""
>> +       )
>> +'

> It's not clear to me what the test is doing. Maybe you could split it
> into 2 tests. Perhaps one setting up a repo with multiple subtrees and
> one checking that a new split ignores other subtree split commits.
> Perhaps adding a few comments would help too.

Added some comments before the test to describe the steps the test is takin=
g in
order to verify the desired behavior.


On Sat, Nov 18, 2023 at 6:28=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Thu, Oct 26, 2023 at 9:18=E2=80=AFPM Zach FettersMoore via GitGitGadge=
t
> <gitgitgadget@gmail.com> wrote:
> >
> > From: Zach FettersMoore <zach.fetters@apollographql.com>
> >
> > When there are multiple subtrees present in a repository and they are
> > all using 'git subtree split', the 'split' command can take a
> > significant (and constantly growing) amount of time to run even when
> > using the '--rejoin' flag. This is due to the fact that when processing
> > commits to determine the last known split to start from when looking
> > for changes, if there has been a split/merge done from another subtree
> > there will be 2 split commits, one mainline and one subtree, for the
> > second subtree that are part of the processing. The non-mainline
> > subtree split commit will cause the processing to always need to search
> > the entire history of the given subtree as part of its processing even
> > though those commits are totally irrelevant to the current subtree
> > split being run.
>
> Thanks for your continued work on this!
>
> I am not familiar with git subtree so I might miss obvious things. On
> the other hand, my comments might help increase a bit the number of
> people who could review this patch.
>
> > In the diagram below, 'M' represents the mainline repo branch, 'A'
> > represents one subtree, and 'B' represents another. M3 and B1 represent
> > a split commit for subtree B that was created from commit M4. M2 and A1
> > represent a split commit made from subtree A that was also created
> > based on changes back to and including M4. M1 represents new changes to
> > the repo, in this scenario if you try to run a 'git subtree split
> > --rejoin' for subtree B, commits M1, M2, and A1, will be included in
> > the processing of changes for the new split commit since the last
> > split/rejoin for subtree B was at M3. The issue is that by having A1
> > included in this processing the command ends up needing to processing
> > every commit down tree A even though none of that is needed or relevant
> > to the current command and result.
> >
> > M1
> >  |        \       \
> > M2         |       |
> >  |        A1       |
> > M3         |       |
> >  |         |      B1
> > M4         |       |
>
> About the above, Junio already commented the following:
>
> -> The above paragraph explains which different things you drew in the
> -> diagram are representing, but it is not clear how they relate to
> -> each other.  Do they for example depict parent-child commit
> -> relationship?  What are the wide gaps between these three tracks and
> -> what are the short angled lines leaning to the left near the tip?
> -> Is the time/topology flowing from bottom to top?
>
> and it doesn't look like you have addressed that comment.
>
> When you say "M3 and B1 represent a split commit for subtree B that
> was created from commit M4." I am not sure what it means exactly.
> Could you give example commands that could have created the M3 and B1
> commits?
>
> > So this commit makes a change to the processing of commits for the spli=
t
> > command in order to ignore non-mainline commits from other subtrees suc=
h
> > as A1 in the diagram by adding a new function
> > 'should_ignore_subtree_commit' which is called during
> > 'process_split_commit'. This allows the split/rejoin processing to stil=
l
> > function as expected but removes all of the unnecessary processing that
> > takes place currently which greatly inflates the processing time.
>
> Could you tell a bit more what kind of processing time reduction is or
> would be possible on what kind of repo? Have you benchmark-ed or just
> timed this somehow on one of your repos or better on an open source
> repo (so that we could reproduce if we wanted)?
>
> > Added a test to validate that the proposed fix
> > solves the issue.
> >
> > The test accomplishes this by checking the output
> > of the split command to ensure the output from
> > the progress of 'process_split_commit' function
> > that represents the 'extracount' of commits
> > processed does not increment.
>
> Does not increment compared to what?
>
> > This was tested against the original functionality
> > to show the test failed, and then with this fix
> > to show the test passes.
> >
> > This illustrated that when using multiple subtrees,
> > A and B, when doing a split on subtree B, the
> > processing does not traverse the entire history
> > of subtree A which is unnecessary and would cause
> > the 'extracount' of processed commits to climb
> > based on the number of commits in the history of
> > subtree A.
>
> Does this mean that the test checks that the extracount is the same
> when subtree A exists as when it doesn't exist?
>
> [...]
>
> >  contrib/subtree/git-subtree.sh     | 29 ++++++++++++++++++++-
> >  contrib/subtree/t/t7900-subtree.sh | 42 ++++++++++++++++++++++++++++++
> >  2 files changed, 70 insertions(+), 1 deletion(-)
> >
> > diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtr=
ee.sh
> > index e0c5d3b0de6..e69991a9d80 100755
> > --- a/contrib/subtree/git-subtree.sh
> > +++ b/contrib/subtree/git-subtree.sh
> > @@ -778,6 +778,20 @@ ensure_valid_ref_format () {
> >                 die "fatal: '$1' does not look like a ref"
> >  }
> >
> > +# Usage: check if a commit from another subtree should be
> > +# ignored from processing for splits
> > +should_ignore_subtree_split_commit () {
>
> Maybe adding:
>
>     assert test $# =3D 1
>     local rev=3D"$1"
>
> here, and using $rev instead of $1 in this function could make things
> a bit clearer and similar to what is done in other functions.
>
> > +  if test -n "$(git log -1 --grep=3D"git-subtree-dir:" $1)"
> > +  then
> > +    if test -z "$(git log -1 --grep=3D"git-subtree-mainline:" $1)" &&
> > +                       test -z "$(git log -1 --grep=3D"git-subtree-dir=
: $arg_prefix$" $1)"
> > +    then
> > +      return 0
> > +    fi
> > +  fi
> > +  return 1
> > +}
>
> The above doesn't seem to be properly indented. We use tabs not spaces.
>
> >  # Usage: process_split_commit REV PARENTS
> >  process_split_commit () {
> >         assert test $# =3D 2
> > @@ -963,7 +977,20 @@ cmd_split () {
> >         eval "$grl" |
> >         while read rev parents
> >         do
> > -               process_split_commit "$rev" "$parents"
> > +               if should_ignore_subtree_split_commit "$rev"
> > +               then
> > +                       continue
> > +               fi
> > +               parsedParents=3D''
>
> It seems to me that we name variables "parsed_parents" (or sometimes
> "parsedparents") rather than "parsedParents".
>
> > +               for parent in $parents
> > +               do
> > +                       should_ignore_subtree_split_commit "$parent"
> > +                       if test $? -eq 1
>
> I think the 2 lines above could be replaced by:
>
> +                       if ! should_ignore_subtree_split_commit "$parent"
>
> > +                       then
> > +                               parsedParents+=3D"$parent "
>
> It doesn't seem to me that we use "+=3D" much in our shell scripts.
> https://www.shellcheck.net/ emits the following:
>
> (warning): In POSIX sh, +=3D is undefined.
>
> so I guess we don't use it because it's not available in some usual shell=
s.
>
> (I haven't checked the script with https://www.shellcheck.net/ before
> and after your patch, but it might help avoid bash-isms and such
> issues.)
>
> > +                       fi
> > +               done
> > +               process_split_commit "$rev" "$parsedParents"
> >         done || exit $?
>
> It looks like we use "exit $?" a lot in git-subtree.sh while we use
> just "exit" most often elsewhere. Not sure why.
>
> >         latest_new=3D$(cache_get latest_new) || exit $?
> > diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t79=
00-subtree.sh
> > index 49a21dd7c9c..87d59afd761 100755
> > --- a/contrib/subtree/t/t7900-subtree.sh
> > +++ b/contrib/subtree/t/t7900-subtree.sh
> > @@ -385,6 +385,48 @@ test_expect_success 'split sub dir/ with --rejoin'=
 '
> >         )
> >  '
> >
> > +test_expect_success 'split with multiple subtrees' '
> > +       subtree_test_create_repo "$test_count" &&
> > +       subtree_test_create_repo "$test_count/subA" &&
> > +       subtree_test_create_repo "$test_count/subB" &&
> > +       test_create_commit "$test_count" main1 &&
> > +       test_create_commit "$test_count/subA" subA1 &&
> > +       test_create_commit "$test_count/subA" subA2 &&
> > +       test_create_commit "$test_count/subA" subA3 &&
> > +       test_create_commit "$test_count/subB" subB1 &&
> > +       (
> > +               cd "$test_count" &&
> > +               git fetch ./subA HEAD &&
> > +               git subtree add --prefix=3DsubADir FETCH_HEAD
> > +       ) &&
> > +       (
> > +               cd "$test_count" &&
> > +               git fetch ./subB HEAD &&
> > +               git subtree add --prefix=3DsubBDir FETCH_HEAD
> > +       ) &&
> > +       test_create_commit "$test_count" subADir/main-subA1 &&
> > +       test_create_commit "$test_count" subBDir/main-subB1 &&
> > +       (
> > +               cd "$test_count" &&
> > +               git subtree split --prefix=3DsubADir --squash --rejoin =
-m "Sub A Split 1"
> > +       ) &&
>
> Not sure why there are so many sub-shells used, and why the -C option
> is not used instead to tell Git to work in a subdirectory. I guess you
> copied what most existing (old) tests in this test script do.
>
> For example perhaps the 4 line above could be replaced by just:
>
> +               git -C "$test_count" subtree split --prefix=3DsubADir
> --squash --rejoin -m "Sub A Split 1" &&
>
> > +       (
> > +               cd "$test_count" &&
> > +               git subtree split --prefix=3DsubBDir --squash --rejoin =
-m "Sub B Split 1"
> > +       ) &&
> > +       test_create_commit "$test_count" subADir/main-subA2 &&
> > +       test_create_commit "$test_count" subBDir/main-subB2 &&
> > +       (
> > +               cd "$test_count" &&
> > +               git subtree split --prefix=3DsubADir --squash --rejoin =
-m "Sub A Split 2"
> > +       ) &&
> > +       (
> > +               cd "$test_count" &&
> > +               test "$(git subtree split --prefix=3DsubBDir --squash -=
-rejoin \
> > +                -d -m "Sub B Split 1" 2>&1 | grep -w "\[1\]")" =3D ""
> > +       )
> > +'
>
> It's not clear to me what the test is doing. Maybe you could split it
> into 2 tests. Perhaps one setting up a repo with multiple subtrees and
> one checking that a new split ignores other subtree split commits.
> Perhaps adding a few comments would help too.
>
> Best,
> Christian.
