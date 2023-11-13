Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D193249F5
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 22:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aky1mYI6"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC451DC
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 14:22:51 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A0700227D4;
	Mon, 13 Nov 2023 17:22:49 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Z0L3+ULZZ9Xo
	G7XU3KBB1iXxZjnabl/HvZsERc9Ese0=; b=aky1mYI6woQDhLm007Kw3ieFuJZr
	0WqiBJP4MVG5yU5k/V4YVsi24XTEQ1MR7uP0WlVYedRHpKC73J6OXjph9kY+ZUTc
	iFal/y3GldeUpdxwCpp8pA7pYeORY2NYQOewcN08BAUjKNJJpnAvaUt+i2o6C1fA
	Z4xgvjXg4qcWe84=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 99D69227D3;
	Mon, 13 Nov 2023 17:22:49 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 37EB5227CE;
	Mon, 13 Nov 2023 17:22:46 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc: Joanna Wang <jojwang@google.com>,  git@vger.kernel.org
Subject: Re: [PATCH 1/1] attr: add native file mode values support
In-Reply-To: <20231113165031.GA28778@tb-raspi4> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?=
	message of "Mon, 13 Nov 2023 17:50:31 +0100")
References: <20231111040309.2848560-1-jojwang@google.com>
	<20231113165031.GA28778@tb-raspi4>
Date: Tue, 14 Nov 2023 07:22:44 +0900
Message-ID: <xmqqo7fx5m4r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 2BC7B1F2-8273-11EE-BB28-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On Sat, Nov 11, 2023 at 04:03:08AM +0000, Joanna Wang wrote:
>
> Some thoughts and comments inline...
>
>> Gives all paths inherent 'mode' attribute values based on the paths'
>> modes (one of 100644, 100755, 120000, 040000, 160000). Users may use
>> this feature to filter by file types. For example a pathspec such as
>> ':(attr:mode=3D160000)' could filter for submodules without needing
>
> My spontanous feeling is that filetype may be another choice:
>> ':(attr:filetype=3D160000)' could filter for submodules without needin=
g

I do agree that "mode" invites "mode of what???" reaction, and that
a term that narrows the scope would be preferrable.  "Filemode" is a
bit questionable, though, as we give this permbits to non-files like
submodules.  "ls-tree" documentation seems to call it %(objectmode).

> And having written this, we can think using something borrowed from
> `find . -type f`
>
> :(attr:filetype=3Df)' or :(attr:filetype=3Dx)' (for executable)

This would not work for submodules, though.  Naively one might want
to abuse 'd' but I suspect we would eventually want to be able to
give the mode bits to an out-of-cone directory storeed in the index
as a tree in a cone-mode sparse checkout, which would be 040000,
which deserves 'd' more than submodules.

> But then I missed the point why we need an attribute here?
> The mode is already defined by the the file system (and Git),
> is there a special reason that the user can define or re-define the
> value here ?

I think the idea is that "mode" being a too generic word can be used
for totally different purposes in existing projects and the addition
did not want to disturb their own use.  But stepping back a bit,
such an application is likely marking selected few paths with the
attribute, and paths for which "mode" was "unset" are now given
these natural "mode"; it is inevitable to crash with such uses.  If
we want to introduce "native" attributes of this kind, we would
probably need to carve out namespaces a bit more clearaly.

> May be there is, when working with pathspec.
> But then "pathspec=3D" could be a better construction.
> Since "mode" could make a reader think that Git does somewhat with the =
file
> when checking out.
> My personal hope reading "mode=3D100755" in .gitattributes would
> be that Git makes it executable when checking out, if if it is
> recorded in Git as 100644, probably coming from a file-system that
> doesn't support the executable bit in a Unix way.

That is not the intended way this attribute is to be used.  Perhaps
we should make it an error (or ignored) when certain built-in/native
attributes are seen in the attribute file, but again that takes some
namespace carved out to avoid crashing with end-user names.

>> If there is any existing mode attribute for a path (e.g. there is
>> !mode, -mode, mode, mode=3D<value> in .gitattributes) that setting wil=
l
>> take precedence over the native mode value.

Again, this has one hole, I think.  Paths that are not mentioned
(not even with "!mode") would come to the function as ATTR__UNKNOWN
and trigger the fallback behaviour, even when other paths are given
end-user specified "mode" attribute values.
