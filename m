From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: large files and low memory
Date: Mon, 4 Oct 2010 13:58:54 -0500
Message-ID: <20101004185854.GA6466@burratino>
References: <20101004092046.GA4382@nibiru.local>
 <AANLkTimbdrAqoWMxiteT5zNYmwHp8M698BEv1FLuiAxx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: weigelt@metux.de, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 04 21:02:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2qIp-0000jR-9U
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 21:02:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253Ab0JDTCR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 15:02:17 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:63950 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932229Ab0JDTCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 15:02:16 -0400
Received: by ewy23 with SMTP id 23so2122644ewy.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 12:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=bneRVXhCNwZ6i6JGjDDDEzXxf98/ezOiIwbBIeMPVjY=;
        b=HyIJKHaYT8N4MxWPELY9GGNFu8FQq9WfpdmZzMnWvhInpO5Fq62sEcG0E1i3Uq5XSm
         m9g6gFBM/G4Kds18hMCKRQCVACrHByHEupNQGCRDbapMifXu6szmJTx6UdTdtgvVoCxT
         SA69jvo6y5XazPrAbJP6M7QA20CFCRI4RmLRs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=R7U15hBvaK9+kEQU492so864rvrhDc9SV/n1Appc8H4JOV9ikySb7nbUPRcvgolaS9
         wsBjXVqhEO2E34gRYVOo9Y6R0fI+62uD11d8Ee9xhtUhQSgIVXFj3sq/1hoMBXAchmyx
         wpd2Sm1UkmkvhURTjQaiUaMAPQhcqQaYQGAHo=
Received: by 10.216.159.131 with SMTP id s3mr8038101wek.99.1286218934920;
        Mon, 04 Oct 2010 12:02:14 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id n40sm3234553weq.5.2010.10.04.12.02.12
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 12:02:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimbdrAqoWMxiteT5zNYmwHp8M698BEv1FLuiAxx@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158094>

Shawn Pearce wrote:

> The mmap() isn't the problem.  Its the allocation of a buffer that is
> larger than the file in order to hold the result of deflating the file
> before it gets written to disk.

Wasn't this already fixed, at least in some cases?

commit 9892bebafe0865d8f4f3f18d60a1cfa2d1447cd7 (tags/v1.7.0.2~11^2~1)
Author: Nicolas Pitre <nico@fluxnic.net>
Date:   Sat Feb 20 23:27:31 2010 -0500

    sha1_file: don't malloc the whole compressed result when writing out objects

    There is no real advantage to malloc the whole output buffer and
    deflate the data in a single pass when writing loose objects. That is
    like only 1% faster while using more memory, especially with large
    files where memory usage is far more. It is best to deflate and write
    the data out in small chunks reusing the same memory instead.

    For example, using 'git add' on a few large files averaging 40 MB ...

    Before:
    21.45user 1.10system 0:22.57elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
    0inputs+828040outputs (0major+142640minor)pagefaults 0swaps

    After:
    21.50user 1.25system 0:22.76elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
    0inputs+828040outputs (0major+104408minor)pagefaults 0swaps

    While the runtime stayed relatively the same, the number of minor page
    faults went down significantly.

    Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
