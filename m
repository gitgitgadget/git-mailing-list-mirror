Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 135F820248
	for <e@80x24.org>; Tue, 16 Apr 2019 19:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbfDPT53 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 16 Apr 2019 15:57:29 -0400
Received: from relay02-outbound-protection.hex2013.com ([195.34.83.221]:52558
        "EHLO relay02-outbound-protection.hex2013.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727136AbfDPT53 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 16 Apr 2019 15:57:29 -0400
Received: from DOX13BE04.hex2013.com (unknown [128.127.71.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay02-outbound-protection.hex2013.com (Postfix) with ESMTPS id 09C8C6318E;
        Tue, 16 Apr 2019 21:57:25 +0200 (CEST)
Received: from DOX13BE05.hex2013.com (fc9a:3ec4:e134:1338::23) by
 DOX13BE04.hex2013.com (fc9a:3ec4:e134:1338::22) with Microsoft SMTP Server
 (TLS) id 15.0.1473.3; Tue, 16 Apr 2019 21:57:25 +0200
Received: from DOX13BE05.hex2013.com ([fe80::757c:305c:4234:5820]) by
 DOX13BE05.hex2013.com ([fe80::757c:305c:4234:5820%18]) with mapi id
 15.00.1473.003; Tue, 16 Apr 2019 21:57:25 +0200
From:   Christian Vetter <christian@rasenplanscher.info>
To:     Thomas Gummerer <t.gummerer@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [BUG] git stash --keep-index undeletes file
Thread-Topic: [BUG] git stash --keep-index undeletes file
Thread-Index: AQHU9H604QsspfATS0uYjRCPVAT7YKY+/2IAgAAxjQ0=
Date:   Tue, 16 Apr 2019 19:57:25 +0000
Message-ID: <1555444649793.14863@rasenplanscher.info>
References: <1555437849815.60450@rasenplanscher.info>,<20190416184816.GU16414@hank.intra.tgummerer.com>
In-Reply-To: <20190416184816.GU16414@hank.intra.tgummerer.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [128.127.69.93]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you, Thomas!

Now that you explained this, I do understand the behaviour, and agree that it is correct.
While this seems to be clear with a deeper understanding of git than I have,
it might be a good idea to specifically point this out in the docs in the context of `--keep-index`.
That would have helped me.

This does, however, bring me back to a related issue by which I stumbled across this:
If, in the given scenario, I run `git stash apply`, the file is not removed. `git status` still outputs this:
> On branch master
> Changes to be committed:
>   (use "git reset HEAD <file>..." to unstage)
>
>         deleted:    file
>
> Untracked files:
>   (use "git add <file>..." to include in what will be committed)
>
>         file

Can you explain that behaviour as well?
The way I understand it, `git stash push --keep-index; git stash apply` should result in zero change to the output of `git status`.
What am I not getting?


________________________________________
From: Thomas Gummerer <t.gummerer@gmail.com>
Sent: Tuesday, April 16, 2019 20:48
To: Christian Vetter
Cc: git@vger.kernel.org
Subject: Re: [BUG] git stash --keep-index undeletes file

On 04/16, Christian Vetter wrote:
> Steps to reproduce
> + mkdir git-stash-test
> + cd git-stash-test
> + git init
> + touch file
> + git add file
> + git commit -m init
> + git rm file
> + git stash push --keep-index
>
>
> Result:
> `git status` gives this output:
> > On branch master
> > Changes to be committed:
> >   (use "git reset HEAD <file>..." to unstage)
> >
> >         deleted:    file
> >
> > Untracked files:
> >   (use "git add <file>..." to include in what will be committed)
> >
> >         file

I think this is the correct result.  --keep-index keeps the changes
that are in the index, in this example that 'file' is deleted, but
restores the working tree to 'HEAD', where 'file' existed.  It's now
showing up as untracked because Git doesn't know about it.

Similarly if you just did 'git stash push' without --keep-index,
'file' would be restored in your working tree, but 'git status' would
report the working tree as clean because it would also be restored in
the index.

> Expected:
> `git status` gives this output:
> > On branch master
> > Changes to be committed:
> >   (use "git reset HEAD <file>..." to unstage)
> >
> >         deleted:    file

This is what you get before 'git stash push --keep-index'.  Do you
think the documentation on '--keep-index' is unclear, and could be
improved?  Or why did you think that this is the correct output?

> Verified on:
> + Windows 10, git version 2.21.0.windows.1
> + Ubuntu 14.04, git version 2.21.0
