Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22EAE2018A
	for <e@80x24.org>; Fri,  1 Jul 2016 17:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752038AbcGARzJ (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 13:55:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:39203 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751953AbcGARzI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 13:55:08 -0400
Received: (qmail 22000 invoked by uid 102); 1 Jul 2016 17:55:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jul 2016 13:55:08 -0400
Received: (qmail 20161 invoked by uid 107); 1 Jul 2016 17:55:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jul 2016 13:55:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Jul 2016 13:55:04 -0400
Date:	Fri, 1 Jul 2016 13:55:04 -0400
From:	Jeff King <peff@peff.net>
To:	Stefan Beller <sbeller@google.com>
Cc:	Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Dan Wang <dwwang@google.com>
Subject: Re: [RFC PATCHv1 0/4] Push options in C Git
Message-ID: <20160701175503.GA16235@sigill.intra.peff.net>
References: <20160630005951.7408-1-sbeller@google.com>
 <20160701070902.GF5358@sigill.intra.peff.net>
 <CAGZ79kY7j3r5b0rz=Lb6Ec2s2f8=UBb-hTtZw0H09KM_9H+7=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kY7j3r5b0rz=Lb6Ec2s2f8=UBb-hTtZw0H09KM_9H+7=Q@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 01, 2016 at 10:07:10AM -0700, Stefan Beller wrote:

> > So you'd probably want some client tool to help the user figure out what
> > to put in the PR, and of course that already exists, because GitHub has
> > an HTTP API that it can talk to. Shoe-horning it into Git doesn't buy
> > much.
> 
> Let's say the example was bad. the reality is that Dennis and I implemented
> a needed feature independently of each other and you have the
> out-of-the-box-Github-does-HTTP-too solution. So I think we'd want
> *something* in Git to have information in the receiving hooks available?

Sure, _if_ it's information that the receiving hooks want to have.

I guess what I'm questioning is exactly what receiving hooks do need to
have. Things like "the user said --force" seem obviously related to the
push. Things like auto-creating a PR seem less about the push itself,
and more about something you can do with the result of the push.

So a litmus test for me would be something like:

  Can you get the same effect with:

    git push $remote my-branch &&
    curl https://$remote/api/do-the-thing?q=my-branch

  as you would with:

    git push --push-data=do-the-thing $remote mybranch

If so, then it seems like inserting the data through the git connection
is not really adding functionality, but it _is_ adding complexity to
git (that other tools are already handling with much more flexibility).

We have a similar rule of thumb for hooks; we don't add a hook if
there's no reason you couldn't just run the hook content immediately
before or after the command.

> It seems to me there are many other Git-wrappers, such as the repo tool
> or git-review[2], and most of them start with the premise: "Git doesn't support
> X yet, so while they take their time to figure out how to do it
> properly upstream,
> we'll just use this hacky script" and then eventually you end up with an xml
> parsing beast with thousands lines of python code (The story of the repo
> tool and submodules).

But it's exactly this complexity that makes me worried about moving
things into git. This patch addresses only the transport problem. If
your problem is that something like a review system built on git
involves lot of complicated data, now you have two problems: you still
have the complicated data, and now you have to shoe-horn it into Git's
ad-hoc protocol.

I'm also not convinced that it alleviates the need for the tool to have
a separate API. Imagine you can send this data while pushing now. How do
you edit it later? How do you retrieve it programmatically? Etc.

> > I think Gerrit is funny in this regard because it
> > eschews branches entirely. E.g., in a GitHub PR, you push to branch
> > "foo", and then you open a PR using "foo" as the source.
> 
> Once upon a time you could also open a pull request using the sha1?
> (I did that once and then was asked to do some fixes before pulling and
> I had to abandon and reopen a proper branch PR)
> 
> > But with
> > Gerrit, you push to the magic refs/for/master, and you have no real way
> > to cross-reference that submission later.
> 
> What do you mean by cross reference?

I just meant that in my GitHub example, the branch name you chose
("foo") becomes the key with which you can correlate the two actions:
pushing the data via Git, and later opening a PR (via the web page, or
the API, or whatever).

With Gerrit, how do you refer to the commits you just pushed, when
making a separate action?  My impression is that Gerrit assigns
change-ids centrally when you push to refs/for/master; how do you figure
out after the push what the change-id is of the thing you just pushed?
I can guess maybe it sends something to stderr that the user then reads,
but that is purely a guess. I've never really used Gerrit.

You're right that one could use sha1s for this purpose.

> Gerrits flaws are off topic to this series though (maybe?)

I'm far from qualified to critique Gerrit. I was mostly just observing
that your view of the problem space (and thus the solution) is colored
by Gerrit's way of doing things. That doesn't make it a wrong solution,
but it's worth seeing whether other systems would get the same benefit
(just because part of the "is it worth it" equation is how widely used
the feature could be).

> > Whereas in Dennis's patches, it was about specific information directly
> > related to the act of pushing.
> 
> But does it cover all the informations related to pushing? like
> 
>   "I am a bot, down-prioritize me, please"
>   "I am a bot, therefore I do not care about the internal replication
> on the server"
> 
> The last one is interesting as it is very specific to our servers. So you could
> argue we'd want to roll our own fork of Git that also covers such a hook option,
> but I think it is easier for both the Git community as well as us here to allow
> Git transmit free form text and the server can decide how to act upon it?

No, I don't think it covers all information. I like the idea of being
able to pass free-form key/value pairs to hooks, because by definition
we don't know what the hooks are doing, or what the user might want to
communicate to them.

> I might have missed the point of this email completely as I seem to
> try to defend the
> patch series (and Gerrit a bit). So do you think the functionality of
> this series is overkill
> and we'd rather go with Dennis series?

Oh, I'm supposed to have a point to my emails? :)

I was mostly just musing. I do see the general idea as a useful thing;
there really is data that is related to the push itself, and not other
actions you may want to perform on the push.

I'm not necessarily sure that we need a complicated data model (like
multiple values of the same key), or the ability to handle arbitrarily
large binary data. Those don't necessarily complicate the wire protocol
(I like the idea of adding a new phase of key/values, followed by a
flush), but they do complicate the server implementation (how do we
communicate them to the hooks? Should there be limits for safety and DoS
protection on the server?)

> Gits spirit (Oh no, not this discussion!) is to allow a broad range of
> uses and work flows.  It doesn't hinder you from shooting into your
> feet if that's what you're into, and that is what this series does
> precisely.

I think Git's spirit is also to fit as a tool into the greater
ecosystem, and not duplicate functionality that is done elsewhere. So
for example there is no authentication in the git:// protocol; that job
is done by ssh.

-Peff
