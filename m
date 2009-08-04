From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: x86 SHA1: Faster than OpenSSL
Date: Mon, 3 Aug 2009 19:30:08 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908031924230.3270@localhost.localdomain>
References: <20090803034741.23415.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, appro@fy.chalmers.se, appro@openssl.org
To: George Spelvin <linux@horizon.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 04:31:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MY9nw-0001UX-5i
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 04:31:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755078AbZHDCa7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2009 22:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754761AbZHDCa7
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 22:30:59 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38231 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754596AbZHDCa7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Aug 2009 22:30:59 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n742UAHu031971
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 3 Aug 2009 19:30:11 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n742U8CZ004108;
	Mon, 3 Aug 2009 19:30:09 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <20090803034741.23415.qmail@science.horizon.com>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.468 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124744>



On Sun, 2 Aug 2009, George Spelvin wrote:
> 
> The original code was excellent, but it was optimized when the P4 was new.
> After a bit of tweaking, I've inflicted a slight (1.4%) slowdown on the
> P4, but a small-but-noticeable speedup on a variety of other processors.
> 
> Before      After       Gain    Processor
> 1.585248    1.353314	+17%	2500 MHz Phenom
> 3.249614    3.295619	-1.4%	1594 MHz P4
> 1.414512    1.352843	+4.5%	2.66 GHz i7
> 3.460635    3.284221	+5.4%	1596 MHz Athlon XP
> 4.077993    3.891826	+4.8%	1144 MHz Athlon
> 1.912161    1.623212	+17%	2100 MHz Athlon 64 X2
> 2.956432    2.940210	+0.55%	1794 MHz Mobile Celeron (fam 15 model 2)

It would be better to have a more git-centric benchmark that actually 
shows some real git load, rather than a sha1-only microbenchmark.

The thing that I'd prefer is simply

	git fsck --full

on the Linux kernel archive. For me (with a fast machine), it takes about 
4m30s with the OpenSSL SHA1, and takes 6m40s with the Mozilla SHA1 (ie 
using a NO_OPENSSL=1 build).

So that's an example of a load that is actually very sensitive to SHA1 
performance (more so than _most_ git loads, I suspect), and at the same 
time is a real git load rather than some SHA1-only microbenchmark. It also 
shows very clearly why we default to the OpenSSL version over the Mozilla 
one.

NOTE! I didn't do multiple runs to see how stable the numbers are, and 
so it's possible that I exaggerated the OpenSSL advantage over the 
Mozilla-SHA1 code. Or vice versa. My point is really only that I don't 
know how meaningful a "50 x 1M SHA1" benchmark is, while I know that a 
"git fsck" benchmark has at least _some_ real life value.

		Linus
