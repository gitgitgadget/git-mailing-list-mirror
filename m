Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E19C43334
	for <git@archiver.kernel.org>; Tue,  7 Jun 2022 00:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235460AbiFGAeH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 20:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235397AbiFGAeG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 20:34:06 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AC06A41F
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 17:34:04 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D0B5F1A1954;
        Mon,  6 Jun 2022 20:34:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WGZwrGyvmgP57TJzXg0lnU4sftbJEL9bPHyrf1
        gczEY=; b=OmR8S5yEwHPjwvZjjAddiotdbzCraOF6s5moDt69t3oU0a9fHO0GWW
        BVGA5NMSU7S608Wwd4iepYhjg0nV47OKiguF3gH+HoJzEG7V9UbwdE+efZ22E6aV
        WDAdbCNwR8kQv+XsV6JkD9pBUAJ+b3g0SLu7rzzUAMZyWE7oJ3e+o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C973C1A1953;
        Mon,  6 Jun 2022 20:34:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 413C11A1950;
        Mon,  6 Jun 2022 20:34:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/6] docs: document bundle URI standard
References: <pull.1248.git.1654545325.gitgitgadget@gmail.com>
        <e771b2971d092af5ea8a47eb708d03e34b284a0f.1654545325.git.gitgitgadget@gmail.com>
Date:   Mon, 06 Jun 2022 17:33:59 -0700
In-Reply-To: <e771b2971d092af5ea8a47eb708d03e34b284a0f.1654545325.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Mon, 06 Jun 2022
        19:55:20 +0000")
Message-ID: <xmqqtu8x1fd4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8634A536-E5F9-11EC-890E-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +Cloning with Bundle URIs
> +------------------------
> +
> +The primary need for bundle URIs is to speed up clones. The Git client
> +will interact with bundle URIs according to the following flow:
> +
> +1. The user specifies a bundle URI with the `--bundle-uri` command-line
> +   option _or_ the client discovers a bundle list advertised by the
> +   Git server.
> +
> +2. If the downloaded data from a bundle URI is a bundle, then the client
> +   inspects the bundle headers to check that the negative commit OIDs are

Although "negative" would be understandable to pros, the commits
required to unbundle a bundle file are officially called
"prerequisite commits" (cf. "git bundle --help"), so that may be
easier to understand by ordinary readers.

> +   present in the client repository. If some are missing, then the client
> +   delays unbundling until other bundles have been unbundled, making those
> +   OIDs present. When all required OIDs are present, the client unbundles
> +   that data using a refspec. The default refspec is
> +   `+refs/heads/*:refs/bundles/*`, but this can be configured.

