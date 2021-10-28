Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6F7C433F5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 15:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07BAA60D43
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 15:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhJ1PcI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 11:32:08 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:14863 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229946AbhJ1PcH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 11:32:07 -0400
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1mg7LW-000CNQ-3g; Thu, 28 Oct 2021 16:29:39 +0100
Message-ID: <ce6a1112-e960-cf1d-5e3f-60ef0de7abea@iee.email>
Date:   Thu, 28 Oct 2021 16:29:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [Discussion] The architecture of Scalar (and others) within Git
Content-Language: en-GB
To:     Derrick Stolee <stolee@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        Victoria Dye <vdye@github.com>, Theodore Ts'o <tytso@mit.edu>
References: <b67bbef4-e4c3-b6a7-1c7f-7d405902ef8b@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <b67bbef4-e4c3-b6a7-1c7f-7d405902ef8b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stollee,
a few very generic points with my "systems" hat on.

On 27/10/2021 22:51, Derrick Stolee wrote:
> The discussion happening on "Upstreaming the Scalar command" [1] has
> gotten pretty deep into some details about builds and code organization.
> While these are important things to discuss, I’d like to step back and
> reframe the discussion to focus on how components like Scalar fit into the
> high-level architecture of Git. The decisions we make for Scalar also
> affect other components that might show up in the future. It could also
> clarify some of the components already in Git, both in and out of the
> `contrib/` directory.
>
> [1] https://lore.kernel.org/git/pull.1005.git.1630359290.gitgitgadget@gmail.com/
>
> I'm starting this discussion thread to create a new area to consider these
> high-level concepts. Specifically: how should a new component like Scalar
> be included in the Git codebase?
>
> Johannes put details in his cover letter about why we put it in
> `contrib/scalar/`, but I feel like code review proceeded at first as if
> that was a foregone conclusion. Then, discussion shifted to some
> alternatives, but the reasons were focused on code size and specific
> tweaks to the `Makefile`. I think there are other concerns for the entire
> Git community that need to be included in the calculus. In particular,
> the decisions we make today will become precedents for similar
> contributions in the future.
We probably should also summarise the status of and relationships with
the existing 'integrations' like `git-gui`, `gitk`, `Git for-Windows`, etc.

>
> I'll start by setting up some goals and guidelines for the decision
> process, then get into some concrete options before comparing them based
> on these guidelines. I also try to separate the "final" goal from "how do
> we get there" in the last section.
>
> All of what I say is up for debate. I would love for others to contribute
> options that I missed. I will send a reply to this message that summarizes
> all options that are recommended in this thread, along with some attempt
> to summarize any consensus that we might be approaching.
>
>
> Goals
> -----
>
> Our
I'm assuming that 'our' here is the corporate team that has been
endeavouring to use Git effectively on it's mega-repo and give back what
it has learnt to Git.

>  main goal is to identify a community-supported plan for upstreaming the
> Scalar CLI.

