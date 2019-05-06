Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D84801F45F
	for <e@80x24.org>; Mon,  6 May 2019 23:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbfEFX2p (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 May 2019 19:28:45 -0400
Received: from resqmta-po-05v.sys.comcast.net ([96.114.154.164]:37424 "EHLO
        resqmta-po-05v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725994AbfEFX2p (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 6 May 2019 19:28:45 -0400
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 May 2019 19:28:45 EDT
Received: from resomta-po-05v.sys.comcast.net ([96.114.154.229])
        by resqmta-po-05v.sys.comcast.net with ESMTP
        id NcVXhgt0f3hFENmuShm2f0; Mon, 06 May 2019 23:20:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1557184836;
        bh=ZWGaIePD18v6Z0mQKfn76Gr8bgv+piPNe2ORPvRZXxk=;
        h=Received:Received:Content-Type:Mime-Version:Subject:From:Date:
         Message-Id:To;
        b=xxbWoXaEHqSkKPEEPoj81iZTsX4Hrq85iyscvRnYvUu1ngEeATVnMUWZMih0rFnBF
         RBqtLGdlBUW3OqY3HHu7+milVpKldGu4Y11z69wrCJPKNYXZROe2nwLanJ3XGdK9Ze
         5vPFUI5kmnHdCyhoNg+7le+W0mPat5X2J/A/jwAqE0uuwx9OEupmZqwjawg1OxR+v8
         u/B7Sf6hI6p9411+7hW7f5zfzgghU8v0AiJR7QUo8OUGIHBkrABLRu7MUyE8IV+yEb
         OuZhZ+QrIJJkY8GCCPhULa27oQft3W7m05ouKP+O7E2AgZoUYiiR2W+QhJCxSZ1EbA
         CN+Az34rx6Umw==
Received: from [IPv6:2620::100e:913:17f:4067:58eb:5bb2] ([IPv6:2620:0:100e:913:17f:4067:58eb:5bb2])
        by resomta-po-05v.sys.comcast.net with ESMTPA
        id NmuBh2Kgb5czHNmuGhTCjK; Mon, 06 May 2019 23:20:34 +0000
X-Xfinity-VMeta: sc=-100;st=legit
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: Proposal: object negotiation for partial clones
From:   Matthew DeVore <matvore@comcast.net>
In-Reply-To: <20190506194625.GB57368@google.com>
Date:   Mon, 6 May 2019 16:20:19 -0700
Cc:     Jonathan Tan <jonathantanmy@google.com>, matvore@google.com,
        git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <EA2BD2A8-2641-4B71-8439-66994DE9589F@comcast.net>
References: <CAMfpvhKYRVwTVNLfRJYcjhHtg=FNLNPbnw8xtY93nJu228v6=g@mail.gmail.com>
 <20190506192800.213716-1-jonathantanmy@google.com>
 <20190506194625.GB57368@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On 2019/05/06, at 12:46, Jonathan Nieder <jrnieder@gmail.com> wrote:
>=20
> Hi,
>=20
> Jonathan Tan wrote:
>> Matthew DeVore wrote:
>=20
>>> I'm considering implementing a feature in the Git protocol which =
would
>>> enable efficient and accurate object negotiation when the client is =
a
>>> partial clone. I'd like to refine and get some validation of my
>>> approach before I start to write any code, so I've written a =
proposal
>>> for anyone interested to review. Your comments would be appreciated.
>>=20
>> Thanks. Let me try to summarize: The issue is that, during a fetch,
>> normally the client can say "have" to inform the server that it has a
>> commit and all its referenced objects (barring shallow lines), but we
>> can't do the same if the client is a partial clone (because having a
>> commit doesn't necessarily mean that we have all referenced objects).
>=20
> Ah, interesting.  When this was discussed before, the proposal has =
been
> that the client can say "have" anyway.  They don't have the commit and
> all referenced objects, but they have the commit and a *promise* that
> they can obtain all referenced objects, which is almost as good.
> That's what "git fetch" currently implements.
Doesn=E2=80=99t that mean the =E2=80=9Chave=E2=80=9D may indicate that =
the client has the entire repository already, even though it=E2=80=99s =
only a partial clone? If so, then the client intends to ask for some =
tree plus trees and blobs 2-3 levels down deeper, how would the server =
distinguish between those objects the client *really* has and those that =
were just promised to them? Because the whole purpose of this =
hypothetical request is to get a bunch of promises fulfilled of which =
0-99% are fulfilled already.

>=20
> For blob filters, if I ignore the capability advertisements (there's
> an optimization that hasn't yet been implemented to allow
> single-round-trip fetches), the current behavior takes the same number
> of round trips as this proposal.  Where the current approach has been
> lacking is in delta base selection during fetch-on-demand.  Ideas for
> improving that?

Maybe something like this (conceptually based on original proposal) ?

1. Client sends request for an object or objects with an extra flag =
which means =E2=80=9CI can=E2=80=99t really tell you what I already have =
since it=E2=80=99s a chaotic subset of the object database of the =
repo=E2=80=9D

2. Server responds back with set of objects, represented by deltas if =
that is how the server has them on disk, along with a list of object-IDs =
needed in order to resolve the content of all the objects. These =
object-IDs can go several layers of deltas back, and they go back as far =
as it takes to get to an object stored in its entirety by the server.

3. Client responds back with another request (this time the extra flag =
sent from step 1 is not necessary) which has =E2=80=9Cwant=E2=80=9Ds for =
every object the server named which the client already has.

Very hand-wavey, but I think you see my idea.

