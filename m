Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: **
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SBL_CSS,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00B6A2082D
	for <e@80x24.org>; Thu,  7 Sep 2017 09:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754894AbdIGJLm (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 05:11:42 -0400
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21479 "EHLO
        sender-of-o52.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754349AbdIGJLm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 05:11:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1504775499;
        s=zoho; d=shikherverma.com; i=root@shikherverma.com;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
        l=3750; bh=vhBFM5mPKfaPWy0MQoV5NREU6kgXKDStW8R54OJ08CQ=;
        b=EyXEewPQfIkxzPL5VWCY8b2UiAnxMCLOEpdR/MB03uwDNIE994jSNxrI29sPdp/0
        DJLay9MKnKkfR91mQGkCaSFHJQP99gWSkjCQj4LbANjt8YMRDFUSSC/pljt3TFJUmKt
        qE4dSjFxt2M5GKXBwdJB41SIOg36Mbox7Hw25ijg=
Received: from weakknees.security.iitk.ac.in (125.17.242.34 [125.17.242.34]) by mx.zohomail.com
        with SMTPS id 1504775499662211.74346599458147; Thu, 7 Sep 2017 02:11:39 -0700 (PDT)
Date:   Thu, 7 Sep 2017 14:41:33 +0530
From:   Shikher Verma <root@shikherverma.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Santiago Torres <santiago@nyu.edu>
Subject: Re: [RFC PATCH 0/2] Add named reference to latest push cert
Message-ID: <20170907091133.zygswf3f6z2bedfo@weakknees.security.iitk.ac.in>
References: <20170906093913.21485-1-root@shikherverma.com>
 <CAGZ79kbxDh11KxrKCk_VjmN06kzp7x4iVO6XTV=a-qBmm39K5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kbxDh11KxrKCk_VjmN06kzp7x4iVO6XTV=a-qBmm39K5A@mail.gmail.com>
X-ZohoMailClient: External
X-ZohoMail: Z_65354923 SPT_1 Z_50090816 SPT_1 SLF_D
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 06, 2017 at 02:31:49PM -0700, Stefan Beller wrote: 
> On Wed, Sep 6, 2017 at 2:39 AM, Shikher Verma <root@shikherverma.com> wrote: 
> > Currently, git only stores push certificates if there is a receive hook 
> > present. This may violate the principle of least surprise (e.g., I 
> > pushed with --signed, and I don't see anything in upstream). 
> > Additionally, push certificates could be more versatile if they are not 
> > tightly bound to git hooks. Finally, it would be useful to verify the 
> > signed pushes at later points of time with ease. 
> > 
> > A named ref is added for ease of access/tooling around push 
> > certificates. If the last push was signed, ref/PUSH_CERT stores the 
> > ref of the latest push cert otherwise it is empty. 
> > 
> > Sending patches as RFC since the documentation would have to be 
> > updated and git gc might have to be patched to not garbage collect 
> > the latest push certificate. 
> > 
> > This patch applies on master (3ec7d702a) 
> 
> What are performance implications for busy repositories at busy hosts? 
> (think kernel.org / github) They may want to disable this new feature 
> for performance reasons or because they don't want to clutter the 
> object store. So at least a config option to turn it off would be useful. 

Any typical git push would write several objects to disk, this patch 
would only add one more object per push so I think the performance 
penalty is not that high. But I agree that we can have a config to turn 
it off. 
> On the ref to store the push certs: 
> (a) Currently the ref points at the blob, I wonder if we'd rather want to 
> point at a commit? (Then we can build up a history of 
> push certs, instead of relying on the reflog to show all 
> push certs. Also the gc issue might be easier to solve using this) 

I am not sure how that would work. The ref points at the blob of push 
certificate. Since each push can update multiple refs, each push 
certificate can point to mutiple commits (tip of the updated refs). 
Also if the named ref points at the commit then how will we get the 
corresponding push certificate? 

I did think about keeping a history of push certificates but the problem 
is new pushes can delete refs and commits which were pointed to by 
previous push certificates. This makes it really difficult to decide 
which push certificates to keep and which to gc. Also this history would 
be different for different clones of the same repo. Since push 
certificate are only meta data of the git workflow I think its best to 
just keep the latest push certificate and gc the old ones. People can 
use the recieve hook if they want to do advance things like logging a 
history of push certificates. I think git should provide a builtin 
solution for the simple case. 

Another motivation to decouple push certificates from hooks was that 
later we could store a map of refs to the latest push cert which 
updated the ref. And serve the corresponding push cert whenever someone 
does `git pull --signed important-ref`. Effectively removing trust from 
the server by preventing tampering with refs. This could really help 
the Github generation developers like me.
> (b) When going with (a), we might want to change the name. Most 
> refs are 3 directories deep: 
> refs/heads/<branch name> 
> refs/pr/<pull request nr> # at github IIUC 
> refs/changes/<id> # Gerrit 
> refs/meta/config # Gerrit to e.g. configure ACLs of the repo 
> "refs" indicates it is a ref, whereas the second part can be seen 
> as a "namespace". Currently Git only uses the "heads" and "tags" 
> namespace, "meta" is used by more than just Gerrit, so maybe it is 
> not wise to use "refs/meta/push_cert", but go with refs/gitmeta/pushcert 
> instead? 