Here, 'scalar' is about large code mono-repos, rather than any operating
system/vendor issues, or visualisation tools. (may need saying)
>
> This comes in two parts:
>
> 1. What is the preferred final organization of the Scalar code within
>    the Git codebase?
>
> 2. What is a realistic approach to contributing the complete Scalar CLI
>    with incrementally-reviewable pieces, in order to end up with the
>    preferred final organization?
>
>
> Optimization Factors
> --------------------
>
> There are multiple factors involved that we wish to optimize. Here is my
> understanding of the most-important factors and how they interact:
>
> ### Value
>
> The main reason to include Scalar within the Git codebase is to make it
> available to more users. This should have downstream effects based on user
> feedback about what they like or dislike about the Scalar CLI that can
> inform future features in core Git that simplify repository management at
> scale.
>
> ### CLI compatibility
>
> The Scalar CLI was developed externally, which informed the choice of
> commands and arguments. We prefer to maintain the existing CLI design to
> support our existing customers without disruption.
>
> After the existing CLI is completely contributed, we can consider making
> changes to the CLI by deprecating certain options and replacing them with
> synonyms. (For example, my personal regret is that `--full-clone` really
> means `--no-sparse`.)
>
> ### Developer friction
>
> Once the Scalar CLI is in the Git codebase, it becomes something that can
> disrupt Git developers as they modify Git code, especially within libgit.a.
> What is the right balance of making developers responsible for breaking
> the Scalar CLI as they make changes to Git?
>
> ### Git Maintainer burden
>
> Similar to developer friction, how much does having Scalar in the Git
> codebase affect the Git maintainer? Does the Git maintainer become
> responsible for the maintenance of Scalar? Do contributions to Scalar need
> the same scrutiny as other contributions? Does the maintainer need to
> inform contributors when they break Scalar?
How to quantify the size of the scalar _code_ contribution, and how is
concept ownership handed over?
>
> ### Scalar Maintainer(s) responsibility
>
> At the very last, what are the roles of "the Scalar maintainer(s)"? Here,
> I'm thinking of Johannes and myself as the accountable parties. An example
> of a responsibility here could be that around release time we validate
> that Scalar is still working with the changes that happened during that
> release cycle.

Ensuring a separation of concerns (partitioning) will be important if
the only mega repo that can really 'battle test' the capability is to be
separate from the ownership of the coded concepts.
>
> The biggest reason to include the Scalar maintainers' responsibility is
> that the options listed below present a converse relationship between
> these responsibilities and those of contributors and the Git maintainer.
> The more responsibility that the Git community is willing to accept, the
> less responsibility on the Scalar maintainers. We are _not_ optimizing to
> minimize our responsibility, but some options change the balance of
> responsibility.

I'm presuming this (responsibility) is with respect to the *transition*
from the independent `scalar` to the Git integrated _scalar_ capability.
>
>
> Options for preferred end state
> -------------------------------
>
> Let's get into some concrete proposals for the location of the Scalar CLI
> within the Git codebase. These are ordered based on increasing
> responsibility on the Git community: the first option should minimize
> community responsibility and maximize responsibility on the Scalar
> maintainers. We will discuss the pros and cons of each option after fully
> describing each of them.
>
> (Please add any options that I may have missed!)
>
> **Option 1:** One-directional coupling in `contrib/scalar/`
>
> The Scalar CLI exists entirely within `contrib/scalar/`, including all code
> and test infrastructure. To opt-in to building and testing Scalar, run
> `make -C contrib/scalar test` to build Git and Scalar and run the Scalar
> test scripts.
>
> **Option 2:** Loose coupling in a new scalar/ directory
>
> Similar to `git-gui` and `gitk-git`, Scalar could exist outside of `contrib/`
> and in its own `scalar/` directory. Its code is isolated to this directory,
> but its tests live in `t/` and its documentation lives in `Documentation/`.
> The root `Makefile` has special logic to avoid building and testing Scalar
> unless an `INCLUDE_SCALAR` option is enabled. The `DEVELOPER=1` option
> enables `INCLUDE_SCALAR` by default. Code in `git.c` is generalized so
> `scalar.c` could take advantage of features such as `-c`, `-C`, and
> `--exec-path` options.
>
> **Option 3:** Tight coupling with entire Git project
>
> Scalar is included at the root as `scalar.c` and is compiled at the same
> priority as the `git` executable. Tests and documentation have the same
> priority as other Git features. Code in `git.c` is generalized so
> `scalar.c` could take advantage of features such as `-c`, `-C`, and
> `--exec-path` options.
>
> Note: there are likely more subtle gradients between these options, but
> Option 1 and Option 3 are intended as extreme ends of a spectrum. Option
> 2 is a potential middle ground, but a lot of the details about it could be
> altered.
This appears to list only end points, rather than transitional
approaches (cf. cut & cover, tunnel, bridging) to providing some or all
of the scalar mono-repo capability to Git.
>
> Benefits and drawbacks of these options
> ---------------------------------------
>
> Here are some pros and cons for each approach. Please reply with additional
> items to add to the list, or to debate the correctness of each item. I'll
> try to summarize these contributions in a reply to this message after the
> discussion stabilizes.
>
> **Option 1:** One-directional coupling in `contrib/scalar/`
>
> This option was our initial choice because it minimizes the responsibility
> of the Git community. While `contrib/scalar/scalar.c` depends on code in
> `libgit.a`, the implementation does not require that code to change to
> accommodate the needs of Scalar. The test suite and documentation is
> separate.
>
> This does mean that changes to `libgit.a` could break Scalar without any
> feedback to the developer that has not compiled Scalar. The Scalar
> maintainers would then need to watch for this and send separate updates to
> Scalar that fix these dependency breaks. This reduces developer friction,
> but might cause some extra burden on the Git maintainer. If these "catch
> up to dependency breaks" updates happen only after a release candidate is
> out, then maybe this isn't too much of a burden. We don't typically have
> release candidates for minor releases, so there is some risk there that
> minor releases could include breaks.
>
> If we make our CI builds include Scalar by default, then the previous
> paragraph about developer friction is negated.
>
> Having Scalar in `contrib/` makes it easy to differentiate it as an
> optional component that distributors could choose to include or leave out.
>
> Code in `contrib/` has a lower barrier to entry. In particular, the Scalar
> CLI is not intended to be up for debate for historical reasons.

