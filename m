From: "George Spelvin" <linux@horizon.com>
Subject: Re: Performance issue of 'git branch'
Date: 26 Jul 2009 19:21:54 -0400
Message-ID: <20090726232154.29594.qmail@science.horizon.com>
Cc: linux@horizon.com
To: git@vger.kernel.org, torvalds@linux-foundation.org
X-From: git-owner@vger.kernel.org Mon Jul 27 01:34:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVDEL-0006c2-DS
	for gcvg-git-2@gmane.org; Mon, 27 Jul 2009 01:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754239AbZGZX2f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2009 19:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754138AbZGZX2f
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jul 2009 19:28:35 -0400
Received: from science.horizon.com ([71.41.210.146]:16898 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754140AbZGZX2e (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jul 2009 19:28:34 -0400
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Sun, 26 Jul 2009 19:28:34 EDT
Received: (qmail 29615 invoked by uid 1000); 26 Jul 2009 19:21:54 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124140>

> It's a bit sad, since the _only_ thing we load all of libcrypto for is the 
> (fairly trivial) SHA1 code. 
>
> But at the same time, last time I benchmarked the different SHA1 
> libraries, the openssl one was the fastest. I think it has tuned assembly 
> language for most architectures. Our regular mozilla-based C code is 
> perfectly fine, but it doesn't hold a candle to assembler tuning.

Actually, openssl only has assembly for x86, x86_64, and ia64.
Truthfully, once you have 32 registers, SHA1 is awfully easy to
compile near-optimally.

Git currently includes some hand-tuned assembly that isn't in OpenSSL:
- ARM (only 16 registers, and the rotate+op support can be used nicely)
- PPC (3-way superscalar *without* OO execution benefits from careful
  scheduling)

Further, all of the core hand-tuned SHA1 assembly code in OpenSSL is by
Andy Polyakov and is dual-licensed GPL/3-clause BSD *in addition to*
the OpenSSL license.  So we can just import it:

See http://www.openssl.org/~appro/cryptogams/
and http://www.openssl.org/~appro/cryptogams/cryptogams-0.tar.gz

(Ooh, look, he has PPC code in there, too.  Does anyone with a PPC machine
want to compare it with Git's?)

It'll take some massaging because that's just the core SHA1_Transform
function and not the wrappers, but it's hardly a heroic effort.

I'm pretty deep in the weeds at $DAY_JOB and can't get to it for a while,
but would a patch be appreciated?
