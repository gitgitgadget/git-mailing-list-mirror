From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Cygwin can't handle huge packfiles?
Date: Mon, 3 Apr 2006 15:23:55 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604031521170.4011@wbgn013.biozentrum.uni-wuerzburg.de>
References: <fa0b6e200604030246q21fccb9ar93004ac67d8b28b3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 03 15:24:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQP2J-0000QH-U5
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 15:24:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbWDCNX7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 09:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750901AbWDCNX7
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 09:23:59 -0400
Received: from wrzx35.rz.uni-wuerzburg.de ([132.187.3.35]:53997 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750892AbWDCNX7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Apr 2006 09:23:59 -0400
Received: from virusscan.mail (mail03.mail [172.25.1.102])
	by mailrelay.mail (Postfix) with ESMTP id 7CBEE1393;
	Mon,  3 Apr 2006 15:23:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 6FC41ABB;
	Mon,  3 Apr 2006 15:23:55 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 2C9D71C02;
	Mon,  3 Apr 2006 15:23:55 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Kees-Jan Dijkzeul <k.j.dijkzeul@gmail.com>
In-Reply-To: <fa0b6e200604030246q21fccb9ar93004ac67d8b28b3@mail.gmail.com>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18325>

Hi,

On Mon, 3 Apr 2006, Kees-Jan Dijkzeul wrote:

> I'm trying to get Git to manage a 5Gb source tree. Under linux, this
> works like a charm. Under cygwin, however, I run in to difficulties.
> For example:
> 
> $ git-clone sgp-wa/ sgp-wa.clone
> fatal: packfile
> ./objects/pack/pack-56aa013a0234e198467ed37ae5db925764a6ee98.pack
> cannot be mapped.
> fatal: unexpected EOF
> fetch-pack from '/cygdrive/e/Projects/sgp-wa/.git' failed.
> 
> To figure out what is happening, I printed the value of errno, which
> turns out to be 12 (Cannot allocate memory). I'm not sure how mmap is
> implemented in cygwin, but if they allocate memory and load the file
> into it, then this error is not surprising, as the pack file in
> question is 1.5Gb in size.

The problem is not mmap() on cygwin, but that a fork() has to jump through 
loops to reinstall the open file descriptors on cygwin. If the 
corresponding file was deleted, that fails. Therefore, we work around that 
on cygwin by actually reading the file into memory, *not* mmap()ing it.

Hth,
Dscho
