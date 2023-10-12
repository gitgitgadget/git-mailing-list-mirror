Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F324BCDB47E
	for <git@archiver.kernel.org>; Thu, 12 Oct 2023 10:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347143AbjJLKzj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Oct 2023 06:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347140AbjJLKzh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2023 06:55:37 -0400
Received: from st43p00im-ztfb10061701.me.com (st43p00im-ztfb10061701.me.com [17.58.63.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32049D3
        for <git@vger.kernel.org>; Thu, 12 Oct 2023 03:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1697108132;
        bh=JJt9GFQITEnWHulqlDcIK5Xb3knTRgkXijG98fy0X28=;
        h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
        b=DOaUmrq6K1cMWrM+5GBIq6V+fSGSQVSnfHJg9eQOvzvUm7HMcs22hUvsf1pc8+GoM
         IRQbvR2FFQEpeBiA4DFJSL+G8OcWkvfq9ZJJQi71weLr35fadqDW6387KqGt32h3Tw
         zm5OofjmlpRS/K8o0eVsz8AuCje5oY7DeNrnj622IrQaOhMO6JItW6e9uX4WaaKwm9
         GxlqSgkKde/juSMWZtDyPYM5jTt+3Ox8sZzjB8Mk3ygoM+8NdVqkpQrlFwuAaOUiNp
         vaYBorOygxJJam/EPGZwOewVOyZ53iluAfYE+IkBtaOHwd7qW7sXV9x2OC2NE3/yWX
         IBQvmfJZz/vqA==
Received: from smtpclient.apple (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
        by st43p00im-ztfb10061701.me.com (Postfix) with ESMTPSA id ACC8F2E02DE;
        Thu, 12 Oct 2023 10:55:31 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [RFC] Define "precious" attribute and support it in `git clean`
From:   Sebastian Thiel <sebastian.thiel@icloud.com>
In-Reply-To: <xmqqttqytnqb.fsf@gitster.g>
Date:   Thu, 12 Oct 2023 12:55:19 +0200
Cc:     git@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0E44CB2C-57F2-4075-95BE-60FBFDD3CEE2@icloud.com>
References: <79901E6C-9839-4AB2-9360-9EBCA1AAE549@icloud.com>
 <xmqqttqytnqb.fsf@gitster.g>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)
X-Proofpoint-ORIG-GUID: XQqWqHDD2LevMimqeHkbvYF2lX-ENDQu
X-Proofpoint-GUID: XQqWqHDD2LevMimqeHkbvYF2lX-ENDQu
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.573,18.0.957,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2023-05-18=5F15:2023-05-17=5F02,2023-05-18=5F15,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 clxscore=1011 adultscore=0 spamscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2310120088
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I liked the idea too see precious files as sub-class of ignored files, =
and
investigated possibilities on how to achieve that while keeping the =
overall
effort low and remove any potential for backwards-incompatibility as =
well.

Currently, `.gitignore` files only contain one pattern per line, which
optionally may be prefixed with `!` to negate it. This can be escaped =
with `\!`
- and that's it.

Parsing patterns that way makes for simple parsing without a need for
quoting.

### What about a `$` syntax in `.gitignore` files?

I looked into adding a new prefix, `$` to indicate the following path is
precious or=E2=80=A6 valuable. It can be escaped with `\$` just like =
`\!`.=20

Doing so has the advantage that older `git` versions simply take the
declaration as literal and would now exclude `$.config`, for example, =
whereas
newer `git` versions will consider them precious.

There is some potential for accidentally excluding files that previously
were untracked with older versions of git, but I'd think chances are =
low.

#### Example: Linux kernel

`.config` is ignored via `.gitignore:=20

    .*

*Unfortunately*, users can't just add a local `.git/info/exclude` file =
with
`$.config` in it and expect `.config` to be considered precious as the =
pattern
search order will search this last as it's part of the exclude-globals. =
The
same is true for per-user git-ignore files. This means that any git =
would
have the `.*` pattern match before the `$.config` pattern, and stop =
right there
concluding that it's expendable, instead of precious. This is how users =
can
expect `.gitignore` files to work, and this is how `!negations` work as =
well -
the negation has to come after the actual exclusion to be effective.

Thus, to make this work, projects that ship the `.gitignore` files would =
*have
to add patterns* that make certain files precious.

Alternatively, users have to specify gitignore-overrides on the =
command-line,
but not all commands (if any except for `git check-ignore`) support =
that.

In the case of `git clean` one can already pass `--exclude=3Dpattern`, =
but if
that's needed one doesn't need syntax for precious files in the first =
place.

**This makes the $precious syntax useful only for projects who chose to =
opt in,
but makes overrides for users near impossible**.

Such opted-in projects would produce `.gitignore` files like these:

    .*
    $.config

Note that due to the way ignore patterns are searched, the following =
would
consider `.config` trackable, not precious:

    .*
    $.config
    !.config

It's up the maintainer of the repository to configure their .gitignore =
files
correctly, so nothing new either.

#### Benefits

* simple implementation, fast
* backwards compatible

#### Disadvantages

* cannot easily be overridden by the user as part of their local =
settings.
* needs repository-buy-in to be useful
* $file could clash with the file '$file' and cause older git  to ignore =
it

### What about a `precious` attribute?

The search of `.gitattributes` works differently which makes it possible =
for
users to set attributes on any file or folder easily using their local =
files.
Using attributes has the added benefit of being extensible as one can =
start out
with:

```gitattributes
.config precious
```

and optionally continue with=E2=80=A6

```gitattributes
.config precious=3Dinput
kernel precious=3Doutput
```

=E2=80=A6to further classify kinds of precious files, probably for their =
personal use.
Please note that currently pathspecs can't be used to filter by =
attribute
for files that are igonred and untracked or I couldn't figure out how.
That even makes sense as it wasn't considered a use-case yet.


#### Benefits

* backwards compatible
* easily extendable with 'tags' or sub-classes of precious files using =
the
  assignment syntax.
* overridable with user's local files

#### Disadvantages

* any 'exclude' query now also needs a .gitattribute query to support =
precious
  files (and it's not easy to optimize unless there is a flag to turn =
precious
  file support on or off)
* `precious` might be in use by some repos which now gains a possibly =
different
  meaning in `git` as well.

### Conclusion

Weighing advantages and disadvantages of both approaches makes me prefer =
the
`.gitignore` extension. The `.gitattributes` version of it *could* also =
be
implemented on top of it at a later date. However, it should be gated =
behind a
configuration flag so users who need it as they want local overrides
can opt-in. Then they also pay for the feature which for most =
repositories=20
won't be an issue in the first place.

All this seems a bit too good to be true, and I hope you can show where
it wouldn't work or which dangers or possible issues haven't been
mentioned yet.

