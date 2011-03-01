From: Jeff King <peff@peff.net>
Subject: Re: Git changes permissions on directories when deleting files.
Date: Tue, 1 Mar 2011 14:44:28 -0500
Message-ID: <20110301194428.GD10082@sigill.intra.peff.net>
References: <AANLkTikJcOgBAZS=cCWULFYz4U_Mxx1gFMg51+r9qDo0@mail.gmail.com>
 <AANLkTinCjaGMe3TnheqORe7Y_qWYTAr3p6UEsK3u4VyE@mail.gmail.com>
 <AANLkTikFMg_yLWmanqyHveDMR==bw8kxjZgr4mSOmY-2@mail.gmail.com>
 <AANLkTimw+TLYv3ANf_Gx6G3SaLwRnRf6PF1YUv86rC5J@mail.gmail.com>
 <AANLkTimx7s94wjPasgdY7O9eoyzXXmhWm6f+CB0_2sv3@mail.gmail.com>
 <AANLkTimBrUo_O6sjhSEf2sPKrYhjMcr24hwRe0kH4CgO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Computer Druid <computerdruid@gmail.com>, git@vger.kernel.org
To: Chad Joan <chadjoan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 20:44:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuVUf-0004BU-99
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 20:44:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757171Ab1CAToU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 14:44:20 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:44024 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756258Ab1CAToT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 14:44:19 -0500
Received: (qmail 9620 invoked by uid 111); 1 Mar 2011 19:44:18 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 01 Mar 2011 19:44:18 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Mar 2011 14:44:28 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimBrUo_O6sjhSEf2sPKrYhjMcr24hwRe0kH4CgO@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168246>

On Tue, Mar 01, 2011 at 02:35:41PM -0500, Chad Joan wrote:

> Something fairly interesting:
> 
> $ mkdir foo
> $ mkdir foo/bar
> $ ls -dl foo/bar
> drwxr-x--x 1 cjoan cjoan 0 Mar  1 14:31 foo/bar
> $ ls -dl foo
> drwxr-x--x 1 cjoan cjoan 0 Mar  1 14:31 foo
> $ echo "test" > foo/bar/baz.txt
> $ echo "somestuff" > foo/bar/somefile.txt
> $ ls -dl foo/bar
> drwxr-x--x 1 cjoan cjoan 0 Mar  1 14:31 foo/bar
> $ ls -dl foo
> drwxr-x--x 1 cjoan cjoan 0 Mar  1 14:31 foo
> $ rmdir foo/bar
> rmdir: failed to remove `foo/bar': Directory not empty
> $ ls -dl foo/bar
> drw------- 1 cjoan cjoan 0 Mar  1 14:32 foo/bar
> $ ls -dl foo
> drwxr-x--x 1 cjoan cjoan 0 Mar  1 14:31 foo
> 
> 
> The rmdir fails of course, but it also changes the permissions.
> So I take it that git always runs an rmdir on the parent directory
> when it removes a file?  Seems like it would be a sensible way to do
> it on a system without this behavior.

Exactly. Rather than spend time figuring out if the directory is
removable (which would not be atomic, anyway), we just rmdir and ignore
the error condition.

I would argue that your filesystem is broken. Even if we implemented a
workaround to opendir() and check for files, it would still have a race
condition that could cause this situation to occur.

-Peff
