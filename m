Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2A621FBEC
	for <e@80x24.org>; Wed,  8 Mar 2017 05:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756715AbdCHFmA (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 00:42:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:40252 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750742AbdCHFl7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 00:41:59 -0500
Received: (qmail 21370 invoked by uid 109); 8 Mar 2017 05:41:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Mar 2017 05:41:58 +0000
Received: (qmail 1220 invoked by uid 111); 8 Mar 2017 05:42:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Mar 2017 00:42:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Mar 2017 00:41:55 -0500
Date:   Wed, 8 Mar 2017 00:41:55 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     tom@oxix.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [Request for Documentation] Differentiate signed
 (commits/tags/pushes)
Message-ID: <20170308054155.yad4hetg5twxf4u3@sigill.intra.peff.net>
References: <CAGZ79kYxD9B_+3vBgO+Z-wh2GMg_REazA-xpTSAqe3_64VMV3w@mail.gmail.com>
 <20170307092353.ibirvitsxhzn3apz@sigill.intra.peff.net>
 <CAGZ79kb=ZwaMeGAu_R1Bjt4KyxKHYnP4U-RgA1of7F05E5CCQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kb=ZwaMeGAu_R1Bjt4KyxKHYnP4U-RgA1of7F05E5CCQg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 07, 2017 at 02:19:19PM -0800, Stefan Beller wrote:

> On Tue, Mar 7, 2017 at 1:23 AM, Jeff King <peff@peff.net> wrote:
> > On Mon, Mar 06, 2017 at 11:59:24AM -0800, Stefan Beller wrote:
> >
> >> What is the difference between signed commits and tags?
> >> (Not from a technical perspective, but for the end user)
> >
> > I think git has never really tried to assign any _meaning_ to the
> > signatures. It implements the technical bits and leaves it up to the
> > user and their workflows to decide what a given signature means.
> 
> That is a nihilistic approach? ;)

To some degree. :) I think it is less that we believe in nothing, but
that Git has traditionally been a toolkit on which you could build a
variety of workflows. We wouldn't want to constrain the low-level tools
by building too much policy logic into them. And IMHO, nobody has really
written the high-level tools for signing.

I would be happy if somebody wanted to do so. Either separate tools, or
a suite of options and config that could be used to make the existing
tools help enforce certain policies. E.g., if "git log --show-signature"
were to complain that the signer id does not match the committer ident,
when a certain config option is set.

Having a git-trust-model(7) manpage is probably a good idea, but I think
it's nicer still if users can adopt the trust model with the flip of a
switch.

> Off list I was told
> "just look at Documentation/technical/signature-format.txt;
> it explains all different things that you can sign or have signed
> stuff". But as an end user I refuse to look at that. ;)

I agree that end users should not have to look at it. But I also think
it doesn't actually discuss the policy options (i.e., what the
signatures could "mean"). AFAIK there is not a good discussion of that
anywhere.

> > Signing individual commits _could_ convey meaning (2), but "all history
> > leading up" part is unlikely to be something that the signer needs to
> > enforce on every commit.
> 
> I was told signed commits could act as a poor mans
> push certificate (again off list :/).

Yeah, they could. But you should probably just use push certificates.
Which _also_ are missing the high-level workflow bits; I'd be happy to
get GitHub to start recording push signatures somewhere if people know
what they would want to do with them.

The idea was discussed of sticking them in git-notes. But I wonder if it
would be useful to hand them out during upload-pack, so that somebody
fetching has a cryptographic chain back to the original pusher (rather
than trusting the intermediate server).

I think that is slightly complicated because each push certificate only
mentions the refs that were pushed. So verifying the ref state for N
refs might involve up to N separate push certificates (i.e., the last
one that touched each ref, not just the last one overall).

> > In my opinion, the most useful meaning for commit-signing is simply to
> > cryptographically certify the identity of the committer. We don't
> > compare the GPG key ident to the "committer" field, but IMHO that would
> > be a reasonable optional feature for verify-commit (I say optional
> > because we're starting to assign semantics now).
> 
> So the signed commit focuses on the committer instead of the content
> (which is what tags are rather used for) ?

I think it's more subtle than that, and gets into the "is a commit a
snapshot or a diff" question. We all know that technically the commit
object points to a snapshot of the tree. But it also points to a parent,
and I think what is interesting here is the change between the parent's
tree and the commit's tree.

So I would take a commit signature to mean that you are the author of
the changes moving from $commit^ to $commit, without making any specific
attestation of the content in $commit^. IOW, you are really signing the
changes and your commit message.

> > I think one of the reasons kernel (and git) developers aren't that
> > interested in signed commits is that they're not really that interesting
> > in a patch workflow. You're verifying the committer, who in this project
> > is invariably Junio, and we just take his word that whatever is in the
> > "author" field is reasonable.
> 
> Well in such a workflow Junio could also sign the tip-commits of
> pu/next before pushing, such that we can trust it was really him doing
> the maintenance work and not his evil twin.

Yes, he could. He could also force-push a tag for the current value
(although git does not handle tag-overwriting very well). That's sort of
what push-certificates were meant to do a better job of.

> > So I don't think it's just a checkbox feature. It's a useful thing for
> > certain workflows that really want to be able to attribute individual
> > commits with cryptographic strength.
> 
> "certain workflows". :(
> 
> See, I really like reading e.g. the "On Re-tagging" section of git-tag
> as it doesn't hand wave around the decisions to make.

OK, less hand-waving. Imagine you are a company with a finite set of
developers, and you issue each developer a gpg key. They all turn on
commit.gpgsign. They all clone from a central GitHub repository, push
back to topic branches in that repository, and then merge via the
website.

What do the commit signatures buy you? If you treat them as "I certify
that I made the changes in this commit", then it gives you a
cryptographic audit trail. When you later find a backdoor in the
software, you are not left guessing as to who pushed it (since they
could easily forge the committer ident in the object header), or even
whether it entered the repository via a push or if somebody broke in to
the server and modified the repository. You find which commit introduced
it and check the signature.

Of course a clever attacker would just not sign the backdoor commit. So
you'd probably want some policy to notice unsigned commits early
(e.g., perhaps reject them on push and fetch).

> Now as a user I may already have a workflow that I like. And I might
> want to "bring in more security". Then I have to figure out possible
> attack scenarios and which sort of signing can prevent such an attack.
> 
> And each organisation has to do that themselves, but we as the provider
> of the tool might have this knowledge because we implemented all
> these shiny "sign here, please" parts.

Sure. I absolutely think we need better documentation and tools here.

-Peff
