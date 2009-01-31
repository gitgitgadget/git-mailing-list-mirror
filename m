From: Jeff King <peff@peff.net>
Subject: Re: 'git clone' doesn't use alternates automatically?
Date: Sat, 31 Jan 2009 02:12:38 -0500
Message-ID: <20090131071238.GC3033@coredump.intra.peff.net>
References: <885649360901301412jd5c6b0dne1eff1ff00dd043e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git ML <git@vger.kernel.org>
To: James Pickens <jepicken@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 31 08:14:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTA3a-0002XX-At
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 08:14:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626AbZAaHMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 02:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751574AbZAaHMl
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 02:12:41 -0500
Received: from peff.net ([208.65.91.99]:45996 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751571AbZAaHMk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 02:12:40 -0500
Received: (qmail 10449 invoked by uid 107); 31 Jan 2009 07:12:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 31 Jan 2009 02:12:51 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 31 Jan 2009 02:12:38 -0500
Content-Disposition: inline
In-Reply-To: <885649360901301412jd5c6b0dne1eff1ff00dd043e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107909>

On Fri, Jan 30, 2009 at 03:12:42PM -0700, James Pickens wrote:

> I have a central, shared Git repository on an NFS drive at path
> $central.  I have added "$central/objects" to
> $central/objects/info/alternates.  I see that when I clone this
> repository with Git 1.6.1, the alternates file is automatically copied
> to the clone, but so are all the pack files and loose objects.  If I
> then cd to the clone and run 'git gc', it removes the redundant local
> objects.

Yes, we don't set up alternates to an origin by default. If it's a local
clone, we do hardlink by default:

  $ ls -i git/.git/objects/pack
  7639155 pack-0651ae7e35ffde1921db158a3292e1c81153be1a.idx
  7638782 pack-0651ae7e35ffde1921db158a3292e1c81153be1a.pack
  $ git clone git foo
  ...
  $ ls -i foo/.git/objects/pack
  7639155 pack-0651ae7e35ffde1921db158a3292e1c81153be1a.idx
  7638782 pack-0651ae7e35ffde1921db158a3292e1c81153be1a.pack

but presumably in your example the second clone is _not_ on the NFS
mount, and therefore can't hardlink.

So you can try "git clone -s" to specify that you definitely want
alternates.

> I thought I tested this setup a few months back, and 'git clone'
> automatically used the alternates file to avoid copying the redundant
> objects into the clone.  Has this behavior changed, or is my memory
> bad?

I don't recall clone ever being that clever, but I could be wrong (it is
not an area of the code that I am too familiar with).

Can you try a test with a few different versions to see if it ever
behaved as you expected (and if it does, bisect to find the breakage)?

-Peff
