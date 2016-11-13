Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B925D1F40E
	for <e@80x24.org>; Sun, 13 Nov 2016 17:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753616AbcKMR6U (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Nov 2016 12:58:20 -0500
Received: from upsilon.cc ([178.32.142.91]:34516 "EHLO upsilon.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753413AbcKMR6T (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Nov 2016 12:58:19 -0500
X-Greylist: delayed 436 seconds by postgrey-1.27 at vger.kernel.org; Sun, 13 Nov 2016 12:58:19 EST
Received: from timira.takhisis.invalid (bau75-1-78-194-69-54.fbxo.proxad.net [78.194.69.54])
        by upsilon.cc (Postfix) with ESMTPSA id E9F4510216;
        Sun, 13 Nov 2016 18:50:58 +0100 (CET)
Received: by timira.takhisis.invalid (Postfix, from userid 1000)
        id C3A986050F; Sun, 13 Nov 2016 18:50:58 +0100 (CET)
Date:   Sun, 13 Nov 2016 18:50:58 +0100
From:   Stefano Zacchiroli <zack@softwareheritage.org>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Junio C Hamano <gitster@pobox.com>,
        git <git@vger.kernel.org>,
        "Shawn O. Pierce" <spearce@spearce.org>, Jeff King <peff@peff.net>
Subject: Re: Regarding "git log" on "git series" metadata
Message-ID: <20161113175058.t7s4o7h5chqzazb6@upsilon.cc>
References: <xmqqa8dfdt6y.fsf@gitster.mtv.corp.google.com>
 <CAP8UFD2+A0MUKazAfSwCvv61TJRPuoOzH5EkqcrBOUi4TcuoDw@mail.gmail.com>
 <20161104211959.3532uiud27nhumt7@x>
 <CAP8UFD13sDOFuyZMWuoJeLFt_LAsfAHFBHpRwcdAGmA22xNEKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD13sDOFuyZMWuoJeLFt_LAsfAHFBHpRwcdAGmA22xNEKQ@mail.gmail.com>
User-Agent: NeoMutt/20161014 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

On Sat, Nov 05, 2016 at 12:04:08AM +0100, Christian Couder wrote:
> On Fri, Nov 4, 2016 at 10:19 PM, Josh Triplett <josh@joshtriplett.org> wrote:
> > On Fri, Nov 04, 2016 at 09:47:41PM +0100, Christian Couder wrote:
> >>
> >> Couldn't a RefTree be used to store refs that point to the base
> >> commit, the tip commit and the blob that contains the cover letter,
> >> and maybe also a ref pointing to the RefTree of the previous version
> >> of the series?
> >
> > That's really interesting!  The Software Heritage project is working on
> > something similar, because they want to store all the refs as part of
> > their data model as well.  I'll point them to the reftree work.
> 
> Yeah, I know them :-) and I think I have already told Stefano
> Zacchiroli about this, but I am not sure anymore.
> Anyway I am CC'ing him.

Thanks Christian (and Josh, on swh-devel) for pointing me to this.

As a bit of background, the conceptual data model we have adopted for
Software Heritage [1] is indeed that of a global Merkle DAG, very much
inspired by Git, but where we deduplicate past the boundaries of
individual VCS repositories. This way we can store only once the same
software artifacts (blobs, trees, commits, etc.) even when they can be
found at different software origins [2] (be it due to GitHub-like forks,
projects moving around, or simply rogue copies of the same code
scattered around the Internet).

[1]: https://www.softwareheritage.org/

[2]: "software origin" is Software Heritage terminology, which just
     stands for places on the Internet where we can find source code

In our original design the topmost entries in our Merkle hierarchy used
to be commits and tags, similar to what Git does. But then we realized
that doing so inhibited us from sharing entire repository states across
multiple software origins or multiple visits of the same software
origin.  So we decided to add "repository snapshot objects" as our
topmost entries, which are essentially git-like objects that map refs to
the ID of the corresponding (typed-)objects. Rationale and a more
lengthy description of this is available on our wiki [3]. It is not
implemented yet, but we're pretty sold on the design at this point.

[3]: https://wiki.softwareheritage.org/index.php?title=Repository_snapshot_objects

Now, even if my only awareness of what's going on in Git upstream is
limited to sporadic chats with Josh and Christian :-), it seems to me
that various ideas in the Git ecosystem go in the same direction of our
snapshot objects (git-series, RefTree). Which is understandable, given a
number of use cases might be served by this.

I don't think we have much to contribute to discussion or implementation
here, and for our needs it doesn't really matter which one gets
implemented. That's because we need an implementation of the concept
which is *external* to Git anyhow. But even if it happens to exist
within actual VCS, it's not a big deal for us, as we do have ways to
distinguish "synthetic" objects in the DAG that we create for our own
needs from "real" objects coming from actual software origins.
(Another example of this concept we already have is when we inject
distribution source packages or tarballs in our archive. In that case we
create synthetic commits that points to the tree extracted from the
tarball/package, preserving the ability to distinguish them from real
commits coming from VCS out there.)

If you think we can help in any other way, other than sharing our
experiences and design considerations that is, please let me know! (I'm
not subscribed to the Git upstream mailing list, but feel free to Cc:-me
in conversations related to this topic.)

Cheers.
-- 
Stefano Zacchiroli . zack@upsilon.cc . upsilon.cc/zack . . o . . . o . o
Computer Science Professor . CTO Software Heritage . . . . . o . . . o o
Former Debian Project Leader . OSI Board Director  . . . o o o . . . o .
« the first rule of tautology club is the first rule of tautology club »
