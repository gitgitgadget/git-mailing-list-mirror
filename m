Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE85C433DF
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 20:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91F0320B80
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 20:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394974AbgFSU6D (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 16:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394715AbgFSU6D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 16:58:03 -0400
X-Greylist: delayed 1267 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 19 Jun 2020 13:58:03 PDT
Received: from vuizook.err.no (vuizook.err.no [IPv6:2a02:20c8:2640::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5651CC06174E
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 13:58:03 -0700 (PDT)
Received: from [2400:4160:1877:2b00:468:8d6c:8b64:977a] (helo=glandium.org)
        by vuizook.err.no with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1jmNki-0002oH-5w; Fri, 19 Jun 2020 20:36:48 +0000
Received: from glandium by goemon.lan with local (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1jmNkd-000Qvq-67; Sat, 20 Jun 2020 05:36:39 +0900
Date:   Sat, 20 Jun 2020 05:36:39 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sergey Organov <sorganov@gmail.com>, git@vger.kernel.org
Subject: Re: Annoyance wrt ref@{1} and reflog expiry
Message-ID: <20200619203639.i5jto4i52ptsihrs@glandium.org>
References: <xmqqzh8zgcfp.fsf@gitster.c.googlers.com>
 <87o8pe3ou6.fsf@osv.gnss.ru>
 <xmqqwo42g5ld.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwo42g5ld.fsf@gitster.c.googlers.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 19, 2020 at 01:31:42PM -0700, Junio C Hamano wrote:
> Sergey Organov <sorganov@gmail.com> writes:
> 
> >> But then if you do
> >>
> >>     $ git reflog expire --expire=now refs/heads/newbranch
> >>     $ git commit --allow=empty -m two
> >>     $ git show -s newbranch@{1}
> >> ...
> >> And it is unintuitive.  It is understandable to the users that all
> >> the ref history before "reflog expire" is lost---it was what the end
> >> user asked Git to do.  But after creating one commit on the state
> >> (or do anything else that moves the ref) and finding it regrettable,
> >> "git reset --hard @{1}" should be a viable way to recover from the
> >> mistake made _after_ the reflog entries were expired.
> 
> And the expiration does not have to be --expire=now; what happens
> more often is when I expire entries older than (say) a week, the
> reflog for a topic branch that hasn't seen any activity may become
> empty.  Then I "git am" the new round on the same base, compare and
> then update, perhaps like so:
> 
>     ... git reflog expire has emptied the log for so/topic ...
>     $ git checkout so/topic
>     $ git log master.. ;# remind myself what the previous round had
>     $ git checkout master... ;# detach HEAD at the previous base
>     $ git am -s ./+so-v2-topic ;# apply
>     $ git range-diff @{-1}... ;# compare
>     $ git checkout -B so/topic
> 
> Now, I'm used to see this work after the above:
> 
>     $ git range-diff @{1}... ;# compare again just to be sure
> 
> but because there is only one entry in the reflog, which was created
> when the last "checkout -B" updated the so/topic branch, "there is
> only one entry" error kicks in.
> 
> > Makes sense. The first solution that comes to mind is immediately record
> > current state after "reflog expire", so that there will be 2 entries for
> > the case in question.
> 
> Perhaps.  
> 
> Or we could change the lookup side to use the value of the ref
> itself when asked for @{0}, and use the "old" side of the only entry
> when asked for @{1}.  That way, we do not need to play games with an
> artificial entry at all, which may be a better solution.

Or more generally, use the old side from @{n} when asked for @{n+1} when
there are only n entries in the reflog.

Mike
