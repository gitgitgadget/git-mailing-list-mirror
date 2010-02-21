From: Steve Diver <squelch@think.zenbe.com>
Subject: [RFC] Is using git describe resilient enough for setting the build
 version of git?
Date: Sun, 21 Feb 2010 00:48:45 +0000
Message-ID: <4B8082ED.7020505@think.zenbe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 21 02:05:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nj09G-0005Ag-DQ
	for gcvg-git-2@lo.gmane.org; Sun, 21 Feb 2010 01:58:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755471Ab0BUA6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 19:58:00 -0500
Received: from smb-out-1.zenbe.com ([67.228.244.51]:60237 "EHLO
	smb-out-1.zenbe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755332Ab0BUA57 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 19:57:59 -0500
X-Greylist: delayed 528 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Feb 2010 19:57:59 EST
Received: from cl1.app01.zenbe.com (ec2-174-129-108-13.compute-1.amazonaws.com [174.129.108.13])
	by smb-out-1.zenbe.com (Postfix) with ESMTPSA id A72CD2423D7;
	Sat, 20 Feb 2010 18:49:02 -0600 (CST)
X-DKIM: Sendmail DKIM Filter v2.5.4 smb-out-1.zenbe.com A72CD2423D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zenbe.com; s=smb;
	t=1266713342; i=@think.zenbe.com; bh=AusK51gVTjjumyBn/jk/+a6XI1zMko
	INIjiqPK1uWnQ=; h=Message-ID:Date:From:MIME-Version:To:CC:Subject:
	 Content-Type:Content-Transfer-Encoding; b=I1Td0tg/KSqiyFKZG07kWUsH
	TMfMosPXlYZCkrbOV2WZXYC6FlDpMhwduzVEHIQsgyCE/l9g/xj1RGsPevQXLzvpQ7a
	/emtz+CdvMiSfRuKC+vMbk7jdOyN9wYdQu3B44rxEwzM04Oqr2ZjgvKTfRxldjl11UC
	OFPln9vYoO74I=
Received: from cl1.mailapp01.zenbe.com (domU-12-31-39-00-78-F6.compute-1.internal [10.254.127.4])
	by cl1.app01.zenbe.com (Postfix) with ESMTP id 036E5321F7;
	Sun, 21 Feb 2010 00:49:01 +0000 (UTC)
Received: from [10.0.0.16] (unknown [92.27.58.103])
	by cl1.app01.zenbe.com (Postfix) with ESMTP id C8699340A6;
	Sun, 21 Feb 2010 00:48:54 +0000 (UTC)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.1.7) Gecko/20100111 Lightning/1.0b1 Thunderbird/3.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140576>

Hi,

I recently ran into a problem with the displayed version number for a 
build of MSysgit. After much head scratching on my part, and divine 
intervention from Dscho given his intimate knowledge of the codebase, 
was it resolved.

My problem was that although I had checked out the tip of devel branch, 
every time I ran make, my build version was incorrect, although the hash 
suffix corresponded to the tip of the devel branch.

$ make
GIT_VERSION = 1.6.4.msysgit.0.2049.g91809
...

I was expecting to see 1.7.0 as the version which had been merged a few 
days ago, and simply inspecting the files did not reveal where the 
discrepancy originated.

I had been concentrating on GIT-VERSION-GEN to see how the version was 
generated, and then comparing between two machines - one with a 
successful build showing correct version and the other not, but both 
showing 1.7.0 as DEF_VER and apparently identical repositories - 
Johannes then replied to my query with a request to fetch some tags 
which had been overlooked. Viewing the two repositories graphically side 
by side immediately revealed that the build with the incorrect version 
label did not have recent tags, and it was not the files I should have 
been diffing, but comparing the output of "git describe". Problem solved 
after fetching the new tags.

This has been a most beneficial learning exercise for me, and I am most 
grateful, and heartened I was on the right track, but I think I also see 
a potential problem.

GIT-VERSION-GEN sets a default value DEF_VER according to the version at 
the time.

The two most recent being 1.6.6.2 at revision 82221 and 1.7.0 at e923e

However, in the absence of a version, the script uses "git describe" to 
retrieve the latest tag, and goes on to use this to create the version 
file along with the hash suffix at the current HEAD. In my case, the 
latest tag was 1.6.4 but I was building from the latest source at 
revision 91809.

Reading the manual entry for "git describe"[1] there is a note saying 
that the hash suffix does not guarantee disambiguity, and given that a 
tag may be incorrect or missing, there is a chance - albeit with 
diminishing odds - that the 5 digit hash/tag combination might lead to 
some obscure problems at some point along the line.

The chance of this happening really is low, but there is a chance all 
the same. We cannot foresee all errors, but identifying, and further 
reducing the odds of some must be good. Without doing the math, a guess 
would be that the probability of a repeat 5 digit abbreviated hash 
suffix increases the longer a tagged version is in place, so never will 
be 100% safe. Relying on the build version alone is not a good test 
under most circumstances, but in my case I could see that the hash was 
correct and the displayed version was unexpected. The other way around 
or one of those rare occasions of a repeat would have gone completely 
unnoticed.

I may be wrong, but the only scenario where I see DEF_VER being used by 
GIT-VERSION-GEN, would be when there are no tags for git describe to 
retrieve. ie "git pull --no-tags"

If my understanding is correct, DEF_VER is unique and set at the same 
time as the tagged version, so wouldn't it be desirable to cross check, 
or include this value instead of relying solely on the tag when present 
during the generation of GIT-VERSION-FILE at build time?


Steve

1. http://www.kernel.org/pub/software/scm/git/docs/git-describe.html
