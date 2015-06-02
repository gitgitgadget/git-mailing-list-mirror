From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/4] implement submodule config cache for lookup of submodule names
Date: Tue, 02 Jun 2015 12:57:08 -0700
Message-ID: <xmqqbngx3muj.fsf@gitster.dls.corp.google.com>
References: <20150602142436.GA7713@book.hvoigt.net>
	<20150602142538.GB7713@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, "W. Trevor King" <wking@tremily.us>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karsten Blees <karsten.blees@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Jun 02 21:57:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzsJN-000180-Tj
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 21:57:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752133AbbFBT5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 15:57:16 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:34002 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076AbbFBT5L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 15:57:11 -0400
Received: by ieczm2 with SMTP id zm2so141612597iec.1
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 12:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=rVZm9Fsk5NoSvS2RHo1GSWbmSzogZPG3vfwrDXv+sy8=;
        b=Nxod+P38UYiYoN7ZYnpZT64w4yFG1WY+Y30ipRZ1PD7SO3sKuHqUjebvT74FdS5GK+
         QLqFE5YkKZw+gIhOIBKrZruxCfK0etrpBXi8x4R1miHKfuJfynlA7KzZ2z6qG40ZvuZ5
         6sJFvKmnXfe1DNpx7M8ZNJ65oa8/bGlPEwOu8edi03QVpaecOOmPNu2U5L1JSY1yEiWU
         swv0pcG5PrglpyGRDwxpUgX2M06gFM3bW0M/sh8zrOlKVPGbOBqDDRsOt9Yed75d5nBh
         J65pjfmD4vt4DcmkyQRBKlE4/SxQrQEOocMbEEqia4Sj+3NOnSRWSchJ0twiJh0kceCi
         I09A==
X-Received: by 10.107.13.130 with SMTP id 124mr12734846ion.70.1433275030665;
        Tue, 02 Jun 2015 12:57:10 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3140:53f3:e8c0:89b0])
        by mx.google.com with ESMTPSA id o9sm13161995ioe.35.2015.06.02.12.57.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Jun 2015 12:57:09 -0700 (PDT)
