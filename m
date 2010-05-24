From: Jeff King <peff@peff.net>
Subject: Re: Bug? file at the same time being deleted and not registered
Date: Mon, 24 May 2010 04:24:30 -0400
Message-ID: <20100524082430.GA18755@coredump.intra.peff.net>
References: <alpine.DEB.2.00.1005232245220.18372@tpo-laptop>
 <20100523234459.GA8285@coredump.intra.peff.net>
 <alpine.DEB.2.00.1005240932130.7107@tpo-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Tomas Pospisek <tpo@sourcepole.ch>
X-From: git-owner@vger.kernel.org Mon May 24 10:24:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGSxk-0001xv-OS
	for gcvg-git-2@lo.gmane.org; Mon, 24 May 2010 10:24:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756728Ab0EXIYf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 May 2010 04:24:35 -0400
Received: from peff.net ([208.65.91.99]:53444 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756104Ab0EXIYe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 May 2010 04:24:34 -0400
Received: (qmail 2422 invoked by uid 107); 24 May 2010 08:24:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 24 May 2010 04:24:36 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 24 May 2010 04:24:30 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1005240932130.7107@tpo-laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147609>

On Mon, May 24, 2010 at 10:02:14AM +0200, Tomas Pospisek wrote:

> >Can you try running the output of "git diff-files --name-only" and "git
> >ls-files -o" through xxd or something that would show individual bytes?
> >My suspicion is that the "a_file" shown in each may not be bit-for-bit
> >identical.
> 
>  $ git diff-files --name-only
>  $ # no output at all

Hrm, I had originally thought that your "git status" output showed
a_file as deleted in the working tree, which is why I suggested
diff-files. But looking at your output again, I see that it is scheduled
for deletion. In other words, the index entry has been removed entirely,
as if "git rm --cached a_file" had been issued.

So I think I was on the wrong track with the filename-munging, then.
Sorry to lead you astray. But the problem is that your index is missing
or bogus, which is even weirder.

Looking at your strace dump, I see it writing out the index (it writes
to index.lock and then renames it into place). Can you take a look at
your .git/index file? It should be 104 bytes and look something like:

  $ xxd .git/index
  0000000: 4449 5243 0000 0002 0000 0001 4bfa 367d  DIRC........K.6}
  0000010: 0000 0000 4bfa 367d 0000 0000 0000 0900  ....K.6}........
  0000020: 0099 801d 0000 81a4 0000 03e8 0000 03e8  ................
  0000030: 0000 0000 e69d e29b b2d1 d643 4b8b 29ae  ...........CK.).
  0000040: 775a d8c2 e48c 5391 0006 615f 6669 6c65  wZ....S...a_file
  0000050: 0000 0000 1f80 d668 c07b 5955 8678 4360  .......h.{YU.xC`
  0000060: 8215 6238 89be 9b4d

It won't match byte-for-byte because there is stat information in there,
but you should see a_file.

If it's empty or 32 bytes, then that explains what status is reporting
(but the question still remains how we got into that state).

-Peff
