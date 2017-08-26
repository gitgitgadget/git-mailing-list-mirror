Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D24120285
	for <e@80x24.org>; Sat, 26 Aug 2017 09:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752051AbdHZJMF (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Aug 2017 05:12:05 -0400
Received: from chiark.greenend.org.uk ([212.13.197.229]:56218 "EHLO
        chiark.greenend.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751931AbdHZJMF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Aug 2017 05:12:05 -0400
Received: by chiark.greenend.org.uk (Debian Exim 4.84_2 #1) with local
        (return-path ijackson@chiark.greenend.org.uk)
        id 1dlX8M-0006o4-ED; Sat, 26 Aug 2017 10:12:02 +0100
From:   Ian Jackson <ijackson@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <22945.15202.337224.529980@chiark.greenend.org.uk>
Date:   Sat, 26 Aug 2017 10:12:02 +0100
To:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Dave Borowitz <dborowitz@google.com>
Subject: Re: git signed push server-side [and 3 more messages]
In-Reply-To: <20170826003229.GL13924@aiede.mtv.corp.google.com>,
        <xmqqshgfqh0g.fsf@gitster.mtv.corp.google.com>,
        <xmqqzianqow2.fsf@gitster.mtv.corp.google.com>,
        <xmqqo9r3qgak.fsf@gitster.mtv.corp.google.com>
References: <22944.38288.91698.811743@chiark.greenend.org.uk>
        <20170826003229.GL13924@aiede.mtv.corp.google.com>
        <xmqqo9r3qgak.fsf@gitster.mtv.corp.google.com>
        <xmqqzianqow2.fsf@gitster.mtv.corp.google.com>
        <xmqqshgfqh0g.fsf@gitster.mtv.corp.google.com>
X-Mailer: VM 8.2.0b under 24.4.1 (i586-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi.  Thanks to both of you for your helpful comments.

Jonathan Nieder writes ("Re: git signed push server-side"):
> Ian Jackson wrote[1]:
> > 2. git-receive-pack calls gpg (Debian #852684)
> >
> > It would be better if it called gpgv.
...
> think respecting gpg.program would be nicer.  Is there a reason not
> to do that?

I think it very unlikely that anyone would want git-receive-pack's
signed push facility to end up running gpg rather than gpgv.  But, the
git-receive-pack functions here are building blocks which need quite a
lot of extra work to use, anyway.  So having all callers have to pass
-c gpg.program would be quite tolerable, if a bit ugly.

> I suspect receive-pack just forgot to call git_gpg_config.

So, I will send a patch to fix that.

> > 3. No way to specify keyring (Debian #852684, side note)
> >
> > There should be a way to specify the keyring used by
> > git-receive-pack's gpgv invocation.  This should probably be done with
> > a config option, receive.certKeyring perhaps.
> 
> How is the keyring configured for other commands that use GPG, like
> "git tag -v"?  (Forgive my laziness in not looking it up.)

It's not.  You just get whatever keyring and trust db etc. your gpg
has as the default.  As Junio says, being able to set the keyring
explicitly is not essential to use the signed push feature; one can
make a wrapper for gpgv, or set GNUPGHOME.

It just seemed to me that the current interface is not very
convenient.  If it is controversial to provide a more convenient
interface, then I will work with what there is.

> > 4. Trouble with the nonce (Debian #852688 part 2)
...
> I also wonder why you say the git configuration system is unsuited to
> keeping secrets.  E.g. passing an include.path setting with -c or
> GIT_CONFIG_PARAMETERS should avoid the kinds of trouble you described.

I was not aware of include.path.  That would solve this aspect of the
problem (but not the rollover aspect, of course).
GIT_CONFIG_PARAMETERS is not documented.

> > (ii) At some later point, the following enhancement: When
> > !stateless_rpc, certNonceSeedsFile is ignored except that if neither
> > it nor the old certNonceSeed is set, the signed push feature is
> > disabled.
> 
> That seems like an awkward interface.  Shouldn't there be at least
> another config variable to enable signed push without making up a seed
> or filename?

Perhaps.  I don't have a strong opinion about the config parameter
names and semantics.  This seems like a matter of taste and I'm happy
to just do whatever others want.

> >            In this state we always get a fresh nonce (from a suitable
> > system random source).
> 
> How does this work with stateless_rpc?  (See "Session State" in
> Documentation/technical/http-protocol.txt.)

It doesn't, which is why I propose this only if !stateless_rpc.

> >                         Nontrivial because current git doesn't seem to
> > have a "get suitable random number" function, and the mess that is the
> > semantics of /dev/*random* files means that providing one is going to
> > be controversial.
> 
> I think you're overestimating how much pushback adding such a thing
> would get.

Well, I'm happy to give it ago.  (NB: I will use /dev/urandom on
Linux.)

> More references:
> 
> - JGit's push cert handling:
>   https://git.eclipse.org/r/#/q/message:cert

Really helpful, thanks.  I will read these.  (Shame that I can't even
view that information without running their javascript!)

I ended up reading this
 https://github.com/sitaramc/gitolite/blob/cf062b8bb6b21a52f7c5002d33fbc950762c1aa7/contrib/hooks/repo-specific/save-push-signatures

> - Gerrit's push cert handling:
>   https://gerrit-review.googlesource.com/q/project:gerrit+message:gpg

(This is an empty page for me, even with javascript turned on.)

I'll probably implement the refs/meta/push-certs:REF@{cert} special
branch thing from JGit.  Can anyone point me at a public repo which
has such push-certs recorded, so I can check the details and make my
thing do stuff the same way ?

Junio C Hamano writes ("Re: git signed push server-side"):
> Jonathan Nieder <jrnieder@gmail.com> writes:
> > Ian Jackson wrote[1]:
> >> Proposed change: provide the full fingerprint instead.  Do this
> >> for every caller of gpg-interface.c.
> >
> > Sounds sane.
> 
> I probably should react a bit stronger against that "instead", as
> Ian will not be writing the world's first server side hook that uses
> this interface.

Anyone who is verifying signatures and doing anything with the
16-character key id other than logging it, has a serious security bug.

> But on the other hand, the value of this environment is not meant to
> be used to make decision by the hook anyway, so it perhaps is OK to
> change it in a backward incompatible way to break those who have
> been using the value for any serious purpose.

Precisely.

> The purpose of the signed push is not to replace authentication and
> authorization.  The primary goal behind the signed push mechanism is
> to allow server side hook to implement a way to store these certs in
> the order it receives without losing them, and that gives a way for
> the server operators to protect against claims that they are showing
> what the pusher did not intend to publish.  They can say "the tip of
> these branches are at this commit, because, see this, a signed cert
> by the pusher asking us to put these commits at these branches" with
> such a mechanism---as opposed to "we authenticated the user and here
> is our server log that says that user pushed to update these refs",
> which is much weaker claim that they can make without the signed
> push mechanism.

I don't understand why the signed push system could (or should) not be
used for A&A.  It seems eminently suited to it, in circumstances where
traceability is important (and the pushers can be expected to be gpg
users).

Junio C Hamano writes ("Re: git signed push server-side"):
> When I did the signed push, the primary focus was to get the
> protocol extension right, and what the server end does with the
> received certificate was left as something that can be refined later
> by those who are really into it.  

Right.  I looked at the protocol in some detail (I have a background
in crypto protocol design) and it seemed good to me.  (Although, I
have not done a formal verification.)

> I and others may or may not have objections and may or may not offer
> better ideas over what you are going to write in your design docs
> and patches---I cannot promise anything before seeing them.

Of course.  But it is helpful for me to get some input on what
direction to go in, before I write and test code.

FTR, I don't expect to do anything particularly quickly.  And, of
course, I'd welcome any other suggestions/input in the meantime.

Thanks,
Ian.

-- 
Ian Jackson <ijackson@chiark.greenend.org.uk>   These opinions are my own.

If I emailed you from an address @fyvzl.net or @evade.org.uk, that is
a private address which bypasses my fierce spamfilter.
