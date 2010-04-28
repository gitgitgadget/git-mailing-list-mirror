From: Sergio Callegari <sergio.callegari@gmail.com>
Subject: Re: Multiblobs
Date: Wed, 28 Apr 2010 19:13:42 +0000 (UTC)
Message-ID: <loom.20100428T204406-308@post.gmane.org>
References: <loom.20100428T164432-954@post.gmane.org> <k2y32541b131004281107u6d15ed4ex54b5e5c138cc0e24@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 28 21:14:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7Chw-0005Aw-Ck
	for gcvg-git-2@lo.gmane.org; Wed, 28 Apr 2010 21:14:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756652Ab0D1TN4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Apr 2010 15:13:56 -0400
Received: from lo.gmane.org ([80.91.229.12]:47984 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754263Ab0D1TNz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Apr 2010 15:13:55 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1O7Chm-00056Z-4p
	for git@vger.kernel.org; Wed, 28 Apr 2010 21:13:54 +0200
Received: from i2-ve060.ingce.unibo.it ([137.204.107.60])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Apr 2010 21:13:54 +0200
Received: from sergio.callegari by i2-ve060.ingce.unibo.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Apr 2010 21:13:54 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 137.204.107.60 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100402 Ubuntu/9.10 (karmic) Firefox/3.5.9)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146005>

Avery Pennarun <apenwarr <at> gmail.com> writes:

> 
> On Wed, Apr 28, 2010 at 11:12 AM, Sergio Callegari
> <sergio.callegari <at> gmail.com> wrote:
> > - storing "structured files", such as the many zip-based file formats
> > (Opendocument, Docx, Jar files, zip files themselves), tars (including
> > compressed tars), pdfs, etc, whose number is rising day after day...
> 
> I'm not sure it would help very much for these sorts of files.  The
> problem is that compressed files tend to change a lot even if only a
> few bytes of the original data have changed.

Probably I have not provided enough elements... My idea is the following:

If you store a structured file as a multiblob, you can use a blob for each
uncompressed element of content.  For instance, when storing an opendocument
file you could use a blob for manifest.xml, one for content.xml, etc... (try
unzip -l on an odt or odp file to get an idea). When you edit your file only a
few of these change. For instance, if we talk about a presentation, each slide
has its own content.xml, so changing one slide only that changes.

The same for PDF files, if you split them using a blob for each uncompressed
stream, little variations of the pdf file will touch only a blob.

In other terms, to benefit from multiblobs you should use a different splitting
strategy for PDFs (1 blob per uncompressed stream + 1 header blob telling how
streams should be put together), Zip files (1 blob per uncompressed file + 1
header blob also containing metadata), long unstructured binary files (1 blob
per chunk + 1 header blob), etc.

> For things like opendocument, or uncompressed tars, you'd be better
> off to decompress them (or recompress with zip -0) using
> .gitattributes.  Generally these files aren't *so* large that they
> really need to be chunked; what you want to do is improve the deltas,
> which decompressing will do.

This is what I currently do.  But using multiblobs would be a definite
improvement over this.
 
> > - storing binary files with textual tags, where the tags could go on a
separate
> > blob, greatly simplifying their readout without any need for caching them on
a
> > note tree.
> 
> That sounds complicated and error prone, and is suspiciously like
> Apple's "resource forks," which even Apple has mostly realized were a
> bad idea.

I did not mean the Apple way... Suppose that you need to store images with exif
tags.  In order to diff them you would tipically set a textconv attribute, to
see only the tags.  However, this kind of filter needs to read the whole file
(expensive). BTW this is why a caching mechanism involving notes has recently
been proposed. Now suppose that you can set up a rule so that image files with
tags are stored as a multiblob. You can use 3 blobs... 1 as a header, one for
the raw image data and one for the tags.  Now your textconv filter only needs to
look at the content of the tags blob.

> > - help the management of upstream trees. This could be simplified since the
> > "pristine tree" distributed as a tar.gz file and the exploded repo could
share
> > their blobs making commands such as pristine-tree unnecessary.

Similar... Right now to do package management with git, you need to use pristine
tar. This is because when you check in the upstream tar you only check in its
elements, not the whole tar.gz.  So you need pristine tar to recreate the
upstream tar.gz whenever needed. But with multiblob you could store both the
content /and/ the upstream tar and there would be minimal overlap since the
blobs would be the same. 
 
> Sharing the blobs of a tarball with a checked-out tree would require a
> tar-specific chunking algorithm.  Not impossible, but a pain, and you
> might have a hard time getting it accepted into git since it's
> obviously not something you really need for a normal "source code"
> tracking system.

I agree... but there could be just a mere couple of gitattributes multiblobsplit
and multiblobcompose, so that one could provide his own splitting and composing
methods for the types of files he is interested in (and maybe contribute them to
the community).

> > - help projects such as bup that currently need to provide split mechanisms
of
> > their own.
> 
> Since bup is so awesome that it will soon rule the world of file
> splitting backup systems, and bup already has a working implemention,
> this reason by itself probably isn't enough to integrate the feature
> into git.

On this I tend to agree!

 > > - be used to add "different representations" to objects... for instance,
when
> > storing a pdf one could use a fake split to store in a separate blob the
> > corresponding text, making the git-diff of pdfs almost instantaneous.
> 
> Aie, files that have different content depending how you look at them?
>  You'll make a lot of enemies with such a patch :)

I would not consider it as different content... rather as a way to cache data
you might need.  But I agree this is probably going too far.
 
> Overall, I'm not sure git would benefit much from supporting large
> files in this way; at least not yet.  As soon as you supported this,
> you'd start running into other problems... such as the fact that
> shallow repos don't really work very well, and you obviously don't
> want to clone every single copy of a 100MB file just so you can edit
> the most recent version.  So you might want to make sure shallow repos
> / sparse checkouts are fully up to speed first.

I am not really thinking that much about large binary files (that would anyway
come as a bonus - an many people often talk about them on the list), but of
structured files that currently do not pack well.  My personal issue is with
opendocument files, since I need to check in lots of documentation and
presentation material.
