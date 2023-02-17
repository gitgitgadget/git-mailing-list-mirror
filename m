Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC66FC636D7
	for <git@archiver.kernel.org>; Fri, 17 Feb 2023 21:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjBQVMl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Feb 2023 16:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjBQVMk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2023 16:12:40 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E325D3EB
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 13:12:37 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id cz7so5676558edb.12
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 13:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yZp6OmiQnAXe7BJ1uzeZPhjWoRaX4qDcnpTFjbzUvqg=;
        b=qEfT/YAOupjlcXXzvcuSWAJ6Y6XXTp0b0+h5ZyGfoAhplYwn4mTExmuDH9JZDrTI9L
         S7BU6gTrzTjhVpMM5Eyd0Kmf3A0GRZaZbnpRErS4ibAr4eiYMXe4LgNAnhJW8s65fHyY
         B+v6vQnbUNbKry78dj8zp1RqdnLaEqP/1Mdfqs3QtAxXWCStq7dBijvsxPKuO5bDx8UI
         p9W0P9HWVK0EadBZ8pciaASJQDnt93po6+Ue+oHiKzn7aanbfp1TDzP5VJmoIUodjDQ+
         qvRQZiYLcfcPo8HGkoaHipANpTxrBQSF2+MQDiGR+tGBRJCVN/I2dk9PEwRP75nJUuTb
         BVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yZp6OmiQnAXe7BJ1uzeZPhjWoRaX4qDcnpTFjbzUvqg=;
        b=SAUH7Y7zUbn6DkHB0wmZT3nSS5uhReEuEp1QIgVyQuny7FEo8uD6T196GXHH2Cm2r7
         LuoapQXQsUKiZo4VFxTHn0kah6bBEYBqo00SfNTtOTFI/4+AHRYSDLFmmUE9nme78yUq
         nUBTTXwDBMmbOeO1MYHp8FMdgut/OYtlTiL8hk9yCNvulJV4l2XCfAUoiqt6skvNqrGz
         JAZkea2TlfJFgcO//JrvQh69AgwrCSwBnpwvl9mAiUnqf87YMVqO6ipwgVyPlvDTN4Nf
         axrJAfX4krf+eeKR36Bv1KeifzNJ67Da1IZWsmbJ3Hh23jGX4RYqugQzsf60Gq5OZCvD
         TAog==
X-Gm-Message-State: AO0yUKWfn0h1h1Q7fwmI8ev+s0oB7gMV0MAMLiCuevRho8BzKyYCe6Fx
        4JSLpB2zAKWElw3ngJrv6guWytX3yeZ5JmQj1u6otazjSfF1n2KorNI=
X-Google-Smtp-Source: AK7set+StEZH7JpfovaFvDEDtB5TJXEcSupc5Q0uiuGa7XHDpFayazBhWmBX52DF17XWTod20NmHXUyLy13h4Ws6WKI=
X-Received: by 2002:a17:906:1347:b0:8b1:2fff:8689 with SMTP id
 x7-20020a170906134700b008b12fff8689mr1189002ejb.6.1676668355542; Fri, 17 Feb
 2023 13:12:35 -0800 (PST)
MIME-Version: 1.0
From:   Emily Shaffer <nasamuffin@google.com>
Date:   Fri, 17 Feb 2023 13:12:23 -0800
Message-ID: <CAJoAoZ=Cig_kLocxKGax31sU7Xe4==BGzC__Bg2_pr7krNq6MA@mail.gmail.com>
Subject: Proposal/Discussion: Turning parts of Git into libraries
To:     Git List <git@vger.kernel.org>
Cc:     Jonathan Nieder <jrn@google.com>,
        Jose Lopes <jabolopes@google.com>,
        Aleksandr Mikhailov <avmikhailov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

As I mentioned in standup this week[1], my colleagues and I at Google
have become very interested in converting parts of Git into libraries
usable by external programs. In other words, for some modules which
already have clear boundaries inside of Git - like config.[ch],
strbuf.[ch], etc. - we want to remove some implicit dependencies, like
references to globals, and make explicit other dependencies, like
references to other modules within Git. Eventually, we'd like both for
an external program to use Git libraries within its own process, and
for Git to be given an alternative implementation of a library it uses
internally (like a plugin at runtime).

This turned out pretty long-winded, so a quick summary before I dive in:

