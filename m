X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Fast access git-rev-list output: some OS knowledge required
Date: Thu, 7 Dec 2006 07:46:05 +0100
Message-ID: <e5bfff550612062246m194ce235nf97149f8b041f486@mail.gmail.com>
References: <e5bfff550612061124jcd0d94em47793710866776e7@mail.gmail.com>
	 <20061206192800.GC20320@spearce.org>
	 <Pine.LNX.4.63.0612070025450.28348@wbgn013.biozentrum.uni-wuerzburg.de>
	 <Pine.LNX.4.64.0612061642440.3542@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 7 Dec 2006 06:46:25 +0000 (UTC)
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Shawn Pearce" <spearce@spearce.org>,
	"Git Mailing List" <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OWbac/ETgePWY5kq9+C1GecrsPasF7XWzczZAfnkmg1EFD4uradbWJimMvwzSVS/z7N9z0aNeQ06yBu0OLY83aFzYv33IpEFhdnR/ilkoVAMQ5IdOZcWaoTJNliBqw7jDthm0OX1U21QkRcHHr0MRVCSbUpyWWFTT+FAmtLQW+A=
In-Reply-To: <Pine.LNX.4.64.0612061642440.3542@woody.osdl.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33554>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsD1Q-0001FK-4e for gcvg-git@gmane.org; Thu, 07 Dec
 2006 07:46:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031728AbWLGGqK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 01:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031732AbWLGGqK
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 01:46:10 -0500
Received: from py-out-1112.google.com ([64.233.166.183]:18303 "EHLO
 py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1031728AbWLGGqG (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec
 2006 01:46:06 -0500
Received: by py-out-1112.google.com with SMTP id a29so212826pyi for
 <git@vger.kernel.org>; Wed, 06 Dec 2006 22:46:05 -0800 (PST)
Received: by 10.35.97.17 with SMTP id z17mr19505pyl.1165473965862; Wed, 06
 Dec 2006 22:46:05 -0800 (PST)
Received: by 10.35.93.11 with HTTP; Wed, 6 Dec 2006 22:46:05 -0800 (PST)
To: "Linus Torvalds" <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On 12/7/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Thu, 7 Dec 2006, Johannes Schindelin wrote:
> >
> > Because, depending on what you do, the revision machinery is not
> > reentrable. For example, if you filter by filename, the history is
> > rewritten in-memory to simulate a history where just that filename was
> > tracked, and nothing else. These changes are not cleaned up after calling
> > the internal revision machinery.
>
> Well, it really wouldn't be that hard to add a new library interface to
> "reset object state". We could fairly trivially either:
>

So the library approach sounds like the best?

Of course in this case the producer git-rev-list and the receiver use
the same address space.

In the case of a temporary file data is first copied to OS disk cache
buffers and then again to userspace, in qgit address space. But the
real pain is that the temporary file is always flushed to disk after
4-5 seconds from creation, also if under heavy read/write activity.
This is a problem for big repos. I really don't know how to workaround
this useless disk flush.

Finally, what about using some kind of shared memory at run time,
instead of _sharing_ developer libraries ;-) ? is it too messy?

Probably the concurrent reading while writing is possible without
syncro if the reader understands that a sequence of _two_ or more \0
it means the end of current write stream if producer is still running
or the end of data if producer is not running anymore. I use a similar
approach in the 'temporary file' patch where receiver is able to read
while producer writes without explicit synchronization. In that case a
read() of a block smaller then maximum with producer still running is
used as the 'break' condition in the receiver while loop.


