X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [RFC \ WISH] Add -o option to git-rev-list
Date: Mon, 11 Dec 2006 21:28:05 +0100
Message-ID: <200612112128.06485.Josef.Weidendorfer@gmx.de>
References: <e5bfff550612100338ye2ca2a0u1c8f29bbc59c5431@mail.gmail.com> <Pine.LNX.4.64.0612111003140.12500@woody.osdl.org> <e5bfff550612111059g35f1aa2dmdead17a60f5dfca8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 11 Dec 2006 20:28:32 +0000 (UTC)
Cc: "Linus Torvalds" <torvalds@osdl.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <junkio@cox.net>,
	"Alex Riesen" <raa.lkml@gmail.com>,
	"Shawn Pearce" <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #352111
User-Agent: KMail/1.9.5
In-Reply-To: <e5bfff550612111059g35f1aa2dmdead17a60f5dfca8@mail.gmail.com>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34031>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtrlC-0001Jp-2y for gcvg-git@gmane.org; Mon, 11 Dec
 2006 21:28:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1763081AbWLKU2X (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 15:28:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763082AbWLKU2X
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 15:28:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:35279 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1763080AbWLKU2W
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec 2006 15:28:22 -0500
Received: (qmail invoked by alias); 11 Dec 2006 20:28:20 -0000
Received: from p5496B761.dip0.t-ipconnect.de (EHLO noname) [84.150.183.97] by
 mail.gmx.net (mp048) with SMTP; 11 Dec 2006 21:28:20 +0100
To: "Marco Costalba" <mcostalba@gmail.com>
Sender: git-owner@vger.kernel.org

On Monday 11 December 2006 19:59, Marco Costalba wrote:
> On 12/11/06, Linus Torvalds <torvalds@osdl.org> wrote:
> >
> >
> >
> > However, you seem to continually ignore the thing I've asked you to do
> > several times: try with a cold-cache situation.
> 
> Yes. I will test it. I was testing with warm cache also to my
> curiosity about comparing pipes with temporary file reading as data
> exchange facility. So I needed to avoid HD artifacts.

Hi,

I just looked at the QProcess implementation in Qt 3.3.6, as I was
curious.

Qt does a big select() call in the event loop. If there is data
available from the child process, it is reading in chunks of a
maximum of 4096 bytes, with a select() call inbetween to see if
there is still data available. After every read, the read data
is concatenated into the read buffer.

For the slow/cold cache case, this probably is the best *if* the
consumer application can act as fast as possible when data is
sent. Which makes it a good fit to avoid --topo-order and do
some redrawing of the graph yourself if needed. For sure, this
gives the fastest visual appeareance. You could start filling
the list after e.g. 30 revs are read.

Obviously, there is some possibility for improvement _when_ you
know that you want to read in large amounts of data in big
chunks, given that QProcess uses at least two system calls every
4 kB.

A general question: How many context switches are involved in such
a producer/consumer scenario, given that the consumer writes one
line at a time, and the consumer uses poll/select to wait for the
data?
Is there some possibility to make the kernel write-combine single
small producer writes into bigger chunks, which will be delivered
at once (or smaller data only after a small timeout)?