- We want to compile parts of Git as independent libraries
- We want to do it by making incremental code quality improvements to Git
- Let's avoid promising stability of the interfaces of those libraries
- We think it'll let Git do cool stuff like unit tests and allowing
purpose-built plugins
- Hopefully by example we can convince the rest of the project to join
in the effort

My team has spent the past year or so trying to make improvements to
Git's behavior with submodules, and we found that the current
structure of Git is quite tricky to work with: because Git doesn't
execute on second repositories in the same process well, recursing
into submodules typically involves spawning child processes, and
piping new arguments through the helpers around those child processes,
and then through Git's typical codepaths, is very tricky. After
spending more than a year trying to make improvements, we have very
little to show for it, largely as a result of the difficulty of
passing information between superprojects and submodules.

It seems like being able to invoke parts of Git as a library, or Git
being able to invoke custom libraries, does a lot of good for the Git
project:

- Having clear, modular libraries makes it easy to find the code
responsible for some behavior, or determine where to add something
new.
- Operations recursing into submodules can be run in-process, and the
callsite makes it very clear which repository context is being used;
if we're not subprocessing to recurse, then we can lose the awkward
git-submodule.sh -> builtin/submodule__helper.c -> top-level Git
process codepath.
- Being able to test libraries in isolation via unit tests or mocks
speeds up determining the root cause of bugs.
- If we can swap out an entire library, or just a single function of
one, it's easy to experiment with the entire codebase without sweeping
changes.

The ability to use Git as a library also makes it easier for other
tooling to interact with a Git repository *correctly*. As an example,
`repo` has a long history of abusing Git by directly manipulating the
gitdir[2], but if it were written in a world where Git exists as
easy-to-use libraries, it probably wouldn't have needed to, as it
could have invoked Git directly or replaced the relevant modules with
its own implementation. Both `repo`[3] and `git-gui[4]` have
reimplemented logic from git.git. Other interfaces that cooperate with
Git's filesystem storage layer, like `scalar` or `jj`[5], would be
able to interop with a Git repository without having to reimplement
custom logic or keep up with new Git changes.

Of course, there's a reason Google wants it, too. We've talked
previously about wanting better integration between Git and something
like a VFS; as we've experimented with it internally, we've found a
couple of tricky areas:

- The VFS relies on running Git commands to determine the state of the
repository. However, these Git commands interact with the gitdir or
worktree, which is populated by the VFS. For example, parsing a
.gitattributes or .gitmodules which is already stored in the VFS
requires the VFS to provide a POSIX file handle, spawn a Git
subprocess, populate other files needed by that subprocess (like
.git/config), and finally collect the output stream of the subprocess.
As you can imagine, this interaction of VFS -> Git -> VFS [-> Git]
creates all sort of complications. The alternative is for the VFS to
write its own parser (or use a library like libgit2; more on that
later). But having a Git library means that a subset of Git
functionality can happen in-process, and that filesystem access could
be replaced by the VFS directly providing high-level objects or plain
bytestreams.

- A user running `git status` in a directory controlled by the VFS
will require the VFS to populate the entire (large) worktree - even
though the VFS is sure that only one file has been modified. The
closest we've come with an alternative is an orchestrated use of
sparse-checkout - but modifying the sparse-checkout configs
automatically in response to the user's filesystem operations takes us
right back to the previous point. If Git could take a plugin and
replacement for the object store that directly interacts with the VFS
daemon, a layer of complexity would disappear and performance would
improve.

We discussed using an existing library like libgit2 or JGit, but it's
not a very exciting proposal: these libraries are already lagging
behind git.git in features, and trying to use them in combination with
brand-new improvements to Git (like new partial clone filters) means
that we'll always get to implement those improvements twice to bring
libgit2 up to speed. It also means that people using the `git` client
directly won't get performance benefits derived from having Git
internal libraries replaced by purpose-built ones in certain contexts.
That said, if libgit2 already provides functionality and performance
equivalent to git.git's in an appropriate wrapper, I'd be excited to
pursue integrating that library into git.git's codebase directly.

The good news is that for practical near-term purposes, "libification"
mostly means cleanups to the Git codebase, and continuing code health
work that the project has already cared about doing:

