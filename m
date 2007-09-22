From: Sam Vilain <sam@vilain.net>
Subject: Re: Git as a filesystem
Date: Sat, 22 Sep 2007 15:09:01 +1200
Message-ID: <46F4874D.8000305@vilain.net>
References: <fbe8b1780709210351x30775090ldab559f25c27645d@mail.gmail.com>	 <Pine.LNX.4.64.0709211208440.28395@racer.site>	 <fbe8b1780709210441n281248dbh5ba9934d09d6bbfc@mail.gmail.com>	 <20070921125337.GA28456@diana.vm.bytemark.co.uk>	 <fbe8b1780709210628u24c14117p5174bedb3d1912cb@mail.gmail.com>	 <20070921172941.GA7399@potapov> <46a038f90709211656n5b23783eu330e8b655cd42aa8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Peter Stahlir <peter.stahlir@googlemail.com>,
	=?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 22 05:13:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYvQX-0004mC-Ij
	for gcvg-git-2@gmane.org; Sat, 22 Sep 2007 05:13:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756240AbXIVDIH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 23:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756239AbXIVDIG
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 23:08:06 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:41490 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756215AbXIVDIF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 23:08:05 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id A282E23C272; Sat, 22 Sep 2007 15:08:01 +1200 (NZST)
Received: from [192.168.69.104] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id B3DA823C26E;
	Sat, 22 Sep 2007 15:07:54 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.12 (X11/20070604)
In-Reply-To: <46a038f90709211656n5b23783eu330e8b655cd42aa8@mail.gmail.com>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=5.0 tests=SPF_HELO_FAIL autolearn=no 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58913>

Martin Langhoff wrote:
> On 9/22/07, Dmitry Potapov <dpotapov@gmail.com> wrote:
>   
>> used to create the original file. So, if you put any .deb file in such
>> a system, you will get back a different .deb file (with a different SHA1).
>> So, aside high CPU and memory requirements, this system cannot work in
>> principle unless all users have exactly the same version of a compressor.
>>     
>
> Was thinking the same - compression machinery, ordering of the files,
> everything. It'd be a nightmare to ensure you get back the same .deb,
> without a single different bit.
>
> Debian packaging toolchain could be reworked to use a more GIT-like
> approach - off the top of my head, at least
>
>   - signing/validating the "tree" of the package rather than the
> completed package could allow the savings in distribution you mention,
> decouple the signing from the compression, and simplify things like
> debdiff
>
>   - git or git-like strategies for source packages
>   

Nightmare indeed.  I actually wrote a proof of concept for this idea for
gzip.

http://git.catalyst.net.nz/gw?p=git.git;a=shortlog;h=archive-blobs
(see also
http://planet.catalyst.net.nz/blog/2006/07/17/samv/xteddy_caught_consuming_rampant_amounts_of_disk_space)

I usually warn people that this undertaking is "slightly insane".

My implementation was designed to be called like "git-hash-object". 
What it did was look at the input stream, and detect quickly whether it
looked like a gzip stream.  If it was, it would decompress it and then
try to compress the first few blocks using different compression
libraries and settings to determine what settings were used.  If it
could find the right settings for the first meg or so, then it would
bank on the rest being identical as well, record which compressor and
what settings were used and write the uncompressed object, as well as
the information needed to reconstruct the gzip header, to a new type of
object called an "archive" object.  If the stream could not be
reproduced then it would save the raw stream instead.  For something
like a Debian archive, it is very likely that all compressed streams
will be reproducible, because they will almost all be compressed using
the same implementation of gzip.

For tar and .ar files, this can be slightly more deterministic of
course.  It doesn't even need to be particularly savvy of what all the
fields are - just locate the files in the .tar, write out a tree, and
then write a TOC that lists tree entries and contains any extra data (ie
headers, etc).

In hindsight, making a new object type was probably a mistake.  If I
were to re-undertake this I would not go down that path, though I'd
certainly consider using tag objects for the extra data, and throwing
them in the tree like submodules.  It would also be essential in a
"real" solution to bundle reference copies of the zlib and gzip
compressors (yes, their output streams differ with longer inputs and
even some short ones).

Sam.
