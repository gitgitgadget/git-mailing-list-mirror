Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56CAB1F461
	for <e@80x24.org>; Mon,  1 Jul 2019 20:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfGAUMh convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 1 Jul 2019 16:12:37 -0400
Received: from elephants.elehost.com ([216.66.27.132]:57387 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfGAUMh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 16:12:37 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from Madrigal (b03e9f.lockharding.com [23.229.103.137] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x61KCN1E040099
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 1 Jul 2019 16:12:26 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   <rsbecker@nexbridge.com>
To:     "'Bryan Turner'" <bturner@atlassian.com>,
        "'Junio C Hamano'" <gitster@pobox.com>
Cc:     "'Eric Kulcyk'" <Eric.kulcyk@microsoft.com>, <git@vger.kernel.org>
References: <DM5PR00MB040845755401A07E5C90251CF1F90@DM5PR00MB0408.namprd00.prod.outlook.com> <xmqqpnmt5z19.fsf@gitster-ct.c.googlers.com> <CAGyf7-EBs_cRB5R7RyQhX0ZDNqLZWVJEYEtqkGRGJykRqKKTvA@mail.gmail.com>
In-Reply-To: <CAGyf7-EBs_cRB5R7RyQhX0ZDNqLZWVJEYEtqkGRGJykRqKKTvA@mail.gmail.com>
Subject: RE: Tracking parent branches in Git
Date:   Mon, 1 Jul 2019 16:12:06 -0400
Message-ID: <007d01d53049$4db5bec0$e9213c40$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQIIm/4Bxufqf2UaHYMxpB5SNwoS0gKMkoUAAh1oeoWmKgb6MA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On July 1, 2019 3:48 PM, Bryan Turner wrote:
On Mon, Jul 1, 2019 at 12:35 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Eric Kulcyk <Eric.kulcyk@microsoft.com> writes:
>
> [Overly long lines are not appreciated around here.]
>
> > We would like to track parent branches so that creating pull 
> > requests can automatically determine the correct branch to merge 
> > against.  I understand that this would require tracking more 
> > information than is currently available right now in git.  Also, it 
> > seems that if some cases, it is not possible to determine a parent 
> > branch, in which case it would just be empty/null.
>
> Do you mean by "parent branch" what people usually call "upstream 
> branch" (i.e. when that branch on the other side gains more commits 
> independent from what you have been working on, then you would want to 
> rebase your work on top of the updated state of that branch on the 
> other side) around here?

I suspect the question is in regards to "What branch did I create my local branch from?", especially given the pull request reference.

In other words, when I locally do:
git checkout --no-track -b bturner-some-bugfix origin/release/5.16

release/5.16 is the "parent branch" of my bugfix branch and, when I push my branch and try to open a pull request, release/5.16 is a _likely_ target for where I'd want to merge it. There may be a remote in the name, a la "origin" in my example, or it might be created on top of some other local branch. It's a common feature request for Bitbucket Server[1], for example, to automatically select the "right"
target branch for a new pull request based on the ancestry of the branch in question--except branches have no ancestry. (This sort of metadata could potentially offer some benefits for building commit graphs (referring to UI treatments for visualizing the DAG, rather than Git's "commit-graph" functionality), depending on how it was implemented, since it would make branch points more stable.)

Since branches are ephemeral names and have no intrinsic metadata of their own (unlike, say, annotated tags or commits), I suspect implementing something like this may be more complicated than it might initially appear, especially if said metadata needs to be communicated to remote repositories (which implies it might require changes to the wire protocol as well).

Best regards,
Bryan Turner

[1] https://jira.atlassian.com/browse/BSERV-7116

>
> Perhaps "git help glossary", look
> for "upstream branch" and start from there?  The entry mentions the 
> configuration variables used to keep track of that information, which 
> are described in "git help config", I think.
>
> > If I made a change to track the parent branch for each branch, would 
> > this feature be accepted/welcomed as part of git, even if it off by 
> > default?
>
> Regardless of what is being proposed, this is often not a very useful 
> question.  Something worth doing for yourself is worth doing whether 
> others also find it useful ;-)  And others usually do not have enough 
> information to judge if such a change is welcome until seeing it in a 
> bit more concrete form.

Was there not, at some point in recent history (2019), a discussion about storing extra arbitrary data associated with a branch or other objects? My thought for satisfying what Eric was originally proposing is to store the root commit associated with the original branch HEAD when checkout -b/branch was done to create the branch. Presumably another datum could store the branch that the branch HEAD was on, but that may not be unique - which is a root part of the problem with this request, although it might be something that the user could select/specify - not sure how - at branch creation. 

But aside from that both of the above are transient relative to the new branch and by the time you wanted to create a Pull Request, the information you originally wanted could irrelevant - at least to git. If I was the product manager on this, I would suggest going to GitLab, GitHub, or BitBucket and asking for some augmented capability of branch creation, that stores the data for future Pull Request management - instead of doing this in core git because of the transient nature of the relationship between a branch and a commit.

My $0.02.
Randall

