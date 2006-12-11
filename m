X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [RFC \ WISH] Add -o option to git-rev-list
Date: Mon, 11 Dec 2006 13:52:39 +0100
Message-ID: <e5bfff550612110452t5bb18517yc0cf8278d4d9948c@mail.gmail.com>
References: <e5bfff550612100338ye2ca2a0u1c8f29bbc59c5431@mail.gmail.com>
	 <Pine.LNX.4.64.0612101439540.12500@woody.osdl.org>
	 <e5bfff550612101615u5f588513n499e3b88ce14a6f6@mail.gmail.com>
	 <200612111026.23656.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 11 Dec 2006 12:52:53 +0000 (UTC)
Cc: "Linus Torvalds" <torvalds@osdl.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <junkio@cox.net>,
	"Alex Riesen" <raa.lkml@gmail.com>,
	"Shawn Pearce" <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XIpFQJkEbI2CIek6lolJwz+TtHPZK6j4cPR7UlcIq9+Ch63e/C9i1yvRrf5zGFkTrm0XEFgPvefuGBZwGRLcf+IZgpTC+/v2ppJigxVf/VGNPteK1I+zQoQLaCUmr56W0L1J5LCAZzesmWnQo/FOdJRsSN3ENyjiWotlT74qPDc=
In-Reply-To: <200612111026.23656.Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33998>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtkeI-00062i-S8 for gcvg-git@gmane.org; Mon, 11 Dec
 2006 13:52:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762887AbWLKMwp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 07:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762886AbWLKMwp
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 07:52:45 -0500
Received: from py-out-1112.google.com ([64.233.166.179]:29890 "EHLO
 py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1762887AbWLKMwo (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec
 2006 07:52:44 -0500
Received: by py-out-1112.google.com with SMTP id a29so909427pyi for
 <git@vger.kernel.org>; Mon, 11 Dec 2006 04:52:44 -0800 (PST)
Received: by 10.35.9.15 with SMTP id m15mr9983776pyi.1165841564345; Mon, 11
 Dec 2006 04:52:44 -0800 (PST)
Received: by 10.35.93.11 with HTTP; Mon, 11 Dec 2006 04:52:39 -0800 (PST)
To: "Josef Weidendorfer" <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org

On 12/11/06, Josef Weidendorfer <Josef.Weidendorfer@gmx.de> wrote:
> On Monday 11 December 2006 01:15, Marco Costalba wrote:
> >               guiUpdateTimer.start(100, true);
>
> What is the result with "guiUpdateTimer.start(0, true);" ?
> There is no need to put in any time interval at all, because
> the timeout is a normal event which will be queued in the GUI
> event queue.
>
> If there were X events in the mean time, they are queued and handled
> before your timeOut function is called again. So the GUI will be
> responsive, even if you have a 0 ms timer.
>

IOW you suggest to use a brute force polling of the pipe.

I'will try this, just to test the pipe, not the application because I
would really need to read data in big chunks.

Data read from pipe/file or something else is read in an array (char*
[]) and do not touched anymore, no more copies are made. For every
read a new array is allocated on the heap.

With chunks of 64KB, because each rev descriptions is about few
hundered bytes only few revs (about 1% with current linux tree) fall
at the boundary of the chunk, half in one and the rest in the next.
This boundary revs require a special handling that at the end involves
an additional copy.

If I get from the pipe very small data (few KB) probably it would be
better to read always in a local array of fixed size and then copy to
final destination in memory. But this imply that all the data work
copy is duplicated: instead of 30MB of data we'll going to move 60MB
(linux tree)

With big chunks of 64KB only about 1% of data (revs that fall at the
array boundary) is duplicated.