In-Reply-To: <20150602142538.GB7713@book.hvoigt.net> (Heiko Voigt's message of
	"Tue, 2 Jun 2015 16:25:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270588>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> This submodule configuration cache allows us to lazily read .gitmodules
> configurations by commit into a runtime cache which can then be used to
> easily lookup values from it. Currently only the values for path or name
> are stored but it can be extended for any value needed.
>
> It is expected that .gitmodules files do not change often between
> commits. Thats why we lookup the .gitmodules sha1 from a commit and then
> either lookup an already parsed configuration or parse and cache an
> unknown one for each sha1. The cache is lazily build on demand for each
> requested commit.
>
> This cache can be used for all purposes which need knowledge about
> submodule configurations. Example use cases are:
>
>  * Recursive submodule checkout needs lookup a submodule name from its
>    path when a submodule first appears. This needs be done before this
>    configuration exists in the worktree.
>
>  * The implementation of submodule support for 'git archive' needs to
>    lookup the submodule name to generate the archive when given a
>    revision that is not checked out.
>
>  * 'git fetch' when given the --recurse-submodules=on-demand option (or
>    configuration) needs to lookup submodule names by path from the
>    database rather than reading from the worktree. For new submodule it
>    needs to lookup the name from its path to allow cloning new
>    submodules into the .git folder so they can be checked out without
>    any network interaction when the user does a checkout of that
>    revision.

What is unclear to me after reading the above twice is what this
thing is meant to achieve.  Is it efficiency by doing lazy lookups
and caching to avoid asking the same thing more than once from
either the filesystem or read_sha1_file()?  Is it expected that
reading through this "cache" will be the _only_ way callers would
interact with the .gitmodules data, or is it an opt-in feature that
some callers that do not see the benefit (why they may want to
ignore is totally unclear, because what the "cache" system wants to
achieve is) can safely ignore and bypass?

Because the above talks about looking up ".gitmodules from a
commit", I am guessing that the "commit" used as one of the lookup
keys throughout the system is a commit in the superproject, not from
submodules, but you may want to state that more explicitly.

What, if anything, should be done for .gitmodules that are not yet
committed?  Are there cases that the callers that usually interact
with .gitmodules via this "cache" system need to use .gitmodules
immediately after adding a new submodule but before committing that
change to the superproject?  Do they code something like this?

	if (cached)
        	read .gitmodules from the index and fabricate
		struct submodule;
	else if (worktree)
        	read .gitmodules from the working tree and fabricate
		struct submodule;
	else
		call submodule_from_name("HEAD", ...) and receive
                struct submodule;

	use the struct submodule to learn from the module;

Yes, I am wondering if submodule_from_name() should be extended to
allow the former two cases, so that the caller can make a single
call above and then use resulting "struct submodule" throughout its
code after doing so.  And I also am hoping that the answer to my
questions above to be "This is not just an opt-in 'cache' API, but
we want to make it the unified API for C code to learn about what is
in .gitmodule".

> diff --git a/Documentation/technical/api-submodule-config.txt b/Documentation/technical/api-submodule-config.txt
> new file mode 100644
> index 0000000..2ff4907
> --- /dev/null
> +++ b/Documentation/technical/api-submodule-config.txt
> @@ -0,0 +1,46 @@
> +submodule config cache API
> +==========================
> +
> +The submodule config cache API allows to read submodule
> +configurations/information from specified revisions. Internally
> +information is lazily read into a cache that is used to avoid
> +unnecessary parsing of the same .gitmodule files. Lookups can be done by
> +submodule path or name.
> +
> +Usage
> +-----
> +
> +The caller can look up information about submodules by using the
> +`submodule_from_path()` or `submodule_from_name()` functions. They return
> +a `struct submodule` which contains the values. The API automatically
> +initializes and allocates the needed infrastructure on-demand.
> +
> +If the internal cache might grow too big or when the caller is done with
> +the API, all internally cached values can be freed with submodule_free().
> +
> +Data Structures
> +---------------
> +
> +`struct submodule`::
> +
> +	This structure is used to return the information about one
> +	submodule for a certain revision. It is returned by the lookup
> +	functions.

Hopefully this will not stay an opaque structure as we read later
patches ;-).

> +Functions
> +---------
> +
> +`void submodule_free()`::
> +
> +	Use these to free the internally cached values.

"These" meaning "this single function", or are there variants of it?

> diff --git a/submodule-config.c b/submodule-config.c
> new file mode 100644
> index 0000000..97f4a04
> --- /dev/null
> +++ b/submodule-config.c
> @@ -0,0 +1,445 @@
> +#include "cache.h"
> +#include "submodule-config.h"
> +#include "submodule.h"
> +#include "strbuf.h"
> +
> +/*
> + * submodule cache lookup structure
> + * There is one shared set of 'struct submodule' entries which can be
> + * looked up by their sha1 blob id of the .gitmodule file and either
> + * using path or name as key.
> + * for_path stores submodule entries with path as key
> + * for_name stores submodule entries with name as key
> + */
> +struct submodule_cache {
> +	struct hashmap for_path;
> +	struct hashmap for_name;
> +};
> +
> +/*
> + * thin wrapper struct needed to insert 'struct submodule' entries to
> + * the hashmap
> + */
> +struct submodule_entry {
> +	struct hashmap_entry ent;
> +	struct submodule *config;
> +};

The above, and the singleton-ness of the "cache", implies that we
can have only one "struct submodule" for a given path (or a name).
Does that mean the subsystem implicitly is tied to a single commit
at the superproject level?

What happens when I call submodule_from_path() for a single
submodule at one commit in the superproject, and then ask about that
same submodule for another commit in the superproject, which may
have a different version of .gitmodules, by calling the same
function again?

	Side note: I think I know the answer to these questions,
	after reading the hash function.  for_path does not store
	submodule entries with path as key.  It uses the commit and
	the path as a combined key, so both HEAD:.gitmodules and
	HEAD^:.gitmodules can be cached and looked up separatedly if
	their contents are different.  The comment and field names
	of "struct submodule_cache" may want to be improved.

When do we evict the cache?  I am wondering what would happen when
you do "git log --recursive" at the superproject level, which may
grow the cache in an unbounded way without some eviction policy.