The refs/bundles/ appear in the document only here, and it is
unclear why we even want it (I am assuming this is against gc while
"git clone" is still running) or how we are going to retire it, if
ever.  If there are multiple bundle files involved in this "git clone",
to anchor objects that are necessary against "gc", don't we need to use
refs/bundles/<i>/* or something like that, where <i> is uniquely assigned
number locally?

> +3. If the file is instead a bundle list, then the client inspects the
> +   `bundle.list.mode` to see if the list is of the `all` or `any` form.

If the downloaded file is not a bundle (e.g. "git bundle list-heads"
barfs on it) and it is not parseable with our configuration parser,
do we error out, or do we pretend as if that bundle file or the TOC
did not exist (if the bundle list with mode=any at the higher level
has appropriate alternatives)?

> +   a. If `bundle.list.mode=all`, then the client considers all bundle
> +      URIs. The list is reduced based on the `bundle.<id>.filter` options
> +      matching the client repository's partial clone filter.

OK, this answers my earlier question nicely.  It probably means that
either the presentation order needs a bit of rethinking, or "we
group by .filter" needs to be mentioned a lot earlier.

> Then, all
> +      bundle URIs are requested. If the `bundle.<id>.timestamp` heuristic
> +      is provided, then the bundles are downloaded in reverse-
> +      chronological order, stopping when a bundle has all required OIDs.

Stop as soon as just one bundle has all the prerequisite objects, or
should we keep going until all bundles have their prerequisites
satisfied?  I presume it is the latter.

> +      The bundles can then be unbundled in chronological order. The client
> +      stores the latest timestamp as a heuristic for avoiding future
> +      downloads if the bundle list does not advertise newer bundles.

So we see a list, we start grabbing from new to old.  Newer ones
that are based on older ones may have dependencies, so we do not
unbndle until we have all the prerequisites for them.  The bundles
that satisfy their prerequisites are unbundled---that would give us
enough objects to play with.  What happens to the refs recorded in
them, though?

Is the timestamp per the serving host, or per the CDN host that
serve us bundle files, or...?  I guess it is premature to discuss it
here. "git clone" bootstraps from the advertisement made only by a
single serving host, so the single newest timestamp among the
bundles used from the bundle list is what we store here.  How that
timestamp is used is primarily of interest in future fetching, which
would be discussed later.

> +Fetching with Bundle URIs
> +-------------------------
> +
> +When the client fetches new data, it can decide to fetch from bundle
> +servers before fetching from the origin remote. This could be done via a
> +command-line option, but it is more likely useful to use a config value
> +such as the one specified during the clone.
> +
> +The fetch operation follows the same procedure to download bundles from a
> +bundle list (although we do _not_ want to use parallel downloads here). We
> +expect that the process will end when all negative commit OIDs in a thin
> +bundle are already in the object database.

I do not see why we do not want to use parallel download, though.
If our last bundle download was last month, and they have two newer
bundles since then, don't we want to grab both at the same time?
Wasn't that the point of recording the newest timestamp when "git
clone" grabbed bundles?

> +Error Conditions
> +----------------
> +
> +If the Git client discovers something unexpected while downloading
> +information according to a bundle URI or the bundle list found at that
> +location, then Git can ignore that data and continue as if it was not
> +given a bundle URI. The remote Git server is the ultimate source of truth,
> +not the bundle URI.
> +
> +Here are a few example error conditions:
> +
> +* The client fails to connect with a server at the given URI or a connection
> +  is lost without any chance to recover.
> +
> +* The client receives a response other than `200 OK` (such as `404 Not Found`,
> +  `401 Not Authorized`, or `500 Internal Server Error`). The client should
> +  use the `credential.helper` to attempt authentication after the first
> +  `401 Not Authorized` response, but a second such response is a failure.
> +
> +* The client receives data that is not parsable as a bundle or table of
> +  contents.

Is it an error if bundle.<id>.list and the contents disagree?

It is fine to call the possibility other than "a bundle file" "table
of contents", but then let's do so consistently throughout the document.
When we explain bundle.<id>.list, we should not call the other
possibility "list" but "table of contents", for example.

> +* The bundle list describes a directed cycle in the
> +  `bundle.<id>.requires` links.
> +
> +* A bundle includes a filter that does not match expectations.

Does this refer to a mismatch between the filter recorded in a
bundle and bundle.<id>.filter entry that described the bundle?

> +* The client cannot unbundle the bundles because the negative commit OIDs
> +  are not in the object database and there are no more
> +  `bundle.<id>.requires` links to follow.

Is a .requires link mandatory?  In a mode=all table of contents, we
should not have to have .requires at all.  In the above description
on how bundle files are downloaded and in what order in Clone and
Fetch operations, I didn't see any mention of .requires at all, but
I think there should be.  For example, the timestamp heuristics may
say the bundle A is the latest.  In a mode=any table of contents,
shouldn't bundles that contain prerequisite commits of the bundle A
be pointed by A's .requires fields?

> +4. Allow the client to understand the `bundle.list.forFetch` configuration
> +   and the `bundle.<id>.timestamp` heuristic. When `git clone` discovers a
> +   bundle URI with `bundle.list.forFetch=true`, it configures the client
> +   repository to check that bundle URI during later `git fetch <remote>`
> +   commands.

So bundle.list.forFetch is, unlike everything else we saw that
looked like a configuration variable in this document, a
configuration variable whose value is boolean?

Ah, no.  You mean the "git clone" sees a bundle URI, grabs it and
sees a table of contents, and in it, finds "bundle.forFetch" is set
to true?  Then "git fetch <remote>" is configured to also use bundle
URI?

It is unclear to me (with the information given here so far), why we
want this.  Isn't this something the responder to "git fetch" can
advertise over the wire?  If we leave a permanent record in the
resulting repository to do the bundle URI during 'fetch', wouldn't
it become more cumbersome to cancel (iow "no, you no longer want to
talk to me with bundle URI feature") from the server side?

> +5. Allow clients to discover bundle URIs during `git fetch` and configure
> +   a bundle URI for later fetches if `bundle.list.forFetch=true`.
> +
> +6. Implement the "inspect headers" heuristic to reduce data downloads when
> +   the `bundle.<id>.timestamp` heuristic is not available.

Sounds sensible, even though I do not offhand see why the "peek
header and stop" is any less useful when the timestamp heurisitc is
available.

> +A major downside to this mechanism is that the origin server needs to know
> +_exactly_ what is in those packfiles, and the packfiles need to be available
> +to the user for some time after the server has responded. This coupling
> +between the origin and the packfile data is difficult to manage.

Hmph.  I strongly suspect that there are Googlers on the list who
have been managing such JGit server installations.  Has this
"coupling" been difficult to manage for you guys in the real world?

> +Further, this implementation is extremely hard to make work with fetches.

IOW, they do this only for clones and not fetches?

> +Related Work: GVFS Cache Servers
> +--------------------------------
> ...
> +During a `git fetch`, a hook requests the prefetch endpoint using the
> +most-recent timestamp from a previously-downloaded prefetch packfile.
> +Only the list of packfiles with later timestamps are downloaded.

That sounds quite straight-forward.  Do you envision that their
incremental snapshot packfile chains can somehow be shared with the
bundle URI implementations?  Doesn't it make it more cumbersome that
this proposal uses the bundles as the encapsulation format, rather
than packfiles?  As you are sending extra pieces of information on
top of the payload in the form of table-of-contents already, I
wonder if bundle.<id>.uri should point at a bare packfile (instead
of a bundle), while multi-valued bundle.<id>.prerequisite give the
prerequisite objects?  The machinery that is already generating the
prefetch packfiles already know which packfile has what
prerequisites in it, so it rather looks simpler if the solution did
not involve bundles.

Thanks.  Here ends my two-part review on the doc.
