From: Jeff King <peff@peff.net>
Subject: Re: bug: "fatal: cannot pread pack file", version 1.7.5.4
Date: Mon, 2 Jul 2012 17:57:36 -0400
Message-ID: <20120702215736.GA5790@sigill.intra.peff.net>
References: <5638dec6e156f83385a3baa01cf9ac4d@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Lars Winterfeld <lars.winterfeld@tu-ilmenau.de>
X-From: git-owner@vger.kernel.org Mon Jul 02 23:57:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Slocw-0005Ra-EV
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jul 2012 23:57:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933014Ab2GBV5k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jul 2012 17:57:40 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:51821
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932549Ab2GBV5j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2012 17:57:39 -0400
Received: (qmail 13204 invoked by uid 107); 2 Jul 2012 21:57:46 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 02 Jul 2012 17:57:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Jul 2012 17:57:36 -0400
Content-Disposition: inline
In-Reply-To: <5638dec6e156f83385a3baa01cf9ac4d@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200865>

On Mon, Jul 02, 2012 at 12:03:13PM -0700, Lars Winterfeld wrote:

> I have used git for some time and regularly pushed changes to another
> server (as some kind of backup), but today I got this error during
> `git push`:
> 
> Counting objects: 1293, done.
> Compressing objects: 100% (1027/1027), done.
> Writing objects: 100% (1229/1229), 70.83 MiB | 364 KiB/s, done.
> Total 1229 (delta 343), reused 0 (delta 0)
> fatal: cannot pread pack file: No such file or directory
> error: unpack failed: index-pack abnormal exit
> To user@host:~/path/
> ! [remote rejected] master -> master (n/a (unpacker error))
> error: failed to push some refs to 'user@host:~/path/'
> 
> I found similar bug reports suggesting to upgrade too version 1.7.x,
> but I am already using git version 1.7.5.4. Can somebody explain to
> me what this error is about? What can I do to resolve it / is there a
> workaround?

It's very odd for pread to report ENOENT (since it is always operating
on an already-opened file descriptor). Older versions of git would
sometimes sometimes report errno even when we get a return of 0 (when
errno is bogus, and they should say "truncated file" or similar), but
that was long ago fixed in fb74243 (Do not use errno when pread()
returns 0, 2008-10-06). There was also an actual bug fixed by a91d49c
(index-pack: Loop over pread until data loading is complete.,
2007-02-27) that I think could also generate this error.

What OS is the server running? Is it using NFS? Are you sure that the
server version is also v1.7.5.4?

-Peff
