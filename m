Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF4AC433EF
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 22:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234348AbiFFWSd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 18:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234570AbiFFWSc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 18:18:32 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C486D3A9
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 15:18:28 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 43B471307D5;
        Mon,  6 Jun 2022 18:18:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tMKFejWxiDGVR/Myto/DKXqSQncMvej173ZDGs
        8agg0=; b=d2rWrFAoZ5thJa4P6DDWNzXrtBEdLVRdSiaRrSFvtrK/lJ2ypE5QbD
        csgDaUiBsTBMbXPhN8BIfW+BQyWFcAxHEOwMR8Qv/Ui/BDkjw5KVbt6Zv4GcwV9p
        wRRr/KOFMSMEZo4QZLSZh38rMBNuH2+bQR6HsYWplIzy73z8tKlX4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A3741307CC;
        Mon,  6 Jun 2022 18:18:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 976221307CA;
        Mon,  6 Jun 2022 18:18:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/6] docs: document bundle URI standard
References: <pull.1248.git.1654545325.gitgitgadget@gmail.com>
        <e771b2971d092af5ea8a47eb708d03e34b284a0f.1654545325.git.gitgitgadget@gmail.com>
Date:   Mon, 06 Jun 2022 15:18:25 -0700
In-Reply-To: <e771b2971d092af5ea8a47eb708d03e34b284a0f.1654545325.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Mon, 06 Jun 2022
        19:55:20 +0000")
Message-ID: <xmqqsfoh4ery.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 962CFC26-E5E6-11EC-856D-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
>
> Introduce the idea of bundle URIs to the Git codebase through an
> aspirational design document. This document includes the full design
> intended to include the feature in its fully-implemented form. This will
> take several steps as detailed in the Implementation Plan section.
>
> By committing this document now, it can be used to motivate changes
> necessary to reach these final goals. The design can still be altered as
> new information is discovered.
>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  Documentation/technical/bundle-uri.txt | 475 +++++++++++++++++++++++++
>  1 file changed, 475 insertions(+)
>  create mode 100644 Documentation/technical/bundle-uri.txt
>
> diff --git a/Documentation/technical/bundle-uri.txt b/Documentation/technical/bundle-uri.txt
> new file mode 100644
> index 00000000000..6657ba079ab
> --- /dev/null
> +++ b/Documentation/technical/bundle-uri.txt
> @@ -0,0 +1,475 @@
> +Bundle URIs
> +===========
> +
> +Bundle URIs are locations where Git can download one or more bundles in
> +order to bootstrap the object database in advance of fetching the remaining
> +objects from a remote.
> +
> +One goal is to speed up clones and fetches for users with poor network
> +connectivity to the origin server. Another benefit is to allow heavy users,
> +such as CI build farms, to use local resources for the majority of Git data
> +and thereby reducing the load on the origin server.
> +
> +To enable the bundle URI feature, users can specify a bundle URI using
> +command-line options or the origin server can advertise one or more URIs
> +via a protocol v2 capability.
> +
> +Design Goals
> +------------
> +
> +The bundle URI standard aims to be flexible enough to satisfy multiple
> +workloads. The bundle provider and the Git client have several choices in
> +how they create and consume bundle URIs.
> +
> +* Bundles can have whatever name the server desires. This name could refer
> +  to immutable data by using a hash of the bundle contents. However, this
> +  means that a new URI will be needed after every update of the content.
> +  This might be acceptable if the server is advertising the URI (and the
> +  server is aware of new bundles being generated) but would not be
> +  ergonomic for users using the command line option.
> +
> +* The bundles could be organized specifically for bootstrapping full
> +  clones, but could also be organized with the intention of bootstrapping
> +  incremental fetches. The bundle provider must decide on one of several
> +  organization schemes to minimize client downloads during incremental
> +  fetches, but the Git client can also choose whether to use bundles for
> +  either of these operations.
> +
> +* The bundle provider can choose to support full clones, partial clones,
> +  or both. The client can detect which bundles are appropriate for the
> +  repository's partial clone filter, if any.
> +
> +* The bundle provider can use a single bundle (for clones only), or a
> +  list of bundles. When using a list of bundles, the provider can specify
> +  whether or not the client needs _all_ of the bundle URIs for a full
> +  clone, or if _any_ one of the bundle URIs is sufficient. This allows the
> +  bundle provider to use different URIs for different geographies.
> +
> +* The bundle provider can organize the bundles using heuristics, such as
> +  timestamps or tokens, to help the client prevent downloading bundles it
> +  does not need. When the bundle provider does not provide these
> +  heuristics, the client can use optimizations to minimize how much of the
> +  data is downloaded.
> +
> +* The bundle provider does not need to be associated with the Git server.
> +  The client can choose to use the bundle provider without it being
> +  advertised by the Git server.
> +
> +* The client can choose to discover bundle providers that are advertised
> +  by the Git server. This could happen during `git clone`, during
> +  `git fetch`, both, or neither. The user can choose which combination
> +  works best for them.
> +
> +* The client can choose to configure a bundle provider manually at any
> +  time. The client can also choose to specify a bundle provider manually
> +  as a command-line option to `git clone`.
> +
> +Each repository is different and every Git server has different needs.
> +Hopefully the bundle URI feature is flexible enough to satisfy all needs.
> +If not, then the feature can be extended through its versioning mechanism.
> +
> +Server requirements
> +-------------------
> +
> +To provide a server-side implementation of bundle servers, no other parts
> +of the Git protocol are required. This allows server maintainers to use
> +static content solutions such as CDNs in order to serve the bundle files.
> +
> +At the current scope of the bundle URI feature, all URIs are expected to
> +be HTTP(S) URLs where content is downloaded to a local file using a `GET`
> +request to that URL. The server could include authentication requirements
> +to those requests with the aim of triggering the configured credential
> +helper for secure access. (Future extensions could use "file://" URIs or
> +SSH URIs.)
> +
> +Assuming a `200 OK` response from the server, the content at the URL is
> +expected to be of one of two forms:
> +
> +1. Bundle: A Git bundle file of version 2 or higher.
> +
> +2. Bundle List: A plain-text file that is parsable using Git's
> +   config file parser. This file describes one or more bundles that are
> +   accessible from other URIs.
> +
> +Any other data provided by the server is considered erroneous.

