Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BCC51FA7B
	for <e@80x24.org>; Thu, 22 Jun 2017 15:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752447AbdFVPQL (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 11:16:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:48734 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752081AbdFVPQK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 11:16:10 -0400
Received: (qmail 3500 invoked by uid 109); 22 Jun 2017 15:16:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 22 Jun 2017 15:16:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1504 invoked by uid 111); 22 Jun 2017 15:16:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Jun 2017 11:16:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Jun 2017 11:16:03 -0400
Date:   Thu, 22 Jun 2017 11:16:03 -0400
From:   Jeff King <peff@peff.net>
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Sahil Dua <sahildua2305@gmail.com>
Subject: Re: Truncating HEAD reflog on branch move
Message-ID: <20170622151603.rrh2j7zsotyt2jxe@sigill.intra.peff.net>
References: <20170621213924.wh43i2h7v2zwihq3@genre.crustytoothpaste.net>
 <xmqqpodxm2t8.fsf@gitster.mtv.corp.google.com>
 <87efud7xjd.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87efud7xjd.fsf@kyleam.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 21, 2017 at 07:04:22PM -0400, Kyle Meyer wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> >
> >> I get the following on 2.11.0:
> >>
> >> 2cbfbd5 HEAD@{0}:
> >> 2cbfbd5 HEAD@{1}: checkout: moving from cPanel to master
> >> eaf8db2 HEAD@{2}: checkout: moving from master to cPanel
> >> 2cbfbd5 HEAD@{3}: clone: from https://bmc@git.crustytoothpaste.net/git/bmc/homedir.git
> >>
> >> and this on a recent next:
> >>
> >> 2cbfbd5 HEAD@{0}: Branch: renamed refs/heads/master to refs/heads/new
> >>
> >> For this test, any repo will work; I just picked this one because it had
> >> two branches I could use to generate dummy reflog entries.
> >>
> >> A colleague reported this to me as a bug.  I don't see anything in the
> >> release notes about this as a desired behavior change, and it does seem
> >> undesirable to truncate the reflog this way.  If this isn't intentional,
> >> I'm happy to work up a patch.
> >
> > I do not think either behaviour is intentional (old one that gives a
> > meaningless empty entry probably is probably not what we want, the
> > new one that truncates is not what we want, either).
> 
> Eh, sorry about that.  I haven't dug very deeply, but it seems like the
> entry is still in .git/logs/HEAD, while "git reflog" is only showing
> they latest entry.  (Maybe because we stop consuming the entries when we
> hit a null sha1 in the old id field?)

Yeah, I think that's it.

I had trouble digging to find the place where this happens, but I
_think_ it's unintentional, and is an artifact of the way the reflog
iteration is bolted onto the regular revision machinery. In
get_revision_1(), we fake the commit parents as if the earlier reflog
entries formed an actual commit history.

There's some magic in fake_reflog_parent() when we hit an entry with a
null sha1 in the old-oid field. But it depends on looking at the new-oid
field of the entry before. And because our entries look like this:

  real_sha1 null_sha1 ...
  null_sha1 real_sha1 ...

Looking at the prior entry's new-oid field doesn't help at all. And we
end up claiming that there are no parents, and this is the end of the
traversal. The patch below makes it work for me by falling back further
to the previous entry's old oid. This feels like a terrible hack to make
this case work. I'd think we'd actually want some kind of loop to keep
looking. After all, what should:

  real_sha1 real_sha1 ...
  null_sha1 null_sha1 ...
  null_sha1 real_sha1 ...

show? Surely we should not stop traversing when we hit the double
null_sha1. We should either display it in some form, or skip it and
issue a warning that there's a funky entry in your reflog.

This whole fake-parents things does just feel like a gigantic hack,
though. It seems like we should be able to just walk backwards down the
reflog list and show the entries. The revision machinery already
special-cases a bunch of reflog-walk bits; I don't know that adding one
or two more would be the end of the world.

Another approach entirely would be to stop generating two entries in the
reflog, and generate a single one:

  real_sha1 real_sha1 ... Rename from "foo" to "bar"

I think we talked about that earlier, but I think the resolution was
just that doing so was hard with the existing ref-update calls.

diff --git a/reflog-walk.c b/reflog-walk.c
index ed99437ad..b7e489ad3 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -259,6 +259,8 @@ void fake_reflog_parent(struct reflog_walk_info *info, struct commit *commit)
 		/* a root commit, but there are still more entries to show */
 		reflog = &commit_reflog->reflogs->items[commit_reflog->recno];
 		logobj = parse_object(&reflog->noid);
+		if (!logobj)
+			logobj = parse_object(&reflog->ooid);
 	}
 
 	if (!logobj || logobj->type != OBJ_COMMIT) {