Are we talking ('not for debate') about the existing `scalar`
(corporate) cli or the potential for a medium term transition to a git
cli embedding the _scalar_ concepts. 
>  If we make
> an exception for Scalar but want Scalar integrated outside of `contrib/`,
> then are we setting expectations for other tools that might want to be
> included?
>
> However, projects within `contrib/` do not currently depend on `libgit.a`
> the way Scalar does. (This is not historically true, as an older project
> ad such dependencies, but has since been ejected.) This leads to questions
> of whether or not this is a desirable pattern to follow. It adds to
> complexity since changes to the core Git codebase can break something in
> `contrib/` at compile time.
>
> By keeping the code dependency one-directional, some nice-to-have features
> can be duplicated within `contrib/scalar/` to avoid disrupting their
> implementation within the core Git codebase.
>
> This option explicitly mentions that all knowledge of how to build Scalar
> lives within `contrib/scalar/` to avoid disrupting the core `Makefile`.
> This has already led to debate about some duplication in the Scalar
> `Makefile` and the one at root. Some functionality might not be critical
> to include in both places. One knob that we can use to adjust this option
> is to be more flexible with the root `Makefile` knowing about code within
> `contrib/scalar`. This violates existing patterns except for how the
> `make coccicheck` target consumes scripts from `contrib/coccinelle` to do
> checks on the Git source code.
>
> **Option 2:** Loose coupling in a `scalar/` directory
>
> The first issue with this option is that the Scalar CLI is established and
> is not up for modification, yet we would be contributing it in a location
> that is typically under high scrutiny for things like this.
>
> This option also breaks into new territory, because even `git-gui` and
> `gitk-git` are not based on C and do not depend on `libgit.a`.
>
> There is some risk that as we refactor some things in the Git build system
> and codebase to allow Scalar to plug in more tightly that we accidentally
> break something.
>
> Developer friction increases as changes to `libgit.a` that break Scalar
> should be fixed within the patches that cause those changes. This means
> that changes to the Scalar project can happen in otherwise-unrelated
> topics, increasing the attention of both Git and Scalar maintainers during
> the full release cycle. However, it does reduce risk that Scalar could be
> broken for a significant chunk of time.
>
> This approach reduces code duplication.
>
> Not only does the code need to be compiled optionally, we need to make
> sure that tests only run if Scalar was compiled. We also want to make sure
> that documentation is compiled with the same options. This could affect
> things like git-scm.com which hosts the Git documentation: should it
> include the Scalar docs if it isn't shipped by default? How can we make
> sure that these docs don't accidentally appear there? (Or, should we
> make sure the docs clearly state that `scalar` might not be available?)
>
> **Option 3:** Tight coupling with the entire Git project
>
> This option removes the ability to opt-out of building the Scalar CLI.
> Distributors might need to react to remove the `scalar` executable if they
> do not want to include it.
>
> This option relies on significant buy-in from the Git community.
>
> This option minimizes code duplication and has the simplest build system.
>
> This option sets a risky precedent that new tools can be added to Git
> without a rigorous review of the CLI.
>
>
> Possible approaches to land in our final target
> -----------------------------------------------
>
> If we agree on option 1 (`contrib/scalar/`), then this discussion is moot,
> because there is no strategy other than to contribute into `contrib/` from
> the start.
>
> If we agree on another option, then we could still continue contributing
> Scalar into `contrib/`, following the currently-proposed organization. There
> might be benefits to a gradual approach to reaching that target. Here is a
> possible multi-stage approach to land in our final approach:

