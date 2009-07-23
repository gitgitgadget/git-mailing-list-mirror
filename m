From: Jeff King <peff@peff.net>
Subject: Re: How to prevent Git from compressing certain files?
Date: Thu, 23 Jul 2009 06:12:27 -0400
Message-ID: <20090723101227.GA4247@coredump.intra.peff.net>
References: <4A676D4B.7040004@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Dirk =?utf-8?Q?S=C3=BCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Thu Jul 23 12:12:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTvHz-0002h4-Ds
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 12:12:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbZGWKMb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Jul 2009 06:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbZGWKMb
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 06:12:31 -0400
Received: from peff.net ([208.65.91.99]:42758 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750927AbZGWKMa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2009 06:12:30 -0400
Received: (qmail 9778 invoked by uid 107); 23 Jul 2009 10:14:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 23 Jul 2009 06:14:32 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jul 2009 06:12:27 -0400
Content-Disposition: inline
In-Reply-To: <4A676D4B.7040004@dirk.my1.cc>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123863>

On Wed, Jul 22, 2009 at 09:49:31PM +0200, Dirk S=C3=BCsserott wrote:

> Somewhere I read that Git isn't supposed to efficiently handle binary
> files. Of course, I don't want to merge my files, just store them wit=
h
> their history and git-push them to some "safe place".

Git handles binary files better than many systems. The downsides are:

  - you can't do file-level diffing and merging very well, for obvious
    reasons (though actually, git is better than most; it makes it easy
    to look at both sides individually and pick the one you want).

  - really _big_ files can give lousy performance. Git assumes single
    files can fit into memory, which means files in the gigabyte range
    (or hundreds of megabytes if your machine is old :) ) can be awful.
    It also means that things like inexact rename detection and finding
    delta candidates can be slow.

> I figured that pushing and git gc'ing both try to compress those file=
s
> (or differences) really hard. Works great for "regular" files, but is
> pointless with jpegs.
>=20
> Question: Is there a way to prevent Git from trying to compress certa=
in
> files based on their extension?

There are actually two types of compression that git uses: delta
compression between similar objects in packs, and zlib compression of
loose objects and objects within packs.

You almost certainly don't want zlib compression on your jpegs, as they
are already compressed. You can turn off zlib compression entirely by
setting core.compression to 0. Unfortunately, this turns off compressio=
n
for _all_ objects, which means in a mixed-use repo you won't be
compressing your text (and even in a photos-only repo, you are not
compressing your commit messages).

Delta compression between two jpegs, or between two versions of a jpeg
where the image data itself was modified, is unlikely to be useful.
However, if you use EXIF metadata in the file, then you will save a lot
of space between versions with the same image data, but different
metadata. So it's worth leaving delta compression on in that case, and
probably turning it off otherwise.

As Jakub mentioned, you can use the delta gitattribute for just your
jpegs. You can also turn off deltas entirely by setting pack.window to
0, though you may be losing some benefit on your non-blob objects.

-Peff
