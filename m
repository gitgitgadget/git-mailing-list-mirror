From: Sergio <sergio.callegari@gmail.com>
Subject: Re: Multiblobs
Date: Wed, 28 Apr 2010 23:26:27 +0000 (UTC)
Message-ID: <loom.20100429T010742-199@post.gmane.org>
References: <loom.20100428T164432-954@post.gmane.org> <k2y32541b131004281107u6d15ed4ex54b5e5c138cc0e24@mail.gmail.com>  <loom.20100428T204406-308@post.gmane.org> <k2x32541b131004281427o2101720at3d324f5e94f05327@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 29 01:26:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7GeQ-0002m8-EN
	for gcvg-git-2@lo.gmane.org; Thu, 29 Apr 2010 01:26:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754577Ab0D1X0g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Apr 2010 19:26:36 -0400
Received: from lo.gmane.org ([80.91.229.12]:60009 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752310Ab0D1X0f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Apr 2010 19:26:35 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1O7GeI-0002jH-OF
	for git@vger.kernel.org; Thu, 29 Apr 2010 01:26:34 +0200
Received: from 109.54.5.85 ([109.54.5.85])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 29 Apr 2010 01:26:34 +0200
Received: from sergio.callegari by 109.54.5.85 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 29 Apr 2010 01:26:34 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 109.54.5.85 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100402 Ubuntu/9.10 (karmic) Firefox/3.5.9)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146020>

Avery Pennarun <apenwarr <at> gmail.com> writes:

> But why not use a .gitattributes filter to recompress the zip/odp file
> with no compression, as I suggested?  Then you can just dump the whole
> thing into git directly.  When you change the file, only the changes
> need to be stored thanks to delta compression.  Unless your
> presentation is hundreds of megs in size, git should be able to handle
> that just fine already.

Actually, I'm doing so...  But in some occasions odf file that share many
components do not delta, even when passed through a filter that uncompresses
them. Multiblobs are like taking advantage of a known structure to get better
deltas.

> But then you're digging around inside the pdf file by hand, which is a
> lot of pdf-specific work that probably doesn't belong inside git.

I perfectly agree that git should not know about the inner structure of things
like PDFs, Zips, Tars, Jars, whatever. But having an infrastructure allowing
multiblobs and attributes like clean/smudge to trigger creation and use of
multiblobs with user provided split/unsplit drivers could be nice.

> Worse, because compression programs don't always produce the same
> output, this operation would most likely actually *change* the hash of
> your pdf file as you do it. 

This should depend on the split/unsplit driver that you write. If your driver
stores a sufficient amount of metadata about the streams and their order, you
should be able to recreate the original file.

> In what way?  I doubt you'd get more efficient storage, at least.
> Git's deltas are awfully hard to beat.

Using the known structure of the file, you automatically identify the bits that
are identical and you save the need to find a delta altogether.


> > I agree... but there could be just a mere couple of gitattributes
multiblobsplit
> > and multiblobcompose, so that one could provide his own splitting and
composing
> > methods for the types of files he is interested in (and maybe contribute
them to
> > the community).
> 
> I guess this would be mostly harmless; the implementation could mirror
> the filter stuff.

This is exactly what I was thinking of: multiblobs as a generalization of the
filter infrastructure.

> In that case, I'd like to see some comparisons of real numbers
> (memory, disk usage, CPU usage) when storing your openoffice documents
> (using the .gitattributes filter, of course).  I can't really imagine
> how splitting the files into more pieces would really improve disk
> space usage, at least.

I'll try to isolate test cases, making test repos:

a) with 1 odf file changing a little on each checkin
b) the same storing the odf file with no compression with a suitable filter
c) the same storing the tree inside the odf file.

> Having done some tests while writing bup, my experience has been that
> chunking-without-deltas is great for these situations:
> 1) you have the same data shared across *multiple* files (eg. the same
> images in lots of openoffice documents with different filenames);
> 2) you have the same data *repeated* in the same file at large
> distances (so that gzip compression doesn't catch it; eg. VMware
> images)
> 3) your file is too big to work with the delta compressor (eg. VMware images).

An aside: bup is great!!! Thanks!
 
And thanks for all your comments, of course!

Sergio
