From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Valgrind updates
Date: Tue, 27 Jan 2009 10:55:40 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0901271006060.3123@localhost.localdomain>
References: <alpine.DEB.1.00.0901210105470.19014@racer> <20090121001551.GB18169@coredump.intra.peff.net> <alpine.DEB.1.00.0901210119510.19014@racer> <20090121003739.GA18373@coredump.intra.peff.net> <alpine.DEB.1.00.0901210216440.19014@racer>
 <20090121190757.GB21686@coredump.intra.peff.net> <alpine.DEB.1.00.0901212259420.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901270327200.26199@intel-tinevez-2-302> <alpine.LFD.2.00.0901261934450.3123@localhost.localdomain> <alpine.DEB.1.00.0901270512171.14855@racer>
 <20090127131404.GA11870@sirena.org.uk> <alpine.DEB.1.00.0901271742430.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mark Brown <broonie@sirena.org.uk>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>, zlib@gzip.org
X-From: git-owner@vger.kernel.org Tue Jan 27 19:58:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRt8T-0002v0-QJ
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 19:58:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755205AbZA0S4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 13:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755056AbZA0S4o
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 13:56:44 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53664 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753665AbZA0S4n (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jan 2009 13:56:43 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n0RItgbO008951
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 27 Jan 2009 10:55:43 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n0RItedF021654;
	Tue, 27 Jan 2009 10:55:40 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.DEB.1.00.0901271742430.3586@pacific.mpi-cbg.de>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.462 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107383>



On Tue, 27 Jan 2009, Johannes Schindelin wrote:
> 
> Come to think of it, the word "suppression" is probably a good indicator 
> that valgrind never claimed it would mark the zlib buffer as properly 
> initialized.

Hmm. The zlib faq has a note about zlib doing a conditional on 
uninitialized memory that doesn't matter, and that is what the suppression 
should be about (to avoid a warning about "Conditional jump or move 
depends on uninitialised value").

But that one is documented to not matter for the actual output (zlib 
FAQ#36).

It's possible that zlib really does leave padding bytes around that 
literally don't matter, and that don't get initialized. That really would 
be bad, because it means that the output of git wouldn't be repeatable. 
But I doubt this is the case - original git used to actually do the SHA1 
over the _compressed_ data, which was admittedly a totally and utterly 
broken design (and we fixed it), but it did work. Maybe it worked by luck, 
but I somehow doubt it.

Some googling did find this:

	http://mailman.few.vu.nl/pipermail/sysprog/2008-October/000298.html

which looks very similar: an uninitialized byte in the middle of a 
deflate() packet.

Anyway, I'm just going to Cc 'zlib@gzip.org', since this definitely is 
_not_ the same issue as in the FAQ, and we're not the only ones seeing it. 
For the zlib people: the code is literally this:

        /* Set it up */
        memset(&stream, 0, sizeof(stream));
        deflateInit(&stream, zlib_compression_level);
        size = 8 + deflateBound(&stream, len+hdrlen);
        compressed = xmalloc(size);

        /* Compress it */
        stream.next_out = compressed;
        stream.avail_out = size;

        /* First header.. */
        stream.next_in = (unsigned char *)hdr;
        stream.avail_in = hdrlen;
        while (deflate(&stream, 0) == Z_OK)
                /* nothing */;

        /* Then the data itself.. */
        stream.next_in = buf;
        stream.avail_in = len;
        ret = deflate(&stream, Z_FINISH);
        if (ret != Z_STREAM_END)
                die("unable to deflate new object %s (%d)", sha1_to_hex(sha1), ret);

        ret = deflateEnd(&stream);
        if (ret != Z_OK)
                die("deflateEnd on object %s failed (%d)", sha1_to_hex(sha1), ret);

        size = stream.total_out;

        if (write_buffer(fd, compressed, size) < 0)
                die("unable to write sha1 file");

and valgrind complains that the "write_buffer()" call will touch an 
uninitialized byte (just one byte, and in the _middle_ of the buffer, no 
less):

> Yet, the buffer in question is 195 bytes, stream.total_count (which 
> totally agrees with size - stream.avail_out) says it is 58 bytes, and 
> valgrind says that the byte with offset 51 is uninitialized.

The thing to note here is that what we are passing in to "write_buffer()" 
is _exactly_ what zlib deflated for us:

 - 'compressed' is the allocation, and is what we used to initialize 
   'stream.next_out' with (at the top of the code sequence above)

 - 'size' is gotten from 'stream.total_out' at the end of the compression.

Maybe the zlib people can tell us that we're idiots and the above is 
buggy, but maybe there is a real bug in zlib. Maybe it's triggered by our 
use of using two different input buffers to deflate() (ie we compress the 
header first, and then the body of the actual data, and put it all in one 
single output buffer), which may be unusual usage of zlib routines and may 
be why there aren't tons of reports of this.

(Our use of just depending on deflate() returning Z_BUF_ERROR after 
consuming all of the header data is probably also "unusual", but the 
manual explicitly says that it's not fatal and that deflate can be called 
again with more buffers).

Oh Gods of zlib, please hear our plea for clarification..

			Linus