I'm minded toward seeing a transitional approach (aka: staged, gated,
..) that would bring capability into Git, but I'm not sure about the
libgit.a linkage.
>
> **Phase 1.** Keep code in contrib/ while we contribute the Scalar features.
>
> Since the current patches on the mailing list are not feature complete, it
> can be beneficial to move forward with the code in `contrib/scalar/` until
> we reach feature parity. At that point, we could move the source into its
> final resting place.
>
> This leans into the fact that `contrib/` contains "interesting tools...
> maybe even experimental ones". While Scalar is not feature complete, it
> can be isolated as experimental here until it is ready for promotion to
> non-experimental.
>
> Depending on the final goal, we could drop some of the work that is currently
> built within the `contrib/scalar/` directory, such as `-c`/`-C` parsing or
> documentation builds. These features would be reimplemented in the new
> location, so we can prevent that duplicate effort if we have a different
> final location in mind.
>
> **Phase 2.** Establish community standards on optional components
>
> While the work in `contrib/scalar/` continues to reach feature parity, we
> can work as a community to set some ground rules about these kinds of
> optional features (depending on how "optional" we land). This can include
> standards such as how the files are laid out in the repository and how
> they interact with the `Makefile`. Whatever we do for Scalar is likely to
> form an example for a future contribution that we can't predict today.
> Many of the questions we are asking today can be written for posterity:
>
> * What is an appropriate level of coupling with the Git codebase?
> * Where should code custom to the component live?
> * How should documentation and tests be organized?
> * How do we initialize builds of a component?
> * Who is responsible for supporting the component? Who fixes the bugs?
> * Who is responsible for reviewing changes to the component?
>
> **Phase 3.** Translate the Scalar code from `contrib/scalar/` to new home
>
> After feature parity is reached _and_ we have established some ground rules
> for how these kinds of components should fit within the Git codebase, we
> can start to translate Scalar into its new home. This should include some
> file renames along with some modifications to fit into the build. The goal
> of this phase is to establish the new build environment and how Scalar fits
> within the CI builds. Once this is complete, whatever responsibility was
> agreed upon by the community to keep Scalar working goes into effect.
>
> **Phase 4.** Integrate features that were delayed until final home
>
> After the code, docs, and tests have been moved, we can start the work of
> adding the features that might have been delayed until the final home. The
> main example on my mind is the `-c`/`-C`/`--exec-path` parsing, which
> should be its own series. Features that fit into this category include
> anything that requires modifying existing code outside of `contrib/` to be
> consumed by Scalar.
>
>
> Call to action
> --------------
>
> Thanks for your attention to this topic. I look forward to any new "big"
> ideas in this space.
>
> Thanks,
> -Stolee
>
>
regards
Philip
