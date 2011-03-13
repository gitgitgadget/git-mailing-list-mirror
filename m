From: Alexander Miseler <alexander@miseler.de>
Subject: Re: Fwd: Git and Large Binaries: A Proposed Solution
Date: Sun, 13 Mar 2011 20:33:18 +0100
Message-ID: <4D7D1BFE.2030008@miseler.de>
References: <AANLkTin=UySutWLS0Y7OmuvkE=T=+YB8G8aUCxLH=GKa@mail.gmail.com> <AANLkTimPua_kz2w33BRPeTtOEWOKDCsJzf0sqxm=db68@mail.gmail.com> <20110121222440.GA1837@sigill.intra.peff.net> <20110123141417.GA6133@mew.padd.com> <4D793C7D.1000502@miseler.de> <20110310222443.GC15828@sigill.intra.peff.net> <AANLkTimpbhaGEfxW1wwRc14tpV6qnPDiZYnXp_tvA3Ft@mail.gmail.com> <20110313025258.GA10452@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Eric Montellese <emontellese@gmail.com>,
	Pete Wyckoff <pw@padd.com>, git@vger.kernel.org,
	schacon@gmail.com, joey@kitenet.net
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 13 20:33:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pyr2g-00088i-5M
	for gcvg-git-2@lo.gmane.org; Sun, 13 Mar 2011 20:33:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755361Ab1CMTdY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Mar 2011 15:33:24 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:59500 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943Ab1CMTdY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Mar 2011 15:33:24 -0400
Received: from [192.168.22.13] (f055019155.adsl.alicedsl.de [78.55.19.155])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0M9vlQ-1Pnsfa0X2e-00BIu3; Sun, 13 Mar 2011 20:33:15 +0100
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <20110313025258.GA10452@sigill.intra.peff.net>
X-Provags-ID: V02:K0:U3yfM/iRQq9WCWGYb75TLrumCtMLmU+aVjoUm688zeF
 tnzPdp/eHTk+Qa1TI2PXvcR8VOlgpMm+hG7kaf1xdyI+7hjDan
 yNKqTBjE1qeR9Mfb/xgsOcnEa4WGwuY8JhwF7OGr9oxLkVT2Iw
 2ZAVIXnfmtWzFa4rOP+IbAY1JQWcQRK8QtFx/i/gqh6tm0WFuJ
 4V6cWVO4hzQjJHVlq+I4w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168976>


My thoughts on big file storage:

We want to store them as flat as possible. Ideally if we have a temp file with the content (e.g. the output of some filter) it should be possible to store it by simply doing a move/rename and updating some meta data external to the actual file.

Options:

1.) The loose file format is inherently unsuited for this. It has a header before the actual content and the whole file (header + content) is always compressed. Even if one changes this to compressing/decompressing header and content independently it is still unsuited by a) having the header within the same file and b) because the header has no flags or other means to indicate a different behavior (e.g. no compression) for the content. We could extend the header format or introduce a new object type (e.g. flatblob) but both would probably cause more trouble than other solutions. Another idea would be to keep the metadata in an external file (e.g. 84d7.header for the object 84d7). This would probably have a bad performance though since every object lookup would first need to check for the e
 xistence of a header file. A smarter variant would be to optionally keep the meta data directly in the filename (e.g. saving the object as 84d7.object_type.size.flag instead of just 84d7). 
This would only require special handling for cases where the normal lookup for 84d7 fails.

2.) The pack format fares a lot better. Content and meta data are already separated with the meta data describing how the content is stored. We would need a flag to mark the content as flat and that would pretty much be it. We would still need to include a virtual header when calculating the sha1 so it is guaranteed that the same content has always the same id.
Thus i think we should simply forgo the loose object phase when storing big files and simply drop each big file flat as a individual pack file, with the idx file describing it as a pack file with one entry which is stored flat.

3.) Do some completely different handling for big files, as suggested by Eric:
>>   1.1 Perhaps a "binaries" directory, or structure of directories, within .git
> 
> I'd rather not do something so drastic.
My main issue with this approach (apart from the 'drastic' ^_^) is that the definition of big file may change at any time by e.g. changing a config value like core.bigFileThreshold. What has been stored as big file may suddenly be considered a normal blob and vice versa. Thus any storage variant that isn't well integrated in the normal object storage will probably be troublesome.




> There may also be code-paths for binary files where
> we accidentally load them (I just fixed one last week where we
> unnecessarily loaded them in the diffstat code path). Somebody will need
> to do some experimenting to shake out those code paths.

This is my main focus for now. They are easy to detect when your memory is small enough :D
