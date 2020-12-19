Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B087C4361B
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 21:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0191323B54
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 21:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbgLSVCE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Dec 2020 16:02:04 -0500
Received: from ciao.gmane.io ([116.202.254.214]:46658 "EHLO ciao.gmane.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbgLSVCD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Dec 2020 16:02:03 -0500
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <gcvg-git-3@m.gmane-mx.org>)
        id 1kqjLt-0000kW-JS
        for git@vger.kernel.org; Sat, 19 Dec 2020 22:01:21 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Achim Gratz <Stromeko@nexgo.de>
Subject: Re: [PATCH] apply: don't use core.sharedRepository to create working tree files
Date:   Sat, 19 Dec 2020 22:01:16 +0100
Organization: Linux Private Site
Message-ID: <87pn354ijn.fsf@Rainer.invalid>
References: <xmqqpn3tqugm.fsf@gitster.c.googlers.com>
        <3f0403b84ab06b9deb7c5c189792bebe1db586a7.1606866276.git.matheus.bernardino@usp.br>
        <CA+kUOamDD_SDNLk3sPSwNAojrAAP+g38MjkfG4JMPRTGOVAKAQ@mail.gmail.com>
        <87y2ht4pfr.fsf@Rainer.invalid>
        <CA+kUOam3h859kK76QuS9OFojeavXO15JNpinUQ0vPrAXrcsCoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Cancel-Lock: sha1:Lk6QYjO/SpTtscHsS0Av7dazo1U=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adam Dinwoodie writes:
> Having done a bit more digging, you're (unsurprisingly) right that
> this seems to be about permissions rather than mount points per se. I
> see the same failure with a build in
> /cygdrive/c/Users/Adam/Documents/git, though, where that directory was
> created solely using Git commands with the installed version of Cygwin
> Git (v2.29.2-1).

Windows is "protecting" various directories and that can get in the way
as well.

> I'm using a test VM here that was created from
> scratch solely to run these tests, and where there has only ever been
> a single login user account, so the permissions setup should be about
> as straightforward as they possibly could be.

You haven't shown what these are in detail, though.  Use getfacl to see
what Cygwin thinks the permissions are and icacls to get the Windows
view.  Once you know what the ACL look like it usually becomes clear
what you need to do to get what you want.  In your particular case I'd
try to recursively do a 'setfacl -kb' to remove all ACL and inheritable
defaults.  Again, it's possible that your user has insufficient
permisions to do that (which will then result in some ACL still present,
i.e. a '+' sign after the permission bits in 'ls -l' output).

Keep in mind that running things as a member of the Administrator group
usually confers some extra permissions on top of that, like
Backup/Restore privileges.

> This seems like a scenario that Cygwin should be able to handle, but I
> don't have a clear enough grasp of how Windows ACLs work in normal
> circumstances, let alone when Cygwin is handling them in its
> non-standard ways, to know what an appropriate solution here is. "Only
> ever build things within the Cygwin home directory" seems like a
> decidedly suboptimal workaround, though.

I have a dedicated build directory outside anything that Windows cares
about and mount that under /mnt/share from Cygwin.  I usually remove all
inheritable and default ACL on the toplevel directory before populating
it.


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

Factory and User Sound Singles for Waldorf Blofeld:
http://Synth.Stromeko.net/Downloads.html#WaldorfSounds

