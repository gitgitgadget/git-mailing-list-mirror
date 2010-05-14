From: Jeff King <peff@peff.net>
Subject: Re: serious performance issues with images, audio files, and other
 "non-code" data
Date: Fri, 14 May 2010 01:10:49 -0400
Message-ID: <20100514051049.GF6075@coredump.intra.peff.net>
References: <4BEAF941.6040609@puckerupgames.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: John <john@puckerupgames.com>
X-From: git-owner@vger.kernel.org Fri May 14 07:10:58 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCnAn-0004vg-Ih
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 07:10:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753054Ab0ENFKx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 01:10:53 -0400
Received: from peff.net ([208.65.91.99]:38914 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752993Ab0ENFKw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 01:10:52 -0400
Received: (qmail 28694 invoked by uid 107); 14 May 2010 05:10:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 14 May 2010 01:10:52 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 14 May 2010 01:10:49 -0400
Content-Disposition: inline
In-Reply-To: <4BEAF941.6040609@puckerupgames.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147050>

On Wed, May 12, 2010 at 02:53:53PM -0400, John wrote:

> We're seeing serious performance issues with repos that store media
> files, even relatively small files. For example, a web site with less
> than 100 MB of images can take minutes to commit, push, or pull when
> images have changed.

That sounds way too slow from my experiences. I have a repository with 3
gigabytes of photos and videos. Committing 20M of new images takes a
second or two. The biggest slowdown is doing the sha1 over the new data
(which actually happens during "git add").

What version of git are you using? Have you tried "commit -q" to
suppress the diff at the end of commit?

Can you show us exactly what commands you're using, along with timings
so we can see where the slowness is?

For pushing and pulling, you're probably seeing delta compression, which
can be slow for large files (though again, minutes seems kind of slow to
me). It _can_ be worth doing for images, if you do things like change
only exif tags but not the image data itself. But if the images
themselves are changing, you probably want to try setting the "-delta"
attribute. Like:

  echo '*.jpg -delta' >.gitattributes

Also, consider repacking your repository, which will generate a packfile
that will be re-used during push and pull.

> Our first guess was that git is repeatedly attempting to
> compress/decompress data that had already been compressed. We tried

Git does spend a fair bit of time in zlib for some workloads, but it
should not create problems on the order of minutes.

>    core.compression 0   ## Docs say this disables compression. Didn't seem to work.

That should disable zlib compression of loose objects and objects within
packfiles. It can save a little time for objects which won't compress,
but you will lose the size benefits for any text files.

But it won't turn off delta compression, which is what the
"compressing..." phase during push and pull is doing. And which is much
more likely the cause of slowness.

>    pack.depth 1     ## Unclear what this does.

It says you can't make a chain of deltas deeper than 1. It's probably
not what you want.

>    pack.window 0    ## No idea what this does.

It sets the number of other objects git will consider when doing delta
compression. Setting it low should improve your push/pull times. But you
will lose the substantial benefit of delta-compression of your non-image
files (and git's meta objects). So the "-delta" option above for
specific files is a much better solution.

>    gc.auto 0        ## We hope this disables automatic packing.

It disables automatic repacking when you have a lot of objects. You
_have_ to pack when pushing and pulling, since packfiles are the
on-the-wire format. What will help is:

  1. Having repositories already packed, since git can re-use the packed
     data.

  2. Using -delta so that things which delta poorly are just copied into
     the packfile as-is.

> Is there a trick to getting git to simply "copy files as is"?  In
> other words, don't attempt to compress them, don't attempt to "diff"
> them, just store/copy/transfer the files as-is?

Hopefully you can pick out the answer to that question from the above
statements. :)

-Peff
