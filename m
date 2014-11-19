From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-fetch: default globally to --no-tags
Date: Wed, 19 Nov 2014 10:45:48 -0800
Message-ID: <xmqqr3wzrpur.fsf@gitster.dls.corp.google.com>
References: <20141119030523.GO22361@norris-Latitude-E6410>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 19:45:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrAGK-0006Rl-AO
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 19:45:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755576AbaKSSpw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2014 13:45:52 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64986 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755334AbaKSSpv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2014 13:45:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 749FD1DA5B;
	Wed, 19 Nov 2014 13:45:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Xokk9xv3mMjZ6xbuaGOa8JCzuJI=; b=BBat6b
	hEfdBi1gsRW5zkSazS9BNcIfI+xZLjmGj1ykCFVl+zhb02r47O481+ahaC9DoMGn
	1BONb9MVrkFfHu/aN8XqXepNgtQ3Q65/31/i5vNt9h8vl26IRmeK7RJR4C+7Pd5k
	oQwWYsqzzgPDf9khlEtkFHJbrmJRWLAPODSBw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TgOUpdUs4zkMxgd2Qwh4aPIBfcLeqvdP
	BPAoN/fxC6OVqs7M0ij61JPIvDi2eBRcOJ6K9jgI68OPvngQm4/YbTU1fc7Xuw2Q
	Ol/nPWFpplTNL791KCTnmN9UstSAgRH2edrcvmWstzgEhgJ1OpcoU27wpkU5RjG/
	gyokPzWBmIw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6A5271DA5A;
	Wed, 19 Nov 2014 13:45:50 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E43FB1DA59;
	Wed, 19 Nov 2014 13:45:49 -0500 (EST)
In-Reply-To: <20141119030523.GO22361@norris-Latitude-E6410> (Brian Norris's
	message of "Tue, 18 Nov 2014 19:05:23 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 48206DBC-701C-11E4-93B4-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brian Norris <computersforpeace@gmail.com> writes:

> --- TL;DR ---

You usually have TL;DR at the beginning to help people save time;
having it at the end forces the whole thing to be read and would not
help anybody. ;-)

> My email boils down to two questions:
>
>   (A) Has there been progress on implementing a proposal like in [2]?

I do not think so, and also I do not agree that "mirror everybody
else's ref hierarchy into separate namespaces" is necessarily a good
idea, especially for tags, whose reason of existence is to give
people a way to have anchoring points they agree on to have a shared
world view necessary to move things forward.

In other words, talks in [2] are attempting to solve a wrong
problem.  The problem people want to solve is to have a mechanism to
keep private anchoring points that are not necessarily shared
project wide, which tags in refs/tags hierarchy is *not*.

Like it or not, tags are meant to be used for globally shared
anchoring points and the whole machinery (e.g. "fetch" that
auto-follows tags, "clone" that gives refs/tags*:refs/tags/*
refspec) is geared towards supporting that use pattern, which will
be broken by moving tags to per-remote namespace.

I can see "git tag --local foo" that creates refs/local-tags/foo
and also adding a mechanism to propagate local-tags/ hierarchy just
like heads/ hierarchy is propagated per-remote as a solution to that
problem that does not break the "release tags" use case, though.

>   (B) Can we allow disabling (auto)tag-fetching globally? Like:
>
>         git config --global remote.tagopt --no-tags

Using remote.<variable> as a fallback for remote.<remote>.<variable>
may be a useful addition, not limited to <variable>==tagopt case.

This is a tangent, but it is an important one because we are talking
about "tagopt" specifically.  I think we should start deprecating
"*.tagopt --[no-]tags".  It started as a quick-and-dirty hack back
when "git fetch" was a shell script Porcelain, where it made it easy
to write things like this in its implementation:

	tagOpt=$(git config "remote.$name.tagopt")
        git fetch $tagOpt $name $args

which gives an impression that any command line option can go there
(e.g.  as if you could set "remote.*.tagopt = --frotz --no-tags")
and "git fetch" implementation, even after it is redone in C, must
forever parse it as if it is part of a shell command line
(e.g. splitting at $IFS, unquoting the shell quotes and interpreting
as if they came in argv[]).

This is ugly and simply unmaintainable, and we should transition
away from that, by doing something like:

 (1) Add remote.*.tags configuration, which defaults to 'follow',
     but can be set to 'true' or 'false'.  Accept '--tags' as a
     synonym to 'true' and '--no-tags' as a synonym to 'false'.

     * when set to 'follow', allow auto-following tags (the default).
     * when set to 'true', act as if --tags is given.
     * when set to 'false', act as if --no-tags is given.

 (2) Deprecate remote.*.tagopt configuration.  When it is used, give
     a warning about deprecation and encourage users to move to
     remote.*.tags setting.

 (3) Wait for several release cycles.

 (4) Remove remote.*.tags configuration support at a major version
     boundary.

Needless to say, support for remote.<variable> as a fallback for
remote.<remote>.<variable> for any <variable> can be done in
parallel to this tangent topic.
