From: Dmitry Ivankov <divanorama@gmail.com>
Subject: Re: long fast-import errors out "failed to apply delta"
Date: Sun, 24 Jul 2011 02:34:20 +0600
Message-ID: <CA+gfSn8C-nB2hSSRTqSu1N1Z-b8ctRsVmUGAjLXTW0du_W3EQw@mail.gmail.com>
References: <CA+gfSn8jjptyv10iVimmfXpf6QHrR_3UpkRdd+Dv1M=KgORtGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 23 22:34:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qkiu3-0002Wc-4B
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jul 2011 22:34:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261Ab1GWUeX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jul 2011 16:34:23 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:62570 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228Ab1GWUeV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2011 16:34:21 -0400
Received: by qyk9 with SMTP id 9so1844749qyk.19
        for <git@vger.kernel.org>; Sat, 23 Jul 2011 13:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=R8QVxMJlcwlGja+0zATMRPghdotDWs6vnwFDUPNPacM=;
        b=Vhg8QEOsqDEE4QkIMifEmDWukVqTAHIobGyRVf5Vx73SBFvtdcQFfoV9ZxlsuStryB
         0614EQy8JcApD5SW6GA2GSMkOxToXnbHHhEOnoaKu/upZcHQQfTsB2+IBVKnagMLKyoO
         JOYT2KO24avn122lTcpM+UMlwCyJLUIj0uBHw=
Received: by 10.229.185.211 with SMTP id cp19mr2218834qcb.102.1311453260711;
 Sat, 23 Jul 2011 13:34:20 -0700 (PDT)
Received: by 10.229.63.232 with HTTP; Sat, 23 Jul 2011 13:34:20 -0700 (PDT)
In-Reply-To: <CA+gfSn8jjptyv10iVimmfXpf6QHrR_3UpkRdd+Dv1M=KgORtGQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177704>

+people contributed to the related parts of fast-import.c

Hi!

I did more tests and investigations. (one can safely jump over next 2
paragraphs)
There is a problem in fast-import, triggered on long svn-fe produced
imports (10k..80k commits depending on the svn repo history, in my
tests at least). fast-imports sometimes writes off a tree object with
wrong sha1. It goes silent unless it tries to read these objects for
later revisions (via ls command) and "crashes", or unless fsck is run
to find sha1 mismatches.

This seems to be a old bug. Due to the content of my fast-import
streams, I need cat-blob and ls commands (once the import stream is
sniffed these can be ignored) and more importantly 334fba656b50c9..
"Teach fast-import to import subtrees named by tree id" 30 Jun 2010
for  "M 040000 <tree id> pathname" commands. The earliest git version
I've tested so far is v1.6.0.6-7-g3d1d81e Jan 2009 + dummy cat-blob
and ls + 334fba656b50c9..

So, how do I currently reproduce it.
Import gcc svn repository with svn-fe up to r15507 - fine. (1.9G
fast-import stream, 3min to import, 1min to fsck)
Import up to r15508 - fine, but fsck finds a sha1 mismatch in a tree object.
Strip r15508 to a three commands:

..commit header..
ls :14842 branches/gcc3/gcc/config
M 040000 fbc83f80e9516c831918dff149058cba38a2e5f1 tags/egcs_ss_970917/gcc/config
ls :15459 trunk/gcc/config/alpha
M 040000 9ffe84c346eec93b523d95ce642b54d54d23109c
tags/egcs_ss_970917/gcc/config/alpha
ls "tags/egcs_ss_970917/gcc/config/alpha"
D tags/egcs_ss_970917/gcc/config/alpha/vms-tramp.asm

So here we set a directory with one old tree, then set it's child with
another old tree, and then delete a file in the child. The broken tree
is the resulting tree for that child. sha1 written to the pack matches
the intent (the second M + D) while the content is wrong (matches the
first M/subdir + D) - the second M command is partially lost.

If a checkpoint command is added before the last commit there is no
sha1 mismatch. I haven't yet found a small fast-import stream with
this bug, but it is a definetely a logic bug somewhere in fast-import.
I randomly changed pool sizes (didn't touch packfile settings yet),
run valgrind, slightly modified the stream many times, tested a bunch
of different git versions on two machines - the bug is stable.

Any ideas? How is it possible at all that the tree's sha1 and content
diverge, and moreover this is unnoticed by fast-import and a broken
packfile is produced?

On Thu, Jul 7, 2011 at 4:47 PM, Dmitry Ivankov <divanorama@gmail.com> wrote:
> Hi,
>
> I'm getting a strange error from git-fast-import.
> Tested on v1.7.5 and v1.7.6 on two machines (gentoo amd64 8gb ram,
> 3-core amd cpu; gentoo x86 2gb ram, 1-core intel mobile cpu).
> The crash is stable - same message, instruction and deepest function
> (patch_delta) parameters contents.
>
> $ git fast-import --quiet < big_dump
> fatal: failed to apply delta
> fast-import: dumping crash report to fast_import_crash_7700
[skipped the details]
