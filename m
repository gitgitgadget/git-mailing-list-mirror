X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: cygwin, 44k files: how to commit only index?
Date: Fri, 8 Dec 2006 08:27:08 +0100
Message-ID: <81b0412b0612072327x77477584jb9131b26b0854f2@mail.gmail.com>
References: <81b0412b0612070627r3ff0b394s124d95fbf8084f16@mail.gmail.com>
	 <7vd56vtt2g.fsf@assigned-by-dhcp.cox.net>
	 <20061207221503.GA4990@steel.home>
	 <7vr6vbqqzh.fsf@assigned-by-dhcp.cox.net>
	 <20061208052705.GA4318@steel.home>
	 <7vzm9ynahc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 8 Dec 2006 07:27:19 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sXhRI8HSRZgaRg+vuXXlkCLucKJIVlDq/Uc3sZtAcyptrUGYBEjpyQ82xwLTiOC62gRd28vfA3pfaTe7tM8I5pyT2hbmk2hHHOQpUfBBFcNdC3oLiWaW6T+Y6MS1Ll+170JIPnazB7cv7Ega0fvhFXWxiZ/HPOPtqtyMLVM0/Gk=
In-Reply-To: <7vzm9ynahc.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33667>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gsa8Y-0007Mz-Np for gcvg-git@gmane.org; Fri, 08 Dec
 2006 08:27:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1425069AbWLHH1M (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 02:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425071AbWLHH1L
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 02:27:11 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:57368 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1425069AbWLHH1K (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec
 2006 02:27:10 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1065205nfa for
 <git@vger.kernel.org>; Thu, 07 Dec 2006 23:27:09 -0800 (PST)
Received: by 10.78.158.11 with SMTP id g11mr268583hue.1165562828967; Thu, 07
 Dec 2006 23:27:08 -0800 (PST)
Received: by 10.78.139.7 with HTTP; Thu, 7 Dec 2006 23:27:08 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On 12/8/06, Junio C Hamano <junkio@cox.net> wrote:
> > yes, except that it'll compare the whole trees. Could I make it stop
> > at first mismatch? "-q|--quiet" for git-diff-index perhaps?
> > It's just not only stat, but also, open, read, mmap (yes, I try to use
> > it for packs) and close are really slow here as well.
>
> That sounds like optimizing for a wrong case -- you expect the
> index to match HEAD and trying to catch mistakes by detecting
> a mismatch, right?

I expect the index to differ from HEAD. The test is to avoid the mistake
of doing an empty commit.

> Having said that, I should point out that it is a low hanging
> fruit to optimize "diff-index --cached" for cases where index
> is expected to mostly match HEAD.
>
> The current code for "diff-index --cached" reads the whole tree
> into the index as stage #1 entries (diff-lib.c::run_diff_index),
> and then compares stage #0 (from the original index contents)
> and stage #1 (the tree parameter from the command line).  Even
> if you stop at the first mismatch, you would already have paid
> the overhead to open and read all tree objects before even
> starting the comparison.

But I don't have to pay for the overhead of comparing all
entries, if I can stop at first mismatch and exit with non-0.
I think it'd make a difference (at least some difference).
But, if we could avoid loading of the entries which
will be never compared anyway, the speedup will be
of course more substantial...

> In 'pu' (jc/diff topic), I have a very generic code to walk the
> index, working tree and zero or more trees in parallel, taking
> advantage of cache-tree.  If somebody is interested to learn the
> internals of git, some of the code could be lifted from there
> and simplified to walk just the index and a single tree, and I
> think that would optimize "diff-index --cached" quite a bit.

