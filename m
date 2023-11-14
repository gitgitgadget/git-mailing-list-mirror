Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B817E
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 02:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lh3dQB0s"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F345812D
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 18:53:03 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 87E072C2E0;
	Mon, 13 Nov 2023 21:53:03 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Q2y2+XPYJRzMqboVM5WjeQa4tMId4z/cU4sgHR
	us4VQ=; b=lh3dQB0sS1a2UF7G6zdh76ULW/9wfp9/Ob4eZej4/6rUx04YSPFXgg
	yTHy7MY/tL3S/dEVwQfs+f6KlPRfQ/N2XDXIKEBMeSgFYUD7UPcy7arilm/+C3J/
	ULGVIVX1lqcpDDLPJai81n4qFEx8OWzLssTr7jEb/8Sw9guytSbeg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7273B2C2DF;
	Mon, 13 Nov 2023 21:53:03 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F2B392C2D6;
	Mon, 13 Nov 2023 21:52:58 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Joanna Wang <jojwang@google.com>
Cc: git@vger.kernel.org,  tboegi@web.de
Subject: Re: [PATCH 1/1] attr: add native file mode values support
In-Reply-To: <CAMmZTi-7=L6XOB9-MwZCpD5QaziTi0x6J7m-UTtwQ0S00wnVgQ@mail.gmail.com>
	(Joanna Wang's message of "Mon, 13 Nov 2023 18:28:00 -0800")
References: <CAMmZTi-7=L6XOB9-MwZCpD5QaziTi0x6J7m-UTtwQ0S00wnVgQ@mail.gmail.com>
Date: Tue, 14 Nov 2023 11:52:57 +0900
Message-ID: <xmqqbkbx11x2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EBF0860A-8298-11EE-AAFB-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Joanna Wang <jojwang@google.com> writes:

>>> Even if we assume that this code is currently meant to work only
>>> with GIT_ATTR_CHECKIN, I do not think this is what you want.  When
>>> asked to perform "git add . ':(exclude,mode=160000)'", you not only
>>> want to exclude the submodules that are already known to this
>>> superproject, but also a repository that _can_ become a submodule of
>>> this superproject when added, no?
> Sorry, I was totally ignorant of ...

Nothing to be sorry about, and if I sounded like I was upset or
something, that wasn't my intention.  Reviewers and more experienced
developers read posted patches to give pieces of advice exactly
because no single human is perfect and knows everything.  We cover
holes in each others' knowledge and attention.

>>> On the other hand, the GIT_ATTR_CHECKOUT direction is hopefully much
>>> simpler.  You'd see what the path in the index is, among a gitlink,
>>> a regular non-executable file, an executable file, or a symlink.
> I noticed for both the GIT_ATTR_CHECKOUT and GIT_ATTR_CHECKIN directions,
> in read_attr(), the indexed .gitattributes file is checked with the
> actual file as fallback or vice versa.
> I would think that we'd only want to use attributes from one state
> (e.g. what's actually in the file)
> or the other (e.g. what's indexed).
> So I guess I'm still not sure what the "direction" concept is.
> For GIT_ATTR_CHECKOUT, would we want to fallback to lstat?

When checking things out of the index, the index should be the
source of the truth.  If something is not in the index, is there a
point in falling back to the workint tree state to decide if the
thing should be checked out of the index?

>>> But stepping back a bit,
>>> such an application is likely marking selected few paths with the
>>> attribute, and paths for which "mode" was "unset" are now given
>>> these natural "mode"; it is inevitable to crash with such uses.
> I'm confused. This does not match what I think is the current behavior
> of my patch.
> If "mode" was unset or removed for a path (meaning '<path> !mode' was
> added to .gitattributes),
> the code in my patch would respect that and not return the native mode.
> It would return 'unspecified' or 'unset'.

But the usual practice is *not* to cover all paths with explicit
attribute definition, isn't it?  If somebody used the "foo"
attribute in their project to decide certain paths are worth giving
special treatments, there are paths with that attribute, perhaps
(totally made up example):

	*.c	foo=yes

Now, if you add a new "built-in" attribute next to 'mode' that
assigns "foo" in attr.c:git_check_attr() the same way to those paths
whose value is still ATTR__UNKNOWN after collect_some_attrs returns,
wouldn't a "hello.c" file get attribute 'foo' with value 'yes',
while a "hello.h" file (not mentioned by .gitattributes) will get
whatever value the built-in logic computed for it?  If that existing
project were using "mode" (instead of "foo"), then doesn't this patch
change the behaviour for them?

>>> Again, this has one hole, I think.  Paths that are not mentioned
>>> (not even with "!mode") would come to the function as ATTR__UNKNOWN
>>> and trigger the fallback behaviour, even when other paths are given
>>> end-user specified "mode" attribute values.
> What you are describing sounds correct/what I intended.
> So are you saying that the expected behavior is actually:
> If the user sets 'mode' for 1+ paths in the repo, then the native mode
> fallback should
> NOT be used for all paths in the repo?

That might be workable, but it breaks a well working system suddenly
when somebody uses "mode" in their .gitattibutes and we do not even
warn about the breakage, which is not ideal.

I think, when we see such an attribute is defined while reading from
.gitattributes and friends, we would probably want to warn and
ignore their definition altogether and use *only* the computed
value.  This cannot be done in a backward compatible way, so it
would be better to carve out a namespace (and avoid overly generic
word like "mode") for ourselves to define built-in attributes that
do not overlap with end-user defined attribute names.

Perhaps call this 'builtin-object-mode' or something and document
that any attribute with a name that begins with 'builtin-' will
always get a computed value (possibly "unset"), it is an error
to define such an attribute in .gitattributes system, or something?