How does a client tell which one it got?  Do we register mimetype
with iana to use for these two types of files, and have the HTTP
downloader to use the information?

> +Bundle Lists
> +------------
> +
> +The Git server can advertise bundle URIs using a set of `key=value` pairs.
> +A bundle URI can also serve a plain-text file in the Git config format
> +containing these same `key=value` pairs. In both cases, we consider this
> +to be a _bundle list_. The pairs specify information about the bundles
> +that the client can use to make decisions for which bundles to download
> +and which to ignore.
> +
> +A few keys focus on properties of the list itself.
> +
> +bundle.list.version::
> +	(Required) This value provides a version number for the table of
> +	contents. If a future Git change enables a feature that needs the Git
> +	client to react to a new key in the bundle list file, then this version
> +	will increment. The only current version number is 1, and if any other
> +	value is specified then Git will fail to use this file.
> +
> +bundle.list.mode::
> +	(Required) This value has one of two values: `all` and `any`. When `all`
> +	is specified, then the client should expect to need all of the listed
> +	bundle URIs that match their repository's requirements. When `any` is
> +	specified, then the client should expect that any one of the bundle URIs
> +	that match their repository's requirements will suffice. Typically, the
> +	`any` option is used to list a number of different bundle servers
> +	located in different geographies.

OK. Presumably, if there are two sets of bundles, A and B, that
consist of 3 and 2 bundle files respectively, and either one of
these two sets is sufficient to help the client, then we'd have a
bundle.list of type 'any', with two bundle.<id>.uri, that point at
(sub) bundle.list of type 'all' in which these 3 or 2 bundle files
are contained?  I am just wondering why we need 'all' and 'any', and
at the same time why these two are sufficient for our needs.

> +bundle.list.heuristic::
> +	If this string-valued key exists, then the bundle list is designed to
> +  work well with incremental `git fetch` commands. The heuristic signals
> +  that there are additional keys available for each bundle that help
> +  determine which subset of bundles the client should download.

Funny indentation?

> +The remaining keys include an `<id>` segment which is a server-designated
> +name for each available bundle.
> +
> +bundle.<id>.uri::
> +	(Required) This string value is the URI for downloading bundle `<id>`.
> +	If the URI begins with a protocol (`http://` or `https://`) then the URI
> +	is absolute. Otherwise, the URI is interpreted as relative to the URI
> +	used for the bundle list. If the URI begins with `/`, then that relative
> +	path is relative to the domain name used for the bundle list. (This use
> +	of relative paths is intended to make it easier to distribute a set of
> +	bundles across a large number of servers or CDNs with different domain
> +	names.)

I have no objection to a host-relative URI notation, but is it
something we need to spell out here?  I am mostly interested in
making sure that we do not deviate a practice that is already used
to point at different resource at the same server.  If the way we
specify host-relative is unnecessarily different from the way
existing "internet" programs (say, a web browser) work, that would
be embarrasing, unless there is a very good reason for us to be
different.

> +bundle.<id>.list::
> +	This boolean value indicates whether the client should expect the
> +	content from this URI to be a list (if `true`) or a bundle (if `false`).
> +	This is typically used when `bundle.list.mode` is `any`.

OK, so the type of a (sub) bundle.list can be specified using this
without having the HTTP(s) server annotate the resource with
mimetype when the thing gets actually downloaded.  It still leaves
the issue of bootstrapping the system.  If the server advises bundle
URI when the client contacts, presumably that first-contact
bundle.*.uri can be annotated with the bundle.*.list at the same
time, but the model allows the client to learn bundles independently
from the server, and it still is a bit unclear how we tell.  Of
course, we can examine the contents of a file that was obtained from
a bundle URI, a file that parses correctly as a config-like file is
very unlikely to be a valid bundle file, and we need to be prepared
to deal with a corrupt resource downloaded from a bundle URI anyway,
so this may not be a huge deal.

