Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C410538F83
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 18:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722450331; cv=none; b=dx1AuslxjFEJhzgtT9iWLuJYmR4lvMJ0GPiqv3Z3NZiEXLV8xBHN0Tcc1ixUrE2FMUMcSc6ed4Pms6aefOJ/kQ3oCKC+bUXV7kve4ERBqSgmoORQNOpQVfY8k4rnH5n4WL7KaQpniJup8dx7vToYZXJwvPUKBJ/eI4jBZbOcqUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722450331; c=relaxed/simple;
	bh=xNb9ro2MNJFun7QcTSPi/jrTglPKeAqXMtoeWJ5Zjbo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oTXBmRPoNSU97dtf8wSb2R7RDNGPMD/HzmVJPCR+ZWdATowmijwV2vQnwqiBYLivduUZFCCsl58VbttPHfskq22X/eEtU8MyBKQORRyqCrYD50/BJZMiTTQfe+9wQR7P6CC5XO8MxP/KqXCaI1ICDI/tb3G+ZZF/4NiO1MDDxvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=mILzmUhz; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mILzmUhz"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 914533AA4D;
	Wed, 31 Jul 2024 14:25:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=xNb9ro2MNJFun7QcTSPi/jrTglPKeAqXMtoeWJ
	5Zjbo=; b=mILzmUhzS6QYMy/pXexTVyIdoeXO/R/8EUD26wTGAAJkHMgGrq5ZI3
	M6uuXCNfEgICYbi4XwPU6FN015WZnvbx9B7HM4eofeA6p78oNyrEqcqHHmxfjXr9
	g/npxDbKqXki9W2Nw1weXsF0an9yHuDpzro48hYBDBeb78unN5cVM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 88F253AA4C;
	Wed, 31 Jul 2024 14:25:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E1C823AA4B;
	Wed, 31 Jul 2024 14:25:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  John Cai <johncai86@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/4] Add 'promisor-remote' capability to protocol v2
