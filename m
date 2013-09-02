From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] revision: introduce --exclude=<glob> to tame wildcards
Date: Mon, 2 Sep 2013 18:09:50 -0500
Message-ID: <CAMP44s2+cG2kb=o9OTT=8=2pm+xCwZEJE5dNkmyKx6P=03sX-Q@mail.gmail.com>
References: <1377838805-7693-1-git-send-email-felipe.contreras@gmail.com>
	<7vhae7k7t1.fsf@alter.siamese.dyndns.org>
	<CAMP44s1y2kvSnF3dKDMr9QtS40PNSW93DWCxFUoL658YkqYeVA@mail.gmail.com>
	<CAPc5daVSqoE74kmsobg7RpMtiL3vzKN+ckAcWEKU_Q_wF8HYuA@mail.gmail.com>
	<CAMP44s0P=XF5C8+fU2cJ-Xuq57iqcAn674Upub6N=+iiMpQK0g@mail.gmail.com>
	<xmqqeh9b15x6.fsf@gitster.dls.corp.google.com>
	<xmqq1u5aybri.fsf_-_@gitster.dls.corp.google.com>
	<5224F0EE.1080205@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Sep 03 01:09:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGdFt-0004Y9-39
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 01:09:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753458Ab3IBXJx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 19:09:53 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:37217 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752655Ab3IBXJw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Sep 2013 19:09:52 -0400
Received: by mail-la0-f52.google.com with SMTP id ev20so3968650lab.39
        for <git@vger.kernel.org>; Mon, 02 Sep 2013 16:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/lZao0Yx5xeAbV24LS1EUjTRaJjl+JcZfBw+4t3A3io=;
        b=TxBLyVz+j/qgatFJK6cd/XEmhOjEjMiF8LLvL6en1BFF/rLwjngYPC3JP8xHlNPrt0
         hfScLSQrrVZu+apG7xROU9cJhX4Rid9R5lCi61+7sntsEU+e5pRyC1v8u0jhXR2Xt6ey
         kz83jOqF5fi0p2jZpXnZ2tXWxRhNBt3b/7g8KMCmJ7PubF5B6Y4ohnJ9w1DHAE40lE5l
         DWFN/kwB1cQ1HF/oHimm6Li9AakwmGzrsCoxAk/ubo4/9KHEmjrR6JdeZZkUzY+TqwQM
         FcJ9NHO8yINLRKsut7gxUlG75SrGJlMKM5NOmpmXhnbuFg2ys7ORqCSVcAhXRR6Qw7eu
         UjrA==
X-Received: by 10.112.168.170 with SMTP id zx10mr22736130lbb.0.1378163390549;
 Mon, 02 Sep 2013 16:09:50 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Mon, 2 Sep 2013 16:09:50 -0700 (PDT)
In-Reply-To: <5224F0EE.1080205@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233674>

On Mon, Sep 2, 2013 at 3:11 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 31.08.2013 01:55, schrieb Junio C Hamano:
>> People often find "git log --branches" etc. that includes _all_
>> branches is cumbersome to use when they want to grab most but except
>> some.  The same applies to --tags, --all and --glob.
>>
>> Teach the revision machinery to remember patterns, and then upon the
>> next such a globbing option, exclude those that match the pattern.
>>
>> With this, I can view only my integration branches (e.g. maint,
>> master, etc.) without topic branches, which are named after two
>> letters from primary authors' names, slash and topic name.
>>
>>     git rev-list --no-walk --exclude=??/* --branches |
>>     git name-rev --refs refs/heads/* --stdin
>>
>> This one shows things reachable from local and remote branches that
>> have not been merged to the integration branches.
>>
>>     git log --remotes --branches --not --exclude=??/* --branches
>>
>> It may be a bit rough around the edges, in that the pattern to give
>> the exclude option depends on what globbing option follows.  In
>> these examples, the pattern "??/*" is used, not "refs/heads/??/*",
>> because the globbing option that follows the -"-exclude=<pattern>"
>> is "--branches".  As each use of globbing option resets previously
>> set "--exclude", this may not be such a bad thing, though.
>
> I argued "--except should trump everything" earlier, but the case
> involving --not
>
>   --branches --except maint --not master
>
> to mean the same as
>
>   --branches --except maint master
>
> just does not make sense.

No, but this could make sense:

--branches ^master --except maint --not master
==
--branches --except maint

> An alternative would be that --not would divide the command line
> arguments into ranges within which one --except would subtract
> subsequent refs from earlier globbing arguments in the same range.
> That's not simpler to explain than your current proposal.

Something like that can be easily done in my approach:

--- a/revision.c
+++ b/revision.c
@@ -1984,6 +1984,7 @@ static int handle_revision_pseudo_opt(const char
*submodule,
                handle_reflog(revs, *flags);
        } else if (!strcmp(arg, "--not")) {
                *flags ^= UNINTERESTING | BOTTOM;
+               *flags &= ~SKIP;
        } else if (!strcmp(arg, "--except")) {
                *flags |= SKIP;
        } else if (!strcmp(arg, "--no-walk")) {
@@ -2628,7 +2629,8 @@ int prepare_revision_walk(struct rev_info *revs)
                for (i = 0; i < revs->cmdline.nr; i++) {
                        struct rev_cmdline_entry *ce;
                        ce = &revs->cmdline.rev[i];
-                       if ((ce->flags & SKIP) && !refcmp(ce->name, e->name)) {
+                       if ((ce->flags & SKIP) && !refcmp(ce->name, e->name) &&
+                                       ((ce->flags & UNINTERESTING)
== (e->item->flags & UNINTERESTING))) {
                                e->item->flags =
recalculate_flag(revs, e->item->sha1, ce->name);
                                goto next;
                        }
diff --git a/t/t6112-rev-list-except.sh b/t/t6112-rev-list-except.sh
index a40a641..441e1da 100755
--- a/t/t6112-rev-list-except.sh
+++ b/t/t6112-rev-list-except.sh
@@ -57,4 +57,21 @@ test_expect_success 'rev-list --except and --not
with proper flags' '
        test_cmp expect actual
 '

+test_expect_success 'rev-list --not ranges' '
+
+       git rev-list --topo-order test --not master --except master
test > actual &&
+       git rev-list --topo-order test > expect &&
+       test_cmp expect actual
+'
+
+test_expect_success 'rev-list multiple --not ranges' '
+
+       git checkout -b extra test &&
+       echo five > content &&
+       git commit -a -m five &&
+       git rev-list --topo-order test --not master --except master
test --not extra > actual &&
+       git rev-list --topo-order test extra > expect &&
+       test_cmp expect actual
+'
+

-- 
Felipe Contreras
