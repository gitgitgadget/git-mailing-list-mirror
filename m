From: Mike Rappazzo <rappazzo@gmail.com>
Subject: Re: [BUG] Wrong worktree path when using multiple worktree
Date: Tue, 3 Nov 2015 21:23:52 -0500
Message-ID: <CANoM8SXKmqq5qpv7vFobyAj9mL0wxFPqWeTt5oJT1EP0+=NqwA@mail.gmail.com>
References: <5638E79E.10407@morey-chaisemartin.com> <CANoM8SVOPpOvnykGxfw+dn1Twwe8S=WKfePogx+GRQeAjn6D7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 03:24:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtnkH-000688-NF
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 03:24:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932762AbbKDCYN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 21:24:13 -0500
Received: from mail-ob0-f176.google.com ([209.85.214.176]:34985 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754815AbbKDCYM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 21:24:12 -0500
Received: by obctp1 with SMTP id tp1so28888027obc.2
        for <git@vger.kernel.org>; Tue, 03 Nov 2015 18:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=jwvm8HWEIsGI1gwejdunOByTB5+BZDwFZ+1MHJU9zoA=;
        b=YMD8E2Ga4pAep2zTLZnSdigTgjPEBs0jfrLgcShgqBWF1IzMgT7Qi1VM5i9q10kku5
         ozst0hItD7Vcrg5/18WODlmRrOleSZDwhV23+kuQ3C1uq+SfBnROseA29XseeIW/W8zC
         MNT1POIwcpzIgAD09819Quon/A6DuN+eHbi/6TYYFL7h2SClbiyMJ17PFvMDzAMHTvPN
         7JR0s2vXSDvrMIJuUuc6bLHgpri7WAew9za/uhkPqxNNWcNKqv4SIM+PyyzxsHcNlNu5
         appW+dRrsFfd4uMZ/TIy2hHp4sTFcKqfHGwjDl0HrieYLJklv7+XuJKO+yYI8kRMSLFo
         WqIQ==
X-Received: by 10.182.81.136 with SMTP id a8mr20157880oby.76.1446603851450;
 Tue, 03 Nov 2015 18:24:11 -0800 (PST)
Received: by 10.202.79.76 with HTTP; Tue, 3 Nov 2015 18:23:52 -0800 (PST)
In-Reply-To: <CANoM8SVOPpOvnykGxfw+dn1Twwe8S=WKfePogx+GRQeAjn6D7g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280843>

On Tue, Nov 3, 2015 at 5:27 PM, Mike Rappazzo <rappazzo@gmail.com> wrote:
> On Tue, Nov 3, 2015 at 11:58 AM, Nicolas Morey-Chaisemartin
> <nicolas@morey-chaisemartin.com> wrote:
>> Hi,
>>
>> There seem to be an issue with the path computed for a worktree when multiple worktree were created (using git worktree)
>> In my Setup, I have 3 repos:
>> A/repo (main One)
>> A/repo-patches (worktree, using branch dev)
>> B/repo (worktree, using branch next)
>>
>> I'm working in A/repo-patches an run:
>> $ git checkout next
>> fatal: 'next' is already checked out at 'A/repo-patches'
>>
>> Which is partially true but not completely.
>> I looked a bit in the code and found that the issue comes from here (get_linked_worktree):
>>     if (!strbuf_strip_suffix(&worktree_path, "/.git")) {
>>         strbuf_reset(&worktree_path);
>>         strbuf_addstr(&worktree_path, absolute_path("."));
>>         strbuf_strip_suffix(&worktree_path, "/.");
>>     }
>> Because it wrongfully assumes that I am in the linked worktree.
>> I checked in the .git/worktree files and couldn't see anything that actually points to where the repo are setup.
>>
>> Nicolas
>
> This is code that I worked on, but I am unable to reproduce it locally
> just yet.  Before I dig too deep, could you report the contents of
> "A/repo/.git/worktrees/repo-patches/gitdir" (or similar)?  There is
> another issue reported[1] where the contents of the gitdir for a
> linked worktree are overwritten in some cases.  A fix for this is
> being worked on (see discussion).
>
> In the mean time, I will continue to try and reproduce.
>
> [1]: http://thread.gmane.org/gmane.comp.version-control.git/280307

Followup:  I was able to reproduce the error when I tried to simulate
the aforementioned bug.  Here is a test which I added to t2027 (not
intended to publish):

+test_expect_success '"checkout" branch already checked out' '
+ git worktree add -b linked_1_br linked_1 master &&
+ git worktree add -b linked_2_br linked_2 master &&
+ echo ".git" > .git/worktrees/linked_2/gitdir &&
+ test_must_fail git -C linked_1 checkout linked_2_br
+'
+

Test run result:
--------------------
Preparing linked_1 (identifier linked_1)
HEAD is now at 2519212 init
Preparing linked_2 (identifier linked_2)
HEAD is now at 2519212 init
fatal: 'linked_2_br' is already checked out at
'/Users/mike/code/git-source/t/trash
directory.t2027-worktree-list/linked_1'
