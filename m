From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Support 64-bit indexes for pack files.
Date: Tue, 27 Feb 2007 00:11:20 -0500 (EST)
Message-ID: <alpine.LRH.0.82.0702270002100.29426@xanadu.home>
References: <200702261540.27080.ttelford.groups@gmail.com>
 <20070226235510.GF1639@spearce.org>
 <alpine.LRH.0.82.0702261916560.29426@xanadu.home>
 <20070227003118.GH1639@spearce.org>
 <alpine.LRH.0.82.0702262306100.29426@xanadu.home>
 <79B129C3-C1B5-43E3-97DA-1ADC70642B88@adacore.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Troy Telford <ttelford.groups@gmail.com>, git@vger.kernel.org
To: Geert Bosch <bosch@adacore.com>
X-From: git-owner@vger.kernel.org Tue Feb 27 06:11:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLucg-0005BR-HB
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 06:11:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbXB0FLW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 00:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751569AbXB0FLW
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 00:11:22 -0500
Received: from relais.videotron.ca ([24.201.245.36]:19245 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564AbXB0FLV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 00:11:21 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JE300GVNVQWAJZ1@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 27 Feb 2007 00:11:20 -0500 (EST)
In-reply-to: <79B129C3-C1B5-43E3-97DA-1ADC70642B88@adacore.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40695>

On Mon, 26 Feb 2007, Geert Bosch wrote:

> Why can't we do it with the current 1<<8 entry fan-out?
> This would allow increases of pack file size up to 1 TB.

I had the exact same thought while I was writing the previous mail.
It is indeed perfectly fine and would require less than 10 lines of code 
to implement.

> BTW, here are a few issues with the current pack file format:
>  - The final SHA1 consists of the count of objects in the file
>    and all compressed data. Why? This is horrible for streaming
>    applications where you only know the count of objects at the
>    end, then you need to access *all* data to compute the SHA-1.
>    Much better to just use compute a SHA1 over the SHA1's of each
>    object. That way at least the data streamed can be streamed to
>    disk. Buffering one SHA1 per object is probably going to be OK.

We always know the number of objects before actually constructing or 
streaming a pack.  Finding best delta matches require that we sort the 
object list by type, but for good locality we need to re-sort that list 
by recency.  So we always know the number of objects before starting to 
write since we need to have the list of objects in memory anyway.

Also the receiving end of a streamed pack wants to know the number of 
objects first if only to provide the user with some progress report.

>  - The object count is implicit in the SHA1 of all objects and the
>    objects we find in the file. Why do we need it in the first place?
>    Better to recompute it when necessary. This makes true streaming
>    possible.

Sorry, I don't follow you here.


Nicolas
