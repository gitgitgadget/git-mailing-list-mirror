X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Avoid accessing a slow working copy during diffcore operations.
Date: Thu, 14 Dec 2006 15:49:38 +0100
Message-ID: <81b0412b0612140649i71643aaar847460ca9e4cea48@mail.gmail.com>
References: <20061214111557.GA24297@spearce.org>
	 <81b0412b0612140557u225ca00du5b15823d05fda4b9@mail.gmail.com>
	 <Pine.LNX.4.63.0612141511110.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 14:49:49 +0000 (UTC)
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hlEWukUBGvlKEGzMc3dQ5io0DanL5Zn562vPwPhMyoVNY61c6bcSCwoJ6k1Bl9R7IweNNjUM2EkTYqYI9EbQeu3L0rvJviOCTvgVt7fS0sdLd/DTKdupt0ejyxIxlLK/achX6KwVTC+XSB0Kea45gpmFspVUzjuo+Y19G0pTavI=
In-Reply-To: <Pine.LNX.4.63.0612141511110.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34343>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Guru5-0007FB-Mr for gcvg-git@gmane.org; Thu, 14 Dec
 2006 15:49:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932766AbWLNOtk (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 09:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932774AbWLNOtk
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 09:49:40 -0500
Received: from an-out-0708.google.com ([209.85.132.240]:1218 "EHLO
 an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S932766AbWLNOtj (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec
 2006 09:49:39 -0500
Received: by an-out-0708.google.com with SMTP id b33so159161ana for
 <git@vger.kernel.org>; Thu, 14 Dec 2006 06:49:38 -0800 (PST)
Received: by 10.78.166.7 with SMTP id o7mr776194hue.1166107778248; Thu, 14
 Dec 2006 06:49:38 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Thu, 14 Dec 2006 06:49:38 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

On 12/14/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > If Git is compiled with NO_FAST_WORKING_DIRECTORY set then we will
> > > avoid looking at the working directory when the blob in question
> > > is available within a packfile and the caller doesn't need the data
> > > unpacked into a temporary file.
> >
> > Why can't it be useful in generic code? What are the downsides?
>
> It is usually cheaper to just read the file, especially if it is still
> cached, because the alternative means unpacking the loose object, or
> worse, unpacking the packed object _along_ with the objects in its delta
> chain.

But you have to read less, and even that could be in cache as well
and unpacking in userspace could be faster than open/write temporary/
read temporary/close/unlink temporary file on a normal system

> Not every OS sucks cache-wise, and you should not make others suffer for
> Redmond's shortcomings.

I'm just do not understand why avoiding temporary file wouldn't help
