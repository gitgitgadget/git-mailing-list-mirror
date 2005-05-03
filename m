From: Dan Holmsand <holmsand@gmail.com>
Subject: Re: RFC: adding xdelta compression to git
Date: Tue, 03 May 2005 14:48:14 +0200
Message-ID: <d57rip$ojm$1@sea.gmane.org>
References: <200505030657.38309.alonz@nolaviz.org> <Pine.LNX.4.58.0505022131380.3594@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue May 03 14:45:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSwlQ-0005sQ-2E
	for gcvg-git@gmane.org; Tue, 03 May 2005 14:44:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261526AbVECMuO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 08:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbVECMuO
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 08:50:14 -0400
Received: from main.gmane.org ([80.91.229.2]:26014 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261526AbVECMto (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2005 08:49:44 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DSwjm-0005He-6j
	for git@vger.kernel.org; Tue, 03 May 2005 14:42:54 +0200
Received: from h65n2fls35o265.telia.com ([217.211.115.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 03 May 2005 14:42:54 +0200
Received: from holmsand by h65n2fls35o265.telia.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 03 May 2005 14:42:54 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: h65n2fls35o265.telia.com
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
In-Reply-To: <Pine.LNX.4.58.0505022131380.3594@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> Also, the fact is, since git saves things as separate files, you'd not win
> as much as you would with some other backing store. So the second step is
> to start packing the objects etc. I think there is actually a very steep
> complexity edge here - not because any of the individual steps necessarily
> add a whole lot, but because they all lead to the "next step".

Actually, you can win quite a lot.

I've just been playing with storing the entire 
linux-2.4.0-to-2.6.12-rc2-patchset as xdelta patches in git. The entire 
thing ended up being 577M (instead of some 3.5G), according to du -sh 
--apparent-size. Considering that that's some 800M of patches, that's 
not too bad.

I used a very simple scheme: I stored a delta to the previous version of 
every file if that delta was less than 20% in size of the new file 
(otherwise, the whole file was stored as usual). If the previous version 
was already in delta form, the delta was computed from that versions 
"parent". I didn't even care to look at files less than 4k in size.

In other words, I didn't have to use any delta "chains", and still got 
quite massive storage size gains. And this scheme could easily be used 
on the fly; I'm guessing that it would be performance neutral (or even a 
slight gain, since less has to be compressed and written to disk on 
commits, and there might be less to read when diffing, since two 
"delta-blobs" might share the same parent).

Or, with careful tuning, a repo might be "deltaified" later on (assuming 
that delta blobs are addressed using the expanded files' hash).

/dan

