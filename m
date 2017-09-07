Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: **
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SBL_CSS,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15D732082D
	for <e@80x24.org>; Thu,  7 Sep 2017 08:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754349AbdIGIzS (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 04:55:18 -0400
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21420 "EHLO
        sender-of-o52.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754073AbdIGIzS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 04:55:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1504774515;
        s=zoho; d=shikherverma.com; i=root@shikherverma.com;
        h=Date:From:To:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
        l=3228; bh=jJKoaZYSviVU4HZDf1iV1At2TrVe8HpBD47Qn+ZwTF8=;
        b=KZLYvqK6dE5laCcCfDW+29Wg3Ix8Ty056tJrBDonOQCv1j+6+KY2/E/XdgzEsuJ8
        23ak9KEKYmNgotlhl1Bwd/EPhivuez+zi7HZVTEhHVTTWFITE0PgHNarq/8ClyFfVlQ
        NcqpGpPGCS6NJ2CKuE7MLTJDvxeajD7CO3qirrrg=
Received: from weakknees.security.iitk.ac.in (125.17.242.34 [125.17.242.34]) by mx.zohomail.com
        with SMTPS id 1504774515802292.0278255527164; Thu, 7 Sep 2017 01:55:15 -0700 (PDT)
Date:   Thu, 7 Sep 2017 14:25:11 +0530
From:   Shikher Verma <root@shikherverma.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] Add named reference to latest push cert
Message-ID: <20170907085511.bpgtm4gqem6eukji@weakknees.security.iitk.ac.in>
References: <20170906093913.21485-1-root@shikherverma.com>
 <CAGZ79kbxDh11KxrKCk_VjmN06kzp7x4iVO6XTV=a-qBmm39K5A@mail.gmail.com>
 <xmqq4lsf2upu.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4lsf2upu.fsf@gitster.mtv.corp.google.com>
X-ZohoMailClient: External
X-ZohoMail: Z_65354923 SPT_1 Z_50090816 SPT_1 SLF_D
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 07, 2017 at 09:55:25AM +0900, Junio C Hamano wrote:
> Stefan Beller <sbeller@google.com> writes:
> 
> > On the ref to store the push certs:
> > (a) Currently the ref points at the blob, I wonder if we'd rather want to
> >     point at a commit? (Then we can build up a history of
> >     push certs, instead of relying on the reflog to show all
> >     push certs. Also the gc issue might be easier to solve using this)
> > (b) When going with (a), we might want to change the name. Most
> >     refs are 3 directories deep:
> >       refs/heads/<branch name>
> >       refs/pr/<pull request nr> # at github IIUC
> >       refs/changes/<id> # Gerrit
> >       refs/meta/config # Gerrit to e.g. configure ACLs of the repo
> >     "refs" indicates it is a ref, whereas the second part can be seen
> >     as a "namespace". Currently Git only uses the "heads" and "tags"
> >     namespace, "meta" is used by more than just Gerrit, so maybe it is
> >     not wise to use "refs/meta/push_cert", but go with refs/gitmeta/pushcert
> >     instead?
> 
> You also need to worry about concurrent pushes.  The resulting
> "history" may not have to be sequencial, but two pushes that affect
> the same ref must be serialized in the resulting push-cert store.

Oh I see. I guess concurrency would be an issue. How does recieve-pack
handle concurrent pushes? Is there a lock that I could use to decide 
if named push cert ref has to be updated or not?

> The original design deliberately punts all the complexity to hook
> exactly because we do not want to have a half-baked "built-in"
> implementation that would only get in the way of those who wants to
> do high-performance servers.  It is very likely that they want to
> have a long-running daemon that listens to a port or a named pipe,
> where the only thing the hook would do is to write the value of
> GIT_PUSH_CERT to that daemon process, which acts as a serialization
> point, can read from the object store that is used as a short-term
> temporary area, and write the push cert to a more permanent store.
> 
> Having said all that, I am sympathetic to a wish to have an
> easy-to-enable-without-thinking example that is not so involved
> (e.g. no portability concern, does not have to perform very well but
> must be correct).  If Shikher wants to add one, I think the right
> approach to do so would be to add and ship a sample hook.
> 

This patch would only add one more object to write per push so I 
think the performance penalty is not that high. We can have a config
to turn it off so that it does not get in the way of those who want 
to do high-performance servers.

People can use the recieve hook for advance use cases but I think git
should provide a builtin solution for the simple case. The reason I
favour a named ref over a sample hook is because decouping push
certificate from hook opens up more possibilities like we could store
a map of refs to the latest push cert which updated the ref. And 
serve the corresponding push cert whenever someone does 
`git pull --signed important-ref`. Effectively removing trust from 
the server by preventing tampering with refs. This could really help 
the Github generation developers like me. What do you think?

> Thanks.

