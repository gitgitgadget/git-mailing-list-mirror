Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 481841F404
	for <e@80x24.org>; Mon,  2 Apr 2018 03:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754122AbeDBDpi (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Apr 2018 23:45:38 -0400
Received: from elephants.elehost.com ([216.66.27.132]:52133 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754074AbeDBDph (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Apr 2018 23:45:37 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w323jYpP025399
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 1 Apr 2018 23:45:34 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Yubin Ruan'" <ablacktshirt@gmail.com>
Cc:     <git@vger.kernel.org>
References: <20180402015035.mzgye6apwn3igch5@HP>        <xmqqwoxqz56y.fsf@gitster-ct.c.googlers.com> <xmqqsh8ez41b.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqsh8ez41b.fsf@gitster-ct.c.googlers.com>
Subject: RE: [RFC] git clone add option to track all remote branches
Date:   Sun, 1 Apr 2018 23:45:27 -0400
Message-ID: <005d01d3ca35$0d4576d0$27d06470$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIAoixSPtJ9AuWab8kICaHOrsBkgwIo9icdAetK7e2jcn83EA==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On April 1, 2018 11:22 PM Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> > If you are really doing your own development, then you would have some
> > topic branches of your own, with forks of some (but most likely not
> > all, especiallyi when there are many branches at the upstream)
> > branches you got from the upstream, and "git branch --list" that shows
> > only your own and what you are interested in (i.e. those that you
> > actually bothered to "git checkout <branchname>") without showing
> > random other branches that exist at the remote but do not interest you
> > is a feature.  Your hypothetical "clone" that indiscriminatedly forks
> > all branches at remote locally will destroy the usefulness of it.
> 
> Related to this, a feature I have long thought we wished to have is
complete
> opposite of this.  After creating and working on a local topic branch and
then
> concluding the work on it, a user would "git push" the branch out to a
> remote, and then check out a different branch (e.g. the 'master' branch).
I
> wish we had a mode that would automatically *delete* the local topic
branch
> that has already been pushed out (and more importantly, a branch that I
> have *done* with, at least for now), to unclutter my local branch
> namespace.  When I want to further work on it, I can ask "git checkout" to
> dwim to recreate one on demand.
> 
> Of course, there are some wrinkles due to pesky impleemntation details
> (e.g. the "autonuke-and-recreate" would lose reflog), but I do not think
it is
> fundamental hurdle.

I'm a little skeptical and confused here. The original RFC does not appear
to stipulate that this is isolated to a single bare. If B,C,D all clone
A.git from one server, it might be ok. If B clones A.git, and C clones B,
and D mirrors C, where would the remote tracking occur. The main value, as a
repo admin of A.git would be to know everything, but that's unlikely.
Stating the obvious rub is, in a DVCS, where connections are not guaranteed,
one can easily move a clone or delete a clone, and your tracking branch
becomes worthless. You might never know about C/D mirrors or even be able to
establish a connection between A.git and those two, in practice - I have
examples of those.
OTOH I have been toying with suggesting a solution to this for a couple of
years, differentiating a transient clone from a (pick a term) authentic
clone, the latter which has some blockchainish so that git will whine
without a valid signature on the clone. Changing the clone without
communicating with the upstream to revalidate it (deferrals could be
implemented), temporarily or permanently invalidates the authentic clone so
it effective becomes pruneable, like a worktree. I see a very deep potential
rabbit hole here that detracts from DVCS principles unless we do have the
conceptual split of the two classes of clones. rm .git is just too easy and
too frequent an operation to just ignore the implication of the deliberate
loss of tracking that is highly unlikely to be trackable by the farthest
upstream, resulting in a whole lot of clutter with no way back.
Alternatively, if the downstreams periodically are forced to revalidate the
tracking branches, then you have sometime potentially workable but annoying
at best, and impractical in some security policies at worst.

Just my $0.02 from managing boat-loads of 4 and 5 level deep repositories.

Cheers,
Randall

