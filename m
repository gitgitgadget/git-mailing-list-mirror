From: Jeff King <peff@peff.net>
Subject: Re: trouble on windows network share
Date: Thu, 4 Apr 2013 11:51:12 -0400
Message-ID: <20130404155112.GA11622@sigill.intra.peff.net>
References: <871B6C10EBEFE342A772D1159D1320853F63D205@umechphj.easf.csd.disa.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Pyeron, Jason J CTR (US)" <jason.j.pyeron.ctr@mail.mil>
X-From: git-owner@vger.kernel.org Thu Apr 04 17:51:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNmS4-00042I-CT
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 17:51:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762035Ab3DDPvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 11:51:19 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55999 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761862Ab3DDPvS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 11:51:18 -0400
Received: (qmail 2355 invoked by uid 107); 4 Apr 2013 15:53:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 04 Apr 2013 11:53:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Apr 2013 11:51:12 -0400
Content-Disposition: inline
In-Reply-To: <871B6C10EBEFE342A772D1159D1320853F63D205@umechphj.easf.csd.disa.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220024>

On Thu, Apr 04, 2013 at 03:01:36PM +0000, Pyeron, Jason J CTR (US) wrote:

> I am having trouble when the .git folder is on a network share, given the below where should I start on my debugging?
> [...]
> jason.pyeron@localhost //server/share/dir/subdir/test
> $ git add test.txt
> 
> jason.pyeron@localhost //server/share/dir/subdir/test
> $ git commit -m test
> error: unable to find 8b7323820a21ebd1360e27262b3c61283c266c23
> fatal: 8b7323820a21ebd1360e27262b3c61283c266c23 is not a valid object

Hmm. That message probably comes from:

  static int sha1_loose_object_info(const unsigned char *sha1, unsigned long *sizep)
  {
  [...]
          map = map_sha1_file(sha1, &mapsize);
          if (!map)
                  return error("unable to find %s", sha1_to_hex(sha1));

So we have found the object and know that it is loose, but then mmap-ing
it fails. My guess is that your system does not support mmap across
network shares (whether this is an OS issue or a cygwin limitation, I
don't know). You could confirm it by running your "git commit" under
strace, which I expect would show mmap returning -ENODEV or similar.

You can work around it by compiling git with NO_MMAP=1.

You might also try msysgit rather than cygwin, which seems to have its
own win32 mmap compatibility layer.

Finally, I suspect we could include our emulate-mmap-with-pread
compatibility wrapper all the time, and drop back to it automatically at
run-time when we see ENODEV or a similar error return from mmap.

-Peff
