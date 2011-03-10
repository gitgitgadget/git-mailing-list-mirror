From: Alexander Miseler <alexander@miseler.de>
Subject: Re: Fwd: Git and Large Binaries: A Proposed Solution
Date: Thu, 10 Mar 2011 22:02:53 +0100
Message-ID: <4D793C7D.1000502@miseler.de>
References: <AANLkTin=UySutWLS0Y7OmuvkE=T=+YB8G8aUCxLH=GKa@mail.gmail.com> <AANLkTimPua_kz2w33BRPeTtOEWOKDCsJzf0sqxm=db68@mail.gmail.com> <20110121222440.GA1837@sigill.intra.peff.net> <20110123141417.GA6133@mew.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	emontellese@gmail.com, schacon@gmail.com, joey@kitenet.net
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 22:03:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pxn1U-0006Sx-BI
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 22:03:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753914Ab1CJVDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 16:03:10 -0500
Received: from moutng.kundenserver.de ([212.227.17.9]:59993 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753823Ab1CJVCz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 16:02:55 -0500
Received: from [192.168.22.13] (f055053254.adsl.alicedsl.de [78.55.53.254])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0LrqDW-1Q6CTG3lDa-0136n8; Thu, 10 Mar 2011 22:02:49 +0100
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <20110123141417.GA6133@mew.padd.com>
X-Provags-ID: V02:K0:C00uYdrod9LqUBoNLciyghdmEl8r3+VLbBjLkpJDQ4W
 qvuJ9YK5X4O+wqbxG7A9wbly0FkPydmoaT3tBvSUCW1yamPtBx
 0W2DXYZRsjB1RoKKD+B5N3EzJOef9lnn3vBH5WxCFUyqLK3NnM
 SAu8mIGjvz9g+Z6BxCOgKY6qM9Tyq1hgiXlXH+IHS2+9A7BUjk
 faWflRdTE8rPzLGruWySA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168851>

I've been debating whether to resurrect this thread, but since it has been referenced by the SoC2011Ideas wiki article I will just go ahead.
I've spent a few hours trying to make this work to make git with big files usable under Windows.

> Just a quick aside.  Since (a2b665d, 2011-01-05) you can provide
> the filename as an argument to the filter script:
> 
>     git config --global filter.huge.clean huge-clean %f
> 
> then use it in place:
> 
>     $ cat >huge-clean 
>     #!/bin/sh
>     f="$1"
>     echo orig file is "$f" >&2
>     sha1=`sha1sum "$f" | cut -d' ' -f1`
>     cp "$f" /tmp/big_storage/$sha1
>     rm -f "$f"
>     echo $sha1
> 
> 		-- Pete

First off, the commit mentioned here is no help at all. This commit changes nothing about the input and output of filters. The file is still loaded completely into memory, still streamed to the filter via stdin, still streamed from the filter via stdout into yet another memory buffer. The two of which, IIRC, exist simultaneous for at least some time, thus doubling the memory requirements. This change only additionally provides the file name to the filter and nothing else. If one carefully rereads the commit message this apparently was the intention.

After this I started digging into the git source code. To change the filter input would be extremely trivial. However, the function that returns the filter output in a memory buffer is called from 8 places (all details from wetware memory and therefore unreliable). Most, maybe all, of the callers just dump the buffer into a file, which could easily be relocated into the filter calling function itself. But two callers detached the buffer from the strbuf and kept it beyond writing the file. I didn't track it any further since I decided to rather spend my time on improving big file handling in git itself, rather than targeting a workaround. Though of course a completely big-file-ready git should also provide a sane way to feed big files to and from filters.

If the two detached buffers are no complication this might be a trivial project. If they do it might become demanding though.
