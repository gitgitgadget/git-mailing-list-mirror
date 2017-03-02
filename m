Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68D141F5FB
	for <e@80x24.org>; Thu,  2 Mar 2017 20:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752012AbdCBUEF (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 15:04:05 -0500
Received: from avasout06.plus.net ([212.159.14.18]:39906 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751998AbdCBUEB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 15:04:01 -0500
Received: from deneb ([80.229.24.9])
        by avasout06 with smtp
        id r83w1u0040BmcFC0183xxx; Thu, 02 Mar 2017 20:03:59 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=QoEu5R6d c=1 sm=1 tr=0
 a=E/9URZZQ5L3bK/voZ0g0HQ==:117 a=E/9URZZQ5L3bK/voZ0g0HQ==:17
 a=kj9zAlcOel0A:10 a=6Iz7jQTuP9IA:10 a=-An2I_7KAAAA:8 a=gs38GCwbxR7ZEJLIhhoA:9
 a=CjuIK1q_8ugA:10 a=Sq34B_EcNBM9_nrAYB9S:22
Received: from mac by deneb with local (Exim 4.84_2)
        (envelope-from <mac@mcrowe.com>)
        id 1cjWxA-0000Dc-Eh; Thu, 02 Mar 2017 20:03:56 +0000
Date:   Thu, 2 Mar 2017 20:03:56 +0000
From:   Mike Crowe <mac@mcrowe.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     tboegi@web.de, git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 1/1] git diff --quiet exits with 1 on clean tree with
 CRLF conversions
Message-ID: <20170302200356.GA31318@mcrowe.com>
References: <xmqqshmyhtnu.fsf@gitster.mtv.corp.google.com>
 <20170301170444.14274-1-tboegi@web.de>
 <xmqqr32gg0o6.fsf@gitster.mtv.corp.google.com>
 <xmqqa894fyst.fsf@gitster.mtv.corp.google.com>
 <20170302142056.GB7821@mcrowe.com>
 <xmqqbmtjcyug.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbmtjcyug.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thursday 02 March 2017 at 10:33:59 -0800, Junio C Hamano wrote:
> Mike Crowe <mac@mcrowe.com> writes:
> 
> > All the solutions presented so far do cause a small change in behaviour
> > when using git diff --quiet: they may now cause warning messages like:
> >
> >  warning: CRLF will be replaced by LF in crlf.txt.
> >  The file will have its original line endings in your working directory.
> 
> That is actually a good thing, I think.  As the test modifies a file
> that originally has "Hello\r\nWorld\r\n" in it to this:
> 
> >> +test_expect_success 'quiet diff works on file with line-ending change that has no effect on repository' '
> >> +	printf "Hello\r\nWorld\n" >crlf.txt &&
> 
> If you did "git add" at this point, you would get the same warning,
> because the lack of CR on the second line could well be a mistake
> you may want to notice and fix before going forward.  Otherwise
> you'd be losing information that _might_ matter to you (i.e. the
> fact that the first line had CRLF while the second had LF) and it is
> the whole point of safe_crlf setting.

Well, there is an argument that it's not very "--quiet" to emit this
message. Especially when it didn't used to come out. However, I can
understand that the message is useful if the line endings have changed
despite this.

However, I can make the message appear from "git diff --quiet" even if the
line endings have not changed. I merely need to touch a file where the line
endings do not match the canonical representation in the repository first.
Upon subsequent invocations of "git diff --quiet" the message does not come
out. (Note that in this may not be reproducible in a script without
sleeps.)

Perhaps this interactive log will make things clearer:

 $ git init
 Initialized empty Git repository in /tmp/test/.git/
 $ echo "* text=auto" >.gitattributes
 $ printf "Hello\r\nWorld\r\n" >crlf.txt
 $ git add .gitattributes crlf.txt
 warning: CRLF will be replaced by LF in crlf.txt.
 The file will have its original line endings in your working directory.

The message was expected and useful there.

 $ git commit -m "initial"
 [master (root-commit) c3fb5a5] initial
 2 files changed, 3 insertions(+)
 create mode 100644 .gitattributes
 create mode 100644 crlf.txt
 $ git diff --quiet
 $ touch crlf.txt
 $ git diff --quiet
 warning: CRLF will be replaced by LF in crlf.txt.
 The file will have its original line endings in your working directory.

I didn't change the file - I just touched it. Why did the message come out here?

 $ git diff --quiet

But then it didn't here. Which is correct?

 $ printf "Hello\r\nWorld\n" >crlf.txt
 $ git diff --quiet
 warning: CRLF will be replaced by LF in crlf.txt.
 The file will have its original line endings in your working directory.
 $ git diff --quiet
 warning: CRLF will be replaced by LF in crlf.txt.
 The file will have its original line endings in your working directory.

If the line endings have genuinely changed then the message comes out every
time...

 $ git add crlf.txt
 warning: CRLF will be replaced by LF in crlf.txt.
 The file will have its original line endings in your working directory.

...until the file is added to the index. That's probably the right thing to
do.

 $ git diff --quiet
 $ touch crlf.txt
 $ git diff --quiet
 warning: CRLF will be replaced by LF in crlf.txt.
 The file will have its original line endings in your working directory.
 $ git diff --quiet

But once the file has been added the previous behaviour of only emitting
the message on the first time after the touch occurs.

 $ printf "Hello\r\nWorld\n" >crlf.txt
 $ git diff --quiet
 warning: CRLF will be replaced by LF in crlf.txt.
 The file will have its original line endings in your working directory.
 $ git diff --quiet
 $ printf "Hello\r\nWorld\r\n" >crlf.txt
 $ git diff --quiet
 warning: CRLF will be replaced by LF in crlf.txt.
 The file will have its original line endings in your working directory.
 $ git diff --quiet
 warning: CRLF will be replaced by LF in crlf.txt.
 The file will have its original line endings in your working directory.

Hopefully that makes things a bit clearer.

Mike.
