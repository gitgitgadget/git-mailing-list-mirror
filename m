Return-Path: <SRS0=62NG=5C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8C5C18E5B
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 12:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFBEE20658
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 12:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgCQMtK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Mar 2020 08:49:10 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:51491 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgCQMtJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Mar 2020 08:49:09 -0400
X-Originating-IP: 103.227.96.249
Received: from localhost (unknown [103.227.96.249])
        (Authenticated sender: me@yadavpratyush.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 6D35060009;
        Tue, 17 Mar 2020 12:49:04 +0000 (UTC)
Date:   Tue, 17 Mar 2020 18:19:02 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Gilbert <JonathanG@iqmetrix.com>
Subject: Re: [PATCH v1 0/2] git-gui: reduce Tcl version requirement from 8.6
 to 8.5
Message-ID: <20200317124902.fitwgrrm6jtv24ec@yadavpratyush.com>
References: <20200314224159.14174-1-me@yadavpratyush.com>
 <CAPig+cRXD_bjUL6=daEAx7VnAy_nw9bao6rLK9xwTCYJSk48Qw@mail.gmail.com>
 <xmqqwo7k8fnk.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwo7k8fnk.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/03/20 08:48AM, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
> > On Sat, Mar 14, 2020 at 9:47 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
> >> Some MacOS distributions ship with Tcl 8.5. This means we can't use
> >> TclOO. So, use our homegrown class.tcl instead.
> >
> > It should be mentioned that this patch series fixes a regression in
> > Git v2.25 in which git-gui could not even be launched on Mac OS. The
> > problem was reported here[1] a couple months ago.
> >
> > I performed some rudimentary testing of this patch series on Mac OS,
> > and it appears to be working as expected; it certainly fixes the
> > problem of git-gui not launching on Mac OS. (I did notice a
> > misbehavior related to the original patch which caused git-gui to be
> > unusable on Mac OS in v2.25, but I suspect that misbehavior is not
> > related to or caused by this patch series, thus shouldn't prevent its
> > acceptance.)
> 
> I was actually hesitant to see this kind of change for the first
> time this late in the cycle

*sigh* I intended to finish the change much sooner, but one thing after 
another, and I kept putting it on the backburner :-(

> (the code may work with old Tcl/Tk but do we know it does with newer 
> ones?)  

It is actually the other way around. My system has Tcl 8.6 installed, 
and it works well with it. The problem is checking if it works with 8.5. 
My distro's package manager doesn't show Tcl 8.5 as an option (only 
8.6), so I have to try and build 8.5 from source to test it. It is more 
work than I can afford right now. So I am relying on Eric and other 
MacOS users' reports.

But IIUC, unless there are any hidden gotchas in Tcl 8.5, there is a 
fairly little chance that this patch breaks anything significant that 
wasn't already broken before. The patch reverts from using a new 
8.6-specific feature to pure, backward-compatible Tcl that should work 
with older versions too. No, a larger concern for me is whether I missed 
something somewhere that breaks the feature for _all_ versions of 
git-gui.
 
> I'll pull git-gui updates when Pratyush tells me to, which would
> happen before the final (scheduled on 22nd).  I'll trust git-gui
> maintainer's decision to include these changes in it, or to cook
> longer to wait for the 2.27 cycle.  Comments like yours that help
> Pratyush make the right judgment is greatly appreciated.

Honestly, I'd like to cook it a bit longer but the reality is that very 
few people, if any, actually track and test my tree. Most people 
actually discover bugs when the changes hit a new Git release.

I cooked the original series that bumped the version requirement for 
quite some time because I suspected some platforms might still be on 
older versions. But I got absolutely no feedback/complaints, so I went 
ahead and sent you a pull request.

The change hit my 'master' on December 6. Git v2.25.0 was tagged on 
January 13th. MacOS breakage was reported on January 15th.

So, I have a choice between waiting for the 2.27 cycle keeping git-gui 
broken on MacOS for another few months in hopes that someone comes in 
and discovers a bug, or have it merged in v2.26 fixing git-gui for MacOS 
but risk (though it shouldn't be too high) introducing a bug in _all_ 
platforms. Neither choice is ideal, but I'm leaning towards the latter. 
Having _most_ things working is better than having nothing working at 
all.

-- 
Regards,
Pratyush Yadav
