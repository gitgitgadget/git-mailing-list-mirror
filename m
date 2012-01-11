From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/8] revert: decouple sequencer actions from builtin
 commands
Date: Tue, 10 Jan 2012 23:49:54 -0600
Message-ID: <20120111054954.GB13507@burratino>
References: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
 <1326212039-13806-1-git-send-email-artagnon@gmail.com>
 <1326212039-13806-3-git-send-email-artagnon@gmail.com>
 <20120110183857.GC22184@burratino>
 <CALkWK0k=44znLr2oYSx61Mk=qdAurona0f0H4i4=YXNSAeQhHQ@mail.gmail.com>
 <CALkWK0=bEPPv4rtPrMrQnk3MK=JY4-wwAByWPmzg86NBm_56iQ@mail.gmail.com>
 <20120111050404.GA13507@burratino>
 <CALkWK0kJpEXvBMV=D7h91sz7U2sLvXdW1UzomW0kG2bbM+byYA@mail.gmail.com>
 <CALkWK0muXXKu37_qQ8E+LEZiCxebWvWghkc8QjyfdBazjLOstw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 11 06:45:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rkqzg-0005q5-6b
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 06:45:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752694Ab2AKFo7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 00:44:59 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:60186 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146Ab2AKFo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 00:44:58 -0500
Received: by ggdk6 with SMTP id k6so166026ggd.19
        for <git@vger.kernel.org>; Tue, 10 Jan 2012 21:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=d/idI+yMEzYesKNb9hSv7TCNQrMCn1GbPG31hVTzr4c=;
        b=ecQyemfH1+xBkzemuZ6A702oYIG94mVqwX3431bc+Sr7p6qMoYWMF6r/t2BIokwVRa
         ci1wh6hKKt1wBdQHZMpbVwSTuZkD+zZeLU+VMr9HSyQkCVSNACVCVMLt+2u2g3++Yqn8
         //9GGQzB7DRJ/1VRRa9vXj/nbK9q8qQJKf63w=
Received: by 10.100.244.37 with SMTP id r37mr9615903anh.11.1326260697977;
        Tue, 10 Jan 2012 21:44:57 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id i50sm691877yhk.11.2012.01.10.21.44.56
        (version=SSLv3 cipher=OTHER);
        Tue, 10 Jan 2012 21:44:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALkWK0muXXKu37_qQ8E+LEZiCxebWvWghkc8QjyfdBazjLOstw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188333>

Ramkumar Ramachandra wrote:

> Hi Jonathan,
>
> I wrote a new commit message for this patch.  Perhaps it can help clarify?

Thanks.

>   revert: decouple sequencer actions from commands
>
>   Currently, we have two actions "pick" and "revert" that directly
>   correspond to the action of the commands 'git cherry-pick' and 'git
>   revert' respectively.

Well, let's start here.  The two insns "pick" and "revert" and the
ability to mix them doesn't have much to do with the picture, does it?

I think the actual problem being solved is that insn types, as described
by the replay_action enum, are being abused to refer to top-level git
commands "revert" and "cherry-pick".  The sequencer isn't supposed to
care which top-level git command called it, except in some messages, so
we'd certainly like to stop pretending that has something to do with
insn types.

Based on what you've said, correcting this cleanly is complicated in
some places by the inconvenient fact that the sequencer _does_ care
which top-level git command called it.  (I haven't checked this; I'm
just taking it on faith from you.)  If we want to let other git
commands (like "git rebase" or "git sequence") call into the
sequencer, that sounds like a way bigger problem than any conflict of
terminology.
