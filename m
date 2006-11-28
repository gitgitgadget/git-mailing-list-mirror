X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Mozilla, git and Windows
Date: Mon, 27 Nov 2006 20:35:05 -0500
Message-ID: <9e4733910611271735y14bed29bk70ae67b5d28eb055@mail.gmail.com>
References: <9e4733910611270728p36e58e08w6cc7a2989b7843ce@mail.gmail.com>
	 <456B057E.4000904@shadowen.org>
	 <9e4733910611270813g4ff982b0tbe6b57d1d49ca9f7@mail.gmail.com>
	 <20061127221338.GP7201@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 28 Nov 2006 01:35:23 +0000 (UTC)
Cc: "Andy Whitcroft" <apw@shadowen.org>,
	"Git Mailing List" <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JhOsly2htDGpv9aLb81w1y65o9f9oYGj0NOya0To6JwRLP2n7TNulUm9yVLP0eu6y1+2BUHpzvdtOfHdIhuUcGvIhBDIbyolTO/IdzLLTkSOKYck/ZZy5UkWOPtC+m6xGpwhne7CGotFvxNun3Md0iArIfgT6IpHYCt3AMQJr/I=
In-Reply-To: <20061127221338.GP7201@pasky.or.cz>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32477>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GorsO-0007lf-Ji for gcvg-git@gmane.org; Tue, 28 Nov
 2006 02:35:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933397AbWK1BfJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 20:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933889AbWK1BfJ
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 20:35:09 -0500
Received: from wr-out-0506.google.com ([64.233.184.225]:14302 "EHLO
 wr-out-0506.google.com") by vger.kernel.org with ESMTP id S933397AbWK1BfG
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 20:35:06 -0500
Received: by wr-out-0506.google.com with SMTP id i7so450719wra for
 <git@vger.kernel.org>; Mon, 27 Nov 2006 17:35:05 -0800 (PST)
Received: by 10.35.69.11 with SMTP id w11mr465354pyk.1164677705507; Mon, 27
 Nov 2006 17:35:05 -0800 (PST)
Received: by 10.35.72.13 with HTTP; Mon, 27 Nov 2006 17:35:05 -0800 (PST)
To: "Petr Baudis" <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

On 11/27/06, Petr Baudis <pasky@suse.cz> wrote:
> On Mon, Nov 27, 2006 at 05:13:10PM CET, Jon Smirl wrote:
> > The SVN version of the Mozilla repository is about 3GB. It takes
> > around a week of CPU time for svnimport to process it.
>
> Is there a reason why a SVN importer would _have_ to take _longer_ than
> a CVS importer? I'd expect the opposite from an optimized importer since
> you don't have to guess the changesets...

These import programs take forever because they fork off git, SVN or
CVS millions of times. It really does take a week to fork a CVS
process that many times. It's not the application code that is taking
a week to run, it is the millions of forks.

As was mentioned in the thread about doing CVS to git import, the
trick is to write your own CVS file parser, parse the file once (not
once for each revision) and output all of the revisions to the git
database in a single pass. When code is structured that way I can
import the whole Mozilla repository into git in two hours. The
fast-import back end also works with out forking, it just listens to
command and stdin and acts on them, all of the commands are implement
in a single binary.

The speed of fork in Linux is fine for most purposes, but it is not
fine if you are going to fork off good sized apps several million
times. When I measured those forks in oprofile, 60% of the CPU was
being consumed by the kernel.

-- 
Jon Smirl