In-Reply-To: <20240731134014.2299361-4-christian.couder@gmail.com> (Christian
	Couder's message of "Wed, 31 Jul 2024 15:40:13 +0200")
References: <20240731134014.2299361-1-christian.couder@gmail.com>
	<20240731134014.2299361-4-christian.couder@gmail.com>
Date: Wed, 31 Jul 2024 11:25:25 -0700
Message-ID: <xmqqikwl2zca.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 424F762A-4F6A-11EF-BF3B-BAC1940A682E-77302942!pb-smtp2.pobox.com

Christian Couder <christian.couder@gmail.com> writes:

> When a server repository S borrows some objects from a promisor remote X,
> then a client repository C which would like to clone or fetch from S might,
> or might not, want to also borrow objects from X. Also S might, or might
> not, want to advertise X as a good way for C to directly get objects from,
> instead of C getting everything through S.

If S is a clone that is keeping up to date with X, even if it does
not borrow anything from X, as long as X is known to be much better
connected to the world (e.g., it is in a $LARGEINTERNETCOMPANY
datacenter with petabit/s backbone connections) than S is (e.g., it
is my deskside box on a cable modem), it may be beneficial if S can
omit objects from its "git fetch" response to C, if C is willing to
fill the gap using X.

So it is of dubious value to limit the feature only to cases where S
"borrows" from X, is it?

> To allow S and C to agree on C using X or not, let's introduce a new
> "promisor-remote" capability in the protocol v2, as well as a few new
> configuration variables:
>
>   - "promisor.advertise" on the server side, and:
>   - "promisor.acceptFromServer" on the client side.
>
> By default, or if "promisor.advertise" is set to 'false', a server S will
> advertise only the "promisor-remote" capability without passing any
> argument through this capability. This means that S supports the new
> capability but doesn't wish any client C to directly access any promisor
> remote X S might use.

I would find it more natural if .advertise is turned off by setting
it explicitly to "false", we would pretend as if we have never even
heard of such a capability.

> If "promisor.advertise" is set to 'true', S will advertise its promisor
> remotes with a string like:
>
>   promisor-remote=<pm-info>[;<pm-info>]...
>
> where each <pm-info> element contains information about a single
> promisor remote in the form:
>
>   name=<pm-name>[,url=<pm-url>]
> where <pm-name> is the name of a promisor remote and <pm-url> is the
> urlencoded url of the promisor remote named <pm-name>.

OK, so pm-name cannot have ";," in it (which is sensible, or define
pm-name more tightly, like "only lowercase alnum").  URL cannot have
';' or ',' in it that is an OK limitation as URL encoding can hide
them.

> For now, the URL is passed in addition to the name. In the future, it
> might be possible to pass other information like a filter-spec that the
> client should use when cloning from S, or a token that the client should
> use when retrieving objects from X.

OK.  And obviously they cannot have ';," in them without encoding
similarly.

> It might also be possible in the future for "promisor.advertise" to have
> other values like "onlyName", so that no URL is advertised.

Saying "<pm-info> is expected to be extended" should be sufficient,
without inviting discussions like "what good does it do to give only
names" that is irrelevant at least at this moment.

> By default or if "promisor.acceptFromServer" is set to "None", the
> client will not accept to use the promisor remotes that might have been
> advertised by the server. In this case, the client will advertise only
> "promisor-remote" in its reply to the server. This means that the client
> has the "promisor-remote" capability but decided not to use any of the
> promisor remotes that the server might have advertised.

OK, that is a signal to the server side that it is not allowed to
omit any objects from its response to "git fetch" request, even
though they might be available via a better connected remotes.

> If "promisor.acceptFromServer" is set to "All", on the contrary, the
> client will accept to use all the promisor remotes that the server
> advertised and it will reply with a string like:
>
>   promisor-remote=<pm-name>[;<pm-name>]...
>
> where the <pm-name> elements are the names of all the promisor remotes
> the server advertised.

So, this is why we need "name" for each "pm-info"---to give a short
name associated with the URL of the remote repository.

Presumably, C has an option to see if each of the remote suggested
is reachable and omit remotes that are not available to C from its
response, so even when .accept is set to "all", the response may not
list all the names of remotes that S advertised, in general.

> If the server advertised no promisor remote
> though, the client will reply with just "promisor-remote".

In other words, at the protocol level:

 - S uses promisor-remote capability to tell C what are potentially
   useful alternate remotes to obtain objects that C may want to
   fetch from S

 - C uses promisor-remote capability to tell S that among the
   remotes advertised by S, it is willing to use the named remotes
   as its promisor, which permits S from omitting objects from its
   response to "git fetch" request from C as long as they are known
   to be available from these remotes.

I think that makes sense, but I do not see the point of sending an
empty promisor-remote capability at all.

What practical difference would it make to S and C, if S chooses not
to advertise the capability at all, instead of advertising an empty
remote list with the capability?  Both tells C that it is useless to
request promistor-remote capability to S in its response.

What practical difference would it make to S and C, if C chooses not
to advertise the capability at all, instead of advertising an empty
remote list with the capability?  Both tells S that S is not allowed
to omit objects that are obtainable from elsewhere.

> In a following commit, other values for "promisor.acceptFromServer" will
> be implemented so that the client will be able to decide the promisor
> remotes it accepts depending on the name and URL it received from the
> server. So even if that name and URL information is not used much right
> now, it will be needed soon.

OK.

> diff --git a/Documentation/config/promisor.txt b/Documentation/config/promisor.txt
> index 98c5cb2ec2..e3939d83a9 100644
> --- a/Documentation/config/promisor.txt
> +++ b/Documentation/config/promisor.txt
> @@ -1,3 +1,16 @@
>  promisor.quiet::
>  	If set to "true" assume `--quiet` when fetching additional
>  	objects for a partial clone.
> +
> +promisor.advertise::
> +	If set to "true", a server will use the "promisor-remote"
> +	capability, see linkgit:gitprotocol-v2[5], to advertise the
> +	promisor remotes it is using if any. Default is "false", which
> +	means no promisor remote is advertised.

Even though I said that there logically is not much reason to tie
this advertisement to the use of promistor remote by the serving
side, I am OK if the initial implementation is limited to that
arrangement.  It would be an easy change to allow this variable
to take a list of remote repositories that may (or may not) be a
promisor remote of this repository (in other words, "they are clones
that are better connected than me") in the future, but that does not
have to happen in the initial iteration.

It would be less confusing to first-time readers if you described
the intent a bit better.  Why would the server want to advertise and
how would the client take advantage of the information?  I see that
the update in this patch to protocol document is skimpy on this point,
and end-user facing documentation has better exposure anyway, so
let's see what we can do here.

    The "promisor-remote" protocol capability can be used by the
    responder to "git fetch" to advertise better-connected remotes
    that the requester can use as promisor remotes, instead of this
    repository, so that "git fetch" requestor can lazily fetch
    objects from these other better-connected remotes.  If this
    configuration variable is set to "true",...

or something, perhaps?

"no promisor remote is advertised" -> "no promisor-remote capability
is advertised".

> +promisor.acceptFromServer::
> +	If set to "all", a client will accept all the promisor remotes
> +	a server might advertise using the "promisor-remote"
> +	capability, see linkgit:gitprotocol-v2[5]. Default is "none",
> +	which means no promisor remote advertised by a server will be
> +	accepted.

Similarly, readers would want to know what the implication is to
"accept" promisor remotes.

	accept ..., and adds them to its promisor remotes, allowing
        the server to omit objects from its response to "fetch"
        requests that are lazily fetchable from these promisor
        remotes, see linkgit:gitprotocol-v2[5].

or something?

> diff --git a/Documentation/gitprotocol-v2.txt b/Documentation/gitprotocol-v2.txt
> index 414bc625d5..4d8d3839c4 100644
> --- a/Documentation/gitprotocol-v2.txt
> +++ b/Documentation/gitprotocol-v2.txt
> @@ -781,6 +781,43 @@ retrieving the header from a bundle at the indicated URI, and thus
>  save themselves and the server(s) the request(s) needed to inspect the
>  headers of that bundle or bundles.
>  
> +promisor-remote=<pr-infos>
> +~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The server may advertise some promisor remotes it is using, if it's OK
> +for the server that a client uses them too. In this case <pr-infos>
> +should be of the form:

As this is the protocol documentation, we should describe what goes
over the wire and what they mean, regardless of how limited the
initial implementation on either end is.  Advertising the promisor
remotes the server side relies on is probably not what we want to
see this capability limited to forever (remember the previous "X is
much better connected than S" example).

    "it is using, if it's OK ..." -> "the other side may want to use
    as its promisot remotes, instead of this repository"

> +	pr-infos = pr-info | pr-infos ";" pr-info
> +
> +	pr-info = "name=" pr-name | "name=" pr-name "," "url=" pr-url
> +
> +where `pr-name` is the name of a promisor remote, and `pr-url` the
> +urlencoded URL of that promisor remote.

Clarify what the syntax for a valid name here.  Also stress the fact
that ';' and ',' MUST be encoded if it appears in 'pr-url'.

> +In this case a client wanting to use one or more promisor remotes the
> +server advertised should reply with "promisor-remote=<pr-names>" where
> +<pr-names> should be of the form:
> +
> +	pr-names = pr-name | pr-names ";" pr-name
> +
> +where `pr-name` is the name of a promisor remote the server
> +advertised.

After seeing advertisement, client can use some it picked but it
does not have to tell the server about it.  Why would it respond
with the promisor remotes, and what effect does it have to give the
list of promisor remotes it uses?

    If the "git fetch" side decides to use one or more promisor
    remotes advertised, it can reply with ...
    ...
    where ... the server advertised.  Doing so allows the server to
    make its response smaller by omitting objects that are known to
    be lazily fetchable from these other promisor remotes
    repositories.

perhaps?

> +If the server prefers a client not to use any promisor remote the
> +server uses, or if the server doesn't use any promisor remote, it
> +should only advertise "promisor-remote" without any value or "=" sign
> +after it.

It should not advertise "promisor-remote" capability at all.

> +In this case, or if the client doesn't want to use any promisor remote
> +the server advertised, the client should reply only "promisor-remote"
> +without any value or "=" sign after it.

Likewise.  It should not advertise "promisor-remote" capability at
all.

> +The "promisor.advertise" and "promisor.acceptFromServer" configuration
> +options can be used on the server and client side respectively to
> +control what they advertise or accept respectively. See the
> +documentation of these configuration options for more information.

OK.
