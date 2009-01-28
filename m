From: Mark Adler <madler@alumni.caltech.edu>
Subject: Re: Valgrind updates
Date: Wed, 28 Jan 2009 15:06:44 -0800
Message-ID: <69A01114-27BB-4239-8FD8-C35D1306CE25@alumni.caltech.edu>
References: <alpine.DEB.1.00.0901210105470.19014@racer> <20090121001551.GB18169@coredump.intra.peff.net> <alpine.DEB.1.00.0901210119510.19014@racer> <20090121003739.GA18373@coredump.intra.peff.net> <alpine.DEB.1.00.0901210216440.19014@racer> <20090121190757.GB21686@coredump.intra.peff.net> <alpine.DEB.1.00.0901212259420.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901270327200.26199@intel-tinevez-2-302> <alpine.LFD.2.00.0901261934450.3123@localhost.localdomain> <alpine.DEB.1.00.0901270512171.14855@racer> <20090127131404.GA11870@sirena.org.uk> <alpine.DEB.1.00.0901271742430.3586@pacific.mpi-cbg.de> <alpine.LFD.2.00.0901271006060.3123@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jean-loup Gailly <jloup@gzip.org>,
	Mark Brown <broonie@sirena.org.uk>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jan 29 00:26:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSJnx-0003EV-ME
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 00:26:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752384AbZA1XZV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 18:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752050AbZA1XZV
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 18:25:21 -0500
Received: from quest.jpl.nasa.gov ([137.79.56.36]:52737 "EHLO
	quest.jpl.nasa.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751826AbZA1XZT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 18:25:19 -0500
X-Greylist: delayed 1114 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Jan 2009 18:25:19 EST
Received: from dhcp-79-35-169.jpl.nasa.gov (dhcp-79-35-169.jpl.nasa.gov [137.79.35.169])
	by quest.jpl.nasa.gov (Postfix) with ESMTP id DF32C3141876;
	Wed, 28 Jan 2009 15:06:42 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0901271006060.3123@localhost.localdomain>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107596>

On Jan 27, 2009, at 10:55 AM, Linus Torvalds wrote:
> and valgrind complains that the "write_buffer()" call will touch an
> uninitialized byte (just one byte, and in the _middle_ of the  
> buffer, no
> less):

Linus,

That is definitely not deflate's intentional use of uninitialized  
bytes that is noted in the zlib FAQ.  This is something else.

> Maybe the zlib people can tell us that we're idiots and the above is
> buggy, but maybe there is a real bug in zlib.

I can't speak to the idiot part, but your usage of deflate is not  
buggy.  (At least assuming that NULL is all zeros for the compiler in  
use.)

If this is all correct, it sounds like a serious bug in deflate.  If  
so, it would have to be a very sneaky bug to not have been discovered  
over the last decade or so of deflate usage on who knows how many  
zettabytes of data.  The deflate code has remained largely unchanged  
in that time, and there really isn't anything unusual about your usage.

I have some questions:

1.  Is this problem reproducible on more than one machine?

2.  Can someone send me the input and the 58 bytes of output from this  
case?

3.  Did you try decompressing the 58 bytes?

4.  For the detection of an "uninitialized byte", if for example an  
uninitialized byte is copied to another location, is that location  
then also considered uninitialized?  Or does uninitialized mean that  
that location has really never been written to?

5.  Would the access of uninitialized bytes by deflate have been  
detected?  Since I don't see a mention of uninitialized access before  
the write_buffer(), does that mean that deflate never did such a thing  
itself?

Mark
