From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] Use FIX_UTF8_MAC to enable conversion from UTF8-MAC to UTF8
Date: Tue, 22 Jan 2008 15:20:19 +0300
Message-ID: <20080122122019.GJ14871@dpotapov.dyndns.org>
References: <fn1nl6$ek5$1@ger.gmane.org> <fn1pj9$kkg$1@ger.gmane.org> <fn1ptk$ljj$1@ger.gmane.org> <fn1q6b$ljj$2@ger.gmane.org> <7vve5nzdqx.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801212025050.2957@woody.linux-foundation.org> <alpine.LFD.1.00.0801212304460.2957@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Mark Junker <mjscod@web.de>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jan 22 13:21:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHI7d-00084R-6Z
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 13:20:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624AbYAVMUY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 07:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751560AbYAVMUY
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 07:20:24 -0500
Received: from smtp04.mtu.ru ([62.5.255.51]:52794 "EHLO smtp04.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751370AbYAVMUX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2008 07:20:23 -0500
Received: from smtp04.mtu.ru (localhost [127.0.0.1])
	by smtp04.mtu.ru (Postfix) with ESMTP id EBE0882A12B;
	Tue, 22 Jan 2008 15:20:19 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-141-189-197.pppoe.mtu-net.ru [85.141.189.197])
	by smtp04.mtu.ru (Postfix) with ESMTP id 7B68382A0CD;
	Tue, 22 Jan 2008 15:20:19 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1JHI71-0002Mb-7f; Tue, 22 Jan 2008 15:20:19 +0300
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0801212304460.2957@woody.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-DCC-STREAM-Metrics: smtp04.mtu.ru 10002; Body=0 Fuz1=0 Fuz2=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71446>

On Mon, Jan 21, 2008 at 11:16:54PM -0800, Linus Torvalds wrote:
> 
> Yes, it will work on OS X, but for all the wrong reasons. It works there 
> just because of the stupid normalization that OS X does both on filename 
> input and output, so if we hook into readdir() and munge the name there, 
> we'll still be able to use the munged name for lstat() and open().

Yes, when I proposed the readdir() wrapper, I meant it to be as OS X
specific hack. Just because HFS+ munges names and does that by converting
them in the form that is HFS+ specific, we can safely convert then into
NFC, as we do not lose more information than it is lost already, and
more importantly, AFAIK, everything that a user types on Mac is in NFC,
whether they are names in the command line or names in .gitatributes.

> However, we'll never be able to test it on a sane Unix system, and it 
> won't ever be able to handle the case of a filesystem actually being 
> Latin1 but git being asked to try to transparently convert it to utf-8 in 
> order to work with others.

Yes, but that is a separate issue, which unfortunately is much more
difficult to deal with. Basically, there are two approaches -- either
to wrap all input/output functions, or to find another point where it
is possible to convert names without re-writing too much code in Git.
It seems to me that the first approach may requires wrapping too much
functions, but looking at the code I am not sure that the second will
be much easier. There are many places where a filename in the local
encoding will interact with Git internal encoding used by repo.

If we spoke about Windows only, I would say that the first approach makes
much more sense, because all i/o functions used on Windows are already
wrappers over Unicode functions. So, converting UTF-8 <-> UTF-16 makes
much more sense than UTF-8 <-> some-local-encoding(*) <-> UTF-16.

(*) In fact, two different encodings for the same locale setting -- 
one for console and the other for non-console programs!

> It would be conceptually nicer to do it in "add_file_to_index()" instead. 
> Ie anything that creates a "struct cache_entry" would do the 
> conversion. 

I don't think it is going to work, without changing a lot of code,
because filenames entered by user and those that are returned by
readdir() are different. Also, .gitignore or .gitattributes files will
have filenames in the form that differs from returned by readdir().


Dmitry
