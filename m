X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [RFC \ WISH] Add -o option to git-rev-list
Date: Mon, 11 Dec 2006 18:28:46 +0100
Message-ID: <e5bfff550612110928h41e05acah4f835caa3fa6fea5@mail.gmail.com>
References: <e5bfff550612100338ye2ca2a0u1c8f29bbc59c5431@mail.gmail.com>
	 <200612111026.23656.Josef.Weidendorfer@gmx.de>
	 <e5bfff550612110452t5bb18517yc0cf8278d4d9948c@mail.gmail.com>
	 <200612111428.29390.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 11 Dec 2006 17:29:06 +0000 (UTC)
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
        b=ENT6yrBJHBp4roUIqccyW7K1Bq+7/fPx3L1G8tIaj+4l3xpK+wDZvsX8MuPNARRhLUp+Xzgd9B5mDbFtQN4N61+wzQiM+ZLzEQbrNY/oomZtVZuUWfFZTLOljKxbYa5oz0h2WFgVwp4U2q1yw06ATiU5cNqA4lhdZXhSrDqRQBo=
In-Reply-To: <200612111428.29390.Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34019>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtoxP-000680-7c for gcvg-git@gmane.org; Mon, 11 Dec
 2006 18:28:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762953AbWLKR2s (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 12:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762983AbWLKR2s
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 12:28:48 -0500
Received: from nz-out-0506.google.com ([64.233.162.235]:34318 "EHLO
 nz-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with
 ESMTP id S1762953AbWLKR2r (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec
 2006 12:28:47 -0500
Received: by nz-out-0102.google.com with SMTP id s1so829865nze for
 <git@vger.kernel.org>; Mon, 11 Dec 2006 09:28:47 -0800 (PST)
Received: by 10.35.65.17 with SMTP id s17mr10753800pyk.1165858126836; Mon, 11
 Dec 2006 09:28:46 -0800 (PST)
Received: by 10.35.93.11 with HTTP; Mon, 11 Dec 2006 09:28:46 -0800 (PST)
To: "Josef Weidendorfer" <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org

On 12/11/06, Josef Weidendorfer <Josef.Weidendorfer@gmx.de> wrote:
> On Monday 11 December 2006 13:52, Marco Costalba wrote:
> > On 12/11/06, Josef Weidendorfer <Josef.Weidendorfer@gmx.de> wrote:
> > > On Monday 11 December 2006 01:15, Marco Costalba wrote:
> > > >               guiUpdateTimer.start(100, true);
> > >
> > > What is the result with "guiUpdateTimer.start(0, true);" ?
> > ...
> > IOW you suggest to use a brute force polling of the pipe.
>
> Ah, yes. That is probably not what you want.
>
> Why did you introduce the timer at all? What was the problem
> with QProcess and handling its signal "data available" ?
>

I did. Actually the released 1.5.3 version and all the verions before
that do use QProcess, but I experimented an increase in performance
reading the data  on a timer instead of on "data available" signal.
BTW that observation led to all this stuff ;-)

The problem is that the frequency of the signal is very very high
because the producer can write a big amount of data with great speed.
We are talking of a signal "data available" each few ms.

By the way of experimenting with QProcess I have found it's better a
timer when the stream is very very fast, _then_ I have update the
reading code to take _more_ adavntage of the big chunks we were
reading with a low frequency timer and avoid a double copy, but the
increase was _already_ present also with the double copy needed by the
original 'small chunks handling' code activated by "data available"
signal.

If you take a look at released qgit you will see, in dataloader.cpp
the reading slot called on the signal.

