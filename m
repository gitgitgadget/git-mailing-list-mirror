Return-Path: <SRS0=UUNX=3P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD259C35240
	for <git@archiver.kernel.org>; Sun, 26 Jan 2020 23:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 804A320720
	for <git@archiver.kernel.org>; Sun, 26 Jan 2020 23:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgAZX5j (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jan 2020 18:57:39 -0500
Received: from locusts.copyleft.no ([193.58.250.85]:61398 "EHLO
        mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgAZX5i (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jan 2020 18:57:38 -0500
Received: from mail-lf1-f41.google.com ([209.85.167.41])
        by mail.mailgateway.no with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72 (FreeBSD))
        (envelope-from <johan@herland.net>)
        id 1ivrmZ-0002Dy-03
        for git@vger.kernel.org; Mon, 27 Jan 2020 00:57:35 +0100
Received: by mail-lf1-f41.google.com with SMTP id y19so4984315lfl.9
        for <git@vger.kernel.org>; Sun, 26 Jan 2020 15:57:34 -0800 (PST)
X-Gm-Message-State: APjAAAUaD/YUucphMyjMrg0odq9d7zSFm+MkURIA5wPwvaZntQvSMIC3
        82l1CS8YhDB4l9trquVQ7j2e6CYWsugJyCazTek=
X-Google-Smtp-Source: APXvYqwvFYD4XNjVZpQgDK3Or1poUMVrlWtj2gSJ0pixI96ebFXKAxwevrj0ihtCToxC//+KwLEbNhyc8p/Ep7ctRlg=
X-Received: by 2002:a19:f514:: with SMTP id j20mr6523110lfb.31.1580083049528;
 Sun, 26 Jan 2020 15:57:29 -0800 (PST)
MIME-Version: 1.0
References: <20200125230035.136348-1-sandals@crustytoothpaste.net>
 <20200125230035.136348-4-sandals@crustytoothpaste.net> <nycvar.QRO.7.76.6.2001261209590.46@tvgsbejvaqbjf.bet>
 <CALKQrgcF0KK1gEvyKe3th2w0YJBbmv+grgbCeN4fOzHKo=H1UA@mail.gmail.com> <nycvar.QRO.7.76.6.2001261957060.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2001261957060.46@tvgsbejvaqbjf.bet>
From:   Johan Herland <johan@herland.net>
Date:   Mon, 27 Jan 2020 00:57:18 +0100
X-Gmail-Original-Message-ID: <CALKQrgc9EwjJL=u8eWbSbXOL9Hu8G0LD6cxTfaa50Nfx2iYDrg@mail.gmail.com>
Message-ID: <CALKQrgc9EwjJL=u8eWbSbXOL9Hu8G0LD6cxTfaa50Nfx2iYDrg@mail.gmail.com>
Subject: Re: [PATCH v2 03/22] t3305: annotate with SHA1 prerequisite
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git mailing list <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On Sun, Jan 26, 2020 at 10:29 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Sun, 26 Jan 2020, Johan Herland wrote:
> > On Sun, Jan 26, 2020 at 12:16 PM Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > On Sat, 25 Jan 2020, brian m. carlson wrote:
> > > > This test relies on a roughly equal distribution of hashes for notes in
> > > > order to ensure that fanouts are compressed.  If there are subtrees with
> > > > only one item left after removing notes, they'll end up still with one
> > > > level of fanout, causing the test to fail.
> > >
> > > That is _almost_ correct: The heuristic wants to see one bucket that has
> > > a note in it. Or something like that.
> > >
> > > See 73f77b909f8 (Notes API: for_each_note(): Traverse the entire notes
> > > tree with a callback, 2010-02-13) for details. (Cc:ing Johan.)
> >
> > Something like that, yeah... Re-reading this code, I believe we stop
> > the fanout at the current level when we can find one or more notes
> > that do not share the high-nibble of their path with another note.
> >
> > Here we're at the top level, so this corresponds to looking at the
> > very first hex character (0-9a-f) of the path (oid of annotated
> > object), and if there are at least two such objects for each hex
> > character, we will use a fanout of 1, otherwise, we collapse the
> > fanout to 0.
>
> That makes sense, but when I looked at the failed test, there seems
> something else at play, at least in addition to what you said: for
> _adding_ notes, your description is 100% accurate, but when deleting
> notes, we are apparently not collapsing `PTR_TYPE_SUBTREE` nodes "quickly"
> enough. Let me show you the part of `git ls-tree -r refs/notes/commits`
> that starts with the hex digits 7, 8 and 9:
>
> -- snip --
> 100644 blob 22939636f79a53181ea58f04f2136bd745976edd0018465e60a8df89816a9c2b 72/67b1c94ab5ddf005fd4b0e50b6a7816a62e7ed0459cec6aa1a00577b2111ba
> 100644 blob 2e3f3dad7043b2d02d09ca12b299acbe05d781357d3a56a2d012fdf787409459 76/62d4b264094ca479be86ef7aa66daae63e45afa633a3892dc787b13ecff495
> 100644 blob 22e7f0c5af7315d692f8a107a43ba0784e1ab00a20ea803fab1acad1319e5f79 7b/8c0a9c86815a94da7ef90b356b1f98d6a4099af3fdc3d8625a8fa793b63821
> 100644 blob b3ce67c9d5507dc00d95d8fb2000c1d5b70908ad1d2c034e5833f57b7bb85511 7f/0af9cf9259cd6e67c0af3324ca443dd3d56694fbdc94d28e300a768d3d0e6e
> 100644 blob fafb40e32e87a2c481df6ceb37804d80c995faec3d7772c071b129fd47c2ba8a 8a/f1ad99a5e559f5835007f2bcb1b07de0e8c7434e7fbaa676a2edbd796a7f60
> 100644 blob b811e8da7c7acc83ef025753504ff6ed2d1eb8d2bb832d6b7487a7786d67aa53 93/f364fafaee6a178d8e8939f15d5b260f71940f663c3731396ee43082fd6551
> 100644 blob 0b1915ccb6f64cac64f2297893bce1ba7408660f79182302faaada71ee8c3c1c 96/b562b168f94e5c6e6a1e40ec4b817aa168c99769b1d9a46f7e048e93897fb4
> -- snap --
>
> This command was run in the worktree after running an unmodified t3305
> with `GIT_TEST_DEFAULT_HASH=sha256` in brian's `transition-stage-4` branch
> (well, I removed the `SHA1` prereq again, that's the modification I made).
>
> As you can see, there _is_ a fanout of 1, but there is only a single note
> for a commit whose ID starts with `8`.

Ah, yes, I glossed over the subtrees in my analysis, blindly assuming
that they would collapse more "quickly" than they do...

It seems the code values not unpacking subtrees "unnecessarily", and
this causes them to remain for longer than perhaps ideal.

> Debugging a little, it seems that the `PTR_TYPE_SUBTREE` node for `8` was
> not collapsed, even if there was only one item left.
>
> So I formed a hypothesis that the subtrees are only removed when the
> _last_ item is removed for any given leading nybble, but that turned out
> to also be incorrect. It is a bit more tricky than that. This is the
> smallest set to which I was able to reduce the notes without reducing the
> fanout to 0:
>
> -- snip --
> 100644 blob cc2ee5e00d8bc3805d704b67439dc8175bcf9497603288e6de2d4d8b3fc7be9f    05/b6e3d1394d020129f71fd8e41cf7ea8cbc58ae0f1332abd5da0c74ea194b71
> 100644 blob 1c6afe76a1bcd0103c36ab9707a2ca9e68974b6a6bbaae564c0509c43b4392bd    1e/311d64dc3ad5491964bcded60fee15b19d5b9c916a7e62a4f0746fa4e81fa6
> 100644 blob cf97d105e3970ef1cf9b12ac092be80abcd496c593bc8ca5550d059c3967630a    28/79e092d524b7ae9a42026ab2886094cce8ffc63175f8b3fd5de84faef10df3
> 100644 blob 78ef788b804dd0e5415c386b4a29668f61033483c35438f0471dfd7c4bfa093b    36/fe8fe67a2e9d0203c665d6e08ca454833ec32a97369769a7138d3938c0000b
> 100644 blob f46845c2d7e3272319aa5c18e359fdbc37731c88a945bb9632b8c4321983c75a    4a/a271a09d848f99d3fb978e5c156baa812a0fa1c30a88c885831641630be01a
> 100644 blob ecf5a4a178ca4b51cea457abe7c935761ca15a1d817f83c2da6816ede84db779    51/eaee3ca1a8698cb0aaa4de2d3f339985570da68b28e84af752e1cfd25f5197
> 100644 blob 2f4e9d6a4a1d050f8cb932ba545e53b48d9b669f6e00dc4a962d88ee9d92482b    62/dd63d43070c3ca7e3a6cdfa4ed970256a00a06e88d10fcb0532acd51419e0f
> 100644 blob 22939636f79a53181ea58f04f2136bd745976edd0018465e60a8df89816a9c2b    72/67b1c94ab5ddf005fd4b0e50b6a7816a62e7ed0459cec6aa1a00577b2111ba
> 100644 blob fafb40e32e87a2c481df6ceb37804d80c995faec3d7772c071b129fd47c2ba8a    8a/f1ad99a5e559f5835007f2bcb1b07de0e8c7434e7fbaa676a2edbd796a7f60
> 100644 blob b811e8da7c7acc83ef025753504ff6ed2d1eb8d2bb832d6b7487a7786d67aa53    93/f364fafaee6a178d8e8939f15d5b260f71940f663c3731396ee43082fd6551
> 100644 blob 589656c26944c471b5ac65739f8c7b96663a9f827a3d27beb49e39e3707b7294    a2/0e8f30856061125d479779755ef3238a7b561f9336e0143c437daac7d93f4c
> 100644 blob 7eaa9350d5c6bd6fd0fc4071c5d6a266949046c67987a9e1f665ba34d95f419d    a2/80d13a05aa68cc5ef948a8b69067807457fd37c00ce4a234fa4a0c0753ef4e
> 100644 blob 7a8378dd60d6024db645757eac7271a80b101a2df230ebd1a57ff52ff2d32e36    b9/2a3a7dc6db290d93f79150bfb31447f3e550cfe4a63c5ddbeac18fec755e86
> 100644 blob 86fff6007d9911249bee803a6630e182677355a5574e637d1a8301e219c5da86    c1/52ffd73d1c5e7c121c7c247682f1ee971f6f09101c96a84486d18be41d0dd0
> 100644 blob cd887698e1da81a76ae1caf0eaec19d60830a13ead152ec4700be511ceb8ee33    d0/3f742b8b95f68478946d7fe7495da9462801fadeaaa06c11bf54dbc46610f5
> 100644 blob 19f7bdfee9687311dbe1195e0a64954b677ae68e6d734fd5fb76ea4ad4f93782    ea/356ae2d38123b46639db98df14953f4c7cdd91738779174ec67876ce9487e3
> 100644 blob 948c0cba23ec0405c622c9dea8ed8dd7b3fa043c86b5e5a8b4de0d1c6a0e67b9    f7/802d4c716fed3c76fe58c86ac7c3ae3e19b8c0d3ea97c9f90f5939fe5a78d8
> 100644 blob 28690ad489e29e3607c82e1f626ec24d7f831555c802108bfe9b993fbd794a7e    f7/da03e811b7d9071ee19dabdc721e0f863e28c92dfa3257474282396a73bb44
> -- snap --
>
> You will note that there are two entries that start with `a2`, and two
> entries that start with `f7`. If I remove any of those, the corresponding
> subtree will be collapsed, and the fanout will be reduced to 0.

I'm looking at note_tree_remove() and note_tree_consolidate() to
explain this behavior. AFAICS, at the point where you remove, say, the
a20e8f entry, the note tree structure should consist of a single
int_node containing 16 subtree entries. note_tree_remove() will search
for the a20e8f entry which will cause the a2 subtree to be unpacked
and replaced with an int_node (representing 'a') referencing another
int_node (representing '2') containing two leaf_nodes. One of the leaf
nodes will be removed, and note_tree_consolidate() will then replace
the 2 int_nodes with the last remaining leaf_node. At this point the
root int_node should now contain 15 subtrees (not yet unpacked) and 1
"regular" leaf_node.

We then move on to write_notes_tree() to write out the resulting tree.
This ends up calling determine_fanout() (via for_each_note_helper()),
which will look at the root int_node, find the one "regular" leaf_node
there, and use that to return fanout = 0. (At which point the other
subtrees will be unpacked and the entire tree is "flattened".)

I now wonder why this did not happen before we got down to 17 notes.
Let's assume (as is most probable) that the previous notes removed
only shared _one_ leading nibble (not two). The root int_node would
have an int_node for the first-nibble which would contain two
subtrees, one for each second-nibble. One of these would be unpacked
and promptly removed, and then note_tree_consolidate() would be left
with the int_node for the first-nibble containing a single subtree
entry. AFAICS note_tree_consolidate() does _not_ collapse this
int_node (and move the subtree into the root node), although I can't
immediately see why it could/should not do this. Even if it did,
though, that would not be enough to trigger a lower fanout, as
determine_fanout() does not distinguish between int_nodes and subtree
nodes.

However, I suspect there may be room for further improvement here: If
we find ourselves consolidating an int_node whose _only_ non-NULL
entry is a subtree, it is a fairly safe assumption that the subtree
itself is probably close to empty as well, and we can probably bear
the cost of more eagerly unpacking it, as we are then more likely to
trigger a lower fanout when writing out the notes tree. At that point
going from fanout 1 to fanout 0 should certainly happen at a less
ridiculous total note count than 17...

> But it is only happenstance with SHA-256 that there are these entries that
> agree not only in the first, but also in the second leading nybble.

True.

> Therefore...
>
> > Hence we need an absolute minimum of 32 notes (and some rotten luck)
> > to get a fanout of 1. As the number of notes increase, the probably of
> > fanning out increases, passing 50% at ~79 notes, and reaching ~100%
> > somewhere north of 150 notes.
>
> ... I would register that we need an absolute minimum of 16 notes (and
> some rather crafty craft) to get a fanout of 1.
>
> In that light, I think that I would prefer to retract my patch that
> "only" reduces the remaining number of notes to 20: it should reduce them
> to 15 or less. So why not reduce it to 10 (because it is only one changed
> digit).

Agreed. The thing we're looking for in the test (and what is certainly
more important) is that we _do_ consolidate the fanout when the note
count decreases. The details around exactly when that happens is more
of a performance tuning issue, and not something that should break the
test.

> > > > The test happens to pass with SHA-1, but doesn't necessarily with other
> > > > hash algorithms, so annotate it with the SHA1 prerequisite.
> > >
> > > I would rather see this tested, still, and reducing the number of notes
> > > that are retained from 50 to 20 before testing that the fanout has been
> > > reduced to 0 seems to do the trick. Therefore, I would love to submit this
> > > for squashing:
> >
> > Yes, it seems that for SHA1 and the (deterministic) objects used in
> > the test, we got away with 50 notes, but that is not the case for
> > other hash algorithms. Lowering the number to 20 definitely results a
> > fanout of 0, as should any other number below 32.
> >
> > +1 to Dscho's squash.
> >
> > ...Johan
>
> Thank you so much for the analysis. To be honest, I did not quite
> understand all the details of the comment added in 73f77b989f8 when I
> wrote the patch I suggested, so I basically just picked that number "20"
> out of thin air.
>
> Together with your insights, I would like to propose this commit message
> for the squashed commits (I left in the hunk that removes the `SHA1`
> prerequisite, but of course that won't be part of the final commit):
>
> -- snip --
> t3305: make fanout test more robust (needed for SHA-256)
>
> To make things more performant, notes are stored in a "fanout": when
> there are enough commit notes, they are no longer stored as verbatim
> commit IDs at the top-level tree of the notes ref, but instead the tree
> is deepened much like the loose object cache: subtrees are introduced
> whose names are the two hex digits they "chomp off" the commit IDs.
>
> The test case 'deleting most notes triggers fanout consolidation' wants
> to verify that the fanout level is reduced automatically when enough
> notes have been deleted.
>
> However, that test case expected that reduction to level 0 (i.e. _no_
> fanout subtrees) to happen after reducing the originally-added 300 notes
> to 50, which _happened_ to work with SHA-1-based commit IDs, but it is
> no longer works with SHA-256-based ones.
>
> The reason: The heuristic for the fanout looks at the number of entries
> for leading nybbles (read: hex digits) of the commit IDs. If there are
> more than a single annotated commit for all of the 16 hex digits, the
> fanout is incremented. It is a bit more tricky when reducing the number
> of notes: the fanout is reduced reliably only if there are less notes
> than hex digits (i.e. less than 15 notes) for a given prefix.
>
> For good measure, let's reduce the number of notes to 10 in the test
> case 'deleting most notes with git-notes' so that the test case
> 'deleting most notes triggers fanout consolidation' is guaranteed to
> succeed with _any_ hash algorithm.

Great commit message.

> Original-patch-by: brian m. carlson <sandals@crustytoothpaste.net>
> Helped-by: Johan Herland <johan@herland.net>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Signed-off-by: Johan Herland <johan@herland.net>


Have fun!
...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
