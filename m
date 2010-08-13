From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: BUG: git log: fatal: internal error in diff-resolve-rename-copy
Date: Fri, 13 Aug 2010 13:38:01 +0000
Message-ID: <AANLkTikGE-m=Tht2tNbP5=Bej78284_ouLBfdk_aEDSO@mail.gmail.com>
References: <AANLkTikPhWgeeLBV3dbLZ5UM3UDmkOmpqrmwqPmGfn7Z@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Bo Yang <struggleyb.nku@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Constantine Plotnikov <constantine.plotnikov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 13 15:38:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjuSY-0001ut-Kk
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 15:38:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761597Ab0HMNiF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Aug 2010 09:38:05 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:64223 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755198Ab0HMNiC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Aug 2010 09:38:02 -0400
Received: by yxg6 with SMTP id 6so951868yxg.19
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 06:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=r2fQ/ctqbpknMEEOwfnmdCFeiDYZvHAeu8dJnB/dckw=;
        b=w710ckSqlFEN3y/pvMdUYpNh2SPAr9yiOb2iWo7U1KJVMmlVVS3QdgZfDOF2CyVWC+
         Ahhp/Li/dL8ZbNTYOxIr0D5cS6FTZZFQ1L7pE4I5qcvz1Nm48sXGfUaiCFCfr6TcKzaj
         JHoTxQleZbznP2szFFAhkBSGsZ8Y9YS1CwhdM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=JG7ijgT0N5fQ/yIEualdajQS8Sc5ubMhLWg8gkydA3UtCH16Mb7j2yqO5/ca3auFKU
         MudAvVfF7HJTyWL1r6Bvz2wPTq6pAbc8YZTmqLHBxb2InxMRJoFL8rWLqj0NgJvlA/j1
         KFEBleCIRnRlOJ+V+nhd9riEadTYswi4s+Yvg=
Received: by 10.150.54.16 with SMTP id c16mr662843yba.318.1281706681458; Fri,
 13 Aug 2010 06:38:01 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Fri, 13 Aug 2010 06:38:01 -0700 (PDT)
In-Reply-To: <AANLkTikPhWgeeLBV3dbLZ5UM3UDmkOmpqrmwqPmGfn7Z@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153472>

On Fri, Aug 13, 2010 at 11:25, Constantine Plotnikov
<constantine.plotnikov@gmail.com> wrote:
> Somewhere between the git 1.7.0.2 and the git 1.7.2.0 the rename
> detection started to fail with fatal error on some files in our
> repository. The bug could be seen on the public IntelliJ IDEA
> repository (about 760M in size), but our users have reported it as
> well.

>From a bisect:

    1da6175d438a9849db07a68326ee05f291510074 is the first bad commit
    commit 1da6175d438a9849db07a68326ee05f291510074
    Author: Bo Yang <struggleyb.nku@gmail.com>
    Date:   Thu May 6 21:52:28 2010 -0700

        Make diffcore_std only can run once before a diff_flush

        When file renames/copies detection is turned on, the
        second diffcore_std will degrade a 'C' pair to a 'R' pair.

        And this may happen when we run 'git log --follow' with
        hard copies finding. That is, the try_to_follow_renames()
        will run diffcore_std to find the copies, and then
        'git log' will issue another diffcore_std, which will reduce
        'src->rename_used' and recognize this copy as a rename.
        This is not what we want.

        So, I think we really don't need to run diffcore_std more
        than one time.

        Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
        Signed-off-by: Junio C Hamano <gitster@pobox.com>

Bisect script:

    #!/bin/sh

    cd ~/g/git
    make clean
    make -j 10 CC=clang CFLAGS=-O0

    ./git --git-dir=/tmp/idea/.git log -M --follow --name-only --
platform/lang-api/src/com/intellij/lang/documentation/CompositeDocumentationProvider.java
> /dev/null
    ret=$?
    test $ret -gt 127 && ret=127
    exit $ret
