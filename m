From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Explanation for dropping write-back in mmap
Date: Mon, 7 Jun 2010 08:50:39 -0700
Message-ID: <20100607155039.GG14847@spearce.org>
References: <AANLkTilrinkNo9awJ9Wso4tXzQKghWEd2bfDRhPHPOga@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 07 17:50:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLebH-0000ZQ-18
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 17:50:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206Ab0FGPum (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jun 2010 11:50:42 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:63472 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810Ab0FGPum (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jun 2010 11:50:42 -0400
Received: by pwj5 with SMTP id 5so915111pwj.19
        for <git@vger.kernel.org>; Mon, 07 Jun 2010 08:50:41 -0700 (PDT)
Received: by 10.141.4.4 with SMTP id g4mr12024994rvi.269.1275925841591;
        Mon, 07 Jun 2010 08:50:41 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id l29sm4775499rvb.16.2010.06.07.08.50.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Jun 2010 08:50:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTilrinkNo9awJ9Wso4tXzQKghWEd2bfDRhPHPOga@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148610>

Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> In the commit f48000fcbe100, you've forced the caller to use
> MAP_PRIVATE in the alternative mmap implementation dropping write-back
> support. Could you kindly explain the rationale for this? David's SVN
> exporter uses mmap with MAP_SHARED, and we figured that the merge
> immediately breaks this functionality.
> 
> Noticed-by: Jonathan Nieder <jrnieder@gmail.com>
> 
> -----------------------------------------------------------------------------------------------------------
> commit f48000fcbe1009c18f1cc46e56cde2cb632071fa
> Author: Junio C Hamano <junkio@cox.net>
> Date:   Sat Oct 8 15:54:36 2005 -0700
> 
>     Yank writing-back support from gitfakemmap.
> 
>     We do not write through our use of mmap(), so make sure callers pass
>     MAP_PRIVATE and remove support for writing changes back.
> 
>     Signed-off-by: Junio C Hamano <junkio@cox.net>
> -----------------------------------------------------------------------------------------------------------


It got dropped because we never really used it.  In almost every
location we were only mapping a file for reading, but were writing
through normal IO write functions.  The Windows emulation code at
that time was using malloc()+read() to emulate mmap(), and thus
any modifications made to the buffer would not be flushed back.

The one place where we were doing both was fast-import, but it was
playing loose with the mmap consistency rules.  I think we have
fixed that code since then to ensure the data stays consistent on
all platforms.

I would strongly suggest finding another way to implement the SVN
exporter, without using MAP_SHARED.

-- 
Shawn.
