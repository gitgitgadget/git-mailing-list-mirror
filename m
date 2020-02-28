Return-Path: <SRS0=f6GY=4Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E26C3F2CD
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 18:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78CF120675
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 18:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgB1Sya convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 28 Feb 2020 13:54:30 -0500
Received: from elephants.elehost.com ([216.66.27.132]:55182 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgB1Sya (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Feb 2020 13:54:30 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 01SIsQsW090452
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 28 Feb 2020 13:54:27 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Robert Dailey'" <rcdailey.lists@gmail.com>,
        "'Git'" <git@vger.kernel.org>
References: <CAHd499DC7pOB3kD7nAG79GrufKrV-8p4vSZ5ZEPQb5gdXrNakg@mail.gmail.com>
In-Reply-To: <CAHd499DC7pOB3kD7nAG79GrufKrV-8p4vSZ5ZEPQb5gdXrNakg@mail.gmail.com>
Subject: RE: Why does `pull.rebase` default to `false`?
Date:   Fri, 28 Feb 2020 13:54:20 -0500
Message-ID: <00f101d5ee68$7fa0ed00$7ee2c700$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQGzoVlmAImGXx/GXtvGgdqKezFiyah1iG3Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 28, 2020 1:15 PM, Robert Dailey wrote:
> To: Git <git@vger.kernel.org>
> Subject: Why does `pull.rebase` default to `false`?
> 
> This is more of a question of practicality. Literally all of the team and project
> workflows I've experienced have demanded that `git pull` actually perform a
> rebase of your local commits, as opposed to introducing a merge commit.
> This means setting `pull.rebase` to `true`. I can't think of a practical, day-to-
> day use case for wanting merge commits after a pull. Since the subject
> commits of the rebase are always local, there's no harm to anything
> upstream since they haven't been pushed yet.
> 
> I'm sure there are edge cases that explain why the default is `false`, but I'd
> argue that it is likely a case of the minority concerns becoming an
> inconvenience for the majority of users.
> 
> Thanks in advance for any enlightenment!

Coming at this from the pull.rebase=false camp, we do not use rebase except in extenuating circumstances in our workflows to correct a poorly constructed commit chain. Merge is almost always preferable. Our topic branches are shared with our BitBucket and Gitlab instances so others can see and learn what is going on - so changes are not strictly local (commit/push is preferred at end of day in case of machine crash/loss from an overnight OS update - happened to our team twice last year). Some of our longer duration topic branches have evolved into temporary sub-integration streams with their own Pull requests until they are finally closed back to master. Random rewriting of history, even on topic branches, would confuse the SHA out of everyone. To us, a merge on a topic branch indicates an explicit "catch up" from origin, which would otherwise require detective work, inferences, and analysis after someone else tries to make sense of what a rebase did prior to a Pull request. There is
  then also the risk that your Pull request will include irrelevant commits that were already covered by a prior Pull request because signatures have changed since the common merge point - while the diff effect and signatures at the end are the same, the parent commit chains can be longer and less reflective of the actual work being done - and screws up our change metrics something terrible, making it look like we are change code far more than we actually are. The rebase paradigm may have worked for other VCS systems (thinking of ClearCase here), but requiring rebase on pull would make that git workflow unpalatable.

One thing really important in context is that we never work on master locally, and only work on our main development/integration branch during release packaging activities if a topic branch will not work nicely - restricted set of people. We secure all main branches (in GitFlow), to prevent push/rewrite. Everything has to go through a Pull request. Our policy is that developers have to do their work on their own personal topic branches. That applies to shared fix branches also, which take in a GitFlow methodology while they exist.

My $0.02 and opinion,
Randall


