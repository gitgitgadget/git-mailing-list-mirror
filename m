From: Sebastian Thiel <byronimo@googlemail.com>
Subject: Indexing Zlib deflated streams for pseudo-random-access to reduce
 delta-resolution memory requirements
Date: Thu, 31 Mar 2011 22:26:45 +0200
Organization: Byronimo
Message-ID: <4D94E385.7090903@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 31 22:27:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5OSJ-0005ot-5H
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 22:26:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754901Ab1CaU0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 16:26:52 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64816 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323Ab1CaU0u convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Mar 2011 16:26:50 -0400
Received: by bwz15 with SMTP id 15so2051065bwz.19
        for <git@vger.kernel.org>; Thu, 31 Mar 2011 13:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:organization:user-agent
         :mime-version:to:subject:content-type:content-transfer-encoding;
        bh=DtaaTRIng8UzEzpON/5hL+U5EnvKHFVO+p1oMdKssZQ=;
        b=CQqLkbWugYc6xZZj5/8XP7OyoTXzBgz3O/XJn4481wz74pUHej3+rhaWjiI7aRN99D
         cZxk2xqEIlWIFz+tyhi3WZcvdE/mWAcGErgvo72ze3hVP26GJ/109MWQqhq1V/MuGfMV
         a0UAREWv4CrOv8/QPtc7PNb9eNb8RJ5LDEqC4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:organization:user-agent:mime-version:to
         :subject:content-type:content-transfer-encoding;
        b=wlyTB/YV0Fq4ekTQwedJDLL4O/orXb7fH1mgJGIpryqOslYAs5JG+qkKXI92ybqCkV
         9ED9OG/qnK0wcDjVGvOJdtc/fIBlycjewRiYhMk0uEmSFGSwRR9AlppXL+lZkzVCn1zd
         rzBbh6oe6UWNb2X5HXGJbUV/FBAVH8KEnrTOk=
Received: by 10.204.20.70 with SMTP id e6mr2923036bkb.145.1301603208635;
        Thu, 31 Mar 2011 13:26:48 -0700 (PDT)
Received: from [10.0.1.33] (91-65-187-112-dynip.superkabel.de [91.65.187.112])
        by mx.google.com with ESMTPS id q18sm977289bka.3.2011.03.31.13.26.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 31 Mar 2011 13:26:47 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15pre) Gecko/20110207 Shredder/3.1.9pre
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170527>

Hi,

Why would one have big files delta compressed anyway ? From my 
experience, this can save a lot of space, even though the process of 
generating the deltas will definitely take up a lot of memory. In my 
use-case the packs are generated on a server with plenty of RAM. And 
even though the most recent version of an object tends to be a base 
which wouldn't need delta resolution, querying older revisions will 
require it. As this is done client side most of the time, it would be 
great to reduce the memory footprint,  at the cost of some additional 
preprocessing time.

Currently, when reapplying deltas on rather big files, assumed that one 
didn't exclude them for delta compression in the first place, the 
current algorithm requires the base-buffer, the target buffer as well as 
the inflated delta stream itself in memory concurrently. Then the 
algorithm works its way up recursively from the first base object to the 
last delta until it is done. This causes plenty of possibly large memory 
allocations, as well as high memory demands.

In my current python and c++ implementation of pack reading, I try to 
stream all objects. Base objects can already be very efficiently 
streamed as a plain (streamed) inflate will do. This is different for 
delta objects. Even though the delta resolution machinery is hidden 
behind a stream interface, it still produces a big buffer to hold the 
resolved object.

My current research went far enough to allow delta streams to be merged 
together at first, so the last delta to be applied gets merged down onto 
its base delta, and so forth, until all deltas were merged into one big 
delta which just applies to the base buffer. This delta will have only 
copy operations which refer to the base object's data, as well as copy 
operations. Currently,  the merged delta stream is kept in memory 
deflated, and could be streamed  more or less easily. The problem I have 
is that the base object's data still needs to be available for random 
access, i.e. inflated in memory.

Although this technique safes some memory during processing, as it will 
never allocate two possibly large base and target buffers, in the end it 
turns out to be more expensive memory wise as it needs the base buffer 
as well as the merged delta to be allocated as long as the streaming is 
in progress, compared to just the possibly smaller target buffer in case 
of the default recursive algorithm.

Here comes the link to the subject line: If it was possible to index the 
zip deflated stream somehow, it wouldn't be required to keep an inflated 
version of the base buffer in memory all the time. Instead, the required 
portions can be decompressed on demand, using the said zip stream index. 
Then we would only need the merged delta stream in memory, which should 
(ideally) be smaller than the target buffer itself.

Do you think it is feasible to burn these extra cycles to reduce the 
memory footprint ? Do you know whether or how it is possible to index a 
zip deflated stream for pseudo-random access or can provide hints ?
So far, from studying the zlib manual, there seems to be some way of 
determining zip blocks which can then possibly be linked to the 
uncompressed data positions, but ... I am absolutely not sure. Ideally, 
this whole indexing process works by quickly skipping through the zlib 
stream without actually decompressing it.

Maybe, all this is too much effort, and maybe the merged delta stream's 
size ends up being larger than the target buffer so it was all for 
nothing (which one would only know once the preprocessing time was 
already spent), but maybe it could really help truly 'stream' deltified 
objects (which has been something like my holy grail for quite some time 
now).

Thanks,
Sebastian
