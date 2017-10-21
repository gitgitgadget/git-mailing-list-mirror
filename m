Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 024321FF72
	for <e@80x24.org>; Sat, 21 Oct 2017 21:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932247AbdJUVvE convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sat, 21 Oct 2017 17:51:04 -0400
Received: from elephants.elehost.com ([216.66.27.132]:32729 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932242AbdJUVvD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Oct 2017 17:51:03 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.147.105])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id v9LLoXRf010638
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 21 Oct 2017 17:50:34 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <nicolas.mailhot@laposte.net>, <git@vger.kernel.org>
References: <2089146798.216127.1508487262593.JavaMail.zimbra@laposte.net> <1290947539.4254.1508496039812.JavaMail.zimbra@laposte.net>
In-Reply-To: <1290947539.4254.1508496039812.JavaMail.zimbra@laposte.net>
Subject: RE: [RFE] Add minimal universal release management capabilities to GIT
Date:   Sat, 21 Oct 2017 17:50:28 -0400
Message-ID: <000001d34ab6$9f549460$ddfdbd20$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEQkiBsJlXtbBQjasldtmQygGgOTaR0QFbw
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

-----Original Message-----
From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On Behalf Of.mailhot@laposte.net
On October 20, 2017 6:41 AM, nicolas wrote:
To: git@vger.kernel.org
Subject: [RFE] Add minimal universal release management capabilities to GIT

>Git is a wonderful tool, which has transformed how software is created, and made code sharing and reuse, a lot easier (both between human and software tools).

<snip>
> Please please please add release handling and versioning capabilities to Git itself. Without it some enthusiastic
> Git adopters are on a fast trajectory to unmanageable hash soup states, even if they are not realising it yet, because
> the deleterious side effects of giving up on releases only get clear with time.
> Here is what such capabilities could look like (people on this list can probably invent something better, I don't care as long as something exists).
<snip>

Nicolas makes some interesting points, and I do suggest looking at the original post, but there are more factors to consider when dealing with production-grade releases in regulatory environments. And my sincere apologies for what, even in my eyes looks like a bit of a soap-box rant. No slight intended, Nicolas.

Possibly most importantly, there are serious distinctions between what is built via CI, what is released, and what is installed. Some of these can be answered addressed directly by git, but others require convention, or a meta-system spanning platforms. I will abbreviate some of this:

Commits being used to initiate CI cycles are typically based on source commit ids (Jenkins, as an example uses this as an initiator). In Open Source environments, where source is specifically released, this is a perfectly reasonable release point requiring no more than the commit id itself. Committers tend to add tags for convention to make identification convenient, and git describe is really helpful here for generating identifying information (I state the obvious here). This is the beginning of wisdom, not the end (to mis-paraphrase).

Release commits, which are not explicitly in a one-to-one relationships with source commits, are a different matter. Suppose the target of your Jenkins build creates a release of objects packaged in some useful form. The release and source commits are somehow related in your repository of record (loads of ways to do this). However, in multi-platform situations, you are in a many-to-one situation, obviously since the changes of the release's hash matching between two platform builds approaches zero. Nonetheless, the release's commit id is relevant to what gets installed, but it is not sufficient for human identification purposes. The tag comes in nicely here, and hopefully is propagated from the dependent source commit. This release-to-source commit derivation is implicitly required in some regulatory environments (financial institutions, FDA, FAA, as examples where this exists for some systems).

But once you are in a production (or QA) environment, the actual install package contains artifacts from a release and from the environment into which the release is being installed and activated. The artifacts themselves can be highly dynamic and changeable on a radically different and independent schedule from the code drop. I advocate keeping those in separate repositories and they make for hellacious merge/distribution rules - particularly if the environments are radically different in structure, platform, and capability. The relationship between commits here is if anything specifically mutable. In a specific way, source and release commits are required to be time reversible in production, whereby if an installation fails, there exist in many environments requirements to be able to fully undo the install action. This is often different from the environment artifacts which can be time-forward constrained and reversible only in extreme situations. This separate, at least in my experience, tends to drive how releases are managed in production shops.

> So nothing terribly complex, just a lot a small helpers to make releasing easier, less tedious, and cheaper for developers,
> that formalize, automate, and make easier existing practices of mature software projects, making them accessible to
> smaller projects. They would make releasing more predictable and reliable for people deploying the code, and easier
> to consume by higher-level cross-project management tools. That would transform the deployment stage of software
> just like Git already transformed early code writing and autotest stages.

Possibly, but primarily for source releases. Release management and the related practices are production functions that do not map particularly well (by assertion) to the git command set or functionality. As an underlying mechanism to manage the production artifacts, git does wonderfully. But installable packages (what they think of as releases) are primarily not for developers but for the Ops side of DevOps. Having operations use git to manage production artifacts is an obvious goal in the DevOps community, but there is a whole lot of platform "convention" that comes into play here, that is way outside the git capability set. My preference would be to leverage as much of git as possible to this end, but not constrain it to a specific convention that may seem natural in only small process subset.

Cheers,
Randall

-- Brief whoami: NonStop&UNIX developer since approximately UNIX(421664400)/NonStop(211288444200000000) 
-- In my real life, I talk too much.



