Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 306342018A
	for <e@80x24.org>; Fri,  1 Jul 2016 20:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752166AbcGAUCm (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 16:02:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:39351 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751900AbcGAUCl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 16:02:41 -0400
Received: (qmail 27495 invoked by uid 102); 1 Jul 2016 20:01:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jul 2016 16:01:27 -0400
Received: (qmail 22184 invoked by uid 107); 1 Jul 2016 20:01:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jul 2016 16:01:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Jul 2016 16:01:23 -0400
Date:	Fri, 1 Jul 2016 16:01:23 -0400
From:	Jeff King <peff@peff.net>
To:	Stefan Beller <sbeller@google.com>
Cc:	Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Dan Wang <dwwang@google.com>
Subject: Re: [RFC PATCHv1 0/4] Push options in C Git
Message-ID: <20160701200123.GB23141@sigill.intra.peff.net>
References: <20160630005951.7408-1-sbeller@google.com>
 <20160701070902.GF5358@sigill.intra.peff.net>
 <CAGZ79kY7j3r5b0rz=Lb6Ec2s2f8=UBb-hTtZw0H09KM_9H+7=Q@mail.gmail.com>
 <20160701175503.GA16235@sigill.intra.peff.net>
 <CAGZ79kZx6=LGjQjzEEjMjZrNbXcVto-+djJbxj9xUCtLMsaL5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZx6=LGjQjzEEjMjZrNbXcVto-+djJbxj9xUCtLMsaL5w@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 01, 2016 at 11:25:40AM -0700, Stefan Beller wrote:

> > So a litmus test for me would be something like:
> >
> >   Can you get the same effect with:
> >
> >     git push $remote my-branch &&
> >     curl https://$remote/api/do-the-thing?q=my-branch
> >
> >   as you would with:
> >
> >     git push --push-data=do-the-thing $remote mybranch
> 
> People are happy when they can use one tool instead of two,
> e.g. "Deploy with Git" is a thing[1] and maybe they want to add a
> switch "once pushed skip the tests, I know they are broken".
> 
> [1] https://devcenter.heroku.com/articles/git

Yes, but people are also happy when they can use a flexible and
standardized tool to do a thing. I'd be more frustrated when I found out
that Git's data-pushing protocol has arbitrary limitations (like, say, I
can't push a data item larger than a single 64K pkt-line), which would
easily just work with something like HTTP POSTs.

I'm not saying my point trumps yours; just that there are a lot of
tradeoffs in a design like this.

> > With Gerrit, how do you refer to the commits you just pushed, when
> > making a separate action?  My impression is that Gerrit assigns
> > change-ids centrally when you push to refs/for/master;
> 
> actually you install a commit hook to do it decentralized.

Ah, OK. So you could do roughly the same thing:

  git push ... &&
  id=$(
    git cat-file commit HEAD |
    perl -lne '/^Change-Id: (.*)/ and print $1'
  ) &&
  curl https://$remote/api/do-something?id=$id

(Yes, I know Gerrit doesn't necessarily have an API like that; I was
mostly just wondering how it compared to the GitHub PR example I had
laid out).

> I am used to read high quality emails from you and asked myself what I can
> learn by reading this email. "Trying to figure out your point", nothing more.

Heh. Sorry, they can't all be winners. ;)

> So you suggest that we only allow key=value pairs and not "key" only?
> I am not sure if that makes it easier, though (what part is easier?) compared
> to completely free form.

I had just assumed they would always have a key and a value. If you have
no key, then you are stuck parsing positionally to know what each value
means. If you have no value, you can treat each element like a boolean
true. But it's not that much worse to turn "foo" into "foo=true".

> > but they do complicate the server implementation (how do we
> > communicate them to the hooks? Should there be limits for safety and
> > DoS protection on the server?)
> 
> Oh good point! How do you handle DoS protection for pushing large
> blobs, or weird history (that may blow up the before-behind
> implementation as referenced in the "topological index field for
> commit objects" thread)

At GitHub we use a combination of push-time size heuristics and CPU
run-time limits.

So at push time, we reject objects larger than 100MB (uncompressed) in
index-pack, and we'll refuse to make a single allocation larger than a
gigabyte or so (to prevent index-pack blowing up while trying to figure
out how big the object is). We reject any single pack larger than 2GB.
Rejected objects never even make it to the repo, and we clean up the tmp
packs immediately. So you can't just stream data at us endlessly and
chew up disk or RAM (you can chew up plenty of CPU, though). 

That prevents the most egregious DoS problems, and protects us from crap
like "whoops, this tree entry has a 2GB name, and it wraps an integer
somewhere deep in git that probably should have been a size_t".

But git is complicated enough that you can still get plenty of malicious
crap through. So we aggressively limit completion times for most
operations, and we keep track of the runtime of every single git
operation and correlate it with the repo, user, and source IP, and apply
quotas when there's excessive use. That's not nice for a user who has a
legitimately big request, but it prevents them from impacting other
users (so it's a baseline, and then we try to optimize things that don't
fit into the timeouts, or that cause users to have quotas applied).

That was a bit of a tangent, but back to this topic: I'd probably want
some kind of hard limit on the number of data items and the size of each
(though if they are single pkt-lines, that puts a hard limit already).

> Shouldn't that be server specific as well?

Potentially, yes.

> Mind that I proposed a "receive.advertisePushOptions" config option.
> Maybe that can be fine tuned in a later patch "receive.PushOptionSizeLimit",
> "receive.maxPushOptions" or such?

Yep, I think that is a good approach (presumably with some sane safe-ish
defaults).

> Talking about authentication, any tool that we additionally have "to
> just trigger this one thing remotely" would need to learn about proper
> auth, too. so it will not be just a small helper script, but blows up
> into a large thing. I think we could avoid that duplicated effort,
> too.

I think the right tool there is credential helpers. And I don't think
it's a new problem. You already can log into Gerrit via the web browser,
but you have to have separate auth for running git. Hopefully there are
tools to make that less painful (either pulling the browser cookie, or
getting an opaque application token from the web app to feed into git).

-Peff
