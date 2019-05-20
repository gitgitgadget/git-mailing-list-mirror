Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTTP_EXCESSIVE_ESCAPES,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16EF21F462
	for <e@80x24.org>; Mon, 20 May 2019 18:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbfETSZP (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 14:25:15 -0400
Received: from resqmta-po-06v.sys.comcast.net ([96.114.154.165]:35486 "EHLO
        resqmta-po-06v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725763AbfETSZO (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 May 2019 14:25:14 -0400
Received: from resomta-po-03v.sys.comcast.net ([96.114.154.227])
        by resqmta-po-06v.sys.comcast.net with ESMTP
        id SkLvhQ0zC6IAbSmyIhuiil; Mon, 20 May 2019 18:25:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1558376714;
        bh=LvbicdEYn9OEYFNTIgyhi2FQ7I398lnSLKea+PXxFGE=;
        h=Received:Received:Content-Type:Mime-Version:Subject:From:Date:
         Message-Id:To;
        b=0MS38tB1laYOaYiwCarM3hQqtkqwr+VvWXJnjsXbTCvFXDxWibfi6W16yJdGr1ACT
         a0X8y09IaVSc1LU+qnZ5W39GWHCG6ap2QEuTzMAebQ6hH2XXZUUK14BH7hIqe7vqUl
         /6t+jWc0GpV7a2kg0HvfOadKa5IGHk38qDzG3XTKH+Ux2eJLVbFMzwLhlEGj1ufMNd
         g6n/xtyh1FAUwE6owqJjA8ZuGt/lRje7Io1hNdE2J88oV0hc0wJ3KCrunRwhT0Ei0W
         RKjydi+CIsfOX2AWFsg780oqle88tn/3wtV2P2py24wG7BopXMOn56oFgDzmQZzJGB
         AHre6OMZqMVZA==
Received: from [IPv6:2620:15c:2ce:200:edad:e98f:19e5:a93] ([IPv6:2620:15c:2ce:200:edad:e98f:19e5:a93])
        by resomta-po-03v.sys.comcast.net with ESMTPA
        id SmxshTGg6yn8lSmxwhb92k; Mon, 20 May 2019 18:25:11 +0000
X-Xfinity-VMeta: sc=0;st=legit
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [RFC PATCH 3/3] list-objects-filter: implement composite filters
From:   Matthew DeVore <matvore@comcast.net>
In-Reply-To: <1E174CAA-BD57-400B-A83B-4AABFAFBC04B@comcast.net>
Date:   Mon, 20 May 2019 11:24:47 -0700
Cc:     Matthew DeVore <matvore@google.com>, jonathantanmy@google.com,
        jrn@google.com, git@vger.kernel.org, dstolee@microsoft.com,
        jeffhost@microsoft.com, jrnieder@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <B379F2FB-77F2-4FAC-B39A-BB3CFE685681@comcast.net>
References: <20190514001610.GA136746@google.com>
 <cover.1558030802.git.matvore@google.com>
 <02a8c9b017d8df056d7e90aff907d6e0b5506467.1558030802.git.matvore@google.com>
 <xmqqwoip3gp0.fsf@gitster-ct.c.googlers.com>
 <1E174CAA-BD57-400B-A83B-4AABFAFBC04B@comcast.net>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On 2019/05/17, at 6:17, Matthew DeVore <matvore@comcast.net> wrote:
>=20
>=20
>=20
>> On May 16, 2019, at 8:25 PM, Junio C Hamano <gitster@pobox.com> =
wrote:
>>>=20
>>> 	$ git rev-list --filter=3Dtree:2 --filter:blob:limit=3D32k
>>=20
>> Shouldn't the second one say "--filter=3Dblob:limit=3D32k" (i.e. the
>> first colon should be an equal sign)?
>=20
> That's right. Fixed locally.
>=20
>>=20
>>> Such usage is currently an error, so giving it a meaning is =
backwards-
>>> compatible.
>>=20
>> Two minor comments. =20
>>=20
>> If combine means "must satisfy all of these", '+' is probably a poor
>> choice (perhaps we want '&' instead).  Also, it seems to me that
>=20
> I think I agree. & is more intuitive.

After I tried this in code, I noticed two problems with & which make
me prefer + again:

a. the "&" char must be quoted or escaped in the shell, even if it is
   hugged by alphanumeric characters on either side:

	$ echo a&b
	[1] 17083
	a
	-bash: b: command not found
	[1]+  Done                    echo a
	$

b. visually speaking, "&" doesn't stand out very well unless it's
   surrounded by whitespace, and currently it must *not* be surrounded
   by whitespace:

	--filter=3Dcombine:blob:none&tree:3&sparse:../foo

	vs.

	--filter=3Dcombine:blob:none+tree:3+sparse:../foo

>=20
>> having to worry about url encoding and parsing encoded data
>> correctly and securely would be far more work than simply taking
>> multiple command line parameters, accumulating them in a string
>> list, and then at the end of command line parsing, building a
>> combined filter out of all of them at once (a degenerate case may
>> end up attempting to build a combined filter that combines a single
>> filter), iow just biting the bullet and do the "potentially be
>> improved" step from the beginning.
>=20
> My intention actually is to support the repeated flag pretty soon, but =
I only want to write the code if there's agreement on my current =
approach.
>=20
> My justification for the URL-encoding scheme is:
>=20
> 1. The combined filters will eventually have to travel over the wire.
>=20
> 2. The Git protocol will either have repeated "filter" lines or it =
will continue to use a single filter line with an encoding scheme.
>=20
> 3. Continuing to use a single filter line seemed the least disruptive =
considering both this codebase and Git clones like JGit. Other clones =
will likely fail saying "unknown filter combine:" or something like that =
until it gets implemented. A paranoid consideration is that clones and =
proprietary server implementations may currently allow the "filter" line =
to be silently overridden if it is repeated.
>=20
> 4. Assuming we *do* use a single filter line over the wire, it makes =
sense to allow the user to specify the raw filter line as well as have =
the more friendly UI of repeating --filter flags.
>=20
> 5. If we use repeated "filter" lines over the wire, and later start =
implementing a more complete DSL for specifying filters (see Mercurial's =
"revsets") the repeated-filter-line feature in the protocol may end up =
becoming deprecated and we will end up back-pedaling to allow =
integration of the "&" operator with whatever new operators we need.
>=20
> (I very much doubt I will be the one implementing such a DSL for =
filters or resets, but I think it's a possibility)
>=20
>> So why are we allowing %3A there that does not even have to be
>> encoded?  Shouldn't it be an error?
>=20
> We do have to require the combine operator (& or +) and % be encoded. =
For other operators, there are three options:
>=20
> 1. Allow anything to be encoded. I chose this because it's how I =
usually think of URL encoding working. For instance, if I go to =
https://public-inbox.org/git/?q=3Dcod%65+coverage in Chrome, the browser =
automatically decodes the %65 to an e in the address bar. Safari does =
not automatically decode, but the server apparently interprets the %65 =
as an e. I am not really attached to this choice.
>=20
> 2. Do not allow or require anything else to be encoded.
>=20
> 3. Require encoding of a couple of "reserved" characters that don't =
appear in filters now, and don't typically appear in UNIX path names. =
This would allow for expansion later. For instance, "~&%*+|(){}!\" plus =
the ASCII range [0, 0x20] and single and double quotes - do not allow =
encoding of anything else.
>=20
> 4. Same requirements as 3, but permit encoding of other arbitrary =
characters.
>=20
> I kind of like 3 now that I've thought it out more.
>=20
>>=20
>> In any case, I am not quite convinced that we need to complicate the
>> parameters with URLencoding, so I'd skip reviewing large part this
>> patch that is about "decoding".
>=20
> It's fine if we drop the encoding scheme. I intentionally tried to =
limit the amount of work I stacked on top of it until I got agreement. =
Please let me know if anything I've said changes your perspective.
>=20
>>=20
>> Once the combined filter definition is built in-core, the code that
>> evaluates the intersection of all conditions seems to be written
>> sanely to me.
>=20
> Great! I actually did simplify it a bit since I sent the first =
roll-up.
>=20
> Thanks.
>=20