- Removing references to global variables and instead piping them
through arguments
- Finding and fixing memory leaks, especially in widely-used low-level code
- Reducing or removing `die()` invocations in low-level code, and
instead reporting errors back to callers in a consistent way
- Clarifying the scope and layering of existing modules, for example
by moving single-use helpers from the shared module's scope into the
single user's scope
- Making module interfaces more consistent and easier to understand,
including moving "private" functions out of headers and into source
files and improving in-header documentation

Basically, if this effort turns out not to be fruitful as a whole, I'd
like for us to still have left a positive impact on the codebase.

In the longer term, if Git has libraries with easily-replaced
dependencies, we get a few more benefits:

- Unit tests. We already have some in t/helper/, but if we can replace
all the dependencies of a certain library with simple stubs, it's
easier for us to write comprehensive unit tests, in addition to the
work we already do introducing edge cases in bash integration tests.
- If our users can use plugins to improve performance in specific
scenarios (like a VFS-aware object store in the VFS case I cited
above), then Git works better for them without having to adopt a
different workflow, such as using an alternative tool or wrapper.
- An easy-to-understand modular codebase makes it easy for new
contributors to start hacking and understand the consequences of their
patch.

Of course, we haven't maintained any guarantee about the consistency
of our implementation between releases. I don't anticipate that we'll
write the perfect library interface on our first try. So I hope that
we can be very explicit about refusing to provide any compatibility
guarantee whatsoever between versions for quite a long time. On
Google's end, that's well-understood and accepted. As I understand,
some other projects already use Git's codebase as a "library" by
including it as a submodule and using the code directly[6]; even a
breakable API seems like an improvement over that, too.

So what's next? Naturally, I'm looking forward to a spirited
discussion about this topic - I'd like to know which concerns haven't
been addressed and figure out whether we can find a way around them,
and generally build awareness of this effort with the community.

I'm also planning to send a proposal for a document full of "best
practices" for turning Git code into libraries (and have quite a lot
of discussion around that document, too). My hope is that we can use
that document to help us during implementation as well as during
review, and refine it over time as we learn more about what works and
what doesn't. Having this kind of documentation will make it easy for
others to join us in moving Git's codebase towards a clean set of
libraries. I hope that, as a project, we can settle on some tenets
that we all agree would make Git nicer.

From the rest of my own team, we're planning on working first on some
limited scope, low-level libraries so that we can all see how the
process works. We're starting with strbuf.[ch] (as it's used
everywhere with few or no dependencies and helps us guarantee string
safety at API boundaries), config.[ch] (as many external tools are
probably interested in parsing Git config formatted files directly),
and a subset of operations related to the object store. These starting
points are intended to have a small impact on the codebase and teach
us a lot about logistics and best practices while doing these kinds of
conversions.

After that, we're still hoping to target low-level libraries first - I
certainly don't think it will make sense to ship a high-level `git
commit` library in the near future, if ever - in the order that
they're required from the VFS project we're working closely with. As
far as I can tell right now, that's likely to cover object store and
worktree access, as well as commit creation and pushing, but we'll see
how planning shakes out over the next month or so. But Google's
schedule should have no bearing on what others in the Git project feel
is important to clean up and libify, and if there is interest in the
rest of the project in converting other existing modules into
libraries, my team and I are excited to participate in the review.

Much, much later on, I'm expecting us to form a plan around allowing
"plugins" - that is, replacing library functionality we use today with
an alternative library, such as an object store relying on a
distributed file store like S3. Making that work well will also likely
involve us coming up with a solution for dependency injection, and to
begin using vtables for some libraries. I'm hoping that we can figure
out a way to do that that won't make the Git source ugly. Around this
time, I think it will make sense to buy into unit tests even more and
start using an approach like mocking to test various edge cases. And
at some point, it's likely that we'll want to make the interfaces to
various Git libraries consistent with each other, which would involve
some large-scale but hopefully-mechanical refactors.

I'm looking forward to the discussion!

 - Emily

1: https://colabti.org/irclogger/irclogger_log/git-devel?date=2023-02-13#l29
2: https://gerrit.googlesource.com/git-repo/+/refs/heads/main/docs/internal-fs-layout.md
3: https://gerrit.googlesource.com/git-repo/+/refs/heads/main/git_config.py
4: https://github.com/git/git/blob/master/git-gui/git-gui.sh#L305
5: https://github.com/martinvonz/jj
6: https://github.com/glandium/git-cinnabar
