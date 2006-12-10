X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [RFC \ WISH] Add -o option to git-rev-list
Date: Sun, 10 Dec 2006 23:35:33 +0100
Message-ID: <e5bfff550612101435o6bc938acmac28ad6adf0c8844@mail.gmail.com>
References: <e5bfff550612100338ye2ca2a0u1c8f29bbc59c5431@mail.gmail.com>
	 <Pine.LNX.4.64.0612101009040.12500@woody.osdl.org>
	 <e5bfff550612101151r5e77ddc0w8f61f36fc1f2920e@mail.gmail.com>
	 <Pine.LNX.4.64.0612101159530.12500@woody.osdl.org>
	 <Pine.LNX.4.64.0612101213520.12500@woody.osdl.org>
	 <e5bfff550612101405h507cc877k87491264d11b0aa8@mail.gmail.com>
	 <Pine.LNX.4.64.0612101410220.12500@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 10 Dec 2006 22:37:45 +0000 (UTC)
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <junkio@cox.net>,
	"Alex Riesen" <raa.lkml@gmail.com>,
	"Shawn Pearce" <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WfcyDI9euwtSxQ/WXIaqabQQJ9f+7VstfCBVmR8ql95tgmYllew+J/MeKcEuXyZM7AjqjQjRNGwqLNwiW+1vQ7nwS7Aii4YJidmuia70I/B2W0LQJQt7kOgZpuZVopXJ/7UCAuDJ/Ttotu9A6T1D6Bin6b7XAro2bFarNRHr1NY=
In-Reply-To: <Pine.LNX.4.64.0612101410220.12500@woody.osdl.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33945>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtXIf-0003Bb-IC for gcvg-git@gmane.org; Sun, 10 Dec
 2006 23:37:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760327AbWLJWfi (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 17:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760449AbWLJWfh
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 17:35:37 -0500
Received: from py-out-1112.google.com ([64.233.166.181]:38468 "EHLO
 py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1760443AbWLJWfe (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec
 2006 17:35:34 -0500
Received: by py-out-1112.google.com with SMTP id a29so798546pyi for
 <git@vger.kernel.org>; Sun, 10 Dec 2006 14:35:33 -0800 (PST)
Received: by 10.35.45.1 with SMTP id x1mr6788145pyj.1165790133399; Sun, 10
 Dec 2006 14:35:33 -0800 (PST)
Received: by 10.35.93.11 with HTTP; Sun, 10 Dec 2006 14:35:33 -0800 (PST)
To: "Linus Torvalds" <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On 12/10/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Sun, 10 Dec 2006, Marco Costalba wrote:
> >
> > Ok. Perhaps I'm doing something wrong but the following code it's
> > always 10% slower then the temporary file one (4.7s against 4.3s for
> > linux tree)
>
> Why do you seem to be doing a "new" on every iteration inside the loop?
>

Becuase it's there where I store the file content.

Function parseSingleBuffer(ba) does only the indexing. But the file
content is stored in QByteArray objects (little wrappers around a
const char* []). So the fread() in the byte array object is the _only_
data copy operation in whole qgit.


> Also, why do you have that strange FILE_BLOCK_SIZE thing, and in
> particular the "if (len < FILE_BLOCK_SIZE)" check? One thing that pipes vs
> files do is the blocking factor.
>
> Especially with older kernels, I _guarantee_ you that you'll only ever get
> 4kB at a time, so because of that "if (len < 64kB) break" thing, the only
> thing you're doing is to make sure things suck performance-wise, and you
> won't be reading the rest of the data until 100ms later.
>

I consistently have len == 65536 bytes until the last fread() where
it's less. See below run against qgit own repository with 'len'
printed inside while loop.

$ ./qgit
Found GNU source-highlight 2.5
len is <65536>
len is <65536>
len is <65536>
len is <65536>
len is <65536>
len is <65536>
len is <65536>
len is <54479>
bash-3.1$

> IOW, your code is written for a file, and makes no sense there either
> (checking "feof(file)" is wrong, since you may well have hit the EOF
> *at*that*time*, but the file may GROW since you are doing it all in the
> background, so you can't rely on feof() anyway).
>

Yes. feof() it's difficult to handle correctly.

> For a pipe, what you should do is to make sure it's in nonblocking mode,
> and just continue reading until it gets no more. And instead of using a
> timeout, you should use poll() or something to get notified when there is
> more data.
>

How can open in nonblocking mode with popen() ?

FILE *popen(const char *command, const char *type);


> IOW, the reason it's slow is because you're doing the wrong thing.
>

That's for sure :-)  My problem is to guess what's is wrong.