> +bundle.<id>.filter::
> +	This string value represents an object filter that should also appear in
> +	the header of this bundle. The server uses this value to differentiate
> +	different kinds of bundles from which the client can choose those that
> +	match their object filters.

Is it an error to have .filter defined for a bundle URI whose .list
says "true"?  Or does it mean all bundle files that make up the list
share the same object filter?

> +bundle.<id>.timestamp::
> +	This value is the number of seconds since Unix epoch (UTC) that this
> +	bundle was created. This is used as an approximation of a point in time
> +	that the bundle matches the data available at the origin server. This is
> +	used when `bundle.list.heuristic=timestamp`.

Name of this field should be better than 'timestamp'; we should say
timestamp of creation (or last modification if the same name can be
reused).

> +bundle.<id>.requires::
> +	This string value represents the ID of another bundle. When present, the
> +	server is indicating that this bundle contains a thin packfile. If the
> +	client does not have all necessary objects to unbundle this packfile,
> +	then the client can download the bundle with the `requires` ID and try
> +	again. (Note: it may be beneficial to allow the server to specify
> +	multiple `requires` bundles.) This is used when
> +	`bundle.list.heuristic=timestamp`.

So, bundle.list.mode can say 'any', with three <id>s in it, but
bundle.1.requires can point at '2', while bundle.2.requires can
point at '1', and bundle.3.requires can be emtpy, in which case you
can either fetch 1&2 or 3 alone.  Is that the idea?

> +bundle.<id>.location::
> +	This string value advertises a real-world location from where the bundle
> +	URI is served. This can be used to present the user with an option for
> +	which bundle URI to use. This is only valuable when `bundle.list.mode`
> +	is `any`.

I am afraid I do not follow.  Do you mean, by "a real-world
location", we write things like "America/Los_Angeles" and
"Asia/Tokyo" in this field, so people can tell which one is cheaper
to get to?  Do we make any further specification to make it machine
usable in any way (I suspect machines would rather measure the
latency and throughput against bundle.<id>.uri and .location is
meant purely for human consumption)?

> +Here is an example bundle list using the Git config format:
> +
> +```
> +[bundle "list"]
> +	version = 1
> +	mode = all
> +	heuristic = timestamp

In all mode, how does heuristic help?  Doesn't mode=all by
definition require you to grab everything anyway?

> +[bundle "2022-02-09-1644442601-daily"]
> +	uri = https://bundles.fake.com/git/git/2022-02-09-1644442601-daily.bundle

example.com (cf. RFC6761)?

> +	timestamp = 1644442601
> +	requires = 2022-02-02-1643842562
> +
> +[bundle "2022-02-02-1643842562"]
> +	uri = https://bundles.fake.com/git/git/2022-02-02-1643842562.bundle
> +	timestamp = 1643842562
> +
> +[bundle "2022-02-09-1644442631-daily-blobless"]
> +	uri = 2022-02-09-1644442631-daily-blobless.bundle
> +	timestamp = 1644442631
> +	requires = 2022-02-02-1643842568-blobless
> +	filter = blob:none
> +
> +[bundle "2022-02-02-1643842568-blobless"]
> +	uri = /git/git/2022-02-02-1643842568-blobless.bundle
> +	timestamp = 1643842568
> +	filter = blob:none
> +```
> +
> +This example uses `bundle.list.mode=all` as well as the
> +`bundle.<id>.timestamp` heuristic. It also uses the `bundle.<id>.filter`
> +options to present two parallel sets of bundles: one for full clones and
> +another for blobless partial clones.
> +
> +Suppose that this bundle list was found at the URI
> +`https://bundles.fake.com/git/git/` and so the two blobless bundles have
> +the following fully-expanded URIs:
> +
> +* `https://bundles.fake.com/git/git/2022-02-09-1644442631-daily-blobless.bundle`
> +* `https://bundles.fake.com/git/git/2022-02-02-1643842568-blobless.bundle`

So,... is the idea that bundle.list.mode=all does *not* mean "you
need to get all of them"?  Rather, you first group bundles with the
same filter, attribute, and then for each group with the same filter,
you'd need to grab all of them?  IOW, if you are interested in a
full clone, you can ignore <id>'s with non-empty bundle.<id>.filter 
and grab all the rest?

If so, then I can see how the design makes sense.  I still do not
know how heuristic kicks in, though.

ANother thing I noticed.  The above scheme makes it impossible to
have <id> that happens to be "list".  I think the variables that
apply to the entire list should be given two-level names, i.e.

      [bundle]
	version = 1
	mode = all
	heuristic = timestamp
      [bundle "2022-02-09-1644442631-daily"]
	uri = ...

> +The client could choose an arbitrary bundle URI as an option _or_ select
> +the URI with lowest latency by some exploratory checks.

Some places may have higher latency but great throughput.

The review for the rest of the document will be left for another
sitting.

Thanks.
