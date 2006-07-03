From: Joachim Berdal Haga <c.j.b.haga@fys.uio.no>
Subject: Re: Compression speed for large files
Date: Tue, 04 Jul 2006 00:25:37 +0200
Message-ID: <44A99961.8090504@fys.uio.no>
References: <loom.20060703T124601-969@post.gmane.org>
 <20060703214503.GA3897@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Joachim B Haga <cjhaga@student.matnat.uio.no>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 04 00:26:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxWrQ-0008Cg-Fr
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 00:25:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbWGCWZl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 18:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbWGCWZl
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 18:25:41 -0400
Received: from osl1smout1.broadpark.no ([80.202.4.58]:40688 "EHLO
	osl1smout1.broadpark.no") by vger.kernel.org with ESMTP
	id S932154AbWGCWZk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jul 2006 18:25:40 -0400
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java System Messaging Server 6.1 HotFix 0.05 (built Oct 21 2004))
 with ESMTP id <0J1U008WYMAR4O40@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Tue, 04 Jul 2006 00:25:39 +0200 (CEST)
Received: from pep ([80.203.45.67]) by osl1sminn1.broadpark.no
 (Sun Java System Messaging Server 6.1 HotFix 0.05 (built Oct 21 2004))
 with ESMTP id <0J1U00KP2MARGH20@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Tue, 04 Jul 2006 00:25:39 +0200 (CEST)
Received: from localhost ([127.0.0.1])	by pep with esmtp (Exim 4.62)
	(envelope-from <c.j.b.haga@fys.uio.no>)	id 1FxWrJ-0007zR-Tj; Tue,
 04 Jul 2006 00:25:38 +0200
In-reply-to: <20060703214503.GA3897@coredump.intra.peff.net>
To: Jeff King <peff@peff.net>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: c.j.b.haga@fys.uio.no
X-SA-Exim-Scanned: No (on pep); SAEximRunCond expanded to false
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23219>

Jeff King wrote:
> On Mon, Jul 03, 2006 at 11:13:34AM +0000, Joachim B Haga wrote:
> 
>> often binary. In git, committing of large files is very slow; I have
>> tested with a 45MB file, which takes about 1 minute to check in (on an
>> intel core-duo 2GHz).
> 
> I know this has already been somewhat solved, but I found your numbers
> curiously high. I work quite a bit with git and large files and I
> haven't noticed this slowdown. Can you be more specific about your load?
> Are you sure it is zlib?

Quite sure: at least to the extent that it is fixed by lowering the
compression level. But the wording was inexact: it's during object
creation, which happens at initial "git add" and then later during "git
commit".

But...

> y 1.8Ghz Athlon, compressing 45MB of zeros into 20K takes about 2s.
> Compressing 45MB of random data into a 45MB object takes 6.3s. In either
> case, the commit takes only about 0.5s (since cogito stores the object
> during the cg-add).
> 
> Is there some specific file pattern which is slow to compress? 

yes, it seems so. At least the effect is much more pronounced for my
files than for random/null data. "My" files are in this context generated
data files, binary or ascii.

Here's a test with "time gzip -[169] -c file >/dev/null". Random data
from /dev/urandom, kernel headers are concatenation of *.h in kernel
sources. All times in seconds, on my puny home computer (1GHz Via Nehemiah)

       random (23MB)  data (23MB)   headers (44MB)
-9     10.2           72.5          38.5
-6     10.2           13.5          12.9
-1      9.9            4.1           7.0

So... data dependent, yes. But it hits even for normal source code.

(Btw; the default (-6) seems to be less data dependent than the other
values. Maybe that's on purpose.)

If you want to look at a highly-variable dataset (the one above), try
http://lupus.ig3.net/SIMULATION.dx.gz (5MB, slow server), but that's just
an example, I see the same variability for example also on binary data files.

-j.
