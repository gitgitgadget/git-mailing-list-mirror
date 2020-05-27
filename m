Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C7BC433DF
	for <git@archiver.kernel.org>; Wed, 27 May 2020 16:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D4CF20787
	for <git@archiver.kernel.org>; Wed, 27 May 2020 16:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389448AbgE0QKg convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 27 May 2020 12:10:36 -0400
Received: from elephants.elehost.com ([216.66.27.132]:49598 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388436AbgE0QKg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 12:10:36 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [173.32.57.223])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 04RGAWKt006456
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 27 May 2020 12:10:32 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Kevin Buchs'" <kevin.buchs@newcontext.com>, <git@vger.kernel.org>
References: <CAKTRx=09tjsH0j+Nf4_1uzn-GwasWFB_Q96KEO=qtr5nVBkAew@mail.gmail.com>
In-Reply-To: <CAKTRx=09tjsH0j+Nf4_1uzn-GwasWFB_Q96KEO=qtr5nVBkAew@mail.gmail.com>
Subject: RE: rationale behind git not tracking history of branches
Date:   Wed, 27 May 2020 12:10:25 -0400
Message-ID: <022f01d63441$58846ac0$098d4040$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQNLTiNnr7GO9GtHxiZNPiri3+pL86XR4fjQ
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On May 26, 2020 5:01 PM, Kevin Buchs wrote:
> For many years of using Git, I always struggled to make sense of commit
> history graphs (git log --graph; gitk). Just recently I discovered that git does
> not track the history of branches to which commits belonged and the
> lightbulb turned on. This is proving to be painful in a project I inherited with
> permanent multiple branches.
> Now, I am a bit curious as to the rationale behind this intentional decision
> not to track branch history. Is it entirely a matter of keeping branches
> lightweight?
> 
> I am assuming one can backfill for the missing capability by using a commit
> hook to manually track when a branch head is changed. Perhaps by storing
> the branch in the commit notes.

Based on the distributed nature of git, the interpretation of the history of a branch can be different based on local clones. The history only comes together as commits are merged together on an upstream repository, so even in the upstream, the interpretation is potentially different from what the branch's interpretation is in someone's clone. The parent-child commit structure in the underlying Merkel tree is the only definitive interpretation and is a post-merge perspective independent of any interpretation of the branch itself.

The point-in-time interpretation of a branch is simply the HEAD where the branch pointer is located, but the point-in-time interpretation is ambiguous across multiple clones and even the upstream. In order to disambiguate the interpretation, the branch contents have to be moved to a common repository which only understands its branch HEAD post push, which may be disallowed without a merge depending on the current tree structure.

To track a branch's history across all domains, and make it meaningful, you could write a commit, push, etc. hook, that understands what the current state of the branch is and where, and interpret the history based on your own project needs. It would be something like a relation set something like the tuple: {some-unique-repo-clone-identifier; branch; commit; date-and-time}, as the branch state (HEAD) is time-varying and can repeat its presence on a commit multiple times (git branch -f branch-name commit-ish) . The "some-unique-repo-clone-identifier" is problematic, because there isn't one currently AFAIK.

That's my interpretation anyway based on how I see things in today's git world - I might very well be wrong.

Regards,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



