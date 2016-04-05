From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git diff --exit-code does not honour textconv setting
Date: Tue, 5 Apr 2016 16:22:05 +0200
Message-ID: <5703CA0D.2090808@drmicha.warpmail.net>
References: <56EE9B09.6040700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Georg Pichler <georg.pichler@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 05 16:22:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anRs0-0002qn-5m
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 16:22:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753784AbcDEOWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2016 10:22:09 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:50292 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751175AbcDEOWI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Apr 2016 10:22:08 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 2830F21839
	for <git@vger.kernel.org>; Tue,  5 Apr 2016 10:22:07 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Tue, 05 Apr 2016 10:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=1mEdg0qtVE1sgYmNbAhIRi74qK0=; b=Dn/MBj
	Ie78d2d1ngqht7/jrp+n9bZtfHRRemO8ASxL5+EGmg8nH017GpKlTIJqM8NIfZgv
	2EGo/opVkjbvTxD/vhk0GILYREa94+qm/kbbP+YzX2rFFwoFSGGq5F6H6fJl3+g2
	0Ks+ILkq+GjI6qXZ+h5rgpZw+JwwszL0SB4dQ=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=1mEdg0qtVE1sgYm
	NbAhIRi74qK0=; b=NDNArkwyE39SHym/V4K2fdVEAwTk2meiT9qeLurymcXZ6WK
	pg1MFbLK9s0t5QnxOrEb5Mr++yjz42gYcslV3tDMVHw8GVPiplslO8B/L/ZYctXf
	PFOgFphqCAdTcmwstIXkuqum5w0niYlku3CMe9QhX53W21UwJxuuP5O4A1Us=
X-Sasl-enc: 774V8trJuiqhhSeJ1RVsYxI4i93yWNr34xghwVwn2wXh 1459866126
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id 44811C0001D;
	Tue,  5 Apr 2016 10:22:06 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.1
In-Reply-To: <56EE9B09.6040700@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290782>

Georg Pichler venit, vidit, dixit 20.03.2016 13:43:
> Hi,
> 
> I realized that "git diff --exit-code" does not honour textconv settings.
> Maybe this behaviour is desired. It can be partially circumvented by using the "-b" flag if one does not care about whitespace changes.
> To reproduce this, create an empty repository and run the following commands:
> 
> (I was using git version 2.7.3)
> 
> $ git config --add diff.void.textconv test
> $ echo "foo diff=void" >.gitattributes
> $ echo foo >foo
> $ git add . && git commit -m "Init"
> [master (root-commit) 70c39d9] Init
> 2 files changed, 2 insertions(+)
> create mode 100644 .gitattributes
> create mode 100644 foo
> $ echo bar >foo
> $ git status
> On branch master
> Changes not staged for commit:
> (use "git add <file>..." to update what will be committed)
> (use "git checkout -- <file>..." to discard changes in working directory)
> 
> modified: foo
> 
> no changes added to commit (use "git add" and/or "git commit -a")
> $ git diff
> $ git diff --exit-code
> [exits with 1, no output]
> $ git diff --exit-code -b
> [exits with 0, no output]
> 
> The "test" command is used as it does not generate any output on stdout.

"test" is a bit of a red herring here since it will receive commands.
But your example works even with "true" which ignores its commands and
produces no output.

> I would expect "git diff --exit-code" to return with exit code 0. If this is not desired, it should be clearly stated in the man page,
> that "--exit-code" does not honour the textconv setting, except if "-b" is given. Currently this is not clear:
> 
>        --exit-code
>            Make the program exit with codes similar to diff(1). That is, it exits
>            with 1 if there were differences and 0 means no differences.
> 
> Best,
> Georg Pichler

The description doesn't make it clear whether exit-code refers to the
actual diff (foo vs. bar) or to the diff after textconv (empty vs.
empty). In any case, "-b" should not make a difference for your example.


diff_flush() in diff.c has this piece of code:

        /*
         * Report the content-level differences with HAS_CHANGES;
         * diff_addremove/diff_change does not set the bit when
         * DIFF_FROM_CONTENTS is in effect (e.g. with -w).
         */
        if (DIFF_OPT_TST(options, DIFF_FROM_CONTENTS)) {
                if (options->found_changes)
                        DIFF_OPT_SET(options, HAS_CHANGES);
                else
                        DIFF_OPT_CLR(options, HAS_CHANGES);
        }

So it's clear that depending on "-b" (or "-w") or not, it's taking
shortcuts or looking at the textconved diff but I'm not sure where's the
proper place to fix that.

Michael
