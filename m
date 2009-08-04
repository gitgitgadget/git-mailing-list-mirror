From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: x86 SHA1: Faster than OpenSSL
Date: Tue, 4 Aug 2009 18:29:42 +0400
Message-ID: <20090804142942.GE10264@dpotapov.dyndns.org>
References: <9e4733910908032007td74ef9fp669d0d958df67c1@mail.gmail.com> <20090804050138.13256.qmail@science.horizon.com> <9e4733910908040556t477dcb66u86a43e12148e3352@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: George Spelvin <linux@horizon.com>, git@vger.kernel.org
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 16:32:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYL37-0005IV-Ri
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 16:31:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755415AbZHDObY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 10:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754506AbZHDObY
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 10:31:24 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:43570 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755407AbZHDObX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 10:31:23 -0400
Received: by ewy10 with SMTP id 10so367776ewy.37
        for <git@vger.kernel.org>; Tue, 04 Aug 2009 07:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=aBlfRR+VTNd84r7o8WEfSC4WqIM88HZuyjfhswHfSY4=;
        b=k6JHfK4upmZguaj0sMqVces7oq+Qsq09K97kX23e1w8oBophfs13CYHXgL0FC7UnvQ
         XNC5Qp2DfkJCyH57qZQUkoBybSDow2kmTN0GdXgj87ySgE1lXUipINQRqRRxrykEJfr4
         MzJ8Nc7WydJMcgcBSvSeTczQBHPei3D1bv+nI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=VQiKWPSFTxnTMN5OJIQ4A16XVlXsDTrV/a12+hx6ZlIbu2A1OGbPRZGL+pEa89J14F
         8FZYd6D5QbG0Srw0qFmYCHnPBTJrGjgVhh8csFZQRQ0ENVs6CvA81pHuX8H/sl6AGDEV
         S+/oO2weMqFZAcz7WwHnJ63BvSfLOrvtJ5JL4=
Received: by 10.210.141.9 with SMTP id o9mr6755690ebd.10.1249396282249;
        Tue, 04 Aug 2009 07:31:22 -0700 (PDT)
Received: from localhost (ppp91-76-18-80.pppoe.mtu-net.ru [91.76.18.80])
        by mx.google.com with ESMTPS id 5sm2283247eyf.8.2009.08.04.07.31.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 04 Aug 2009 07:31:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <9e4733910908040556t477dcb66u86a43e12148e3352@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124791>

On Tue, Aug 04, 2009 at 08:56:48AM -0400, Jon Smirl wrote:
> 
> A simple start would be to feed each byte as it is decompressed
> directly into the sha code and avoid the intermediate buffer. Removing
> the buffer reduces cache pressure.

First, you still have to preserve any decoded byte in the compress
window, which is 32Kb by default. Typical files in Git repositories are
not so big, many are under 32Kb and practically all of them fit to L2
cache of modern processors. Second, complication of assembler code from
the coupling of two algorithms will be enormous. It is not sufficient
registers on x86 for SHA-1 alone. Third, SHA-1 is very computationally
intensive and with predictable access pattern (linear), so you do not
wait for L2, because it will be in L1. So, I don't see where you can
gain significantly. Perhaps, you can win just from re-writing inflate in
assembler, but I do not expect any significant gains other than that.
And coupling has obvious disadvantages when it comes to maintenance...


Dmitry
