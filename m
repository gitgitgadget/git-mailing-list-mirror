From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Understanding version 4 packs
Date: Mon, 26 Mar 2007 14:16:11 +0200
Message-ID: <e5bfff550703260516q5da5f46et8aab2ebadcd9cceb@mail.gmail.com>
References: <20070324202356.GA20734@bohr.gbar.dtu.dk>
	 <alpine.LFD.0.83.0703241913110.18328@xanadu.home>
	 <20070325083530.GA25523@bohr.gbar.dtu.dk>
	 <20070325091806.GH25863@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Peter Eriksen" <s022018@student.dtu.dk>,
	"Nicolas Pitre" <nico@cam.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Mar 26 14:16:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVo7a-0007af-Gx
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 14:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752381AbXCZMQT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 08:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752391AbXCZMQT
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 08:16:19 -0400
Received: from nz-out-0506.google.com ([64.233.162.228]:62507 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323AbXCZMQS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 08:16:18 -0400
Received: by nz-out-0506.google.com with SMTP id s1so2000473nze
        for <git@vger.kernel.org>; Mon, 26 Mar 2007 05:16:18 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=atawFZvypKzhJn3k982hyAfYLxzqZBdFNk2ydrEubzv6HEi+G2II74ISGvS/5pM21G6mr83M/dMoDACnXpJIOksqnG5HBJy4C1HToc3zloHMiFBfDtcqigPMypjXzHhtvJeLeS7I7ob2gqzwOUwSWF2vTWVZIAU4DEEIEKpfPko=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AOJjJpGhpwZlN2Y1cF8UXL95oGaXOCgxyr2yZpsBf+L/AZRm2UiDykizuHXVXSKxY5YDFmNGgwePP6A2Yz8wZaWEd/8AWaJ7teMBUzxGU9tTG6KeNpNJgUtJgz62Ht4gWj9f6JycX4KE89+C45D2toBXQr5/2BiThkZDSvOquTw=
Received: by 10.114.180.1 with SMTP id c1mr2610551waf.1174911377163;
        Mon, 26 Mar 2007 05:16:17 -0700 (PDT)
Received: by 10.114.60.16 with HTTP; Mon, 26 Mar 2007 05:16:11 -0700 (PDT)
In-Reply-To: <20070325091806.GH25863@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43150>

On 3/25/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> Peter Eriksen <s022018@student.dtu.dk> wrote:
> > On Sat, Mar 24, 2007 at 07:24:17PM -0400, Nicolas Pitre wrote:
> > > On Sat, 24 Mar 2007, Peter Eriksen wrote:
> > >
> >
> > The uncompressed file name table contains NR_ENTRIES entries,
> > and looks like this:
> >
> > +------------+------+--------------+------+--------------------+----
> > | NR_ENTRIES | MODE |  Full path 1 | MODE | Full path 2        | ...
> > +------------+------+--------------+------+--------------------+----
> >    4 bytes    2 bytes   n1 bytes    2 bytes     n2 bytes
> >
> > MODE is a network-byte-order integer representing the mode of the path,
> > and the path is a variable length, null-terminated string.
>
> Yes so far.
>

Perhaps has been already evaluated and my comment is not pertinent
but, anyway...

Experimenting with file names cache in qgit I have found a big saving
splitting the paths in base name and file name and indexing both:

drivers\usb\host\ehci.h
drivers\usb\host\ehci-pci.c
drivers\usb\host\ohci-pci.c
kernel\sched.c

became:

dir names table

0 drivers\usb\host
1 kernel


file name table

0 ehci.h
1 ehci-pci.c
2 ohci-pci.c

In this way a big saving is achieved in case of directories deep in
the tree (long paths) and a lot of files. Also after compressing the
difference is noticeable.

Regarding MODE field an observation could be that is almost always the
same, so an idea could be to store a 'default mode' just after
nr_entries and do not add the field any more except in case path mode
is different from default mode. In case this could bring to unaligned
entries another idea could be to store _all_ mode fields at the
beginning (or at the end and let deflate to remove almost everything
more easily)

  Marco
